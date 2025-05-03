local bear_market = {
    object_type = "Joker",
    key = 'bear_market',
    config = {
        extra = { interest = 2, cash = 5, interest_amount = 0, odds = 2 },
    },
    atlas = 'Joker',
    pos = { x = 18, y = 16 },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cash, (card.ability.extra.interest - 1), card.ability.extra.odds, (G.GAME.probabilities.normal or 1) } }
    end,
    yes_pool_flag = 'bear_market_flag',
    no_collection = true,
    calculate = function(self, card, context)
        if context.ending_shop and not card.ability.eternal then
            if pseudorandom('bull_chance') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local bull_card = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_fam_bull_market", 'bull_card')
                        bull_card:add_to_deck()
                        G.jokers:emplace(bull_card)
                        bull_card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                    end}))   
                card:start_dissolve()
                return
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.interest_amount = G.GAME.interest_amount - card.ability.extra.interest
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.interest_amount = G.GAME.interest_amount + card.ability.extra.interest
    end
}
return {name = "Jokers", items = {bear_market}}