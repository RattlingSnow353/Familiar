if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local sparesleeve = {
        object_type = "Sleeve",
        key = 'sparesleeve',
        name = "Spare Sleeve",
        atlas = 'cardsleeves',
        pos = {x = 2, y = 1},
        config = {
            hand_size = -1,
            discards = 3
        },
        loc_vars = function(self)
            return {
                vars = {}
            }
        end,
        trigger_effect = function(self,args) end,
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
        end,
        loc_txt = {
            name = "Spare Sleeve",
            text = {
                "Start run with",
                "Some {C:attention}missing{} cards, ",
                "Some {C:attention}addition{} cards",
                "{C:blue}+1{} hand, and some {C:money}Money",
            }
        }
    }
    return {name = "Card Sleeves", items = {sparesleeve}}
end