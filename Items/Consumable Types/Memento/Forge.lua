local forge = {
    object_type = "Consumable",
    key = 'forge',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_gilded_seal"} },
    atlas = 'Consumables',
    pos = { x = 3, y = 4 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Forge",
            text = {
                "Add a {C:money}Gilded Seal",
                "to 2 {C:attention}selected cards{}",
                "in your hand",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.fam_sapphire_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 2)  then
            return true 
        end
    end,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for i = 1, #G.hand.highlighted do 
                G.hand.highlighted[i]:set_seal("fam_gilded_seal", nil, true)
            end
            return true end }))
        
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}
return {name = "Forge", items = {forge}}