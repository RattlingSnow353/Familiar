local spare_deck = {
    object_type = "Back",
    key = "spare_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Spare Deck",
            text = {
                "Start run with",
                "{C:attention}no Aces{}, {C:attention}doubled Jacks",
                "{C:attention}no queen's{}, and {C:attention}doubled 7's",
                "{C:blue}+1{} hand, and {C:money}$13",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 3, y = 3 },
    config = { dollars = 9 },
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({ 
            func = function()
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + 1
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                G.GAME.starting_params.dollars = self.config.dollars
                for i = #G.playing_cards, 1, -1 do 
                    if G.playing_cards[i]:get_id() == 14 or G.playing_cards[i]:get_id() == 12 then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                    if G.playing_cards[i]:get_id() == 11 or G.playing_cards[i]:get_id() == 7 then
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
return {name = "Spare Deck", items = {spare_deck}}