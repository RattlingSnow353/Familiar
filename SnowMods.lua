--- STEAMODDED HEADER
--- MOD_NAME: Snows Mods
--- MOD_ID: SnowMods
--- MOD_AUTHOR: [RattlingSnow353]
--- MOD_DESCRIPTION: This mod adds a varity of jokers to the game. 
--- BADGE_COLOUR: 60efff
--- DISPLAY_NAME: Snows Mods
--- VERSION: 0.2.0
--- PREFIX: snow

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

local function create_consumable(card_type,tag,message,extra)
    extra=extra or {}
    
    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, extra.forced_key or nil, tag)
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

local function create_joker(card_type,tag,message,extra)
    extra=extra or {}
    
    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = (function()
                local card = create_card(card_type, G.joker, nil, nil, nil, nil, extra.forced_key or nil, tag)
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

local BackApply_to_run_ref = Back.apply_to_run
function Back.apply_to_run(self)
    BackApply_to_run_ref(self)

    if self.effect.config.DawnDeck then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1 
                G.GAME.round_resets.hands = G.GAME.starting_params.hands
                G.GAME.current_round.hands_left = G.GAME.starting_params.hands

                create_joker('Joker', nil, nil, {forced_key = 'j_snow_dawn_deck', edition = {negative=true}, eternal = true})

                -- Add effect to starting params
                G.GAME.starting_params.DawnDeck = true

                return true
            end
        }))
    end
end

function SMODS.current_mod.process_loc_text()
    G.localization.misc.v_dictionary.sj_shift = "Bonus!"
    G.localization.misc.v_dictionary.sj_times = "X#1#"
    G.localization.misc.v_dictionary.sj_plus = "+#1#"
    G.localization.misc.v_dictionary.sj_mult = "+#1# Mult!"
    G.localization.misc.v_dictionary.sj_xmult = "+#1# Xmult!"
    G.localization.misc.v_dictionary.sj_chips = "+#1# Chips!"
    G.localization.misc.v_dictionary.sj_enhanced = "Enhanced!"
    G.localization.misc.v_dictionary.sj_blindmoney = "Win, -$#1#!"
    G.localization.misc.v_dictionary.sj_probint = "+X#1#!"
    G.localization.misc.v_dictionary.sj_prob = "+#1# Probabity!"
    G.localization.misc.v_dictionary.sj_cash = "+$#1#"

    -- Inefficient i know
    G.localization.descriptions.Other.c_snow_lyman = {
        name = "Artist",
        text = {
            "{C:green,E:1,S:1.1}Lyman{}",
        }
    }
    G.localization.descriptions.Other.c_snow_dieuwt = {
        name = "Artist",
        text = {
            "{C:green,E:1,S:1.1}Dieuwt{}",
        }
    }
    G.localization.descriptions.Other.c_snow_loganboi2 = {
        name = "Artist",
        text = {
            "{C:green,E:1,S:1.1}Loganboi2{}",
        }
    }
    G.localization.descriptions.Other.c_snow_flare = {
        name = "Artist",
        text = {
            "{C:green,E:1,S:1.1}Flare{}",
        }
    }
    G.localization.descriptions.Other.c_snow_loganboi2flare = {
        name = "Artist",
        text = {
            "{C:green,E:1,S:1.1}Loganboi2/Flare{}",
        }
    }

    G.localization.descriptions.Other.c_snow_suit_augmentation = {
        name = "Augmentation",
        text = {
            "Triggers joker again if",
            "all played cards are #1#s",
        }
    }
end

local mod_path = ''..SMODS.current_mod.path
if JokerDisplay then
	JOKER_DISPLAY = NFS.load(mod_path .. "/JokerDisplayIntegration.lua")()
end

-- Holiday Theme
SMODS.Atlas { key = 'Joker', path = 'Jokers.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Deck', path = 'SnowDecks.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Enhancers', path = 'Enhancers.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Consumables', path = 'Tarots.png', px = 71, py = 95 }

-- Jokers
SMODS.Joker {
    key = 'egg_basket',
    config = {
        extra = {odds = 4, _every = 1, money = 7},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Egg Basket',
            text = {
                "Gains {C:money}$#3#{} in {C:attention}sell value{} every round.",
                "{C:green,E:1,S:1.1}#2# in #1#{} chance this is {C:mult}destroyed{}",
                "at the end of round.",
                "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy{}"
            }
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra._every = card.ability.extra._every - 1

            if card.ability.extra._every <= 0 then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
                card:set_cost()
                card.ability.extra._every = card.ability.extra._every + 1
                if pseudorandom('lucky_money') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    card:start_dissolve()
                    return
                end
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'ritual_sacrifice',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Ritual Sacrifice',
            text = {
                "If {C:attention}consumable{} slots are full when",
                "blind is selected, {C:mult}destroy{} all {C:attention}consumables{}",
                "and create a random {C:blue}Spectral{} card.",
                "{C:inactive}Art by {C:red,E:1,S:1.1}CADIO{}"
            }
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            if G.consumeables.config.card_limit == #G.consumeables.cards then
                for i=#G.consumeables.cards, 1, -1 do
                    G.consumeables.cards[i]:start_dissolve(nil, i == 1)
                end
                create_consumable('Spectral', nil, nil, nil)
                return {
                    message = localize('k_plus_spectral')
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'seventh_heaven',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 2, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = '7th Heaven',
            text = {
                "If played hand is a",
                "single {C:attention}7{} create a",
                "{C:attention}Judgement tarot{}",
                "{C:inactive}(Must have room){}"
            }
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        -- Animate card
        if context.first_hand_drawn then
            local eval = function()
                return G.GAME.current_round.hands_played == 0
            end
            juice_card_until(card, eval, true)
        end
        if G.GAME.current_round.hands_played == 0 then
            if context.before then
                if #context.full_hand == 1 and context.full_hand[1]:get_id() == 7 then
                    create_consumable('Tarot', nil, nil, {forced_key='c_judgement'})
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'dawn_deck',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 3, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Dawn Deck',
            text = {
                "{C:attention}Retrigger{} all cards {C:mult}twice{}",
                "on final played hand",
                "{C:inactive} Can only be found in Dawn Deck"
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    yes_pool_flag = 'dawn_flag',
    calculate = function(self, card, context)
        -- Animate card
        if context.first_hand_drawn then
            local eval = function()
                return G.GAME.current_round.hands_left == 0
            end
            juice_card_until(card, eval, true)
        end
        if G.GAME.current_round.hands_left == 0 then
            if context.repetition and context.cardarea == G.play then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 2,
                    card = card
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'clover',
    config = {
        extra = {odds = 4, money = 4, cr = 1, submon = 1},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Clover',
            text = {
                "Rerolls cost {C:money}$#3#{} less.",
                "{C:green,E:1,S:1.1}#2# in #1#{} chance to decrease",
                "price by {C:money}$#4#{} when blind is selected.",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.money, card.ability.extra.submon} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            G.E_MANAGER:add_event(Event({func = function()
                if pseudorandom('lucky_money') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.money
                    card.ability.extra.money = card.ability.extra.money - card.ability.extra.submon
                    card.ability.extra.cr = 1
                    if card.ability.extra.money == 0 then
                        card:start_dissolve()
                        return
                    end
                end
                if card.ability.extra.cr == 1 then
                    G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.money
                    card.ability.extra.cr = 0
                end
            return true end }))
        end
    end
}
SMODS.Joker {
    key = 'verdant_shift',
    config = {
        extra = {suitnum = 1 , line1 = " a season in order", line2 = "whenever a blind is selected", 
                curseason = "Picks", current_chips = 1, chip_mod = 4, current_mult = 1, mult_mod = 3, base = 1},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Verdant Shift',
            text = {
                "{C:purple}#4#{}{C:black}#2#{}",
                "{C:black}#3#{}",
                "{C:inactive}(Currently {C:chips}+#5#{C:inactive} Chips, {C:mult}+#6#{C:inactive} Mult)",
                "{C:inactive}Art by {C:red,E:1,S:1.1}CADIO{}"
            }
        }
    },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.suitnum, card.ability.extra.line1, card.ability.extra.line2, card.ability.extra.curseason, card.ability.extra.current_chips, card.ability.extra.current_mult} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            if card.ability.extra.suitnum == 1 then
                card.ability.extra.curseason = "Spring"
                card.ability.extra.line1 = ": each played card with the club"
                card.ability.extra.line2 = "suit gives random enhancement to it."
                card.ability.extra.suitnum = card.ability.extra.suitnum + 1
            elseif card.ability.extra.suitnum == 2 then
                card.ability.extra.curseason = "Summer"
                card.ability.extra.line1 = ": +3 Mult for each played"
                card.ability.extra.line2 = "card with the heart suit."
                card.ability.extra.suitnum = card.ability.extra.suitnum + 1
            elseif card.ability.extra.suitnum == 3 then
                card.ability.extra.curseason = "Autumn"
                card.ability.extra.line1 = ": +4 chips for each discarded"
                card.ability.extra.line2 = "card with the diamond suit."
                card.ability.extra.suitnum = card.ability.extra.suitnum + 1
            elseif card.ability.extra.suitnum == 4 then
                card.ability.extra.curseason = "Winter"
                card.ability.extra.line1 = ": each discarded card with the spade"
                card.ability.extra.line2 = "suit gives random enhancement to it."
                card.ability.extra.suitnum =  1
            end
        end
        if context.cardarea == G.play and context.individual then
            if card.ability.extra.suitnum == 2 and context.other_card:is_suit('Clubs') then
                --Spring
                shakecard(context.other_card)
                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end
                center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))

                context.other_card:set_ability(center, nil, true)

                return {
                    message = localize {
                        type = 'variable',
                        key = 'sj_enhanced',
                        vars = { }
                    },
                    card = context.other_card
                }
            end
        end
        if context.discard and not context.other_card.debuff then
            if card.ability.extra.suitnum == 4 and context.other_card:is_suit('Diamonds') then
                --Autumn
                card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chip_mod
                return {
                    message = localize {
                        type = 'variable',
                        key = 'sj_chips',
                        vars = { card.ability.extra.chip_mod }
                    },
                    card = self
                }
            end
        end
        if context.joker_main then
            return {
                -- Return bonus message and apply bonus
                message = localize{type='variable',key='sj_shift',vars={card.ability.extra.mult, card.ability.extra.chips}},
                mult_mod = card.ability.extra.current_mult,
                chip_mod = card.ability.extra.current_chips,
                card = self
            }
        end
        if context.individual and context.cardarea == G.play then
            if card.ability.extra.suitnum == 3 and context.other_card:is_suit('Hearts') then
                --Summer
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
                return {
                    message = localize {
                        type = 'variable',
                        key = 'sj_mult',
                        vars = { card.ability.extra.mult_mod }
                    },
                    card = self
                }
            end
        end
        if context.discard and not context.other_card.debuff then
            if card.ability.extra.suitnum == 1 and context.other_card:is_suit('Spades') then
                --Winter
                shakecard(context.other_card)
                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end
                center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))

                context.other_card:set_ability(center, nil, true)

                return {
                    message = localize {
                        type = 'variable',
                        key = 'sj_enhanced',
                        vars = { }
                    },
                    card = context.other_card
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'fools_fortune',
    config = {
        extra = {extra_value = 2, money = 2, copies = 2},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = "Fool's Fortune",
            text = {
                "Sell this card to create",
                "{C:attention}#1#{} free copies of {C:tarot}The Fool{}",
                "{C:inactive}(Must have room, Only works during play){}"
            }
        }
    },
    rarity = 2,
    cost = 7,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.copies} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            card.ability.extra_value = card.ability.extra_value - card.ability.extra.money
            card:set_cost()
            card.ability.extra.money = card.ability.extra_value
        end
        if context.selling_self then
            if G.STATE ~= G.STATES.SELECTING_HAND then
                return
            end
            for i = card.ability.extra.copies, 1, -1 do
                create_consumable('Tarot', nil, nil, {forced_key='c_fool'})
            end
        end
    end
}
SMODS.Joker {
    key = 'combat_confection',
    config = {
        extra = {current_Xmult = 1.6, Xmult_mod = 0.13, base = 1.6},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = "Combat Confection",
            text = {
                "If every scored card in",
                "played hand is a {C:Spades}Spade",
                "gain {C:mult}X#2#{} Mult.",
                "{C:inactive}(Currently{} {C:mult}X#1#{} {C:inactive}Mult){}"
            }
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.current_Xmult, card.ability.extra.Xmult_mod} }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local bolcoco = true 
            for k, v in ipairs(context.full_hand) do 
                bolcoco = bolcoco and (v:get_suit() == 'Spades') 
            end 
            if not bolcoco then 
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_Xmult } },
                    Xmult_mod = card.ability.extra.current_Xmult
                }
            else
                card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod
                message = localize { type = 'variable', key = 'sj_xmult', vars = { card.ability.extra.Xmult_mod } }
            end 
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_Xmult } },
                Xmult_mod = card.ability.extra.current_Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'black_swan',
    config = {
        extra = {poker_hand = "Pair", mult_mod = 3, current_mult = 5, mm = false},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = "Black Swan",
            text = {
                "Playing a {C:attention}#1#{} of",
                "face cards gives {C:mult}+#3#{} Mult",
                "{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult)",
            }
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = {localize(card.ability.extra.poker_hand, 'poker_hands'), card.ability.extra.current_mult, card.ability.extra.mult_mod} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if is_face(context.other_card) and context.scoring_name == card.ability.extra.poker_hand then
                message = localize {
                    type = 'variable',
                    key = 'sj_mult',
                    vars = { card.ability.extra.mult_mod }
                }
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                message = localize {
                    type = 'variable',
                    key = 'sj_shift'
                },
                mult_mod = card.ability.extra.current_mult
            }
        end
    end
}
SMODS.Joker {
    key = 'love_is_blind',
    config = {
        extra = {current_Xmult = 3},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = "Love Is Blind",
            text = {
                "{C:mult}X#1#{} Mult, all hearts cards in",
                "hand become {C:mult}debuffed{}",
            }
        }
    },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.current_Xmult} }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                message = localize {
                    type = 'variable',
                    key = 'sj_shift'
                },
                Xmult_mod = card.ability.extra.current_Xmult 
            }
        end
    end
}
SMODS.Joker {
    key = 'turkey_dinner',
    config = {
        extra = {money = 4},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = "Turkey Dinner",
            text = {
                "Sell this card to {C:attention}instantly win{}",
                "current blind",
                "{C:inactive}(Only works during play, Does not work on Bosses){}"
            }
        }
    },
    rarity = 3,
    cost = 12,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            card.ability.extra_value = card.ability.extra_value - card.ability.extra.money
            card:set_cost()
            card.ability.extra.money = card.ability.extra_value
        end
        if context.selling_self and not G.GAME.blind.boss then
            if G.STATE ~= G.STATES.SELECTING_HAND then
                return
            end
            G.GAME.current_round.hands_left = 0
            G.GAME.chips = G.GAME.blind.chips
            G.STATE = G.STATES.HAND_PLAYED
            G.STATE_COMPLETE = true
            end_round()
        end
    end
}

-- Decks
SMODS.Back {
    key = "dawn_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Dawn Deck",
            text = {
                "{C:attention}Retrigger{} last played hand {C:mult}twice{},",
                "{C:chips}-1{} hand per round", 
            }
        }
    },
    atlas = 'Deck',
    pos = { x = 0, y = 0 },
    config = {DawnDeck = true},
}

-- Other Theme

-- Jokers
if SMODS.Mods['joker_evolution'] then

    SMODS.Joker {
        key = 'chick',
        config = {
            extra = {money = 3},
        },
        atlas = 'Joker',
        pos = { x = 4, y = 1 },
        loc_txt = {
            ['en-us'] = {
                name = "Chick",
                text = {
                    "Gains {C:money}$#1#{} in {C:attention}sell value{}",
                    "every round. Lays an",
                    "egg when {C:attention}sold{}.",
                }
            }
        },
        rarity = "evo",
        cost = 8,
        blueprint_compat = false,
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.money} }
        end,
        calculate = function(self, card, context)
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
                card:set_cost()
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
            if context.selling_self then
                create_joker('Joker', nil, nil, {forced_key='j_egg'})
            end
        end,
        calculate_evo = function(self, card, context)
		    if context.selling_card then
			    card:decrement_evo_condition()
		    end
	    end,
	    set_badges = function(self, card, badges)
		    local len = string.len("Joker Evolution")
		    local size = 0.9 - (len > 6 and 0.02*(len-6) or 0)
		    badges[#badges + 1] = create_badge("Joker Evolution", HEX("18cadc"), nil, size)
	    end,
	    set_card_type_badge = function(self, card, badges)
		    local card_type_colour = get_type_colour(card.config.center or card.config, card)
		    badges[#badges + 1] = create_badge("Evolved", card_type_colour, nil, 1.2)
	    end,
    }

    JokerEvolution.evolutions:add_evolution("j_egg", "j_snow_chick", 2)

    local process_loc_textref = JokerEvolution_Mod.process_loc_text
    function JokerEvolution_Mod.process_loc_text()
        process_loc_textref()
        G.localization.descriptions.Other.je_j_egg = {
            name = "Evolution",
            text = {
			    "Sell {C:attention}#2#{} Jokers",
			    "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
		    }
        }
    end
end

-- Diced Theme

function set_denominator(cur, num)
    cur.ability.extra.odds = num
    return cur.ability.extra.odds
end

function get_denominator(cur)
    return cur.ability.extra.odds
end

Dice = {
    "j_opps",
    "j_snow_opps_all_glorbsDice",
    "j_snow_what_no_numbersDice",
    "j_snow_sichermanDice",
    "j_snow_infinityDice",
    "j_snow_fluxDice",
    "j_snow_fudgeDice",
    "j_snow_erm_noDice",
}

-- Inefficient
ProbabilityObjects = {
    "j_opps",
    "j_snow_opps_all_glorbsDice",
    "j_snow_what_no_numbersDice",
    "j_snow_sichermanDice",
    "j_snow_infinityDice",
    "j_snow_fluxDice",
    "j_snow_fudgeDice",
    "j_snow_oops_all_oopsDice",
    "j_snow_erm_noDice",
    "j_snow_bent_coin",
    "c_snow_fuel_cell",
    "j_snow_metal_coin",
    "j_snow_liquid_coin",
    "j_snow_ghost_coin",
    "j_snow_diamond_coin",
    "j_snow_spade_coin",
    "j_snow_club_coin",
    "j_snow_heart_coin",
    "j_snow_coin",
    "j_bloodstone",
    "j_cavendish",
    "j_space_joker",
    "j_gros_michel",
    "j_business_card",
    "j_reserved_parking",
    "j_hallucination",
    "c_wheel_of_fortune",
}

denominators = {}

-- Dice
SMODS.Joker {
    key = 'opps_all_glorbsDice',
    config = {
        extra = {temp = 0, temp2 = 0, tempdem = {}, tempdem2 = {}},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "Opps! All Glorbs!",
            text = {
                "All Probabilities {C:attention}Randomized{}",
                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}(0-3)/3{}{C:inactive})",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    add_to_deck = function(self, from_debuff)
        self.added_to_deck = true
		for k, v in pairs(G.GAME.probabilities) do 
            self.config.extra.temp = math.random(0.1, 10)
			G.GAME.probabilities[k] = v*self.config.extra.temp
		end
    end,
    remove_from_deck = function(self, from_debuff)
        self.added_to_deck = false
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = v/self.config.extra.temp
		end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_dieuwt", set = "Other"}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}
SMODS.Joker {
    key = 'what_no_numbersDice',
    config = {
        extra = {temp = 0},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "What? No Numbers?",
            text = {
                "All Probabilities Become {C:mult}0{}",
                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}0/3{}{C:inactive})",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    add_to_deck = function(self, from_debuff)
        self.added_to_deck = true
		for k, v in pairs(G.GAME.probabilities) do 
			if G.GAME.probabilities[k] == 1 and not next(SMODS.find_card('j_oops')) then
				G.GAME.probabilities[k] = 0
			else
                self.config.extra.temp = v
				G.GAME.probabilities[k] = 0
			end
		end
    end,
    remove_from_deck = function(self, from_debuff)
        self.added_to_deck = false
		for k, v in pairs(G.GAME.probabilities) do 
			if G.GAME.probabilities[k] == 0 then
				G.GAME.probabilities[k] = 1
				if next(SMODS.find_card('j_oops')) then
					for kk, vv in pairs(G.jokers.cards) do
						if vv.config.name == 'Oops! All 6s' then
							G.GAME.probabilities[k] = self.config.extra.temp
						end
					end
				end
			else
				G.GAME.probabilities[k] = self.config.extra.temp
			end
		end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2flare", set = "Other"}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}
SMODS.Joker {
    key = 'sichermanDice',
    config = {
        extra = {temp = 0},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "Sicherman",
            text = {
                "All Probabilities {C:green}double{} or {C:mult}half{} each {C:attention}round{}.",
                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}(0.5/2)/3{}{C:inactive})",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    add_to_deck = function(self, from_debuff)
        self.added_to_deck = true
        local prob = math.random(1,2)
		for k, v in pairs(G.GAME.probabilities) do 
			if prob == 1 then
                self.config.extra.temp = v
				G.GAME.probabilities[k] = v/2
			else
                self.config.extra.temp = v
				G.GAME.probabilities[k] = v*2
			end
		end
    end,
    remove_from_deck = function(self, from_debuff)
        self.added_to_deck = false
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = self.config.extra.temp
		end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            local prob = math.random(1,2)
            for k, v in pairs(G.GAME.probabilities) do 
			    if prob == 1 then
				    G.GAME.probabilities[k] = self.config.extra.temp/2
			    else
				    G.GAME.probabilities[k] = self.config.extra.temp*2
			    end
		    end
        end
    end
}
SMODS.Joker {
    key = 'infinityDice',
    config = {
        extra = {temp = 0},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "AAAH?! It's Infinity!?",
            text = {
                "All Probabilities become {C:green}certain{}",
                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}999999999999/3{}{C:inactive})",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    add_to_deck = function(self, from_debuff)
        self.added_to_deck = true
		for k, v in pairs(G.GAME.probabilities) do 
            self.config.extra.temp = v
			G.GAME.probabilities.normal = v*1e300
		end
    end,
    remove_from_deck = function(self, from_debuff)
        self.added_to_deck = false
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = self.config.extra.temp
		end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}
--SMODS.Joker {
--    key = 'erm_noDice',
--    config = {
--        extra = {temp = 0},
--    },
--    atlas = 'Joker',
--    pos = { x = 1, y = 4 },
--    loc_txt = {
--        ['en-us'] = {
--            name = "Erm... No Dice?",
--            text = {
--                "Jokers and Tarots with {C:green}probabilties{} cannot spawn.",
--            }
--        }
--    },
--    rarity = 1,
--    cost = 4,
--    blueprint_compat = false,
--    add_to_deck = function(self, from_debuff)
--        self.added_to_deck = true
--        tempvars = {}
--        for k, v in pairs(ProbabilityObjects) do 
--            insert_table(tempvars, ProbabilityObjects.weight[k])
--			SMODS.ProbabilityObjects[k].weight = 0
--		end
--    end,
--    remove_from_deck = function(self, from_debuff)
--        self.added_to_deck = false
--		for k, v in pairs(ProbabilityObjects) do 
--			ProbabilityObjects.weight[k] = tempvars[k]
--		end
--    end,
--    loc_vars = function(self, info_queue, card)
--        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
--        return { vars = {} }
--    end,
--    calculate = function(self, card, context)
--    end
--}
--SMODS.Joker {
--    key = 'huh_a_7Dice',
--    config = {
--        extra = {temp = 0},
--    },
--    atlas = 'Joker',
--    pos = { x = 2, y = 4 },
--    loc_txt = {
--        ['en-us'] = {
--            name = "Huh? A 7!:",
--            text = {
--                "All Probabilities’s denominators are increased by 1",
--                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}1/4{}{C:inactive})",
--            }
--        }
--    },
--    rarity = 3,
--    cost = 8,
--    blueprint_compat = false,
--    add_to_deck = function(self, from_debuff)
--        self.added_to_deck = true
--		for k, v in pairs(denominators) do 
--            self.config.extra.temp = v
--			set_denominator(self, v+1)
--		end
--    end,
--    remove_from_deck = function(self, from_debuff)
--        self.added_to_deck = false
--		for k, v in pairs(denominators) do 
--			set_denominator(self, self.config.extra.temp)
--		end
--    end,
--    loc_vars = function(self, info_queue, card)
--        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
--        return { vars = {} }
--    end,
--    calculate = function(self, card, context)
--    end
--}
--SMODS.Joker {
--    key = 'cool_a_5Dice',
--    config = {
--        extra = {temp = 0, odds = 1},
--    },
--    atlas = 'Joker',
--    pos = { x = 2, y = 2 },
--    loc_txt = {
--        ['en-us'] = {
--            name = "Cool! A 5!",
--            text = {
--                "All Probabilities goes {C:green}up{} by 1 per {C:attention}attempt{}",
--                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}#1#/3{}{C:inactive})",
--            }
--        }
--    },
--    rarity = 3,
--    cost = 8,
--    blueprint_compat = false,
--    add_to_deck = function(self, from_debuff)
--        self.added_to_deck = true
--		for k, v in pairs(G.GAME.probabilities) do 
--            self.config.extra.temp = v
--		end
--    end,
--    remove_from_deck = function(self, from_debuff)
--        self.added_to_deck = false
--		for k, v in pairs(G.GAME.probabilities) do 
--			G.GAME.probabilities[k] = self.config.extra.temp
--		end
--    end,
--    loc_vars = function(self, info_queue, card)
--        return { vars = {self.config.extra.odds} }
--    end,
--    calculate = function(self, card, context)
--        if pseudorandom('lucky_money') < G.GAME.probabilities.normal then
--            for k, v in pairs(G.GAME.probabilities) do 
--			    G.GAME.probabilities[k] = v+1 weight
--            end
--        end
--    end
--}
SMODS.Joker {
    key = 'fudgeDice',
    config = {
        extra = {temp = 0},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "Fudge Dice",
            text = {
                "All Probabilties are {C:green}increased{} or",
                "{C:mult}decreased{} by 1 randomly each {C:attention}round{}.",
                "{C:inactive}(ex: {C:green}1/3{}{C:inactive} -> {C:green}(+1/-1)/3{}{C:inactive})",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    add_to_deck = function(self, from_debuff)
        self.added_to_deck = true
		for k, v in pairs(G.GAME.probabilities) do 
            self.config.extra.temp = v
		end
    end,
    remove_from_deck = function(self, from_debuff)
        self.added_to_deck = false
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = self.config.extra.temp
		end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            local ran = math.random(1,2)
            for k, v in pairs(G.GAME.probabilities) do 
                if ran == 1 then
                    G.GAME.probabilities[k] = v-1
                else
                    G.GAME.probabilities[k] = v+1
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'fluxDice',
    config = {
        extra = {temp = 0, ProbMult = 1, ProbInt = 0.03, has_triggered = false},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "Flux Dice",
            text = {
                "All Probabilties are {C:mult}multiplied{} by {C:green}X#2#{}.",
                "Gains {C:green}X#1#{} every time a {C:attention}lucky card{} is scored.",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    add_to_deck = function(self, from_debuff)
        self.added_to_deck = true
		for k, v in pairs(G.GAME.probabilities) do 
            self.config.extra.temp = v
		end
    end,
    remove_from_deck = function(self, from_debuff)
        self.added_to_deck = false
		for k, v in pairs(G.GAME.probabilities) do 
			G.GAME.probabilities[k] = self.config.extra.temp
		end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {self.config.extra.ProbInt, self.config.extra.ProbMult} }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.config.effect == "Lucky Card" and not context.blueprint then
            if not context.other_card.lucky_trigger and not self.config.extra.has_triggered then
                self.config.extra.has_triggered = true
            end
        end

        if context.repetition and context.cardarea == G.play then
            if not self.config.extra.has_triggered then
                self.config.extra.ProbMult = self.config.extra.ProbMult + self.config.extra.ProbInt
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = self.config.extra.temp*self.config.extra.ProbMult
                end
            end
            self.config.extra.has_triggered = false
        end
    end
}
SMODS.Joker {
    key = 'oops_all_oopsDice',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 3, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = "Oops! All Oops!",
            text = {
                "Spawns a {C:attention}random{} dice, {C:mult}destroys{} itself.",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            local die = Dice[math.random(0, #Dice)]
            create_joker('Joker', nil, nil, {forced_key=die})
            card:start_dissolve()
            return
        end
    end
}

-- Coins
SMODS.Joker {
    key = 'coin',
    config = {
        extra = {odds = 2, multmod = 2, mult = 0},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to gain {C:mult}+#4#{} mult when hand played",
                "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {card.ability.extra.mult, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.multmod} }
    end,
    calculate = function(self, card, context)
        if context.before then
            if pseudorandom('coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multmod
                return {
                    message = localize {
                        type = 'variable',
                        key = 'sj_mult',
                        vars = { card.ability.extra.multmod }
                    },
                }
            end
        end
        if context.joker_main then
            return {
                message = localize {
                    type = 'variable',
                    key = 'sj_mult',
                    vars = { card.ability.extra.mult }
                },
                mult_mod = card.ability.extra.mult,
                card = self
            }
        end
    end
}
SMODS.Joker {
    key = 'heart_coin',
    config = {
        extra = {odds = 2, current_Xmult = 4},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Heart Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to give {C:mult}X#1#{} mult",
                "If only {C:mult}Hearts{} are played",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.current_Xmult, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local hchd = true 
            for k, v in ipairs(context.full_hand) do 
                hchd = hchd and (v:get_suit() == 'Hearts') 
            end 
            if hchd then
                if pseudorandom('heart_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'sj_times',
                            vars = { card.ability.extra.current_Xmult }
                        },
                        Xmult_mod = card.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'club_coin',
    config = {
        extra = {odds = 2, mult = 50},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 4 },
    loc_txt = {
        ['en-us'] = {
            name = "Club Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to give {C:mult}+#1#{} mult",
                "If only {C:green}Clubs{} are played",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local cccd = true 
            for k, v in ipairs(context.full_hand) do 
                cccd = cccd and (v:get_suit() == 'Clubs') 
            end 
            if cccd then
                if pseudorandom('club_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'sj_mult',
                            vars = { card.ability.extra.mult }
                        },
                        mult_mod = card.ability.extra.mult,
                        card = self
                    }
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'spade_coin',
    config = {
        extra = {odds = 2, chips = 150},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Spade Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to give {C:blue}+#1#{} chips",
                "If only Spades are played",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local scsd = true 
            for k, v in ipairs(context.full_hand) do 
                scsd = scsd and (v:get_suit() == 'Spades') 
            end 
            if scsd then
                if pseudorandom('spade_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    return {
                        -- Return bonus message and apply bonus
                        message = localize{type='variable',key='sj_chips', vars={card.ability.extra.chips}},
                        chip_mod = card.ability.extra.chips,
                        card = self
                    }
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'diamond_coin',
    config = {
        extra = {odds = 2, money = 7},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Diamond Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to give {C:attention}$#1#{}",
                "If only {C:attention}Diamonds{} are played",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.money, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            local scsd = true 
            for k, v in ipairs(context.full_hand) do 
                scsd = scsd and (v:get_suit() == 'Diamonds') 
            end 
            if scsd then
                if pseudorandom('diamond_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        ease_dollars(self.config.extra.money, true)
                        return true end }))
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'ghost_coin',
    config = {
        extra = {odds = 10, current_Xmult = 10},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Ghost Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to give {C:mult}X#1#{} mult",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "c_snow_loganboi2", set = "Other"}
        return { vars = {card.ability.extra.current_Xmult, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if pseudorandom('ghost_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
            if context.joker_main and context.cardarea == G.jokers then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'sj_times',
                        vars = { card.ability.extra.current_Xmult }
                    },
                    Xmult_mod = card.ability.extra.current_Xmult,
                    card = self
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'liquid_coin',
    config = {
        extra = {odds = 20, num_retriggers = 1},
    },
    atlas = 'Joker',
    pos = { x = 2, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Liquid Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to {C:attention}retrigger{} all jokers",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.num_retriggers, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if pseudorandom('liquid_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
            if context.retrigger_joker_check and not context.retrigger_joker then
				return {
					message = localize('k_again_ex'),
					repetitions = self.config.num_retriggers,
					card = card
				}
		    end
        end
    end
}
SMODS.Joker {
    key = 'metal_coin',
    config = {
        extra = {odds = 4, num_retriggers = 1},
    },
    atlas = 'Joker',
    pos = { x = 3, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Metal Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to {C:attention}retrigger{} held in hand abilities",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.num_retriggers, card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand then
            if pseudorandom('metal_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'bent_coin',
    config = {
        extra = {odds = 4},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Bent Coin",
            text = {
                "Has a {C:green,E:1,S:1.1}#2# in #1#{} chance to double {C:attention}money{}. Else, halve {C:attention}money{}.",
            }
        }
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if pseudorandom('bent_coin') < G.GAME.probabilities.normal / card.ability.extra.odds then
                ease_dollars(G.GAME.dollars)
            else
                ease_dollars(-(G.GAME.dollars / 2))
            end
        end
    end
}

-- Consumables
SMODS.Consumable{
    key = 'fuel_cell',
    set = 'Tarot',
    discovered = true,
    config = { mod_conv = 'm_snow_platinum_card', max_highlighted = 1 },
    atlas = 'Consumables',
    pos = { x = 0, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Fuel Cell",
            text = {
                "Enhances {C:attention}1{} selected card",
                "into a {C:attention}Platinum card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_snow_platinum_card

        return {vars = {self.config.max_highlighted}}
    end,
}

-- Enhancements
SMODS.Enhancement {
    key = 'platinum_card',
    loc_txt = {
        name = 'Platinum Card',
        text = {
            "{C:green,E:1,S:1.1}#2# in 6{} chance to",
            "{C:attention}Retrigger{}",
            "{C:green,E:1,S:1.1}#2# in 18{} chance",
            "for {C:green}+#1#{} Probability",
        }
    },
    pos = {x = 0, y = 0}, 
    atlas = 'Enhancers', 
    config = { extra = {p_dollars = 4, platinum_trigger = false, prob = 0.2} },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.prob, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
}

-- Enhancement code
card_cal_seal = Card.calculate_seal
function Card:calculate_seal(context)
    local ret = card_cal_seal(self,context)
    if self.debuff then return nil end
    if context.repetition then
        if self.config.center == G.P_CENTERS.m_snow_platinum_card then
            if pseudorandom('platinum_rep') < G.GAME.probabilities.normal/3 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = self
                }
            end
        end
        if self.config.center == G.P_CENTERS.snow_a_club then
            if context.joker_main and context.cardarea == G.jokers then
                local bolcoco = true 
                for k, v in ipairs(context.full_hand) do 
                    bolcoco = bolcoco and (v:get_suit() == 'Clubs') 
                end 
                if bolcoco then 
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = self
                    }
                end 
            end
        end
    end
    if context.cardarea == G.play then
        if self.config.center == G.P_CENTERS.m_snow_platinum_card then
            if pseudorandom('platinum_prob') < G.GAME.probabilities.normal/15 then
                for k, v in pairs(G.GAME.probabilities) do 
                    G.GAME.probabilities[k] = v+0.2
                end
                return {
                    message = localize('sj_prob'),
                }
            end
        end
    end
    return ret
end

-- Augmentations
--SMODS.Atlas { key = 'Augment', path = 'Augmentations.png', px = 53, py = 63 }
--
---- Consumables
--SMODS.ConsumableType { 
--    key = 'Augmentations',
--    collection_rows = { 4,4 },
--    primary_colour = HEX("b17212"),
--    secondary_colour = HEX("b17212"),
--    loc_txt = {
--        collection = 'Augmentations',
--        name = 'Augmentations',
--        label = 'Augmentations',
--        undiscovered = {
--			name = "Not Discovered",
--			text = {
--				"Purchase or use",
--                "this card in an",
--                "unseeded run to",
--                "learn what it does"
--			},
--		},
--    },
--}
--
--SMODS.UndiscoveredSprite {
--	key = "Augmentations",
--	atlas = "Augment",
--	pos = {
--		x = 4,
--		y = 3,
--	}
--}
--
--SMODS.Consumable{
--    key = 'club_augmentation',
--    set = 'Augmentations',
--    config = { max_highlighted = 1, suit = "Club" },
--    atlas = 'Augment',
--    pos = { x = 0, y = 0 },
--    cost = 3,
--    loc_txt = {
--        ['en-us'] = {
--            name = "Club Augmentation",
--            text = {
--                "Enhances {C:attention}1{} selected joker",
--                "with the Augmentation {C:green}Club{}.",
--            }
--        }
--    },
--    loc_vars = function(self, info_queue)
--        info_queue[#info_queue+1] = {key = "c_snow_suit_augmentation", set = "Other", vars = {self.config.suit}}
--
--        return {vars = {self.config.max_highlighted}}
--    end,
--    can_use = function(self, card, area, copier)
--        if #G.jokers.highlighted == 1 then
--            return true
--        end
--        return false
--    end,
--    use = function(self, card)
--        for i=1, #G.jokers.highlighted do
--            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.jokers.highlighted[i]:set_ability(G.P_CENTERS.snow_a_club);return true end }))
--        end 
--    end,
--}
--SMODS.Consumable{
--    key = 'spade_augmentation',
--    set = 'Augmentations',
--    config = { suit = "Spade" },
--    atlas = 'Augment',
--    pos = { x = 1, y = 0 },
--    cost = 3,
--    loc_txt = {
--        ['en-us'] = {
--            name = "Spade Augmentation",
--            text = {
--                "Enhances {C:attention}1{} selected joker",
--                "with the Augmentation Spade.",
--            }
--        }
--    },
--    loc_vars = function(self, info_queue)
--        info_queue[#info_queue+1] = {key = "c_snow_suit_augmentation", set = "Other", vars = {self.config.suit}}
--        return { vars = { } }
--    end,
--    can_use = function(self, card, area, copier)
--        if #G.jokers.highlighted == 1 then
--            return true
--        end
--        return false
--    end,
--    use = function(self, card)
--        create_joker('Joker', nil, nil, {forced_key="j_snow_clubbed_joker"})
--        for i = 1, #G.jokers.cards do
--            if G.jokers.cards[i] == G.jokers.highlighted then
--                card:start_dissolve()
--            end
--        end
--    end,
--}
--SMODS.Consumable{
--    key = 'diamond_augmentation',
--    set = 'Augmentations',
--    config = { suit = "Diamond" },
--    atlas = 'Augment',
--    pos = { x = 2, y = 0 },
--    cost = 3,
--    loc_txt = {
--        ['en-us'] = {
--            name = "Diamond Augmentation",
--            text = {
--                "Enhances {C:attention}1{} selected joker",
--                "with the Augmentation {C:attention}Diamond{}.",
--            }
--        }
--    },
--    loc_vars = function(self, info_queue)
--        info_queue[#info_queue+1] = {key = "c_snow_suit_augmentation", set = "Other", vars = {self.config.suit}}
--        return { vars = { } }
--    end,
--    can_use = function(self, card, area, copier)
--        if #G.jokers.highlighted == 1 then
--            return true
--        end
--        return false
--    end,
--    use = function(self, card)
--        create_joker('Joker', nil, nil, {forced_key="j_snow_clubbed_joker"})
--        for i = 1, #G.jokers.cards do
--            if G.jokers.cards[i] == G.jokers.highlighted then
--                card:start_dissolve()
--            end
--        end
--    end,
--}
--SMODS.Consumable{
--    key = 'heart_augmentation',
--    set = 'Augmentations',
--    config = { suit = "Heart" },
--    atlas = 'Augment',
--    pos = { x = 3, y = 0 },
--    cost = 3,
--    loc_txt = {
--        ['en-us'] = {
--            name = "Heart Augmentation",
--            text = {
--                "Enhances {C:attention}1{} selected joker",
--                "with the Augmentation {C:mult}Heart{}.",
--            }
--        }
--    },
--    loc_vars = function(self, info_queue)
--        info_queue[#info_queue+1] = {key = "c_snow_suit_augmentation", set = "Other", vars = {self.config.suit}}
--        return { vars = { } }
--    end,
--    can_use = function(self, card, area, copier)
--        if #G.jokers.highlighted == 1 then
--            return true
--        end
--        return false
--    end,
--    use = function(self, card)
--        create_joker('Joker', nil, nil, {forced_key="j_snow_clubbed_joker"})
--        for i = 1, #G.jokers.cards do
--            if G.jokers.cards[i] == G.jokers.highlighted then
--                card:start_dissolve()
--            end
--        end
--    end,
--}

function SMODS.current_mod.set_debuff(card)
	if (next(SMODS.find_card('j_snow_love_is_blind')) and (card:is_suit('Hearts', true))) then
		return true
	end
end

----------------------------------------------
------------MOD CODE END---------------------
