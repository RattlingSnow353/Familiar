local joyful_jester = {
    object_type = "Joker",
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
return {name = "Joyful Jester", items = {joyful_jester}}