local strawberry = {
    object_type = "Joker",
    key = 'strawberry',
    config = {
        extra = {mult = 20, mult_mod = 1},
    },
    atlas = 'Joker',
    pos = { x = 4, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Strawberry',
            text = {
                "{C:mult}+#1#{} Mult",
                "{C:mult}-#2#{} Mult for",
                "every hand played",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod} }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            if card.ability.extra.mult - card.ability.extra.mult_mod <= 0 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_mod
                return {
                    message = localize{type='variable',key='a_mult_minus',vars={card.ability.extra.mult_mod}},
                    colour = G.C.RED,
                }
                
            end
        end
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult, 
                colour = G.C.RED,
                card = self,
            }
        end
    end
}
return {name = "Strawberry", items = {strawberry}}