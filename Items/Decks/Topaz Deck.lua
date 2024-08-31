local topaz_deck = {
    object_type = "Back",
    key = "topaz_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Topaz Deck",
            text = {
                "{C:blue}+1{} hand every round,",
                "{C:red}+1{} discard every round",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 0, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                ease_discard(1)

                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                return true
            end
        }))
    end
}
return {name = "Topaz Deck", items = {topaz_deck}}