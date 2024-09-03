local prosopagnosia = {
    object_type = "Joker",
    key = 'prosopagnosia',
    config = {
        extra = { },
    },
    atlas = 'Joker',
    pos = { x = 6, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = 'Prosopagnosia',
            text = {
                "No cards",
                "are considered",
                "{C:attention}face{} cards",
            }
        }
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
    end
}
return {name = "Jokers", items = {prosopagnosia}}