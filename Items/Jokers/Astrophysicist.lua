local astrophysicist = {
    object_type = "Joker",
    key = 'astrophysicist',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = 'Astrophysicist',
            text = {
                "Create a {C:blue}Planet{} card",
                "when {C:attention}Blind{} is selected",
                "{C:inactive}(Must have room)",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            create_consumable("Planet", nil, {localize('k_plus_tarot'), colour = G.C.blue})
        end
    end
}
return {name = "Astrophysicist", items = {astrophysicist}}