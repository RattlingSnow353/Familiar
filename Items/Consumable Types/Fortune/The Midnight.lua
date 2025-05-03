local the_midnight = {
    object_type = "Consumable",
    key = 'the_midnight',
    set = 'Familiar_Tarots',
    config = { max_highlighted = 3 },
    atlas = 'Consumables',
    pos = { x = 8, y = 1 },
    cost = 4,
    order = 19,
    familiar = "c_moon",
    unlocked = false,
    loc_vars = function(self, info_queue)
        return { vars = { self.config.max_highlighted } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= card.ability.max_highlighted) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i].ability.is_club = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
return {name = "Fortune Cards", items = {the_midnight}}