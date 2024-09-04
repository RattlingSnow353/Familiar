--- STEAMODDED HEADER
--- MOD_NAME: Familiar
--- MOD_ID: familiar
--- MOD_AUTHOR: [RattlingSnow353]
--- MOD_DESCRIPTION: Adds different variations to everything in-game
--- BADGE_COLOUR: 63e19a
--- DISPLAY_NAME: Familiar
--- VERSION: 0.1.0
--- PREFIX: fam

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
    get_idref(self, base)
    local id = self.base.id
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
    return self.base.id
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
    if self.debuff and not from_boss then return end
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
    if not card.ability.suitless == true then
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
    if juice == true then
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            card:flip()
        return true end }))
    end
    card.children.front.atlas = G.ASSET_ATLAS['fam_SuitEffects']
    if card.ability.suitless == true then
        card.children.front:set_sprite_pos({x = position, y = 11})
    end
    if (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and not card.ability.is_club == true and not card.ability.is_diamond == true then -- Hearts & Spades
        card.children.front:set_sprite_pos({x = position, y = 2})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Clubs' or card.ability.is_club == true ) and not card.ability.is_spade == true and not card.ability.is_diamond == true then -- Hearts & Clubs
        card.children.front:set_sprite_pos({x = position, y = 0})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and (card.base.suit == 'Clubs' or card.ability.is_club == true ) and not card.ability.is_diamond == true then -- Hearts, Clubs, & Spades
        card.children.front:set_sprite_pos({x = position, y = 7})
    elseif (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and not card.ability.is_club == true then -- Hearts, Diamonds, & Spades
        card.children.front:set_sprite_pos({x = position, y = 8})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and not card.ability.is_heart == true and not card.ability.is_diamond == true then -- Clubs & Spades
        card.children.front:set_sprite_pos({x = position, y = 4})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and not card.ability.is_heart == true then -- Clubs, Diamonds, & Spades
        card.children.front:set_sprite_pos({x = position, y = 9})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and not card.ability.is_spade == true then -- Clubs, Diamonds, & Hearts
        card.children.front:set_sprite_pos({x = position, y = 6})
    elseif (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) and not card.ability.is_club == true and not card.ability.is_heart == true then -- Diamonds & Spades
        card.children.front:set_sprite_pos({x = position, y = 5})
    elseif (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and not card.ability.is_club == true and not card.ability.is_spade == true then -- Diamonds & Hearts
        card.children.front:set_sprite_pos({x = position, y = 1})
    elseif (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Clubs' or card.ability.is_club == true ) and not card.ability.is_heart == true and not card.ability.is_spade == true then -- Diamonds & Clubs
        card.children.front:set_sprite_pos({x = position, y = 3})
    elseif (card.base.suit == 'Clubs' or card.ability.is_club == true ) and (card.base.suit == 'Hearts' or card.ability.is_heart == true ) and (card.base.suit == 'Diamonds' or card.ability.is_diamond == true ) and (card.base.suit == 'Spades' or card.ability.is_spade == true ) then -- Clubs, Diamonds, Spades, & Hearts
        card.children.front:set_sprite_pos({x = position, y = 10})
    end
    if juice == true then
        card:juice_up(0.3, 0.5)
        card:flip()
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

function Card:get_chip_x_bonus()
    if self.debuff then return 0 end
    if self.ability.set == 'Joker' then return 0 end
    if self.ability.fam_x_chips <= 1 then return 0 end
    return self.ability.fam_x_chips
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
    G.localization.misc.v_dictionary.fam_penalty = "-#1# Chips"
    G.localization.misc.labels.unstable = "Unstable"
end

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front);
    if _center and _center.fifth_layer then
        if _center and _center.set == 'tekana' then
            self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fifth_layer)
            self.children.floating_sprite4.role.draw_major = self
            self.children.floating_sprite4.states.hover.can = false
            self.children.floating_sprite4.states.click.can = false
        else
            self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fifth_layer)
            self.children.floating_sprite4.role.draw_major = self
            self.children.floating_sprite4.states.hover.can = false
            self.children.floating_sprite4.states.click.can = false
        end
    end
    if _center and _center.fouth_layer then
        if _center and _center.set == 'tekana' then
            self.children.floating_sprite3 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fouth_layer)
            self.children.floating_sprite3.role.draw_major = self
            self.children.floating_sprite3.states.hover.can = false
            self.children.floating_sprite3.states.click.can = false
        else
            self.children.floating_sprite3 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fouth_layer)
            self.children.floating_sprite3.role.draw_major = self
            self.children.floating_sprite3.states.hover.can = false
            self.children.floating_sprite3.states.click.can = false
        end
    end
    if _center and _center.third_layer then
        if _center and _center.set == 'tekana' then
            self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.third_layer)
            self.children.floating_sprite2.role.draw_major = self
            self.children.floating_sprite2.states.hover.can = false
            self.children.floating_sprite2.states.click.can = false
        else
            self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.third_layer)
            self.children.floating_sprite2.role.draw_major = self
            self.children.floating_sprite2.states.hover.can = false
            self.children.floating_sprite2.states.click.can = false
        end
    end
end

--SMODS.Shader {
--    key = 'statics', 
--    path = 'statics.fs'
--}

function tekana_shut_down(self, _center, _front)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.soul_pos)
        self.children.floating_sprite2.role.draw_major = self
        self.children.floating_sprite2.states.hover.can = false
        self.children.floating_sprite2.states.click.can = false
        self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.soul_pos)
        self.children.floating_sprite4.role.draw_major = self
        self.children.floating_sprite4.states.hover.can = false
        self.children.floating_sprite4.states.click.can = false
    return true end }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5,
        func = (function() 
        self:remove()
        local card = create_card("tekana",G.consumeables, nil, nil, true, nil, nil, nil)
        G.consumeables:emplace(card)
        return true end)
    })) 
end

function gltich(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    local dissolve_time = 0.7 * (dissolve_time_fac or 1)
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    if not no_juice then self:juice_up() end

    local childParts = Particles(0, 0, 0, 0, {
        timer_type = 'TOTAL',
        timer = 0.01 * dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7 * dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay = 0.7 * dissolve_time,
        func = function()
            childParts:fade(0.3 * dissolve_time)
            return true
        end
    }))

    if not silent then
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                play_sound('whoosh2', math.random() * 0.2 + 0.9, 0.5)
                play_sound('crumple' .. math.random(1, 5), math.random() * 0.2 + 0.9, 0.5)
                return true
            end
        }))
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay = dissolve_time,
        func = function(t)
            local scale_mod = 0.07 * (1 - t)
            local flicker = math.random() * (1 - t)
            return t
        end
    }))

end

fam_operators = {"+"}
fam_numbers = {"0","1","2","3","4","5","6","7","8","9","10","25","m","nan","nil","???"}
fam_msgs_mult = {
	{string = 'rand()', colour = G.C.UI.TEXT_INACTIVE},
	{string = 'Mult'},
	{string = 'Mult'},
    {string = 'Mult'},
    {string = 'Mult'},
    {string = 'Mult'},
    {string = 'Mult'},
	{string = "#@"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'D'), colour = G.C.RED},
}
fam_msgs_chips = {
	{string = 'rand()', colour = G.C.UI.TEXT_INACTIVE},
	{string = 'Chips'},
	{string = 'Chips'},
	{string = 'Chips'},
    {string = 'Chips'},
    {string = 'Chips'},
    {string = 'Chips'},
	{string = "#@"..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11)..(G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1,1) or 'D'), colour = G.C.BLUE},
}

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
for _, folder in ipairs(folders) do
    if folder == "Consumable Types" then
        for _, folder2 in ipairs(folders2) do
            local files = NFS.getDirectoryItems(mod_path.."Items/Consumable Types/"..folder2)
            for _, file in ipairs(files) do
                local f, err = SMODS.load_file("Items/"..file)
                if not err then
                    local curr_obj = f()
                    if Familiar_config[curr_obj.name] == nil then Familiar_config[curr_obj.name] = true end
                end
            end
            for _, file in ipairs(files) do
                print("Loading file "..file)
                local f, err = SMODS.load_file("Items/Consumable Types/"..folder2.."/"..file)
                if err then print("Error loading file: "..err) else
                    local curr_obj = f()
                    if Familiar_config[curr_obj.name] == nil then Familiar_config[curr_obj.name] = true end
                    if Familiar_config[curr_obj.name] then
                        if curr_obj.init then curr_obj:init() end
                        if not curr_obj.items then
                            print("Warning: "..file.." has no items")
                        else
                            for _, item in ipairs(curr_obj.items) do
                                item.discovered = true
                                if SMODS[item.object_type] then
                                    SMODS[item.object_type](item)
                                else
                                    print("Error loading item "..item.key.." of unknown type "..item.object_type)
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif folder == "Cross Mod Content" then
        for _, folder3 in ipairs(folders3) do
            local files = NFS.getDirectoryItems(mod_path.."Items/Cross Mod Content/"..folder3)
            for _, file in ipairs(files) do
                local f, err = SMODS.load_file("Items/"..file)
                if not err then
                    local curr_obj = f()
                    if Familiar_config[curr_obj.name] == nil then Familiar_config[curr_obj.name] = true end
                end
            end
            for _, file in ipairs(files) do
                print("Loading file "..file)
                local f, err = SMODS.load_file("Items/Cross Mod Content/"..folder3.."/"..file)
                if err then print("Error loading file: "..err) else
                    local curr_obj = f()
                    if Familiar_config[curr_obj.name] == nil then Familiar_config[curr_obj.name] = true end
                    if Familiar_config[curr_obj.name] then
                        if curr_obj.init then curr_obj:init() end
                        if not curr_obj.items then
                            print("Warning: "..file.." has no items")
                        else
                            for _, item in ipairs(curr_obj.items) do
                                item.discovered = true
                                if SMODS[item.object_type] then
                                    SMODS[item.object_type](item)
                                elseif CardSleeves[item.object_type] then
                                    CardSleeves[item.object_type](item)
                                else
                                    print("Error loading item "..item.key.." of unknown type "..item.object_type)
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        local files = NFS.getDirectoryItems(mod_path.."Items/"..folder)
        for _, file in ipairs(files) do
            local f, err = SMODS.load_file("Items/"..file)
            if not err then
                local curr_obj = f()
                if Familiar_config[curr_obj.name] == nil then Familiar_config[curr_obj.name] = true end
            end
        end
        for _, file in ipairs(files) do
            print("Loading file "..file)
            local f, err = SMODS.load_file("Items/"..folder.."/"..file)
            if err then print("Error loading file: "..err) else
                local curr_obj = f()
                if Familiar_config[curr_obj.name] == nil then Familiar_config[curr_obj.name] = true end
                if Familiar_config[curr_obj.name] then
                    if curr_obj.init then curr_obj:init() end
                    if not curr_obj.items then
                    print("Warning: "..file.." has no items")
                    else
                        for _, item in ipairs(curr_obj.items) do
                            item.discovered = true
                            if SMODS[item.object_type] then
                                SMODS[item.object_type](item)
                            else
                                print("Error loading item "..item.key.." of unknown type "..item.object_type)
                            end
                        end
                    end
                end
            end
        end
    end
end

if not SpectralPack then
    SpectralPack = {}
    local ct = create_tabs
    function create_tabs(args)
        if args and args.tab_h == 7.05 then
            args.tabs[#args.tabs+1] = {
                label = "Spectral Pack",
                tab_definition_function = function() return {
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
                    nodes = SpectralPack
                } end
            }
        end
        return ct(args)
    end
  end
  SpectralPack[#SpectralPack+1] = UIBox_button{ label = {"Familiar"}, button = "familiarMenu", colour = HEX("63e19a"), minw = 5, minh = 0.7, scale = 0.6}
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
