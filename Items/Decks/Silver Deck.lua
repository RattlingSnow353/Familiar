local silver_deck = {
    object_type = "Back",
    key = "silver_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Silver Deck",
            text = {
                "{C:attention}+2{} joker slots,",
                "{C:blue}-1{} hand every round,",
                "{C:red}-1{} discard every round",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 3, y = 2 },
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
return {name = "Silver Deck", items = {silver_deck}}