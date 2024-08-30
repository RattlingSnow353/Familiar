--- STEAMODDED HEADER
--- MOD_NAME: Familiar
--- MOD_ID: familiar
--- MOD_AUTHOR: [RattlingSnow353]
--- MOD_DESCRIPTION: Adds different variations to everything in-game
--- BADGE_COLOUR: cecf4b
--- DISPLAY_NAME: Familiar
--- VERSION: 0.1.0
--- PREFIX: fam

---------------------------------------------- 
------------MOD CODE ------------------------- 

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

local function create_joker(card_type,tag,message,extra, rarity)
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

function SMODS.current_mod.process_loc_text()
    G.localization.misc.v_dictionary.fam_penalty = "-#1# Chips"
    G.localization.misc.labels.unstable = "Unstable"
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
SMODS.Atlas { key = 'Booster', path = 'BoostersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Tags', path = 'TagsFam.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Stickers', path = 'StickersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Voucher', path = 'VouchersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'modicon', path = 'ModIcon.png', px = 18, py = 18 }

SMODS.ConsumableType { 
    key = 'Familiar_Tarots',
    collection_rows = { 5,6 },
    primary_colour = HEX("2e3530"),
    secondary_colour = HEX("2e3530"),
    loc_txt = {
        collection = 'Fortune Cards',
        name = 'Fortune',
        label = 'Fortune',
        undiscovered = {
			name = "Not Discovered",
			text = {
				"Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
			},
		},
    },
}
SMODS.UndiscoveredSprite {
	key = "Familiar_Tarots",
	atlas = "Consumables",
	pos = {
		x = 6,
		y = 2,
	}
}
SMODS.ConsumableType { 
    key = 'Familiar_Planets',
    collection_rows = { 6,6 },
    primary_colour = HEX("675baa"),
    secondary_colour = HEX("675baa"),
    loc_txt = {
        collection = 'Sacred Cards',
        name = 'Sacred',
        label = 'Sacred',
        undiscovered = {
			name = "Not Discovered",
			text = {
				"Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
			},
		},
    },
}
SMODS.UndiscoveredSprite {
	key = "Familiar_Planets",
	atlas = "Consumables",
	pos = {
		x = 7,
		y = 2,
	}
}
local MenmentosType = SMODS.ConsumableType { 
    key = 'Familiar_Spectrals',
    collection_rows = { 4,5 },
    primary_colour = HEX("e16363"),
    secondary_colour = HEX("e16363"),
    shop_rate = 0,
    loc_txt = {
        collection = 'Memento Cards',
        name = 'Mementos',
        label = 'Mementos',
        undiscovered = {
			name = "Not Discovered",
			text = {
				"Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
			},
		},
    },
}
SMODS.UndiscoveredSprite {
	key = "Familiar_Spectrals",
	atlas = "Consumables",
	pos = {
		x = 5,
		y = 2,
	}
}
SMODS.ConsumableType { 
    key = 'tekana',
    collection_rows = { 5,6 },
    primary_colour = HEX("2e3530"),
    secondary_colour = HEX("2e3530"),
    loc_txt = {
        collection = 'Tekana Cards',
        name = 'Tekana',
        label = 'Tekana',
        undiscovered = {
			name = "Not Discovered",
			text = {
				"Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
			},
		},
    },
}
SMODS.UndiscoveredSprite {
	key = "tekana",
	atlas = "Consumables",
	pos = {
		x = 6,
		y = 2,
	}
}

-- JokersV1
SMODS.Joker {
    key = 'joey_j_jester',
    config = {
        extra = { fam_x_chips = 1.2 },
    },
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Joey. J. Jester',
            text = {
                "{X:chips,C:white}X#1#{} Chips",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'joyful_jester',
    config = {
        extra = { poker_hand = "Pair", money = 2},
    },
    atlas = 'Joker',
    pos = { x = 2, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Joyful Jester',
            text = {
                "Gain {C:money}$#2#{} if played",
                "hand contains",
                "a {C:attention}#1#",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            ease_dollars(card.ability.extra.money)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                message = localize('$')..card.ability.extra.money,
                dollars = card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
}
SMODS.Joker {
    key = 'peppy_jester',
    config = {
        extra = { poker_hand = "Three of a Kind", money = 4},
    },
    atlas = 'Joker',
    pos = { x = 3, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Peppy Jester',
            text = {
                "Gain {C:money}$#2#{} if played",
                "hand contains",
                "a {C:attention}#1#",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            ease_dollars(card.ability.extra.money)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                message = localize('$')..card.ability.extra.money,
                dollars = card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
}
SMODS.Joker {
    key = 'mirthful_jester',
    config = {
        extra = { poker_hand = "Two Pair", money = 3},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Mirthful Jester',
            text = {
                "Gain {C:money}$#2#{} if played",
                "hand contains",
                "a {C:attention}#1#",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            ease_dollars(card.ability.extra.money)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                message = localize('$')..card.ability.extra.money,
                dollars = card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
}
SMODS.Joker {
    key = 'cheerful_jester',
    config = {
        extra = { poker_hand = "Straight", money = 4},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Cheerful Jester',
            text = {
                "Gain {C:money}$#2#{} if played",
                "hand contains",
                "a {C:attention}#1#",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            ease_dollars(card.ability.extra.money)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                message = localize('$')..card.ability.extra.money,
                dollars = card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
}
SMODS.Joker {
    key = 'delightful_jester',
    config = {
        extra = { poker_hand = "Flush", money = 3},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Delightful Jester',
            text = {
                "Gain {C:money}$#2#{} if played",
                "hand contains",
                "a {C:attention}#1#",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            ease_dollars(card.ability.extra.money)
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                message = localize('$')..card.ability.extra.money,
                dollars = card.ability.extra.money,
                colour = G.C.MONEY
            }
        end
    end
}
--SMODS.Joker {
--    key = 'debit_card',
--    config = {
--        extra = {money = 0, interest = 1, mod = 5, trm = true},
--    },
--    atlas = 'Joker',
--    pos = { x = 5, y = 1 },
--    loc_txt = {
--        ['en-us'] = {
--            name = 'Debit Card',
--            text = {
--                "Store {C:red}half{} of cash-out money,",
--                "earn {C:money}$1{} more interest every {C:money}$#3#",
--                "sell to retrieve money",
--                "{C:inactive}(Currently {C:money}$#2#{})",
--            }
--        }
--    },
--    rarity = 2,
--    cost = 1,
--    blueprint_compat = false,
--    loc_vars = function(self, info_queue, card)
--        return { vars = { card.ability.extra.money, card.ability.extra.interest, card.ability.extra.mod } }
--    end,
--    calculate = function(self, card, context)
--        if card.ability.extra.trm then
--            local tempint = G.GAME.interest_amount
--        end
--        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
--            card.ability.extra.interest = card.ability.extra.money/card.ability.extra.mod
--            card.ability.extra.money = card.ability.extra.money + G.GAME.current_round.dollars/2
--            G.GAME.current_round.dollars = G.GAME.current_round.dollars/2
--            G.GAME.interest_amount = tempint + card.ability.extra.interest
--        end
--        if context.selling_self then
--            G.GAME.interest_amount = tempint
--            ease_dollars(card.ability.extra.money)
--        end
--    end
--}
SMODS.Joker {
    key = 'flag_of_surrender',
    config = {
        extra = {mult = 10, mult_mod = 10},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = 'Flag of Surrender',
            text = {
                "{C:mult}+#1#{} Mult",
                "for each played",
                "{C:attention}hand{} this round",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.mult = (G.GAME.current_round.hands_played + 1) * card.ability.extra.mult_mod
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult, 
                colour = G.C.MULT,
                card = self
            }
        end
    end
}
SMODS.Joker {
    key = 'prosopagnosia',
    config = {
        extra = { },
    },
    atlas = 'Joker',
    pos = { x = 6, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = 'Prosopagnosia',
            text = {
                "No cards",
                "are considered",
                "{C:attention}face{} cards",
            }
        }
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
    end
}
SMODS.Joker {
    key = 'dry-erase_board',
    config = {
        extra = { fam_x_chips = 3 },
    },
    atlas = 'Joker',
    pos = { x = 2, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Dry-Erase Board',
            text = {
                "{X:chips,C:white}X#1#{} Chips if",
                "all cards scored",
                "are {C:hearts}Hearts{} and {C:diamonds}Diamonds",
            }
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips } }
    end,
    calculate = function(self, card, context)
        local red_suits, all_cards = 0, 0
        for k, v in ipairs(G.hand.cards) do
            all_cards = all_cards + 1
            if v:is_suit('Hearts', nil, true) or v:is_suit('Diamonds', nil, true) then
                red_suits = red_suits + 1
            end
        end
        if context.joker_main and red_suits == all_cards then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'neopolitan',
    config = {
        extra = {chips = 50, chip_mod = 10 , mult = 10, mult_mod = 2, money = 5, money_mod = 1},
    },
    atlas = 'Joker',
    pos = { x = 14, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Neopolitan',
            text = {
                "{C:blue}+#3#{} Chips or {C:mult}+#1#{} Mult or {C:money}+$#5#{}",
                "{C:blue}-#4#{} Chips, {C:mult}-#2#{} Mult, and {C:money}-$#6#{}",
                "for every hand played",
            }
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.money, card.ability.extra.money_mod} }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.mult - card.ability.extra.mult_mod <= 0 or card.ability.extra.chips - card.ability.extra.chip_mod <= 0 or card.ability.extra.money - card.ability.extra.money_mod <= 0 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_mod
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_mod
                card.ability.extra.money = card.ability.extra.money - card.ability.extra.money_mod
                if 1 == 1 then
                    return {
                        message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.mult_mod}},
                        colour = G.C.RED,
                    }
                end
                if 1 == 1 then
                    return {
                        message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chip_mod}},
                        colour = G.C.CHIPS,
                    }
                end
                return {
                    message = localize('-$')..card.ability.extra.money_mod,
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            if pseudorandom('neopolitan') < G.GAME.probabilities.normal/3 then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult, 
                    colour = G.C.RED,
                    card = self,
                }
            elseif pseudorandom('neopolitan') < G.GAME.probabilities.normal/2 then
                ease_dollars(card.ability.extra.money)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    message = localize('$')..card.ability.extra.money,
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY
                }
            else
                return {
                    message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                    chip_mod = card.ability.extra.chips, 
                    colour = G.C.CHIPS,
                    card = self,
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'strawberry',
    config = {
        extra = {mult = 20, mult_mod = 1},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Strawberry',
            text = {
                "{C:mult}+#1#{} Mult",
                "{C:mult}-#2#{} Mult for",
                "every hand played",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod} }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.mult - card.ability.extra.mult_mod <= 0 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_mod
                return {
                    message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.mult_mod}},
                    colour = G.C.RED,
                }
                
            end
        end
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult, 
                colour = G.C.RED,
                card = self,
            }
        end
    end
}
SMODS.Joker {
    key = 'rna',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'RNA',
            text = {
                "If {C:attention}first discard{} of round",
                "has only {C:attention}1{} card, add a",
                "permanent copy to deck",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if G.GAME.current_round.discards_used <= 0 then
            local eval = function()
                return G.GAME.current_round.discards_used <= 0
            end
            juice_card_until(card, eval, true)
        end
        if G.GAME.current_round.discards_used <= 0 and context.discard then
            if #context.full_hand == 1 then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                G.deck:emplace(_card)
                _card.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        _card:start_materialize()
                        return true
                    end
                })) 
                return {
                    message = localize('k_copied_ex'),
                    colour = G.C.RED,
                    card = self,
                    playing_cards_created = {true}
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'sploosh',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Sploosh',
            text = {
                "Every {C:attention}In-hand{} card vaules",
                "counts in scoring",
            }
        }
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for i = 1, #G.hand.cards do
                highlight_card(G.hand.cards[i])
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local id = context.other_card:get_chip_bonus()
            SMODS.eval_this(context.other_card, {chip_mod = id, message = localize{type='variable',key='a_chips',vars={id}}} )
        end
        if context.joker_main then
            for i = 1, #G.hand.cards do
                highlight_card(G.hand.cards[i],(i-0.999)/(#G.hand.cards-0.998),'down')
            end
        end
    end
}
SMODS.Joker {
    key = 'red_jester',
    config = {
        extra = {mult = 1, deckcards = 26},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Red Jester',
            text = {
                "{C:mult}+#1#{} Mult for every two",
                "remaining cards in {C:attention}deck",
                "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult)",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.deckcards } }
    end,
    calculate = function(self, card, context)
        card.ability.extra.deckcards = card.ability.extra.mult*(#G.deck.cards/2)
        if #G.deck.cards > 0 and context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult * (#G.deck.cards/2)}},
                mult_mod = card.ability.extra.mult * (#G.deck.cards/2), 
                colour = G.C.MULT,
                card = self
            }
        end
    end
}
SMODS.Joker {
    key = 'purple_card',
    config = {
        extra = { chips = 0, chip_mod = 20},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 11 },
    loc_txt = {
        ['en-us'] = {
            name = 'Purple Card',
            text = {
                "This Joker gains",
                "{C:blue}+#2#{} Chips when any",
                "{C:attention}Booster Pack{} is skipped",
                "{C:inactive}(Currently {C:blue}+#1#{} {C:inactive}Chips)",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            G.E_MANAGER:add_event(Event({
                func = function() 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chip_mod}},
                        colour = G.C.CHIPS,
                        delay = 0.45, 
                        card = self
                    }) 
                    return true
                end}))
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = 'trapeze_artist',
    config = {
        extra = { fam_x_chips = 3 },
    },
    atlas = 'Joker',
    pos = { x = 2, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = 'Trapeze Artist',
            text = {
                "{X:chips,C:white}X#1#{} Chips on {C:attention}first",
                "{C:attention}hand{} of round",
            }
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'forged_signature',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 8, y = 8 },
    loc_txt = {
        ['en-us'] = {
            name = 'Forged signature',
            text = {
                "When round begins,",
                "add a random {C:attention}playing",
                "{C:attention}card{} with a random",
                "{C:attention}edition{} to your hand",
            }
        }
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_playing_card({front = pseudorandom_element(G.P_CARDS, pseudoseed('forged_card')), center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                    _card:set_edition(poll_edition('forged_signature', nil, false, true))
                    G.hand:sort()
                    return true
                end}))

            playing_card_joker_effects({true})
        end
    end
}
SMODS.Joker {
    key = 'smudged_jester',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 6 },
    loc_txt = {
        ['en-us'] = {
            name = 'Smudged Jester',
            text = {
                "{C:attention}3s{} counts as {C:attention}8s{}",
                "{C:attention}6s{} count as {C:attention}9s{}",
                "{C:attention}Kings{} count as {C:attention}Aces{}",
            }
        }
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end
}
SMODS.Joker {
    key = 'perfect_ballot',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 9, y = 6 },
    loc_txt = {
        ['en-us'] = {
            name = 'Perfect Ballot',
            text = {
                "Retrigger {C:attention}all{} played",
                "cards used in scoring",
                "{C:attention}once",
            }
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}
SMODS.Joker {
    key = 'con_man',
    config = {
        extra = { money = 10 },
    },
    atlas = 'Joker',
    pos = { x = 6, y = 5 },
    loc_txt = {
        ['en-us'] = {
            name = 'Con Man',
            text = {
                "Spend {C:money}$#1#{} dollars to create",
                "a random duplicate of a {C:attention}Joker",
                "or a {C:tarot}Consumable{} you currently have.",
                "{C:inactive}(Must have room){}"

            }
        }
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            if G.GAME.dollars >= card.ability.extra.money then
                local random = math.random(1,2)
                if #G.consumeables.cards > 0 and #G.consumeables.cards < G.consumeables.config.card_limit and random == 1 then
                    local eligibleConsumeables = {}
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i].ability.name ~= card.ability.name then
                            eligibleConsumeables[#eligibleConsumeables+1] = G.consumeables.cards[i] 
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = copy_card(pseudorandom_element(eligibleConsumeables, pseudoseed('fam_con_man')), nil)
                            card:add_to_deck()
                            G.consumeables:emplace(card) 
                            return true
                        end}))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    ease_dollars(-card.ability.extra.money)
                    card.ability.extra.money = card.ability.extra.money + 2
                end
                if #G.jokers.cards > 0 and #G.jokers.cards < G.jokers.config.card_limit and random == 2 then
                    local eligibleJokers = {}
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.name ~= card.ability.name then
                            eligibleJokers[#eligibleJokers+1] = G.jokers.cards[i] 
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = copy_card(pseudorandom_element(eligibleJokers, pseudoseed('fam_con_man')), nil)
                            card:add_to_deck()
                            G.jokers:emplace(card) 
                            return true
                        end}))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    ease_dollars(-card.ability.extra.money)
                    card.ability.extra.money = card.ability.extra.money + 2
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'crimsonotype',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = 'Crimsonotype',
            text = {
                "Copies ability of",
                "{C:attention}Joker{} to the left",
            }
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        local jokers = G.jokers.cards
        for i = 1, #jokers do
            if jokers[i] == card then
                other_joker = jokers[i-1] 
            end
        end
        if not other_joker then
            return 
        end
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or card
        if context.blueprint > #G.jokers.cards + 1 then 
            return 
        end
        local other_joker_ret = other_joker:calculate_joker(context)
        if other_joker_ret then 
            other_joker_ret.card = context.blueprint_card or card
            other_joker_ret.colour = G.C.RED
            return other_joker_ret
        end
    end
}
SMODS.Joker {
    key = 'the_twins',
    config = {
        extra = {poker_hand = "Pair", fam_x_chips = 2},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 4 },
    loc_txt = {
        ['en-us'] = {
            name = 'The Twins',
            text = {
                "{X:chips,C:white}X#1#{} Chips if played",
                "hand contains",
                "a {C:attention}#2#",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'the_triplets',
    config = {
        extra = {poker_hand = "Three of a Kind", fam_x_chips = 3},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 4 },
    loc_txt = {
        ['en-us'] = {
            name = 'The Triplets',
            text = {
                "{X:chips,C:white}X#1#{} Chips if played",
                "hand contains",
                "a {C:attention}#2#",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'the_tetrad',
    config = {
        extra = {poker_hand = "Four of a Kind", fam_x_chips = 4},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 4 },
    loc_txt = {
        ['en-us'] = {
            name = 'The Tetrad',
            text = {
                "{X:chips,C:white}X#1#{} Chips if played",
                "hand contains",
                "a {C:attention}#2#",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'the_class',
    config = {
        extra = {poker_hand = "Straight", fam_x_chips = 3},
    },
    atlas = 'Joker',
    pos = { x = 8, y = 4 },
    loc_txt = {
        ['en-us'] = {
            name = 'The Class',
            text = {
                "{X:chips,C:white}X#1#{} Chips if played",
                "hand contains",
                "a {C:attention}#2#",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'the_kingdom',
    config = {
        extra = {poker_hand = "Flush", fam_x_chips = 2},
    },
    atlas = 'Joker',
    pos = { x = 9, y = 4 },
    loc_txt = {
        ['en-us'] = {
            name = 'The Kingdom',
            text = {
                "{X:chips,C:white}X#1#{} Chips if played",
                "hand contains",
                "a {C:attention}#2#",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'thinktank',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 7 },
    loc_txt = {
        ['en-us'] = {
            name = 'Thinktank',
            text = {
                "Copies the ability",
                "of rightmost {C:attention}Joker{}",
            }
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        local jokers = G.jokers.cards
        other_joker = jokers[#jokers] 
        if not other_joker then
            return 
        end
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or card
        if context.blueprint > #G.jokers.cards + 1 then 
            return 
        end
        local other_joker_ret = other_joker:calculate_joker(context)
        if other_joker_ret then 
            other_joker_ret.card = context.blueprint_card or card
            other_joker_ret.colour = G.C.RED
            return other_joker_ret
        end
    end
}
SMODS.Joker {
    key = 'astrophysicist',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = 'Astrophysicist',
            text = {
                "Create a {C:blue}Planet{} card",
                "when {C:attention}Blind{} is selected",
                "{C:inactive}(Must have room)",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            create_consumable("Planet", nil, {localize('k_plus_tarot'), colour = G.C.blue})
        end
    end
}
SMODS.Joker {
    key = 'taromancer',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 2, y = 7 },
    loc_txt = {
        ['en-us'] = {
            name = 'Taromancer',
            text = {
                "All {C:tarot}Tarot{} cards and",
                "{C:tarot}Arcana Packs{} in",
                "the shop are {C:attention}free",
            }
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end
}
SMODS.Joker {
    key = 'archibald',
    config = {
        extra = { money = 50, current_money = 0},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 8 },
    loc_txt = {
        ['en-us'] = {
            name = 'Archibald',
            text = {
                "Gives {C:money}$#2#{} for every",
                "{C:attention}2{} consumables in hand.",
                "{C:inactive}(Gain {C:money}$#1#{} {C:inactive}at end of round)",
            }
        }
    },
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    soul_pos = {x = 7, y = 9},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_money, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if #G.consumeables.cards % 2 == 0 and #G.consumeables.cards ~= 0 then
                ease_dollars(card.ability.extra.money * (#G.consumeables.cards/2))
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return {
                    message = localize('$')..card.ability.extra.money,
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
        if #G.consumeables.cards % 2 == 0 and #G.consumeables.cards ~= 0 then
            card.ability.extra.current_money = card.ability.extra.money * (#G.consumeables.cards/2)
        end
    end
}

-- Familiar Tarots
SMODS.Consumable{
    key = 'the_broken',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 0, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Broken",
            text = {
                "Creates a {C:attention}Familiar Consumable",
                "based on the {C:attention}Consumable",
                "you last used",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if (#G.consumeables.cards <= G.consumeables.config.card_limit or self.area == G.consumeables) and G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool' then
            return true 
        end
    end,
    use = function(self, card)
        if G.GAME.last_tarot_planet == "c_strength" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_vigor'})
        elseif G.GAME.last_tarot_planet == "c_hanged_man" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_martyr'})
        elseif G.GAME.last_tarot_planet == "c_death" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_demise'})
        elseif G.GAME.last_tarot_planet == "c_judgement" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_verdict'})
        elseif G.GAME.last_tarot_planet == "c_high_priestess" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_harlot'})
        elseif G.GAME.last_tarot_planet == "c_wheel_of_fortune" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_cycle_of_fate'}) 
        elseif G.GAME.last_tarot_planet == "c_devil" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_humanity'}) 
        elseif G.GAME.last_tarot_planet == "c_world" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_landscape'}) 
        elseif G.GAME.last_tarot_planet == "c_moon" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_midnight'}) 
        elseif G.GAME.last_tarot_planet == "c_star" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_galaxy'}) 
        elseif G.GAME.last_tarot_planet == "c_sun" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_daylight'}) 
        elseif G.GAME.last_tarot_planet == "c_tower" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_pit'}) 
        elseif G.GAME.last_tarot_planet == "c_heirophant" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_bishop'}) 
        elseif G.GAME.last_tarot_planet == "c_empress" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_queen'}) 
        elseif G.GAME.last_tarot_planet == "c_lovers" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_wed'}) 
        elseif G.GAME.last_tarot_planet == "c_magician" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_illusionist'}) 
        elseif G.GAME.last_tarot_planet == "c_ceres" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_demeter'}) 
        elseif G.GAME.last_tarot_planet == "c_earth" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_terra'}) 
        elseif G.GAME.last_tarot_planet == "c_eris" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_discordia'}) 
        elseif G.GAME.last_tarot_planet == "c_jupiter" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_zeus'}) 
        elseif G.GAME.last_tarot_planet == "c_mars" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_ares'}) 
        elseif G.GAME.last_tarot_planet == "c_mercury" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_hermes'}) 
        elseif G.GAME.last_tarot_planet == "c_neptune" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_poseidon'}) 
        elseif G.GAME.last_tarot_planet == "c_planet_x" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_hecate'}) 
        elseif G.GAME.last_tarot_planet == "c_pluto" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_hades'}) 
        elseif G.GAME.last_tarot_planet == "c_saturn" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_cronus'}) 
        elseif G.GAME.last_tarot_planet == "c_uranus" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_caelus'}) 
        elseif G.GAME.last_tarot_planet == "c_venus" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_aphrodite'}) 
        end
    end,
}
SMODS.Consumable{
    key = 'the_illusionist',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_charmed', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 1, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Illusionist",
            text = {
                "Enhances {C:attention}2{} selected card",
                "into a {C:attention}Charmed Card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_charmed

        return {vars = {self.config.max_highlighted}}
    end,
}
SMODS.Consumable{
    key = 'the_harlot',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 2, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Harlot",
            text = {
                "Creates a {C:attention}planet{} card",
                "of your {C:attention}most{} used poker hand",
                "{C:inactive}(Must have room){}"
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then 
            return true 
        end
    end,
    use = function(self, card)
        local _planet, _hand, _tally = nil, nil, 0
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end
        if _hand then
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == _hand then
                    _planet = v.key
                end
            end
        end
        create_consumable("Planet",'pl1',nil,{forced_key = _planet}, true, true)
    end,
}
SMODS.Consumable{
    key = 'the_queen',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_div', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 3, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Queen",
            text = {
                "Enhances {C:attention}2{} selected card",
                "into a {C:attention}Div Card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_div

        return {vars = {self.config.max_highlighted}}
    end,
}
SMODS.Consumable{
    key = 'the_bishop',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_penalty', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 5, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Bishop",
            text = {
                "Enhances {C:attention}2{} selected card",
                "into a {C:attention}Penalty Card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_penalty

        return {vars = {self.config.max_highlighted}}
    end,
}
--SMODS.Consumable{
--    key = 'the_wed',
--    set = 'Familiar_Tarots',
--    config = { mod_conv = 'm_fam_split', max_highlighted = 2 },
--    atlas = 'Consumables',
--    pos = { x = 6, y = 0 },
--    cost = 3,
--    loc_txt = {
--        ['en-us'] = {
--            name = "The Wed",
--            text = {
--                "Enhances {C:attention}2{} selected card",
--                "into a {C:attention}Split Card{}.",
--            }
--        }
--    },
--    loc_vars = function(self, info_queue)
--        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_split
--
--        return {vars = {self.config.max_highlighted}}
--    end,
--}
SMODS.Consumable{
    key = 'the_cycle_of_fate',
    set = 'Familiar_Tarots',
    config = { extra = { odds = 4 } },
    atlas = 'Consumables',
    pos = { x = 0, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Cycle of Fate",
            text = {
                "{C:green,E:1,S:1.1}#2# in #1#{} chance to",
                "make a {C:attention}joker{} Negative.",
                "{C:inactive}(Overrides other Editions){}"
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    can_use = function(self, card, area, copier)
        if #G.jokers.cards > 0 then 
            return true 
        end
    end,
    use = function(self, card)
        local eligibleJokers = {}
        for i = 1, #G.jokers.cards do
            eligibleJokers[#eligibleJokers+1] = G.jokers.cards[i] 
        end
        local joker = math.random(1,#G.jokers.cards)
        if pseudorandom('cycle_of_fate') < G.GAME.probabilities.normal/card.ability.extra.odds and G.jokers.cards[joker].edition ~= 'negative' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local edition = {negative = true}
                G.jokers.cards[joker]:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
            return true end }))
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.GREY,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4);return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
            return true end }))
        end
        delay(0.6)
    end,
}
SMODS.Consumable{
    key = 'vigor',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 1, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Vigor",
            text = {
                "Increases rank of",
                "{C:attention}one{} selected card",
                "by {C:attention}3",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            for j = 1, 3 do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local card = G.hand.highlighted[i]
                    local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                    local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 then rank_suffix = 'A'
                    end
                    card:juice_up(0.3, 0.5)
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                return true end }))
            end
        end  
    end,
}
SMODS.Consumable{
    key = 'the_martyr',
    set = 'Familiar_Tarots',
    config = { extra = 2 },
    atlas = 'Consumables',
    pos = { x = 2, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Martyr",
            text = {
                "Creates {C:attention}2{} random cards",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier, context)
        if (G.hand and not G.shop) or (G.hand) then
            return true 
        end
    end,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function() 
                local cards = {}
                for i=1, self.config.extra do
                    cards[i] = true
                    local _suit, _rank = nil, nil
                    _rank = pseudorandom_element({'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'}, pseudoseed('incantation_create'))
                    _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('incantation_create'))
                    _suit = _suit or 'S'; _rank = _rank or 'A'
                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank]}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                end
                playing_card_joker_effects(cards)
        return true end }))
    end,
}
SMODS.Consumable{
    key = 'demise',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 3, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Demise",
            text = {
                "Select {C:attention}3{} cards,",
                "convert {C:attention}them{} into",
                "a {C:attention}random{} selected card",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 3) then
            return true 
        end
    end,
    use = function(self, card)
        local random = G.hand.highlighted[math.random(1, #G.hand.highlighted)]
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= random then
                    G.hand.highlighted[i]:juice_up(0.3, 0.5)
                    copy_card(random, G.hand.highlighted[i])
                end
            return true end }))
        end  
    end,
}
SMODS.Consumable{
    key = 'humanity',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_gilded', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 5, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Humanity",
            text = {
                "Enhances {C:attention}2{} selected card",
                "into a {C:attention}Gilded card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_gilded

        return {vars = {self.config.max_highlighted}}
    end,
}
SMODS.Consumable{
    key = 'the_pit',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 6, y = 1 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Pit",
            text = {
                "Turns up to {C:attention}3{} selected",
                "cards to {C:GREY}Suitless",
                "{C:inactive}(Suitless cards always score)",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i].ability.suitless = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
SMODS.Consumable{
    key = 'the_galaxy',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 7, y = 1 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Galaxy",
            text = {
                "Adds {C:diamonds}Diamonds{} to up",
                "to {C:attention}3{} selected cards.",
                "{C:inactive}(Does not remove other suit(s))",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i].ability.is_diamond = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
SMODS.Consumable{
    key = 'the_midnight',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 8, y = 1 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Midnight",
            text = {
                "Adds {C:clubs}Clubs{} to up",
                "to {C:attention}3{} selected cards.",
                "{C:inactive}(Does not remove other suit(s))",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i].ability.is_club = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
SMODS.Consumable{
    key = 'the_daylight',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 9, y = 1 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Daylight",
            text = {
                "Adds {C:hearts}Hearts{} to up",
                "to {C:attention}3{} selected cards.",
                "{C:inactive}(Does not remove other suit(s))",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i].ability.is_heart = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
SMODS.Consumable{
    key = 'verdict',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 0, y = 2 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Verdict",
            text = {
                "Creates a random",
                "{C:attention}Consumble{} card",

            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then 
            return true 
        end
    end,
    use = function(self, card)
        create_consumable("Consumeables", nil, nil, nil)
    end,
}
SMODS.Consumable{
    key = 'the_landscape',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 1, y = 2 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Landscape",
            text = {
                "Adds {C:spades}Spades{} to up",
                "to {C:attention}3{} selected cards.",
                "{C:inactive}(Does not remove other suit(s))",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i].ability.is_spade = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}

-- Familiar Planets
SMODS.Consumable{
    key = 'hermes',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Pair", xmult = 1.1, xchips = 1.3} },
    atlas = 'Consumables',
    pos = { x = 0, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Hermes",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'aphrodite',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Three of a Kind", xmult = 1.1, xchips = 1.5} },
    atlas = 'Consumables',
    pos = { x = 1, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Aphrodite",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'terra',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Full House", xmult = 1.2, xchips = 1.7} },
    atlas = 'Consumables',
    pos = { x = 2, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Terra",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'ares',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Four of a Kind", xmult = 1.25, xchips = 1.75} },
    atlas = 'Consumables',
    pos = { x = 3, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Ares",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'zeus',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush", xmult = 1.2, xchips = 1.3} },
    atlas = 'Consumables',
    pos = { x = 4, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Zeus",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'cronus',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Straight", xmult = 1.25, xchips = 1.75} },
    atlas = 'Consumables',
    pos = { x = 5, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Cronus",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'caelus',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Two Pair", xmult = 1.1, xchips = 1.5} },
    atlas = 'Consumables',
    pos = { x = 6, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Caelus",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'poseidon',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Straight Flush", xmult = 1.3, xchips = 1.8} },
    atlas = 'Consumables',
    pos = { x = 7, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Poseidon",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'hades',
    set = 'Familiar_Planets',
    config = { extra = {hand = "High Card", xmult = 1.1, xchips = 1.2} },
    atlas = 'Consumables',
    pos = { x = 8, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Hades",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'hecate',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Five of a Kind", xmult = 1.25, xchips = 1.75} },
    atlas = 'Consumables',
    pos = { x = 9, y = 2 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Hecate",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'demeter',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush House", xmult = 1.3, xchips = 1.8} },
    atlas = 'Consumables',
    pos = { x = 8, y = 2 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Demeter",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
SMODS.Consumable{
    key = 'discordia',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush Five", xmult = 1.25, xchips = 2} },
    atlas = 'Consumables',
    pos = { x = 3, y = 2 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Discordia",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}

-- Familiar Spectrals 
SMODS.Consumable{
    key = 'forge',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_gilded_seal"} },
    atlas = 'Consumables',
    pos = { x = 3, y = 4 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Forge",
            text = {
                "Add a {C:money}Gilded Seal",
                "to 2 {C:attention}selected cards{}",
                "in your hand",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.fam_sapphire_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 2)  then
            return true 
        end
    end,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for i = 1, #G.hand.highlighted do 
                G.hand.highlighted[i]:set_seal("fam_gilded_seal", nil, true)
            end
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}
SMODS.Consumable{
    key = 'shade',
    set = 'Familiar_Spectrals',
    config = { extra = { odds = 4 } },
    atlas = 'Consumables',
    pos = { x = 5, y = 4 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Shade",
            text = {
                "{C:green,E:1,S:1.1}#3# in #2#{} chance to",
                "create a {C:mult}rare{} joker",
                "{C:green,E:1,S:1.1}#3# in #1#{} chance to",
                "set money to {C:attention}-$10{}",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, card.ability.extra.odds/2, G.GAME.probabilities.normal } }
    end,
    can_use = function(self, card, area, copier)
        if #G.jokers.cards < G.jokers.config.card_limit then 
            return true 
        end
    end,
    use = function(self, card)
        if pseudorandom('shade1') < G.GAME.probabilities.normal/(card.ability.extra.odds/2) then
            create_joker('Joker', nil, nil, nil, 0.99)
        end
        if pseudorandom('shade2') < G.GAME.probabilities.normal/card.ability.extra.odds then
            if G.GAME.dollars ~= 0 then
                ease_dollars(-(G.GAME.dollars + 10), true)
            end
        end
    end,
}
SMODS.Consumable{
    key = 'playback',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_maroon_seal"} },
    atlas = 'Consumables',
    pos = { x = 1, y = 5 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Playback",
            text = {
                "Add a {C:red}Maroon Seal",
                "to one {C:attention}selected card{}",
                "in your hand",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.fam_maroon_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true 
        end
    end,
    use = function(self, card)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("fam_maroon_seal", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}
SMODS.Consumable{
    key = 'mesmer',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_sapphire_seal"} },
    atlas = 'Consumables',
    pos = { x = 3, y = 5 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Mesmer",
            text = {
                "Add a {C:blue}Sapphire Seal",
                "to one {C:attention}selected card{}",
                "in your hand",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.s_fam_sapphire_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true 
        end
    end,
    use = function(self, card)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("fam_sapphire_seal", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}
SMODS.Consumable{
    key = 'oracle',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_familiar_seal"} },
    atlas = 'Consumables',
    pos = { x = 4, y = 5 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Oracle",
            text = {
                "Add a Familiar Seal",
                "to one {C:attention}selected card{}",
                "in your hand",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.fam_familiar_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true 
        end
    end,
    use = function(self, card)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("fam_familiar_seal", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}

-- Boosters
SMODS.Booster{
	name = "Fortune Pack",
	key = "forture_booster_1",
    group_key = "pantheon_booster",
	atlas = 'Booster',
	pos = {x = 0, y = 0},
    loc_txt = {
        ['en-us'] = {
            name = "Fortune Pack",
            text = {
                "Choose {C:attention}#2#{} of up to",
				"{C:attention}#3#{} Fortune Cards"
            }
        }
    },
	weight = 0.7 * 4,
	cost = 6,
	config = {draw_hand = true, extra = 3, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.draw_hand, card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
		return create_card("Familiar_Tarots", G.pack_cards, nil, nil, true, true, nil, 'fam_forture')
	end,
    update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Fortune Pack", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Fortune Tin",
	key = "forture_booster_2",
    group_key = "forture_booster",
	atlas = 'Booster',
	pos = {x = 0, y = 2},
    loc_txt = {
        ['en-us'] = {
            name = "Fortune Booster Tin",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Fortune Cards"
            }
        }
    },
	weight = 0.7 * 2,
	cost = 9,
	config = {draw_hand = true, extra = 5, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
		return create_card("Familiar_Tarots", G.pack_cards, nil, nil, true, true, nil, 'fam_forture')
	end,
    update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Fortune Tin", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Fortune Chest",
	key = "forture_booster_3",
    group_key = "forture_booster",
	atlas = 'Booster',
	pos = {x = 2, y = 2},
    loc_txt = {
        ['en-us'] = {
            name = "Fortune Collector Chest",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Fortune Cards"
            }
        }
    },
	weight = 0.7 * 0.5,
	cost = 12,
	config = {draw_hand = true, extra = 5, choose = 2},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
		return create_card("Familiar_Tarots", G.pack_cards, nil, nil, true, true, nil, 'fam_forture')
	end,
    update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Fortune Chest", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Pantheon Pack",
	key = "pantheon_booster_1",
    group_key = "pantheon_booster",
	atlas = 'Booster',
	pos = {x = 0, y = 1},
    loc_txt = {
        ['en-us'] = {
            name = "Pantheon Pack",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Sacred Cards"
            }
        }
    },
	weight = 0.5 * 4,
	cost = 6,
	config = { extra = 3, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
        local _planet, _hand, _planets = nil, nil, {}
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible then
                _hand = v
                
            end
            for k, v in pairs(G.P_CENTER_POOLS.Familiar_Planets) do
                if v.config.extra.hand == _hand then
                    _planet = v.key
                    table.insert(_planets, _planet)
                end
            end
        end
		return create_card("Familiar_Planets", G.pack_cards, nil, nil, true, true, _planets[math.random(1,#_planets)], 'fam_pantheon')
	end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Pantheon Pack", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Pantheon Tin",
	key = "pantheon_booster_2",
    group_key = "pantheon_booster",
	atlas = 'Booster',
	pos = {x = 0, y = 3},
    loc_txt = {
        ['en-us'] = {
            name = "Pantheon Tin",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Sacred Cards"
            }
        }
    },
	weight = 0.5 * 2,
	cost = 9,
	config = { extra = 5, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
        local _planet, _hand, _planets = nil, nil, {}
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible then
                _hand = v
                
            end
            for k, v in pairs(G.P_CENTER_POOLS.Familiar_Planets) do
                if v.config.extra.hand == _hand then
                    _planet = v.key
                    table.insert(_planets, _planet)
                end
            end
        end
		return create_card("Familiar_Planets", G.pack_cards, nil, nil, true, true, _planets[math.random(1,#_planets)], 'fam_pantheon')
	end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Pantheon Tin", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Pantheon Chest",
	key = "pantheon_booster_3",
    group_key = "pantheon_booster",
	atlas = 'Booster',
	pos = {x = 2, y = 3},
    loc_txt = {
        ['en-us'] = {
            name = "Pantheon Chest",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Sacred Cards"
            }
        }
    },
	weight = 0.5 * 0.5,
	cost = 12,
	config = { extra = 5, choose = 2},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
        local _planet, _hand, _planets = nil, nil, {}
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible then
                _hand = v
                
            end
            for k, v in pairs(G.P_CENTER_POOLS.Familiar_Planets) do
                if v.config.extra.hand == _hand then
                    _planet = v.key
                    table.insert(_planets, _planet)
                end
            end
        end
		return create_card("Familiar_Planets", G.pack_cards, nil, nil, true, true, _planets[math.random(1,#_planets)], 'fam_pantheon')
	end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Pantheon Chest", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Ethereal Pack",
	key = "ethereal_booster_1",
    group_key = "ethereal_booster",
	atlas = 'Booster',
	pos = {x = 0, y = 4},
    loc_txt = {
        ['en-us'] = {
            name = "Ethereal Pack",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Memento Cards"
            }
        }
    },
	weight = 0.7 * 0.6,
	cost = 6,
	config = {draw_hand = true, extra = 2, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
		return create_card("Familiar_Spectrals", G.pack_cards, nil, nil, true, true, nil, 'fam_memento')
	end,
    update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Ethereal Pack", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Ethereal Tin",
	key = "ethereal_booster_2",
    group_key = "ethereal_booster",
	atlas = 'Booster',
	pos = {x = 2, y = 4},
    loc_txt = {
        ['en-us'] = {
            name = "Ethereal Booster Tin",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Memento Cards"
            }
        }
    },
	weight = 0.7 * 0.3,
	cost = 9,
	config = {draw_hand = true, extra = 4, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
		return create_card("Familiar_Spectrals", G.pack_cards, nil, nil, true, true, nil, 'fam_memento')
	end,
    update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Ethereal Tin", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
SMODS.Booster{
	name = "Ethereal Chest",
	key = "ethereal_booster_3",
    group_key = "ethereal_booster",
	atlas = 'Booster',
	pos = {x = 3, y = 4},
    loc_txt = {
        ['en-us'] = {
            name = "Ethereal Collector Chest",
            text = {
                "Choose {C:attention}#1#{} of up to",
				"{C:attention}#2#{} Memento Cards"
            }
        }
    },
	weight = 0.7 * 0.07,
	cost = 12,
	config = {draw_hand = true, extra = 4, choose = 2},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
		return create_card("Familiar_Spectrals", G.pack_cards, nil, nil, true, true, nil, 'fam_memento')
	end,
    update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Ethereal Chest", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,

}

-- Tags
SMODS.Tag { 
    key = 'aureate', 
    loc_txt = {
        name = "Aureate Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Aureate'
        }
    },
    pos = { x = 0, y = 4},
    atlas = 'Tags',

    config = {type = 'store_joker_modify', edition = 'fam_aureate', odds = 4},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_fam_aureate
        return {}
    end,

    apply = function(tag, context)
        if context.type == 'store_joker_modify' then
            local applied = nil
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true

                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION,function()
                    context.card:set_edition({fam_aureate = true}, true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    context.card.temp_edition = nil
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                applied = true

                tag.triggered = true
            end
            return applied
        end
    end,
}
SMODS.Tag { 
    key = 'speckle', 
    loc_txt = {
        name = "Speckled Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Speckled'
        }
    },
    pos = { x = 3, y = 0},
    atlas = 'Tags',

    config = {type = 'store_joker_modify', edition = 'fam_speckle', odds = 4},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_fam_speckle
        return {}
    end,

    apply = function(tag, context)
        if context.type == 'store_joker_modify' then
            local applied = nil
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true

                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION,function()
                    context.card:set_edition({fam_speckle = true}, true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    context.card.temp_edition = nil
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                applied = true

                tag.triggered = true
            end
            return applied
        end
    end,
}
SMODS.Tag { 
    key = 'statics', 
    loc_txt = {
        name = "Static Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Static'
        }
    },
    pos = { x = 0, y = 1},
    atlas = 'Tags',

    config = {type = 'store_joker_modify', edition = 'fam_statics', odds = 4},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_fam_statics
        return {}
    end,

    apply = function(tag, context)
        if context.type == 'store_joker_modify' then
            local applied = nil
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true

                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION,function()
                    context.card:set_edition({fam_statics = true}, true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    context.card.temp_edition = nil
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                applied = true

                tag.triggered = true
            end
            return applied
        end
    end,
}
SMODS.Tag {
    atlas = "Tags",
    pos = { x = 2, y = 2},
    config = {type = 'new_blind_choice'},
    key = "mezmerize_tag",
    min_ante = 3,
    loc_txt = {
        name = "Mezmerize Pin",
        text = {
            "Gives a free",
            "Fortune Chest"
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Other", key = "p_fam_forture_booster_3", vars = {2, 5}}
        return {vars = {}}
    end,
    apply = function(self, _context)
        if _context.type == 'new_blind_choice' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            self:yep('+', G.C.BLACK,function() 
                local key = 'p_fam_forture_booster_3'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            self.triggered = true
            return true
        end
    end,
}
SMODS.Tag {
    atlas = "Tags",
    pos = { x = 3, y = 2},
    config = {type = 'new_blind_choice'},
    key = "Zeus_tag",
    min_ante = 4,
    loc_txt = {
        name = "Pin of Zeus",
        text = {
            "Gives a free",
            "Pantheon Chest"
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Other", key = "p_fam_pantheon_booster_3", vars = {2, 5}}
        return {vars = {}}
    end,
    apply = function(self, _context)
        if _context.type == 'new_blind_choice' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            self:yep('+', G.C.BLACK,function() 
                local key = 'p_fam_pantheon_booster_3'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            self.triggered = true
            return true
        end
    end,
}
SMODS.Tag {
    atlas = "Tags",
    pos = { x = 3, y = 3},
    config = {type = 'new_blind_choice'},
    key = "specter_tag",
    min_ante = 2,
    loc_txt = {
        name = "Specter Pin",
        text = {
            "Gives a free",
            "{C:red}Ethereal Pack"
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Other", key = "p_fam_ethereal_booster_1", vars = {1, 2}}
        return {vars = {}}
    end,
    apply = function(self, _context)
        if _context.type == 'new_blind_choice' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            self:yep('+', G.C.red,function() 
                local key = 'p_fam_ethereal_booster_1'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            self.triggered = true
            return true
        end
    end,
}

-- Stickers
--SMODS.Sticker{
--    atlas = "Stickers",
--    pos = { x = 1, y = 0},
--    badge_colour = HEX '4f5da1',
--    needs_enable_flag = false,
--    config = { },
--    key = "unstable",
--    rate = 51,
--    loc_txt = {
--        label = "Unstable",
--        name = "Unstable",
--        text = {
--            "{C:green,E:1,S:1.1}1 in 3{} chance to be debuffed",
--            "at end of next round until",
--            "the end of next round",
--        }
--    },
--    loc_vars = function(self, info_queue)
--        return {vars = {}}
--    end,
--    calculate = function(self, card, context)
--        if context.end_of_round and context.individual then
--            if pseudorandom('unstable') < G.GAME.probabilities.normal/3 then
--	            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_disabled_ex'),colour = G.C.FILTER, delay = 0.45})
--	            card.debuff = true
--            else
--                card.debuff = false
--            end
--        end
--    end
--}

-- Seals
SMODS.Seal{
    key = 'maroon_seal',
    config = {
        extra = { },
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    badge_colour = HEX("8a0a0a"),
    loc_txt = {
        label = 'Maroon Seal',
        name = 'Maroon Seal',
        text = {
            'Retrigger leftmost',
            'card {C:attention}1{} time',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.repetition then
            if context.cardarea == G.play then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.scoring_hand[1]
                }
            end
        end
    end
}
SMODS.Seal{
    key = 'sapphire_seal',
    config = {
        extra = {},
    },
    atlas = 'Enhancers',
    pos = { x = 6, y = 4 },
    badge_colour = HEX("0d47a0"),
    loc_txt = {
        label = 'Sapphire Seal',
        name = 'Sapphire Seal',
        text = {
            'Creates a {C:blue}Spectral{} card',
            'if {C:attention}held in hand{} until',
            'the end of round',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
}
SMODS.Seal{
    key = 'gilded_seal',
    config = {
        extra = { odds = 4 },
    },
    atlas = 'Enhancers',
    pos = { x = 2, y = 0 },
    badge_colour = HEX("caae80"),
    loc_txt = {
        label = 'Gilded Seal',
        name = 'Gilded Seal',
        text = {
            '{C:money}$5{} when played, {C:green,E:1,S:1.1}#2# in #1#{} chance',
            'that it gives {C:money}-$5{} instead.',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition and not context.blueprint then
            if pseudorandom('gilded_seal') < G.GAME.probabilities.normal/4 then
                ease_dollars(-5)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 5
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return
            else
                ease_dollars(5)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 5
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return
            end
        end
    end
}
SMODS.Seal{
    key = 'familiar_seal',
    config = {
        extra = {},
    },
    atlas = 'Enhancers',
    pos = { x = 4, y = 4 },
    badge_colour = HEX("3c423e"),
    loc_txt = {
        label = 'Familiar Seal',
        name = 'Familiar Seal',
        text = {
            'Creates a {C:attention}Familiar tarot{} when',
            'only this card is {C:attention}discarded',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if #context.full_hand == 1 then
                create_consumable("Familiar_Tarots")
            end
        end
    end
}

-- Decks
SMODS.Back {
    key = "andys_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Merry Andy's Deck",
            text = {
                "{C:attention}+3{} discards,",
                "{C:blue}-1{} hand size."
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 7, y = 0 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 3
                ease_discard(3)
                G.hand:change_size(-1)
                return true
            end
        }))
    end
}
SMODS.Back {
    key = "amethyst_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Amethyst Deck",
            text = {
                "{C:attention}+5{} hand size",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:change_size(5)
                return true
            end
        }))
    end
}
SMODS.Back {
    key = "topaz_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Topaz Deck",
            text = {
                "{C:blue}+1{} hand every round,",
                "{C:red}+1{} discard every round",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 0, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                ease_discard(1)

                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                return true
            end
        }))
    end
}
SMODS.Back {
    key = "ruby_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Ruby Deck",
            text = {
                "Start with {C:attention}2 copies{} of Playback,",
                "{C:red}+2{} discards every round.",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 2, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
                ease_discard(2)
                
                create_consumable("Familiar_Spectrals", nil, nil, {forced_key='c_fam_playback'})
                create_consumable("Familiar_Spectrals", nil, nil, {forced_key='c_fam_playback'})
                return true
            end
        }))
    end
}
SMODS.Back {
    key = "silver_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Silver Deck",
            text = {
                "{C:attention}+2{} joker slots,",
                "{C:blue}-1{} hand every round,",
                "{C:red}-1{} discard every round",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 3, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
                ease_discard(-1)
                
                G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 2
                G.jokers.config.card_limit = G.jokers.config.card_limit + 2

                G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
                return true
            end
        }))
    end
}
SMODS.Back {
    key = "spare_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Spare Deck",
            text = {
                "Start run with",
                "{C:attention}no Aces{}, {C:attention}doubled Jacks",
                "{C:attention}no queen's{}, and {C:attention}doubled 7's",
                "{C:blue}+1{} hand, and {C:money}$13",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 3, y = 3 },
    config = { dollars = 9 },
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({ 
            func = function()
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                G.GAME.starting_params.dollars = self.config.dollars
                for i = #G.playing_cards, 1, -1 do 
                    if G.playing_cards[i]:get_id() == 14 or G.playing_cards[i]:get_id() == 12 then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                    if G.playing_cards[i]:get_id() == 11 or G.playing_cards[i]:get_id() == 7 then
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(G.playing_cards[i], nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                    end
                end
                return true
            end
        }))
    end
}
SMODS.Back {
    key = "duality_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Duality Deck",
            text = {
                "Start with 26",
                "{C:attention}dual-suit{} cards",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 1, y = 3 },
    config = {fam_force_dual = true},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({ 
            func = function()
                local dual1 = math.random(1,4)
                local dual2 = math.random(1,4)
                local notsuit = nil
                local setsuit1 = true
                local setsuit2 = true
                for i = #G.playing_cards, 1, -1 do 
                    if i <= 13 then
                        if dual1 == 1 then
                            G.playing_cards[i].ability.is_diamond = true
                            notsuit = "Diamonds"
                        elseif dual1 == 2 then
                            G.playing_cards[i].ability.is_club = true
                            notsuit = "Clubs"
                        elseif dual1 == 3 then
                            G.playing_cards[i].ability.is_spade = true
                            notsuit = "Spades"
                        elseif dual1 == 4 then
                            G.playing_cards[i].ability.is_heart = true
                            notsuit = "Hearts"
                        end
                        if setsuit1 == true then
                            suit = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                            if suit == notsuit then
                                while suit == notsuit do
                                    suit = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                                end
                            end
                            setsuit1 = false
                        end
                        G.playing_cards[i]:change_suit(suit)
                    elseif i >= 14 and i <= 26 then
                        if dual2 == 1 then
                            G.playing_cards[i].ability.is_diamond = true
                            notsuit = "Diamonds"
                        elseif dual2 == 2 then
                            G.playing_cards[i].ability.is_club = true
                            notsuit = "Clubs"
                        elseif dual2 == 3 then
                            G.playing_cards[i].ability.is_spade = true
                            notsuit = "Spades"
                        elseif dual2 == 4 then
                            G.playing_cards[i].ability.is_heart = true
                            notsuit = "Hearts"
                        end
                        if setsuit2 == true then
                            suit2 = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                            if suit2 == notsuit or suit2 == notsuit then
                                while suit2 == notsuit or suit2 == notsuit do
                                    suit2 = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                                end
                            end
                            setsuit2 = false
                        end
                        G.playing_cards[i]:change_suit(suit2)
                    else
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end
                return true
            end
        }))
    end
}
--SMODS.Back {
--    key = "fleeting_deck",
--    loc_txt = {
--        ['en-us'] = {
--            name = "Fleeting Deck",
--            text = {
--                "Find {C:red}Mementos{} in the shop",
--            }
--        }
--    },
--    atlas = 'Enhancers',
--    pos = { x = 6, y = 2 },
--    config = {shop_rate = 35},
--}
SMODS.Back {
    key = "speckled_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Speckled Deck",
            text = {
                "All {C:attention}Cards{} in the deck",
                "are {C:dark_edition}Speckled",
                "All {C:attention}Jokers{} are {C:dark_edition}Speckled",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 2 },
    config = {fam_force_edition = "fam_speckle"},
}
SMODS.Back {
    key = "static_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Static Deck",
            text = {
                "All {C:attention}Cards{} in the deck",
                "are {C:dark_edition}Static",
                "All {C:attention}Jokers{} are {C:dark_edition}Static",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 2 },
    config = {fam_force_edition = "fam_statics"},
}
SMODS.Back {
    key = "aureate_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Aureate Deck",
            text = {
                "All {C:attention}Cards{} in the deck",
                "are {C:dark_edition}Aureate",
                "All {C:attention}Jokers{} are {C:dark_edition}Aureate",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 2 },
    config = {fam_force_edition = "fam_aureate"},
}

-- Enhancements
SMODS.Enhancement {
    key = 'penalty',
    loc_txt = {
        name = 'Penalty',
        text = {
            "{C:red}+#1#{} Mult",
            "{C:blue}-#2#{} Chips",
        }
    },
    pos = {x = 1, y = 1}, 
    atlas = 'Enhancers', 
    config = { extra = {mult = 20, chips = 20} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.mult, self.config.extra.chips} }
    end,
    calculate = function(self, card, context)
        hand_chips = mod_chips(hand_chips)
        if context.cardarea == G.play and not context.repetition then
            SMODS.eval_this(card, {mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}} )
            delay(0.2)
            SMODS.eval_this(card, {chip_mod = -card.ability.extra.chips, message = localize{type='variable',key='fam_penalty',vars={card.ability.extra.chips}}} )
        end
    end
}
SMODS.Enhancement {
    key = 'div',
    loc_txt = {
        name = 'Div',
        text = {
            "{C:red}X#1#{} Mult",
            "{C:blue}+#2#{} Chips",
        }
    },
    pos = {x = 2, y = 1}, 
    atlas = 'Enhancers', 
    config = { extra = {mult = 0.9, chips = 100} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.mult, self.config.extra.chips} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition then
            SMODS.eval_this(card, {chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} )
            delay(0.2)
            SMODS.eval_this(card, {Xmult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.mult}}} )
        end
    end
}
--SMODS.Enhancement {
--    key = 'split',
--    loc_txt = {
--        name = 'Split',
--        text = {
--            "copies suit to its right",
--            "copies rank to its left",
--        }
--    },
--    pos = {x = 3, y = 1}, 
--    atlas = 'Enhancers', 
--    config = { extra = {mult = 0.9, chips = 100} },
--    loc_vars = function(self, info_queue, card)
--        return { vars = {self.config.extra.mult, self.config.extra.chips} }
--    end
--}
SMODS.Enhancement {
    key = 'gilded',
    loc_txt = {
        name = 'Gilded',
        text = {
            "{C:money}$#1#{} when held in hand",
            "decreases by {C:money}$#2#{} each use",
            "becomes a {C:attention}steel card",
            "after {C:attention}#1#{} uses.",
        }
    },
    pos = {x = 6, y = 0}, 
    atlas = 'Enhancers', 
    config = { extra = {p_dollars = 5, dollar_mod = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.p_dollars, self.config.extra.dollar_mod} }
    end,
}
SMODS.Enhancement {
    key = 'charmed',
    loc_txt = {
        name = 'Charmed',
        text = {
            "{C:green,E:1,S:1.1}#3# in #1#{} chance",
            "for {C:blue}+#2#{} Chips",
            "{C:green,E:1,S:1.1}#3# in #4#{} chance",
            "for a random {C:attention}Tarot{} card",
        }
    },
    pos = {x = 4, y = 1}, 
    atlas = 'Enhancers', 
    config = { extra = { chips = 150, odds = 5, } },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.odds, self.config.extra.chips, '' .. (G.GAME and G.GAME.probabilities.normal or 1), self.config.extra.odds*2} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition then
            if pseudorandom('charmed_prob') < G.GAME.probabilities.normal/self.config.extra.odds then
                delay(0.2)
                SMODS.eval_this(card, {chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} )
            end
            if pseudorandom('charmed_prob') < G.GAME.probabilities.normal/(self.config.extra.odds*2) then
                create_consumable("Tarot")
            end
        end
    end
}

-- Shaders
SMODS.Shader({key = 'statics', path = 'statics.fs'})
SMODS.Shader({key = 'aureate', path = 'aureate.fs'})
SMODS.Shader({key = 'speckle', path = 'speckled.fs'})

SMODS.Edition{
    key = 'aureate', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Aureate",
        label = "Aureate",
        text = {
            "{X:money,C:white}$#1#{}"
        }
    },
    config = { p_dollars = 3 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.p_dollars}}
    end,

    in_shop = true,
    weight = 15,
    extra_cost = 2,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    shader = 'aureate'
}
SMODS.Edition{
    key = 'speckle', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Speckled",
        label = "Speckled",
        text = {
            "{C:blue}+rand(){} Chips",
            "{C:red}+rand(){} Mult"
        }
    },
    config = { ranmult = 0, ranchips = 0, mmin = 1, mmax = 5, cmin = 1, cmax = 25, rantextnum =  fam_numbers[math.random(1, 15)], rantextnum2 =  fam_numbers[math.random(1, 15)] },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.ranmult, self.config.ranchips, self.config.rantextnum, self.config.rantextnum2}}
    end,

    in_shop = true,
    weight = 12,
    extra_cost = 2,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    shader = 'speckle'
}
SMODS.Edition{
    key = 'statics', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Static",
        label = "Static",
        text = {
            "{X:chips,C:white} X#1# {} Chips"
        }
    },
    config = { fam_x_chips = 1.5 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.fam_x_chips}}
    end,

    in_shop = true,
    weight = 7,
    extra_cost = 5,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    shader = 'statics'
}

-- Vouchers
SMODS.Voucher {
    key = 'pickpocket',
    loc_txt = {
        name = 'Pickpocket',
        text = {
            "{C:blue}+#2#{} hand",
            "{C:attention}+#1#{} hand size",
        }
    },
    cost = 10,
    atlas = 'Voucher',
    pos = { x = 5, y = 0 },
    config = { extra = {hand_size = 2, hands = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.hand_size, self.config.extra.hands} }
    end,
    redeem = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:change_size(card.ability.extra.hand_size)

                G.GAME.starting_params.hands = G.GAME.starting_params.hands + card.ability.extra.hands
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                return true
            end
        }))
        G.GAME.pool_flags.pickpocket_redeemed = true
    end
}
SMODS.Voucher {
    key = 'sleight_of_hand',
    loc_txt = {
        name = 'Sleight of Hand',
        text = {
            "{C:red}+#2#{} discard",
            "{C:attention}+#1#{} hand size",
        }
    },
    cost = 15,
    atlas = 'Voucher',
    pos = { x = 5, y = 1 },
    config = { extra = {hand_size = 3, discards = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.hand_size, self.config.extra.discards} }
    end,
    requires={'v_fam_pickpocket'},
    redeem = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:change_size(card.ability.extra.hand_size)

                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
                ease_discard(card.ability.extra.discards)
                return true
            end
        }))
        G.GAME.pool_flags.sleight_of_hand_redeemed = true
    end
}

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
            {n = G.UIT.T, config = { text = "Sapphire Seal, Con Man, Thinktank, Merry Andy's Deck", scale = 0.35, colour = G.C.UI.TEXT_LIGHT}},
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

----------------------------------------------
------------MOD CODE END---------------------
