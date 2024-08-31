local static_deck = {
    object_type = "Back",
    key = "static_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Static Deck",
            text = {
                "All {C:attention}Cards{} in the deck",
                "are {C:dark_edition}Static",
                "All {C:attention}Jokers{} are {C:dark_edition}Static",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 2 },
    config = {fam_force_edition = "fam_statics"},
}
return {name = "Static Deck", items = {static_deck}}