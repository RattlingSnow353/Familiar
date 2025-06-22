local neopolitan = {
    object_type = "Joker",
    key = 'neopolitan',
    config = {
        extra = {chips = 50, chip_mod = 10 , mult = 10, mult_mod = 2, money = 5, money_mod = 1},
    },
    atlas = 'Joker',
    pos = { x = 14, y = 10 },
    rarity = 2,
    cost = 6,
    familiar = "j_ice_cream",
    order = 50,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.money, card.ability.extra.money_mod} }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_hand and not context.blueprint then
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
                return {
                    extra = {
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = '-$'..number_format(card.ability.extra.money_mod),
                            colour = G.C.MONEY,
                        }),
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chip_mod}},
                            colour = G.C.CHIPS,
                        })
                    },
                    message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.mult_mod}},
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            if pseudorandom('neopolitan') < G.GAME.probabilities.normal/3 then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult, 
                    colour = G.C.RED,
                    card = card,
                }
            elseif pseudorandom('neopolitan') < G.GAME.probabilities.normal/2 then
                return {
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY
                }
            else
                return {
                    message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                    chip_mod = card.ability.extra.chips, 
                    colour = G.C.CHIPS,
                    card = card,
                }
            end
        end
    end
}
return {name = "Jokers", items = {neopolitan}}