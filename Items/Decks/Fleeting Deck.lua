local fleeting_deck = {
    object_type = "Back",
    key = "fleeting_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Fleeting Deck",
            text = {
                "{C:attention}+3{} discards,",
                "{C:blue}-1{} hand size."
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 6, y = 2 },
    config = { memento_rate = 400 },
}
return {name = "Decks", items = {fleeting_deck}}