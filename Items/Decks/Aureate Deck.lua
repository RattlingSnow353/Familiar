local aureate_deck = {
    object_type = "Back",
    key = "aureate_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Aureate Deck",
            text = {
                "All {C:attention}Cards{} in the deck",
                "are {C:dark_edition}Aureate",
                "All {C:attention}Jokers{} are {C:dark_edition}Aureate",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 2 },
    config = {fam_force_edition = "fam_aureate"},
}
return {name = "Aureate Deck", items = {aureate_deck}}