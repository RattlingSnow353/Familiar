--- STEAMODDED HEADER
--- MOD_NAME: Familiar
--- MOD_ID: familiar
--- MOD_AUTHOR: [RattlingSnow353, Humplydinkle]
--- MOD_DESCRIPTION: Adds different variations to everything in-game
--- BADGE_COLOUR: 63e19a
--- DISPLAY_NAME: Familiar
--- VERSION: 0.1.7
--- PREFIX: fam
--- DEPENDENCIES: 
--- PRIORITY: 1

---------------------------------------------- 
------------MOD CODE ------------------------- 

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

function create_consumable(card_type,tag,messae,extra, thing1, thing2)
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
                    card_eval_status_text(card,'extra',nil,nil,nil,{message=messae})
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

function mult_level_up_hand(card, hand, instant, XMult, XChips)
    G.GAME.hands[hand].level = math.max(0, G.GAME.hands[hand].level)
    G.GAME.hands[hand].mult = math.max((XMult * G.GAME.hands[hand].mult), 1)
    G.GAME.hands[hand].chips = math.max((XChips * G.GAME.hands[hand].chips), 0)
    G.GAME.hands[hand].l_chips = math.max((XChips * G.GAME.hands[hand].l_chips), 0)
    G.GAME.hands[hand].l_mult = math.max((XMult * G.GAME.hands[hand].l_mult), 1)
    if not instant then 
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
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
        update_hand_text({delay = 0}, {mult = 0, StatusText = true})
        update_hand_text({delay = 0}, {chips = 0, StatusText = true})
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=""})
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
    }))
end

local get_idref = Card.get_id
function Card:get_id(base)
    local id = get_idref(self)
    if base == true then
        return self.base.id
    end
    if self.config.center == G.P_CENTERS.m_fam_split then
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i] == self then
                if i ~= 1 then
                    return G.hand.highlighted[i-1]:get_id(base)
                else
                    return 0
                end
            end
        end
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
    local ref=is_suitref(self)
    if self.config.center == G.P_CENTERS.m_fam_split then
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i] == self then
                if i ~= #G.hand.highlighted then
                    return G.hand.highlighted[i+1]:is_suit(suit, bypass_debuff, flush_calc)
                else
                    return false
                end
            end
        end
    end
    if self.ability.suitless == true then
        return false
    end
    if next(find_joker('Smeared Joker')) then
        if (self.base.suit == 'Spades' or self.ability.is_spade == true) or (self.base.suit == 'Clubs' or self.ability.is_club == true) then
            if suit == 'Spades' or suit == 'Clubs' then
                return true
            end
        end
        if (self.base.suit == 'Hearts' or self.ability.is_heart == true) or (self.base.suit == 'Diamonds' or self.ability.is_diamond == true) then
            if suit == 'Hearts' or suit == 'Diamonds' then
                return true
            end
        end
    else
        if self.ability.is_spade == true then
            set_sprite_suits(self, false)
            if suit == 'Spades' then
                return true
            end
        end
        if self.ability.is_heart == true then
            set_sprite_suits(self, false)
            if suit == 'Hearts' then
                return true
            end
        end
        if self.ability.is_club == true then
            set_sprite_suits(self, false)
            if suit == 'Clubs' then
                return true
            end
        end
        if self.ability.is_diamond == true then
            set_sprite_suits(self, false)
            if suit == 'Diamonds' then
                return true
            end
        end
    end
    return (self.base.suit == suit) or ref
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

function SMODS.current_mod.process_loc_text()
    G.localization.misc.labels.unstable = "Unstable"
end

--local set_spritesref = Card.set_sprites
--function Card:set_sprites(_center, _front)
--    set_spritesref(self, _center, _front);
--    if _center and _center.fifth_layer then
--        if _center and _center.set == 'tekana' then
--            self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fifth_layer)
--            self.children.floating_sprite4.role.draw_major = self
--            self.children.floating_sprite4.states.hover.can = false
--            self.children.floating_sprite4.states.click.can = false
--        else
--            self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fifth_layer)
--            self.children.floating_sprite4.role.draw_major = self
--            self.children.floating_sprite4.states.hover.can = false
--            self.children.floating_sprite4.states.click.can = false
--        end
--    end
--    if _center and _center.fouth_layer then
--        if _center and _center.set == 'tekana' then
--            self.children.floating_sprite3 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fouth_layer)
--            self.children.floating_sprite3.role.draw_major = self
--            self.children.floating_sprite3.states.hover.can = false
--            self.children.floating_sprite3.states.click.can = false
--        else
--            self.children.floating_sprite3 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fouth_layer)
--            self.children.floating_sprite3.role.draw_major = self
--            self.children.floating_sprite3.states.hover.can = false
--            self.children.floating_sprite3.states.click.can = false
--        end
--    end
--    if _center and _center.third_layer then
--        if _center and _center.set == 'tekana' then
--            self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.third_layer)
--            self.children.floating_sprite2.role.draw_major = self
--            self.children.floating_sprite2.states.hover.can = false
--            self.children.floating_sprite2.states.click.can = false
--        else
--            self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.third_layer)
--            self.children.floating_sprite2.role.draw_major = self
--            self.children.floating_sprite2.states.hover.can = false
--            self.children.floating_sprite2.states.click.can = false
--        end
--    end
--end

--SMODS.Shader {
--    key = 'statics', 
--    path = 'statics.fs'
--}

SMODS.Atlas { key = 'Joker', path = 'JokersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Consumables', path = 'TarotsFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Enhancers', path = 'EnhancersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'SuitEffects', path = 'Double_Suit_CardsFam.png', px = 71, py = 95 }
--SMODS.Atlas { key = 'Suits', path = '8BitDeckFam.png', px = 71, py = 95 }
--SMODS.Atlas { key = 'SuitsHc', path = '8BitDeckFam_opt2.png', px = 71, py = 95 }
--SMODS.Atlas { key = 'UI', path = 'ui_assets.png', px = 34, py = 34 }
--SMODS.Atlas { key = 'UIHc', path = 'ui_assets_opt2.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Booster', path = 'BoostersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Tags', path = 'TagsFam.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Stickers', path = 'StickersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Voucher', path = 'VouchersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'modicon', path = 'ModIcon.png', px = 18, py = 18 }
if (SMODS.Mods["CardSleeves"] or {}).can_load then
    SMODS.Atlas { key = 'cardsleeves', path = 'CardSleevesFam.png', px = 71, py = 95}
end

--local lc = loc_colour
--function loc_colour(_c, _default)
--    if not G.ARGS.LOC_COLOURS then lc() end
--    G.ARGS.LOC_COLOURS.web = HEX("55d2be") 
--    return lc(_c, _default)
--end

jester_table = {
    ["j_joker"] = {},
    ["j_greedy_joker"] = {},
    ["j_lusty_joker"] = {},
    ["j_wrathful_joker"] = {},
    ["j_gluttenous_joker"] = {},
    ["j_jolly"] = {},
    ["j_zany"] = {},
    ["j_mad"] = {},
    ["j_crazy"] = {},
    ["j_droll"] = {},
    ["j_sly"] = {},
    ["j_wily"] = {},
    ["j_clever"] = {},
    ["j_devious"] = {},
    ["j_crafty"] = {},
    ["j_half"] = {},
    ["j_stencil"] = {},
    ["j_four_fingers"] = {},
    ["j_mime"] = {},
    ["j_credit_card"] = {},
    ["j_ceremonial"] = {},
    ["j_banner"] = {},
    ["j_mystic_summit"] = {},
    ["j_marble"] = {},
    ["j_loyalty_card"] = {},
    ["j_8_ball"] = {},
    ["j_misprint"] = {},
    ["j_dusk"] = {},
    ["j_raised_fist"] = {},
    ["j_chaos"] = {},
    ["j_fibonacci"] = {},
    ["j_steel_joker"] = {},
    ["j_scary_face"] = {},
    ["j_abstract"] = {},
    ["j_delayed_grat"] = {},
    ["j_hack"] = {},
    ["j_pareidolia"] = {},
    ["j_gros_michel"] = {},
    ["j_even_steven"] = {},
    ["j_odd_todd"] = {},
    ["j_scholar"] = {},
    ["j_business"] = {},
    ["j_supernova"] = {},
    ["j_ride_the_bus"] = {},
    ["j_space"] = {},
    ["j_egg"] = {},
    ["j_burglar"] = {},
    ["j_blackboard"] = {},
    ["j_runner"] = {},
    ["j_ice_cream"] = {},
    ["j_dna"] = {},
    ["j_splash"] = {},
    ["j_blue_joker"] = {},
    ["j_sixth_sense"] = {},
    ["j_constellation"] = {},
    ["j_hiker"] = {},
    ["j_faceless"] = {},
    ["j_green_joker"] = {},
    ["j_superposition"] = {},
    ["j_todo_list"] = {},
    ["j_cavendish"] = {},
    ["j_card_sharp"] = {},
    ["j_red_card"] = {},
    ["j_madness"] = {},
    ["j_square"] = {},
    ["j_seance"] = {},
    ["j_riff_raff"] = {},
    ["j_vampire"] = {},
    ["j_shortcut"] = {},
    ["j_hologram"] = {},
    ["j_vagabond"] = {},
    ["j_baron"] = {},
    ["j_cloud_9"] = {},
    ["j_rocket"] = {},
    ["j_obelisk"] = {},
    ["j_midas_mask"] = {},
    ["j_luchador"] = {},
    ["j_photograph"] = {},
    ["j_gift"] = {},
    ["j_turtle_bean"] = {},
    ["j_erosion"] = {},
    ["j_reserved_parking"] = {},
    ["j_mail"] = {},
    ["j_to_the_moon"] = {},
    ["j_hallucination"] = {},
    ["j_fortune_teller"] = {},
    ["j_juggler"] = {},
    ["j_drunkard"] = {},
    ["j_stone"] = {},
    ["j_golden"] = {},
    ["j_lucky_cat"] = {},
    ["j_baseball"] = {},
    ["j_bull"] = {},
    ["j_diet_cola"] = {},
    ["j_trading"] = {},
    ["j_flash"] = {},
    ["j_popcorn"] = {},
    ["j_trousers"] = {},
    ["j_ancient"] = {},
    ["j_ramen"] = {},
    ["j_walkie_talkie"] = {},
    ["j_selzer"] = {},
    ["j_castle"] = {},
    ["j_smiley"] = {},
    ["j_campfire"] = {},
    ["j_ticket"] = {},
    ["j_mr_bones"] = {},
    ["j_acrobat"] = {},
    ["j_sock_and_buskin"] = {},
    ["j_swashbuckler"] = {},
    ["j_troubadour"] = {},
    ["j_certificate"] = {},
    ["j_smeared"] = {},
    ["j_throwback"] = {},
    ["j_hanging_chad"] = {},
    ["j_rough_gem"] = {},
    ["j_bloodstone"] = {},
    ["j_arrowhead"] = {},
    ["j_onyx_agate"] = {},
    ["j_glass"] = {},
    ["j_ring_master"] = {},
    ["j_flower_pot"] = {},
    ["j_blueprint"] = {},
    ["j_wee"] = {},
    ["j_merry_andy"] = {},
    ["j_oops"] = {},
    ["j_idol"] = {},
    ["j_seeing_double"] = {},
    ["j_matador"] = {},
    ["j_hit_the_road"] = {},
    ["j_duo"] = {},
    ["j_trio"] = {},
    ["j_family"] = {},
    ["j_order"] = {},
    ["j_tribe"] = {},
    ["j_stuntman"] = {},
    ["j_invisible"] = {},
    ["j_brainstorm"] = {},
    ["j_satellite"] = {},
    ["j_shoot_the_moon"] = {},
    ["j_drivers_license"] = {},
    ["j_cartomancer"] = {},
    ["j_astronomer"] = {},
    ["j_burnt"] = {},
    ["j_bootstraps"] = {},
    ["j_caino"] = {},
    ["j_triboulet"] = {},
    ["j_yorick"] = {},
    ["j_chicot"] = {},
    ["j_perkeo"] = {},
}

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
        for _, name in ipairs(curr_obj.name) do
            if Familiar_config[name] then
                should_load = true
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
                item.discovered = true
                if SMODS[item.object_type] then
                    SMODS[item.object_type](item) 
                    if item.object_type == "Joker" and item.familiar then
                        for key, _ in pairs(jester_table) do
                            if key == item.familiar then
                                table.insert(jester_table[item.familiar], item.key)
                                print(item.key.." has been added to "..key)
                            end
                        end 
                    end
                elseif CardSleeves and CardSleeves[item.object_type] then
                    CardSleeves[item.object_type](item)
                else
                    print("Error loading item "..item.key.." of unknown type "..item.object_type)
                end
            end
        end
    end
end
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
                    load_items(curr_obj, Familiar_config)
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
                        load_items(curr_obj, Familiar_config)
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
                load_items(curr_obj, Familiar_config)
            end
        end
    end
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