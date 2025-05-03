local topaz_deck = {
    object_type = "Back",
    key = "topaz_deck",
    atlas = 'Enhancers',
    order = 2,
    pos = { x = 0, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                ease_discard(1)

                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1

                G.hand:change_size(-2)
                return true
            end
        }))
    end
}
return {name = "Decks", items = {topaz_deck}}