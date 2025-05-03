local prosopagnosia = {
    object_type = "Joker",
    key = 'prosopagnosia',
    config = {
        extra = { },
    },
    atlas = 'Joker',
    pos = { x = 6, y = 3 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_pareidolia",
    order = 37,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
    end
}
return {name = "Jokers", items = {prosopagnosia}}