local andys_deck = {
    object_type = "Back",
    key = "andys_deck",
    atlas = 'Enhancers',
    order = 1,
    pos = { x = 7, y = 0 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 3
                ease_discard(3)
                G.hand:change_size(-1)
                return true
            end
        }))
    end
}
return {name = "Decks", items = {andys_deck}}