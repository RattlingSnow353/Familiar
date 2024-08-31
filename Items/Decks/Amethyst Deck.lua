local amethyst_deck = {
    object_type = "Back",
    key = "amethyst_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Amethyst Deck",
            text = {
                "{C:attention}+5{} hand size",
            }
        }
    },
    atlas = 'Enhancers',
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
return {name = "Amethyst Deck", items = {amethyst_deck}}