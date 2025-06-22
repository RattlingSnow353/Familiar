local stained_glass = {
    object_type = "Enhancement",
    key = 'stained_glass',
    pos = {x = 5, y = 1}, 
    atlas = 'Enhancers', 
    order = 4,
    shatters = true,
    config = { extra = { odds = 4, editions = {} } },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1)} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if pseudorandom('stained_glass') < G.GAME.probabilities.normal/card.ability.extra.odds then
                return {
                    card:shatter()
                }
            else
                local ed = poll_edition('stained_glass', 1, false, true)
                if card.edition ~= nil then
                    table.insert(card.ability.extra.editions, card.edition)
                end
                local editions = card.ability.extra.editions
                card:set_edition(ed, true, true)
                for i = #editions, 1, -1 do
                    delay(0.2)
                    SMODS.calculate_effect(editions[i],card)
                end
                return
            end
        end
	end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {stained_glass}}