local stainless = {
    object_type = "Enhancement",
    key = 'stainless',
    pos = {x = 6, y = 1}, 
    atlas = 'Enhancers', 
    order = 5,
    config = { extra = { chips = 50, x_mult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.x_mult, self.config.extra.chips} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            SMODS.calculate_effect({chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}},card)
            delay(0.2)
            SMODS.calculate_effect({Xmult_mod = card.ability.extra.x_mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}}}, card)
        end
	end,
    update = function(self, card, dt)
        card:set_edition(nil, true, true)
        if card.debuff then
            card.debuff = false
        end
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {stainless}}