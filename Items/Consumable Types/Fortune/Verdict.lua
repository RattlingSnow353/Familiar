local verdict = {
    object_type = "Consumable",
    key = 'verdict',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 0, y = 2 },
    cost = 3,
    order = 21,
    familiar = "c_judgement",
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if #G.consumeables.cards <= G.consumeables.config.card_limit or self.area == G.consumeables then 
            return true 
        end
    end,
    use = function(self, card)
        create_consumable("Consumeables", nil, nil, nil)
    end,
}
return {name = "Fortune Cards", items = {verdict}}