local amethyst_deck = {
    object_type = "Back",
    key = "amethyst_deck",
    atlas = 'Enhancers',
    order = 1,
    pos = { x = 0, y = 0 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:change_size(5)
                return true
            end
        }))
    end
}
return {name = "Decks", items = {amethyst_deck}}