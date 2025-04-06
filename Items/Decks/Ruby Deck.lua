local ruby_deck = {
    object_type = "Back",
    key = "ruby_deck",
    atlas = 'Enhancers',
    order = 4,
    pos = { x = 2, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
                ease_discard(2)

                G.GAME.starting_params.hands = G.GAME.starting_params.hands - 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
                
                create_consumable("Familiar_Spectrals", nil, nil, {forced_key='c_fam_playback'})
                create_consumable("Familiar_Spectrals", nil, nil, {forced_key='c_fam_playback'})
                return true
            end
        }))
    end
}
return {name = {"Decks", "Memento Cards"}, items = {ruby_deck}}