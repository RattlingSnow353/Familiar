local astrophysicist = {
    object_type = "Joker",
    key = 'astrophysicist',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 3 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    familiar = "j_cartomancer",
    order = 142,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                create_consumable("Planet", nil, {localize('k_fam_plus_planet'), colour = G.C.blue})
            end 
        end
    end
}
return {name = "Jokers", items = {astrophysicist}}