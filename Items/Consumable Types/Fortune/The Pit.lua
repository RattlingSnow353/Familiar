local the_pit = {
    object_type = "Consumable",
    key = 'the_pit',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 6, y = 1 },
    cost = 4,
    loc_txt = {
        ['en-us'] = {
            name = "The Pit",
            text = {
                "Turns up to {C:attention}3{} selected",
                "cards to {C:GREY}Suitless",
                "{C:inactive}(Suitless cards always score)",
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
            G.hand.highlighted[i].ability.suitless = true
            set_sprite_suits(G.hand.highlighted[i], true)
        end
    end,
}
return {name = "The Pit", items = {the_pit}}