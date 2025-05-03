local silver_deck = {
    object_type = "Back",
    key = "silver_deck",
    atlas = 'Enhancers',
    order = 5,
    pos = { x = 3, y = 2 },
    unlocked = false,
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
                ease_discard(-1)
                
                G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + 2
                G.jokers.config.card_limit = G.jokers.config.card_limit + 2

                G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
                return true
            end
        }))
    end
}
return {name = "Decks", items = {silver_deck}}