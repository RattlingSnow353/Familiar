local smudged_jester = {
    object_type = "Joker",
    key = 'smudged_jester',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 6 },
    loc_txt = {
        ['en-us'] = {
            name = 'Smudged Jester',
            text = {
                "{C:attention}3s{} counts as {C:attention}8s{}",
                "{C:attention}6s{} count as {C:attention}9s{}",
                "{C:attention}Kings{} count as {C:attention}Aces{}",
            }
        }
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_smeared",
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end
}
return {name = "Jokers", items = {smudged_jester}}