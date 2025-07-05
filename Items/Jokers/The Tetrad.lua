local the_tetrad = {
    object_type = "Joker",
    key = 'the_tetrad',
    config = {
        poker_hand = "Four of a Kind", Xchips = 4,
    },
    atlas = 'Joker',
    pos = { x = 7, y = 4 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    familiar = "j_family",
    order = 133,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips, localize(card.ability.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.poker_hand]) then
            return {
                xchips = card.ability.Xchips
            }
        end
    end
}
return {name = "Jokers", items = {the_tetrad}}