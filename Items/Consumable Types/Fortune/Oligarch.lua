local oligarch = {
    object_type = "Consumable",
    key = 'oligarch',
    set = 'Familiar_Tarots',
    config = { extra = { } },
    atlas = 'Consumables',
    pos = { x = 4, y = 0 },
    cost = 3,
    order = 5,
    familiar = "c_emperor",
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if #G.consumeables.cards > 0 then
            for ind, k_ in pairs(G.consumeables.cards) do
                for key, _ in pairs(fam_comsumable_table) do
                    if key == k_.config.center_key then
                        local new_joke = fam_comsumable_table[key]
                        if #new_joke == 0 then
                            return false
                        end
                        return true 
                    end
                end 
            end
        end
    end,
    use = function(self, card)
        local temp = 0
        for ind, k_ in pairs(G.consumeables.cards) do
            for key, _ in pairs(fam_comsumable_table) do
                if key == k_.config.center_key and temp ~= 1 then
                    local new_joke = fam_comsumable_table[key]

                    local jester_key = new_joke[math.random(1, #new_joke)]
                    create_consumable("Consumeables", nil, nil, {forced_key=jester_key})
                    k_:start_dissolve()
                    temp = temp + 1
                end
            end
        end
    end,
}
return {name = {"Fortune Cards"}, items = {oligarch}}