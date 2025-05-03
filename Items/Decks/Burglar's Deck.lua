local burglars_deck = {
    object_type = "Back",
    key = "burglars_deck",
    atlas = 'Enhancers',
    order = 2,
    pos = { x = 7, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_discard(-G.GAME.round_resets.discards)
                G.GAME.round_resets.discards = 0
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 3
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 3
                return true
            end
        }))
    end
}
return {name = "Decks", items = {burglars_deck}}