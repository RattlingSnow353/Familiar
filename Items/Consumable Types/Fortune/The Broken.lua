local the_broken = {
    object_type = "Consumable",
    key = 'the_broken',
    discovered = false,
    order = 1,
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 0, y = 0 },
    cost = 3,
    familiar = "c_fool",
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if (#G.consumeables.cards <= G.consumeables.config.card_limit or self.area == G.consumeables) and G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool' then
            return true 
        end
    end,
    use = function(self, card)
        local self_card = G.GAME.last_tarot_planet
        for key, _ in pairs(fam_comsumable_table) do
            if key == self_card then
                local new_joke = fam_comsumable_table[key]

                local jester_key = new_joke[math.random(1, #new_joke)]
                create_consumable("Consumeables", nil, nil, {forced_key=jester_key})
            end
        end
    end,
}
return {name = "Fortune Cards", items = {the_broken, Familiar_TarotsUndiscoveredSprite, Familiar_TarotsConsumableType}}