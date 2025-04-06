local desolate_wanderer = {
    object_type = "Consumable",
    key = 'desolate_wanderer',
    set = 'tekana',
    config = { extra = {} },
    ignore = true,
    atlas = 'Consumables',
    pos = { x = 15, y = 4 },
    soul_pos = {x = 10, y = 5},
    third_layer = {x = 12, y = 2},
    fouth_layer = {x = 10, y = 0},
    fifth_layer = {x = 16, y = 4},
    order = 1,
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    keep_on_use = function(self,card)
        return true
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        tekana_shut_down(self, card)
    end,
}
return {name = "Tekana Cards", items = {desolate_wanderer}}