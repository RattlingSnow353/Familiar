local joyful_jester = {
    object_type = "Joker",
    key = 'joyful_jester',
    config = {
        poker_hand = "Pair", money = 2,
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
        return { vars = { card.ability.poker_hand, card.ability.money } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.poker_hand]) then
            return {
                dollars = card.ability.money,
                colour = G.C.MONEY
            }
        end
    end
}
return {name = "Jokers", items = {joyful_jester}}