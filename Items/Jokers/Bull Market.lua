local bull_market = {
    object_type = "Joker",
    key = 'bull_market',
    config = {
        extra = { interest = 1, cash = 5, odds = 2 },
    },
    atlas = 'Joker',
    pos = { x = 18, y = 13 },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_to_the_moon",
    order = 84,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cash, card.ability.extra.interest, card.ability.extra.odds, (G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop and not card.ability.eternal then
            if pseudorandom('bull_chance') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local bear_card = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_fam_bear_market", 'bear_card')
                        bear_card:add_to_deck()
                        G.jokers:emplace(bear_card)
                        bear_card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                    end}))   
                card:start_dissolve()
                return
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.interest_amount = G.GAME.interest_amount + card.ability.extra.interest
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.interest_amount = G.GAME.interest_amount - card.ability.extra.interest
    end
}
return {name = "Jokers", items = {bull_market}}