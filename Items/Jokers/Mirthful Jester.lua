local mirthful_jester = {
    object_type = "Joker",
    key = 'mirthful_jester',
    config = {
        poker_hand = "Two Pair", money = 3,
    },
    atlas = 'Joker',
    pos = { x = 4, y = 0 },
    rarity = 1,
    cost = 4,
    order = 8,
    blueprint_compat = true,
    familiar = "j_mad",
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
return {name = "Jokers", items = {mirthful_jester}}