local taromancer = {
    object_type = "Joker",
    key = 'taromancer',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 2, y = 7 },
    loc_txt = {
        ['en-us'] = {
            name = 'Taromancer',
            text = {
                "All {C:tarot}Tarot{} cards and",
                "{C:tarot}Arcana Packs{} in",
                "the shop are {C:attention}free",
            }
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end
}
return {name = "Jokers", items = {taromancer}}