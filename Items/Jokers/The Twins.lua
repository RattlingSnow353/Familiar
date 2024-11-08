local the_twins = {
    object_type = "Joker",
    key = 'the_twins',
    config = {
        extra = {poker_hand = "Pair", x_chips = 2},
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
        return { vars = { card.ability.extra.x_chips, localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.extra.poker_hand]) then
            return {
                message = "X"..number_format(card.ability.extra.x_chips),
                Xchip_mod = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
return {name = "Jokers", items = {the_twins}}