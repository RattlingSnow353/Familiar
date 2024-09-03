local duality_deck = {
    object_type = "Back",
    key = "duality_deck",
    loc_txt = {
        ['en-us'] = {
            name = "Duality Deck",
            text = {
                "Start with 26",
                "{C:attention}dual-suit{} cards",
            }
        }
    },
    atlas = 'Enhancers',
    pos = { x = 1, y = 3 },
    config = {fam_force_dual = true},
    apply = function(self, card, context)
        G.E_MANAGER:add_event(Event({ 
            func = function()
                local dual1 = math.random(1,4)
                local dual2 = math.random(1,4)
                local notsuit = nil
                local setsuit1 = true
                local setsuit2 = true
                for i = #G.playing_cards, 1, -1 do 
                    if i <= 13 then
                        if dual1 == 1 then
                            G.playing_cards[i].ability.is_diamond = true
                            notsuit = "Diamonds"
                        elseif dual1 == 2 then
                            G.playing_cards[i].ability.is_club = true
                            notsuit = "Clubs"
                        elseif dual1 == 3 then
                            G.playing_cards[i].ability.is_spade = true
                            notsuit = "Spades"
                        elseif dual1 == 4 then
                            G.playing_cards[i].ability.is_heart = true
                            notsuit = "Hearts"
                        end
                        if setsuit1 == true then
                            suit = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                            if suit == notsuit then
                                while suit == notsuit do
                                    suit = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                                end
                            end
                            setsuit1 = false
                        end
                        G.playing_cards[i]:change_suit(suit)
                    elseif i >= 14 and i <= 26 then
                        if dual2 == 1 then
                            G.playing_cards[i].ability.is_diamond = true
                            notsuit = "Diamonds"
                        elseif dual2 == 2 then
                            G.playing_cards[i].ability.is_club = true
                            notsuit = "Clubs"
                        elseif dual2 == 3 then
                            G.playing_cards[i].ability.is_spade = true
                            notsuit = "Spades"
                        elseif dual2 == 4 then
                            G.playing_cards[i].ability.is_heart = true
                            notsuit = "Hearts"
                        end
                        if setsuit2 == true then
                            suit2 = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                            if suit2 == notsuit or suit2 == notsuit then
                                while suit2 == notsuit or suit2 == notsuit do
                                    suit2 = pseudorandom_element({'Spades','Hearts','Diamonds','Clubs'}, pseudoseed('dual_deck'))
                                end
                            end
                            setsuit2 = false
                        end
                        G.playing_cards[i]:change_suit(suit2)
                    else
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end
                return true
            end
        }))
    end
}
return {name = "Decks", items = {duality_deck}}