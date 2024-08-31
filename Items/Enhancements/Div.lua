local div = {
    object_type = "Enhancement",
    key = 'div',
    loc_txt = {
        name = 'Div',
        text = {
            "{C:red}X#1#{} Mult",
            "{C:blue}+#2#{} Chips",
        }
    },
    pos = {x = 2, y = 1}, 
    atlas = 'Enhancers', 
    config = { extra = {mult = 0.9, chips = 100} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.mult, self.config.extra.chips} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition then
            SMODS.eval_this(card, {chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} )
            delay(0.2)
            SMODS.eval_this(card, {Xmult_mod = card.ability.extra.mult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.mult}}} )
        end
    end
}
return {name = "Div", items = {div}}