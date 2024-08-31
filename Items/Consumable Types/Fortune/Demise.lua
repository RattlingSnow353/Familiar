local demise = {
    object_type = "Consumable",
    key = 'demise',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 3, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Demise",
            text = {
                "Select {C:attention}3{} cards,",
                "convert {C:attention}them{} into",
                "a {C:attention}random{} selected card",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 3) then
            return true 
        end
    end,
    use = function(self, card)
        local random = G.hand.highlighted[math.random(1, #G.hand.highlighted)]
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= random then
                    G.hand.highlighted[i]:juice_up(0.3, 0.5)
                    copy_card(random, G.hand.highlighted[i])
                end
            return true end }))
        end  
    end,
}
return {name = "Demise", items = {demise}}