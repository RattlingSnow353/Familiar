local fleeting_deck = {
    object_type = "Back",
    key = "fleeting_deck",
    atlas = 'Enhancers',
    order = 8,
    pos = { x = 6, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME["familiar_spectrals_rate"] = 1.5
                return true
            end
        }))
    end
}
return {name = "Decks", items = {fleeting_deck}}