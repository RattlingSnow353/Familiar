local the_midnight = {
    object_type = "Consumable",
    key = 'the_midnight',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 8, y = 1 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Midnight",
            text = {
                "Adds {C:clubs}Clubs{} to up",
                "to {C:attention}3{} selected cards.",
                "{C:inactive}(Does not remove other suit(s))",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
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
return {name = "The Midnight", items = {the_midnight}}