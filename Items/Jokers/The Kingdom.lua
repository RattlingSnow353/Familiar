local the_kingdom = {
    object_type = "Joker",
    key = 'the_kingdom',
    config = {
        poker_hand = "Flush", Xchips = 2,
    },
    atlas = 'Joker',
    pos = { x = 9, y = 4 },
    rarity = 3,
    cost = 8,
    order = 135,
    blueprint_compat = true,
    familiar = "j_tribe",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips, localize(card.ability.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.poker_hand]) then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
    end
}
return {name = "Jokers", items = {the_kingdom}}