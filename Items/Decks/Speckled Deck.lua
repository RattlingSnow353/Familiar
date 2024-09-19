local speckled_deck = {
    object_type = "Back",
    key = "speckled_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Speckled Deck",
            text = {
                "All {C:attention}Cards{} in the deck",
                "are {C:dark_edition}Speckled",
                "All {C:attention}Jokers{} are {C:dark_edition}Speckled",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 2 },
    config = {fam_force_edition = "fam_speckle"},
}
return {name = {"Editions", "Decks"}, items = {speckled_deck}}