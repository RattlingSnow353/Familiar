local rug_pull = {
    object_type = "Joker",
    key = 'rug_pull',
    config = {
        extra = { mult = 0, mult_mod = 2, cash = 0, interest_amount = 0 },
    },
    atlas = 'Joker',
    pos = { x = 8, y = 13 },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_to_the_moon",
    order = 84,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end,
}
return {name = "Jokers", items = {rug_pull}}