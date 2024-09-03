local andys_deck = {
    object_type = "Back",
    key = "andys_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Merry Andy's Deck",
            text = {
                "{C:attention}+3{} discards,",
                "{C:blue}-1{} hand size."
            }
        }
    },
    atlas = 'Enhancers',
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