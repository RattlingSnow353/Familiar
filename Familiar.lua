local mod_path = ''..SMODS.current_mod.path
Familiar_config = SMODS.current_mod.config

-- You're not supposed to be here
function Card:get_suit()
    if self.ability.effect == 'Stone Card' and not self.vampired then
        return -math.random(100, 1000000)
    end
    return self.base.suit
end

local function is_face(card)
    local id = card:get_id()
    return id == 11 or id == 12 or id == 13
end

to_big = to_big or function(num)
    return num
end

function shakecard(self)
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(1, 1)
            return true
        end
    }))
end

function create_consumable(card_type,tag,message,extra, thing1, thing2)
    extra=extra or {}
    
    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type,G.consumeables, nil, nil, thing1, thing2, extra.forced_key or nil, tag)
                card:add_to_deck()
                if extra.edition~=nil then
                    card:set_edition(extra.edition,true,false)
                end
                if extra.eternal~=nil then
                    card.ability.eternal=extra.eternal
                end
                if extra.perishable~=nil then
                    card.ability.perishable = extra.perishable
                    if tag=='v_epilogue' then
                        card.ability.perish_tally=get_voucher('epilogue').config.extra
                    else card.ability.perish_tally = G.GAME.perishable_rounds
                    end
                end
                if extra.extra_ability~=nil then
                    card.ability[extra.extra_ability]=true
                end
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                if message~=nil then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=message})
                end
        return true
    end)}))
end

function create_joker(card_type,tag,message,extra, rarity)
    extra=extra or {}
    
    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type, G.joker, nil, rarity, nil, nil, extra.forced_key or nil, tag)
                card:add_to_deck()
                if extra.edition~=nil then
                    card:set_edition(extra.edition,true,false)
                end
                if extra.eternal~=nil then
                    card.ability.eternal=extra.eternal
                end
                if extra.perishable~=nil then
                    card.ability.perishable = extra.perishable
                    if tag=='v_epilogue' then
                        card.ability.perish_tally=get_voucher('epilogue').config.extra
                    else card.ability.perish_tally = G.GAME.perishable_rounds
                    end
                end
                if extra.extra_ability~=nil then
                    card.ability[extra.extra_ability]=true
                end
                G.jokers:emplace(card)
                G.GAME.joker_buffer = 0
                if message~=nil then
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=message})
                end
        return true
    end)}))
end

local set_ed = Card.set_edition
function Card:set_edition(edition, immediate, silent)
    if SMODS.has_enhancement(self, 'm_fam_stainless') then
        return set_ed(self, nil, immediate, silent)
    end
    local temped = edition
    if G.GAME.modifiers.fam_neg_common and self.config.center.rarity == 1 then
        temped = {negative = true}
    end
    return set_ed(self, temped, immediate, silent)
end

local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
    Backapply_to_runRef(self)
    if self.effect.config.fam_force_edition then
        G.GAME.modifiers.fam_force_edition = self.effect.config.fam_force_edition
        G.E_MANAGER:add_event(Event({
            func = function()
                for c = #G.playing_cards, 1, -1 do
                    local ed_table = {}
                    ed_table[self.effect.config.fam_force_edition] = true
                    G.playing_cards[c]:set_edition(ed_table, true, true);
                end
            
                return true
            end
        }))
    end
    if self.effect.config.fam_force_dual then
        G.GAME.modifiers.fam_force_dual = true
    end
    local se = Card.set_edition
    function Card:set_edition(edition, y, z)
        if G.GAME.modifiers.fam_neg_common and self.config.center.rarity == 1 then
            edition = 'negative'
        end
        return se(self, G.GAME.modifiers.fam_force_edition and {[G.GAME.modifiers.fam_force_edition]=true} or edition, y, z)
    end
    if self.effect.config.shop_rate then
        MenmentosType.shop_rate = self.effect.config.shop_rate
    end
end

SMODS.current_mod.credits_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, align = "tm", padding = 0.1, colour = G.C.BLACK, minw = 10, minh = 6}, nodes = {
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Art for The Broken, The Harlot, Mesmer, Joey. J. Jester, Joyful Jester,", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Sapphire Seal, Con Man, Thinktank, Merry Andy's Deck, (Webs, Digits, Arms, and Bottles Suits)", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Code for Merry Andy's Deck", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "by: ", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "humplydinkle", scale = 0.5, colour = G.C.GREEN}},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Art for suitless, multisuited cards, and Pantheon cards", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "by: ", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "luigicat11", scale = 0.5, colour = G.C.GREEN}},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Art for (Webs, Digits, Arms, and Bottles) Faces ", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "by: ", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "hedera0489", scale = 0.5, colour = G.C.GREEN}},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Art for Forged Signature", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "by: ", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "dnolife", scale = 0.5, colour = G.C.GREEN}},
            {n = G.UIT.T, config = { text = "/", scale = 0.3, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "RattlingSnow353", scale = 0.3, colour = G.C.GREEN}},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Other things", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "by: ", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "RattlingSnow353", scale = 0.5, colour = G.C.GREEN}},
        }},

        {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
            {n = G.UIT.T, config = { text = "Playtesters: ", scale = 0.5, colour = G.C.UI.TEXT_LIGHT}},
            {n = G.UIT.T, config = { text = "humplydinkle, potted_plant., dnolife, and con_artistssbu", scale = 0.5, colour = G.C.GREEN}},
        }},
    }}
end

i_hands = {
    ["Flush Five"] =        {s_x_mult = 1.25, s_x_chips = 2, i_level = 0},
    ["Flush House"] =       {s_x_mult = 1.3, s_x_chips = 1.8, i_level = 0},
    ["Five of a Kind"] =    {s_x_mult = 1.25, s_x_chips = 1.75, i_level = 0},
    ["Straight Flush"] =    {s_x_mult = 1.3, s_x_chips = 1.8, i_level = 0},
    ["Four of a Kind"] =    {s_x_mult = 1.25, s_x_chips = 1.75, i_level = 0},
    ["Full House"] =        {s_x_mult = 1.2, s_x_chips = 1.7, i_level = 0},
    ["Flush"] =             {s_x_mult = 1.1, s_x_chips = 1.3, i_level = 0},
    ["Straight"] =          {s_x_mult = 1.25, s_x_chips = 1.75, i_level = 0},
    ["Three of a Kind"] =   {s_x_mult = 1.1, s_x_chips = 1.5, i_level = 0},
    ["Two Pair"] =          {s_x_mult = 1.1, s_x_chips = 1.5, i_level = 0},
    ["Pair"] =              {s_x_mult = 1.1, s_x_chips = 1.3, i_level = 0},
    ["High Card"] =         {s_x_mult = 1.1, s_x_chips = 1.2, i_level = 0},
}

function mult_level_up_hand(card, hand, instant, amount)
    if not instant then 
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=hand,chips = G.GAME.hands[hand].chips, mult = G.GAME.hands[hand].mult, level=G.GAME.hands[hand].level})
        i_hands[hand].i_level = math.max(0, i_hands[hand].i_level + amount)
        G.GAME.hands[hand].s_mult = math.max((i_hands[hand].s_x_mult * G.GAME.hands[hand].s_mult), 1)
        G.GAME.hands[hand].s_chips = math.max((i_hands[hand].s_x_chips * G.GAME.hands[hand].s_chips), 0)
        G.GAME.hands[hand].l_chips = math.max((i_hands[hand].s_x_chips * G.GAME.hands[hand].l_chips), 0)
        G.GAME.hands[hand].l_mult = math.max((i_hands[hand].s_x_mult * G.GAME.hands[hand].l_mult), 1)
        G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].s_mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1), 1)
        G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].s_chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1), 0)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=i_hands[hand].i_level.."+i"})
        delay(1.3)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    else
        i_hands[hand].i_level = math.max(0, i_hands[hand].i_level + amount)
        G.GAME.hands[hand].s_mult = math.max((i_hands[hand].s_x_mult * G.GAME.hands[hand].s_mult), 1)
        G.GAME.hands[hand].s_chips = math.max((i_hands[hand].s_x_chips * G.GAME.hands[hand].s_chips), 0)
        G.GAME.hands[hand].l_chips = math.max((i_hands[hand].s_x_chips * G.GAME.hands[hand].l_chips), 0)
        G.GAME.hands[hand].l_mult = math.max((i_hands[hand].s_x_mult * G.GAME.hands[hand].l_mult), 1)
        G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].s_mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1), 1)
        G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].s_chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1), 0)
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = i_hands[hand].i_level} return true end)
    }))
end

local get_idref = Card.get_id
function Card:get_id(base)
    local id = get_idref(self)
    if SMODS.has_no_rank(self) then
        return 0
    end
    if base == true then
        return self.base.id
    end
    if G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == "j_fam_smudged_jester" then
                if id == 3 then
                    return 8
                elseif id == 6 then
                    return 9
                elseif id == 13 then
                    return 14
                end
            end
        end
    end
    return id
end

local is_suitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if SMODS.has_no_suit(self) then
        return false
    end
    local ref=is_suitref(self)
    if next(find_joker('Smeared Joker')) and (self.base.suit == 'Hearts' or self.base.suit == 'Diamonds') == (suit == 'Hearts' or suit == 'Diamonds') then
            return true
    end
    return (self.base.suit == suit) or ref
end

fam_ability_calulate = function(card, equation, extra_value, exclusions, inclusions, do_round)
  if do_round == nil then
    do_round = true
  end

  local operators = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end,
    ["%"] = function(a, b) return a % b end,
  }
  
  local function process_value(val)
    if type(val) == "number" then
      local res = operators[equation](val, extra_value)
      if do_round then
        return math.floor(res)
      else
        return res
      end
    else
      return val
    end
  end

  local function should_process(key, value)
    if type(key) ~= "string" then
      return true  
    end
    if inclusions and next(inclusions) then
      local valid = false
      for _, prefix in ipairs(inclusions) do
        if key:sub(1, #prefix) == prefix then
          valid = true
          break
        end
      end
      if not valid then
        return false
      end
    end
    if exclusions and exclusions[key] ~= nil then
        if exclusions[key] == true or value == exclusions[key] then
            return false
        end
    end
    return true
  end

  if card.ability and card.ability.extra then
    if type(card.ability.extra) == "number" then
      card.ability.prev_calc_value = card.ability.extra
      card.ability.extra = process_value(card.ability.extra)
    elseif type(card.ability.extra) == "table" then
      for key, value in pairs(card.ability.extra) do
        if value ~= nil and should_process(key, value) then
          card.ability.extra[key] = process_value(value)
        end
      end
    else
      card.ability.extra = process_value(card.ability.extra)
    end
  end

  if card.ability then
    if type(card.ability) == "number" then
      card.ability = process_value(card.ability)
    elseif type(card.ability) == "table" then
      for key, value in pairs(card.ability) do
        if value ~= nil and should_process(key, value) then
          card.ability[key] = process_value(value)
        end
      end
    end
  end
end

local is_faceref = Card.is_face
function Card:is_face(from_boss)
    local ref=is_faceref(self)
    if (self.debuff and not from_boss) or not G.jokers then return end
    local id = self:get_id()
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == "j_fam_prosopagnosia" then
            return false
        end
    end
    if id == 11 or id == 12 or id == 13 or next(find_joker("Pareidolia")) then
        return true
    end
    return ref
end

local set_costref = Card.set_cost
function Card:set_cost()
    local ref= set_costref(self)
    if (self.ability.set == 'Tarot' or (self.ability.set == 'Booster' and self.ability.name:find('Arcana'))) and #find_joker('j_fam_taromancer') > 0 then
        self.cost = 0
    end
    return ref
end

function set_sprite_suits(card, juice)
	local id = card:get_id(true)
    local position = id - 2
    -- Sets Sprites
    if not card.ability.suitless == true then -- what does this accpolish again?
        if card.base.suit == 'Diamonds' and card.ability.is_diamond == true and card.ability.is_club ~= true and card.ability.is_spade ~= true and card.ability.is_heart ~= true then
            return
        elseif card.base.suit == 'Clubs' and card.ability.is_club == true and card.ability.is_diamond ~= true and card.ability.is_spade ~= true and card.ability.is_heart ~= true then
            return
        elseif card.base.suit == 'Spades' and card.ability.is_spade == true and card.ability.is_diamond ~= true and card.ability.is_club ~= true and card.ability.is_heart ~= true then
            return
        elseif card.base.suit == 'Hearts' and card.ability.is_heart == true and card.ability.is_diamond ~= true and card.ability.is_spade ~= true and card.ability.is_club ~= true then
            return
        elseif card.base.suit == 'Diamonds' and card.ability.is_diamond ~= true and card.ability.is_club ~= true and card.ability.is_spade ~= true and card.ability.is_heart ~= true then
            return
        elseif card.base.suit == 'Clubs' and card.ability.is_club ~= true and card.ability.is_diamond ~= true and card.ability.is_spade ~= true and card.ability.is_heart ~= true then
            return
        elseif card.base.suit == 'Spades' and card.ability.is_spade ~= true and card.ability.is_diamond ~= true and card.ability.is_club ~= true and card.ability.is_heart ~= true then
            return
        elseif card.base.suit == 'Hearts' and card.ability.is_heart ~= true and card.ability.is_diamond ~= true and card.ability.is_spade ~= true and card.ability.is_club ~= true then
            return
        end
    end
    card.children.front.atlas = G.ASSET_ATLAS['fam_SuitEffects']
    if card.ability.suitless == true then
        card.children.front:set_sprite_pos({x = position, y = 11})
        return
    end
    if (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) then -- Clubs, Diamonds, Spades, & Hearts
        card.children.front:set_sprite_pos({x = position, y = 10})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and (card.base.suit == 'Clubs' or card.ability.is_club == true ) and not card.ability.is_diamond == true then -- Hearts, Clubs, & Spades
        card.children.front:set_sprite_pos({x = position, y = 7})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and not card.ability.is_club == true then -- Hearts, Diamonds, & Spades
        card.children.front:set_sprite_pos({x = position, y = 8})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and not card.ability.is_heart == true then -- Clubs, Diamonds, & Spades
        card.children.front:set_sprite_pos({x = position, y = 9})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and not card.ability.is_spade == true then -- Clubs, Diamonds, & Hearts
        card.children.front:set_sprite_pos({x = position, y = 6})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and not card.ability.is_heart == true and not card.ability.is_diamond == true then -- Clubs & Spades
        card.children.front:set_sprite_pos({x = position, y = 4})
    elseif (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and not card.ability.is_club == true and not card.ability.is_heart == true then -- Diamonds & Spades
        card.children.front:set_sprite_pos({x = position, y = 5})
    elseif (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and not card.ability.is_club == true and not card.ability.is_spade == true then -- Diamonds & Hearts
        card.children.front:set_sprite_pos({x = position, y = 1})
    elseif (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Clubs' or card.ability.is_club == true ) and not card.ability.is_heart == true and not card.ability.is_spade == true then -- Diamonds & Clubs
        card.children.front:set_sprite_pos({x = position, y = 3})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and not card.ability.is_club == true and not card.ability.is_diamond == true then -- Hearts & Spades
        card.children.front:set_sprite_pos({x = position, y = 2})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Clubs' or card.ability.is_club == true ) and not card.ability.is_spade == true and not card.ability.is_diamond == true then -- Hearts & Clubs
        card.children.front:set_sprite_pos({x = position, y = 0})
    end
end

local copy_cardref = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    new_card = copy_cardref(other, new_card, card_scale, playing_card, strip_edition)

    if other.ability.suitless then
        new_card.ability.suitless = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_club then
        new_card.ability.is_club = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_diamond then
        new_card.ability.is_diamond = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_spade then
        new_card.ability.is_spade = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_heart then
        new_card.ability.is_heart = true
        set_sprite_suits(new_card, false)
    end
    

    return new_card
end

local card_drawref = Card.draw
function Card:draw(layer)
    local card_drawref = card_drawref(self, layer)
    if self.ability.set == 'Familiar_Spectrals' then
        self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
    end
    return card_drawref
end

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front);
    if _center and _center.fifth_layer then
        if _center then
            self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fifth_layer)
            self.children.floating_sprite4.role.draw_major = self
            self.children.floating_sprite4.states.hover.can = false
            self.children.floating_sprite4.states.click.can = false
        end
    end
    if _center and _center.fouth_layer then
        if _center then
            self.children.floating_sprite3 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fouth_layer)
            self.children.floating_sprite3.role.draw_major = self
            self.children.floating_sprite3.states.hover.can = false
            self.children.floating_sprite3.states.click.can = false
        end
    end
    if _center and _center.third_layer then
        if _center then
            self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.third_layer)
            self.children.floating_sprite2.role.draw_major = self
            self.children.floating_sprite2.states.hover.can = false
            self.children.floating_sprite2.states.click.can = false
        end
    end
end

SMODS.optional_features.quantum_enhancements = true

--SMODS.Shader {
--    key = 'statics', 
--    path = 'statics.fs'
--}

SMODS.Atlas { key = 'Joker', path = 'JokersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Consumables', path = 'TarotsFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Enhancers', path = 'EnhancersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'SuitEffects', path = 'Double_Suit_CardsFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Suits', path = '8BitDeckFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'SuitsHc', path = '8BitDeckFam_opt2.png', px = 71, py = 95 }
SMODS.Atlas { key = 'UI', path = 'ui_assets.png', px = 34, py = 34 }
SMODS.Atlas { key = 'UIHc', path = 'ui_assets_opt2.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Booster', path = 'BoostersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Tags', path = 'TagsFam.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Stickers', path = 'StickersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Voucher', path = 'VouchersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'modicon', path = 'ModIcon.png', px = 18, py = 18 }
if (SMODS.Mods["CardSleeves"] or {}).can_load then
    SMODS.Atlas { key = 'cardsleeves', path = 'CardSleevesFam.png', px = 71, py = 95}
end

local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then lc() end
    G.ARGS.LOC_COLOURS.web = HEX("55d2be") 
    return lc(_c, _default)
end

local folders = NFS.getDirectoryItems(mod_path.."Items")
local folders2 = NFS.getDirectoryItems(mod_path.."Items/Consumable Types")
local folders3 = NFS.getDirectoryItems(mod_path.."Items/Cross Mod Content")
local function handle_name(curr_obj_name, Familiar_config)
    if type(curr_obj_name) == "string" then
        if Familiar_config[curr_obj_name] == nil then 
            Familiar_config[curr_obj_name] = true 
        end
    elseif type(curr_obj_name) == "table" then
        for _, name in ipairs(curr_obj_name) do
            if Familiar_config[name] == nil then 
                Familiar_config[name] = true 
            end
        end
    end
end
local function load_items(curr_obj, Familiar_config)
    handle_name(curr_obj.name, Familiar_config)

    local should_load = false
    if type(curr_obj.name) == "string" then
        should_load = Familiar_config[curr_obj.name]
    elseif type(curr_obj.name) == "table" then
        should_load = true
        for _, name in ipairs(curr_obj.name) do
            if not Familiar_config[name] then
                should_load = false
                break
            end
        end
    end
    if should_load then
        if curr_obj.init then curr_obj:init() end

        if not curr_obj.items then
            print("Warning: curr_obj has no items")
        else
            for _, item in ipairs(curr_obj.items) do
                if item.unlocked == true then
                    item.discovered = true
                else
                    item.discovered = false
                end
                if item.ignore == nil then
                    item.ignore = false
                end
                if SMODS[item.object_type] and not item.ignore then
                    SMODS[item.object_type](item) 
                elseif CardSleeves and CardSleeves[item.object_type] and not item.ignore then
                    CardSleeves[item.object_type](item)
                else
                    print("Error loading item "..item.key.." of unknown type "..item.object_type)
                end
            end
        end
    end
end
local objects = {}
for _, folder in ipairs(folders) do
    if folder == "Consumable Types" then
        for _, folder2 in ipairs(folders2) do
            local files = NFS.getDirectoryItems(mod_path.."Items/Consumable Types/"..folder2)

            for _, file in ipairs(files) do
                local f, err = SMODS.load_file("Items/Consumable Types/"..folder2.."/"..file)
                if err then
                    print("Error loading file: "..err)
                else
                    local curr_obj = f()
                    table.insert(objects, curr_obj) 
                end
            end
        end
    elseif folder == "Cross Mod Content" then
        if (SMODS.Mods["CardSleeves"] or {}).can_load then
            for _, folder3 in ipairs(folders3) do
                local files = NFS.getDirectoryItems(mod_path.."Items/Cross Mod Content/"..folder3)

                for _, file in ipairs(files) do
                    local f, err = SMODS.load_file("Items/Cross Mod Content/"..folder3.."/"..file)
                    if err then
                        print("Error loading file: "..err)
                    else
                        local curr_obj = f()
                        table.insert(objects, curr_obj)
                    end
                end
            end
        end
    else
        local files = NFS.getDirectoryItems(mod_path.."Items/"..folder)

        for _, file in ipairs(files) do
            local f, err = SMODS.load_file("Items/"..folder.."/"..file)
            if err then
                print("Error loading file: "..err)
            else
                local curr_obj = f()
                table.insert(objects, curr_obj)
            end
        end
    end
end
table.sort(objects, function(a, b)
    local function get_lowest_order(obj)
        if not obj.items then return math.huge end
        local lowest = math.huge
        for _, item in ipairs(obj.items) do
            if item.order and item.order < lowest then
                lowest = item.order
            end
        end
        return lowest
    end

    return get_lowest_order(a) < get_lowest_order(b)
end)
for _, curr_obj in ipairs(objects) do
    load_items(curr_obj, Familiar_config)
end

local familiarTabs = {
    {
        label = "Features",
        chosen = true,
        tab_definition_function = function()
            fam_nodes = {{n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = "Select features to enable (applies on game restart):", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
              }}}
            left_settings = {n=G.UIT.C, config={align = "tl", padding = 0.05}, nodes={}}
            right_settings = {n=G.UIT.C, config={align = "tl", padding = 0.05}, nodes={}}
            for k, _ in pairs(Familiar_config) do
                if k ~= "Familiar" then
                    if #right_settings.nodes < #left_settings.nodes then
                        right_settings.nodes[# right_settings.nodes+1] = create_toggle({label = k, ref_table = Familiar_config, ref_value = k})
                    else
                        left_settings.nodes[#left_settings.nodes+1] = create_toggle({label = k, ref_table = Familiar_config, ref_value = k})
                    end
                end
            end
            config = {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={left_settings,right_settings}}
            fam_nodes[#fam_nodes+1] = config
            return {
            n = G.UIT.ROOT,
            config = {
                emboss = 0.05,
                minh = 6,
                r = 0.1,
                minw = 10,
                align = "cm",
                padding = 0.2,
                colour = G.C.BLACK
            },
            nodes = fam_nodes
        }
        end
    },
}
  G.FUNCS.familiarMenu = function(e)
    local tabs = create_tabs({
        snap_to_nav = true,
        tabs = familiarTabs})
    G.FUNCS.overlay_menu{
            definition = create_UIBox_generic_options({
                back_func = "options",
                contents = {tabs}
            }),
        config = {offset = {x=0,y=10}}
    }
  end

SMODS.current_mod.extra_tabs = function() return familiarTabs end

----------------------------------------------
------------MOD CODE END---------------------