local ruby_deck = {
    object_type = "Back",
    key = "ruby_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Ruby Deck",
            text = {
                "Start with {C:attention}2 copies{} of Playback,",
                "{C:red}+2{} discards every round.",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 2, y = 2 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 2
                ease_discard(2)
                
                create_consumable("Familiar_Spectrals", nil, nil, {forced_key='c_fam_playback'})
                create_consumable("Familiar_Spectrals", nil, nil, {forced_key='c_fam_playback'})
                return true
            end
        }))
    end
}
return {name = "Ruby Deck", items = {ruby_deck}}