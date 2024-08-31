local oracle = {
    object_type = "Consumable",
    key = 'oracle',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_familiar_seal"} },
    atlas = 'Consumables',
    pos = { x = 4, y = 5 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Oracle",
            text = {
                "Add a Familiar Seal",
                "to one {C:attention}selected card{}",
                "in your hand",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.fam_familiar_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true 
        end
    end,
    use = function(self, card)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal("fam_familiar_seal", nil, true)
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}
return {name = "Oracle", items = {oracle}}