local void_deck = {
    object_type = "Back",
    key = "void_deck",
    atlas = 'Enhancers',
    order = 5,
    pos = { x = 7, y = 3 },
    config = {joker_slot = -3},
    apply = function(self, card, context)
        G.GAME.modifiers.fam_neg_common = true
    end
}
return {name = "Decks", items = {void_deck}}