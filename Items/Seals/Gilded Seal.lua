local gilded_seal = {
    object_type = "Seal",
    key = 'gilded_seal',
    config = {
        extra = { odds = 4 },
    },
    atlas = 'Enhancers',
    pos = { x = 2, y = 0 },
    badge_colour = HEX("caae80"),
    loc_txt = {
        label = 'Gilded Seal',
        name = 'Gilded Seal',
        text = {
            '{C:money}$5{} when played, {C:green,E:1,S:1.1}#2# in #1#{} chance',
            'that it gives {C:money}-$5{} instead.',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition and not context.blueprint then
            if pseudorandom('gilded_seal') < G.GAME.probabilities.normal/4 then
                ease_dollars(-5)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - 5
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return
            else
                ease_dollars(5)
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 5
                G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                return
            end
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {gilded_seal}}