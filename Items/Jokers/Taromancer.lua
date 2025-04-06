local taromancer = {
    object_type = "Joker",
    key = 'taromancer',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 2, y = 7 },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    familiar = "j_astronomer",
    order = 143,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end
}
return {name = "Jokers", items = {taromancer}}