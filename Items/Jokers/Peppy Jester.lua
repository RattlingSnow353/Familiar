local peppy_jester = {
    object_type = "Joker",
    key = 'peppy_jester',
    config = {
        poker_hand = "Three of a Kind", money = 4,
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
    order = 7,
    blueprint_compat = true,
    familiar = "j_zany",
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
return {name = "Jokers", items = {peppy_jester}}