local spare_deck = {
    object_type = "Back",
    key = "spare_deck",
    atlas = 'Enhancers',
    order = 9,
    unlocked = false,
    pos = { x = 3, y = 3 },
    config = { dollars = math.random(-2,7) },
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({ 
            func = function()
                self.config.dollars = math.random(-2,7)
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                G.GAME.starting_params.dollars = self.config.dollars
                for i = #G.playing_cards, 1, -1 do 
                    if pseudorandom('nocards') < 1/4 then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                    if pseudorandom('nocards') < 1/16 then
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(G.playing_cards[i], nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                    end
                end
                return true
            end
        }))
    end
}
return {name = "Decks", items = {spare_deck}}