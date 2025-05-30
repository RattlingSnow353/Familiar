local penalty = {
    object_type = "Enhancement",
    key = 'penalty',
    pos = {x = 1, y = 1}, 
    atlas = 'Enhancers', 
    order = 1,
    unlocked = true,
    config = { extra = {mult = 20, chips = 20} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.mult, self.config.extra.chips} }
    end,
    calculate = function(self, card, context)
        hand_chips = mod_chips(hand_chips)
        if context.main_scoring and context.cardarea == G.play then
            SMODS.calculate_effect({mult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}, card)
            delay(0.2)
            SMODS.calculate_effect({chip_mod = -card.ability.extra.chips, message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chips}}}, card)
        end
    end
}
return {name = {"Fortune Cards", "Enhancements"}, items = {penalty}}