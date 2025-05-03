local internet = {
    object_type = "Consumable",
    key = 'internet',
    set = 'tekana',
    config = {max_highlighted = 3, suit_conv = 'fam_webs'},
    ignore = true,
    atlas = 'Consumables',
    pos = { x = 15, y = 4 },
    soul_pos = {x = 10, y = 5},
    third_layer = {x = 18, y = 3},
    fouth_layer = {x = 18, y = 1},
    fifth_layer = {x = 18, y = 4},
    cost = 3,
    order = 19,
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    keep_on_use = function(self,card)
        return true
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 3) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self)
        if G.GAME then
            G.GAME.Webs = true
        end

        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip()
                play_sound('card1', percent)
                G.hand.highlighted[i]:juice_up(0.3, 0.3)
            return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                G.hand.highlighted[i]:change_suit(self.config.suit_conv)
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip()
                play_sound('tarot2', percent, 0.6)
                G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end }))
        delay(0.5)
    end,

    in_pool = G.GAME and G.GAME.Webs
}
return {name = {"Tekana Cards", "Suits"}, items = {internet}}