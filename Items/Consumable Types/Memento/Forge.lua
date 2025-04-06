local forge = {
    object_type = "Consumable",
    key = 'forge',
    set = 'Familiar_Spectrals',
    config = { extra = {mod_conv = "fam_gilded_seal", odds = 4 } },
    atlas = 'Consumables',
    pos = { x = 3, y = 4 },
    order = 4,
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {key = 'fam_gilded_seal_seal', set = 'Other', vars = { self.config.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) }}
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
return {name = {"Seals", "Memento Cards"}, items = {forge}}