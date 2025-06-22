local gilded_seal = {
    object_type = "Seal",
    key = 'gilded_seal',
    config = {
        extra = { odds = 4, money = 5 },
    },
    atlas = 'Enhancers',
    pos = { x = 2, y = 0 },
    badge_colour = HEX("caae80"),
    order = 3,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('gilded_seal') < G.GAME.probabilities.normal/card.ability.extra.odds then
                return {
                    dollars = -card.ability.extra.money,
                }
            else
                return {
                    dollars = card.ability.extra.money,
                }
            end
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {gilded_seal}}