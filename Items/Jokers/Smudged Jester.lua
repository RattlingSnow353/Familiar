local smudged_jester = {
    object_type = "Joker",
    key = 'smudged_jester',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 6 },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_smeared",
    order = 113,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end
}
return {name = "Jokers", items = {smudged_jester}}