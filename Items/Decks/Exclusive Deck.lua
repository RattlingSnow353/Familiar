local exclusive_deck = {
    object_type = "Back",
    key = "exclusive_deck",
    atlas = 'Enhancers',
    order = 15,
    pos = { x = 2, y = 3 },
    config = {},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({ 
            func = function()
                local rank = pseudorandom_element(SMODS.Ranks, pseudoseed('exclusive_deck'))
                local suit = pseudorandom_element(SMODS.Suits, pseudoseed('exclusive_deck'))
                for i = #G.playing_cards, 1, -1 do 
                    assert(SMODS.change_base(G.playing_cards[i], suit.key, rank.key))
                end
                return true
            end
        }))
    end
}
return {name = "Decks", items = {exclusive_deck}}