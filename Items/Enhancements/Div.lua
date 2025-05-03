local div = {
    object_type = "Enhancement",
    key = 'div',
    pos = {x = 2, y = 1}, 
    atlas = 'Enhancers', 
    order = 2,
    unlocked = true,
    config = { extra = {mult = 0.9, chips = 100} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.mult, self.config.extra.chips} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            SMODS.calculate_effect({chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}},card)
            delay(0.2)
            SMODS.calculate_effect({Xmult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.mult}}}, card)
        end
    end
}
return {name = {"Fortune Cards", "Enhancements"}, items = {div}}