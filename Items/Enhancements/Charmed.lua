local charmed = {
    object_type = "Enhancement",
    key = 'charmed',
    pos = {x = 4, y = 1}, 
    atlas = 'Enhancers', 
    order = 8,
    unlocked = true,
    config = { extra = { chips = 150, odds = 5, } },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.odds, self.config.extra.chips, '' .. (G.GAME and G.GAME.probabilities.normal or 1), self.config.extra.odds*2} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('charmed_prob') < G.GAME.probabilities.normal/self.config.extra.odds then
                delay(0.2)
                SMODS.calculate_effect({chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}, card)
            end
            if pseudorandom('charmed_prob') < G.GAME.probabilities.normal/(self.config.extra.odds*2) then
                create_consumable("Tarot")
            end
        end
    end
}
return {name = {"Fortune Cards", "Enhancements"}, items = {charmed}}