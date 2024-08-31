local charmed = {
    object_type = "Enhancement",
    key = 'charmed',
    loc_txt = {
        name = 'Charmed',
        text = {
            "{C:green,E:1,S:1.1}#3# in #1#{} chance",
            "for {C:blue}+#2#{} Chips",
            "{C:green,E:1,S:1.1}#3# in #4#{} chance",
            "for a random {C:attention}Tarot{} card",
        }
    },
    pos = {x = 4, y = 1}, 
    atlas = 'Enhancers', 
    config = { extra = { chips = 150, odds = 5, } },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.odds, self.config.extra.chips, '' .. (G.GAME and G.GAME.probabilities.normal or 1), self.config.extra.odds*2} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition then
            if pseudorandom('charmed_prob') < G.GAME.probabilities.normal/self.config.extra.odds then
                delay(0.2)
                SMODS.eval_this(card, {chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} )
            end
            if pseudorandom('charmed_prob') < G.GAME.probabilities.normal/(self.config.extra.odds*2) then
                create_consumable("Tarot")
            end
        end
    end
}
return {name = "Charmed", items = {charmed}}