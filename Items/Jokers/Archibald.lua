local archibald = {
    object_type = "Joker",
    key = 'archibald',
    config = {
        extra = { money = 25, current_money = 0},
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
return {name = "Jokers", items = {archibald}}