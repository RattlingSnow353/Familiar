local rna = {
    object_type = "Joker",
    key = 'rna',
    config = {
        extra = { odds = 2 },
    },
    atlas = 'Joker',
    pos = { x = 5, y = 10 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    familiar = "j_dna",
    order = 51,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if G.GAME.current_round.discards_used <= 0 then
            local eval = function()
                return G.GAME.current_round.discards_used <= 0
            end
            juice_card_until(card, eval, true)
        end
        if G.GAME.current_round.discards_used <= 0 and context.discard then
            if pseudorandom('perfect_ballot') < G.GAME.probabilities.normal/card.ability.extra.odds then
                if #context.full_hand == 1 then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                    _card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_copied_ex'),
                        colour = G.C.RED,
                        card = self,
                        playing_cards_created = {true}
                    }
                end
            end
        end
    end
}
return {name = "Jokers", items = {rna}}