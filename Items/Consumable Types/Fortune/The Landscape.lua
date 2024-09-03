local the_landscape = {
    object_type = "Consumable",
    key = 'the_landscape',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 1, y = 2 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Landscape",
            text = {
                "Adds {C:spades}Spades{} to up",
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
            G.hand.highlighted[i].ability.is_spade = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
return {name = "Fortune Cards", items = {the_landscape}}