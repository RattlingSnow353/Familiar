local pantheon_booster_2 = {
    object_type = "Booster",
    name = "Pantheon Tin",
	key = "pantheon_booster_2",
    group_key = "pantheon_booster",
	atlas = 'Booster',
    order = 5,
	pos = {x = 0, y = 3},
	weight = 0.5 * 2,
	cost = 9,
	config = { extra = 5, choose = 1},
	discovered = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.config.center.config.choose, card.ability.extra} }
	end,
	create_card = function(self, card)
        return create_card("Familiar_Planets", G.pack_cards, nil, nil, true, true, nil, 'fam_pantheon')
	end,
        update_pack = function(self, dt)
        if G.buttons then self.buttons:remove(); G.buttons = nil end
        if G.shop then G.shop.alignment.offset.y = G.ROOM.T.y+11 end
        
        if not G.STATE_COMPLETE then
            G.STATE_COMPLETE = true
            G.CONTROLLER.interrupt.focus = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if self.sparkles then
                        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
                            timer = self.sparkles.timer or 0.015,
                            scale = self.sparkles.scale or 0.1,
                            initialize = true,
                            lifespan = self.sparkles.lifespan or 3,
                            speed = self.sparkles.speed or 0.2,
                            padding = self.sparkles.padding or -1,
                            attach = G.ROOM_ATTACH,
                            colours = self.sparkles.colours or {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
                            fill = true
                        })
                    end
                    G.booster_pack = UIBox{
                        definition = self:pack_uibox(),
                        config = {align="tmi", offset = {x=0,y=G.ROOM.T.y + 9}, major = G.hand, bond = 'Weak'}
                    }
                    G.booster_pack.alignment.offset.y = -2.2
                    G.ROOM.jiggle = G.ROOM.jiggle + 3
                    self:ease_background_colour()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            G.FUNCS.draw_from_deck_to_hand()
        
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.5,
                                func = function()
                                    G.CONTROLLER:recall_cardarea_focus('pack_cards')
                                    return true
                                end}))
                            return true
                        end
                    }))  
                    return true
                end
            }))  
        end
    end,
    pack_uibox = function(self)
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = "Pantheon Tin", colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}
return {name = "Sacred Cards", items = {pantheon_booster_2}}