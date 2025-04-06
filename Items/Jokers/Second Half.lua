local second_half = {
    object_type = "Joker",
    key = 'second_half',
    config = {
        extra = { chips = 75, least_cards = 3 },
    },
    atlas = 'Joker',
    pos = { x = 7, y = 0 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    familiar = "j_half",
    order = 16,
    pixel_size = { w = 71, h = 41 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.least_cards } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand >= card.ability.extra.least_cards then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips
            }
        end
    end
}
return {name = "Jokers", items = {second_half}}