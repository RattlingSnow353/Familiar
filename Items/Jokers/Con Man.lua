local con_man = {
    object_type = "Joker",
    key = 'con_man',
    config = {
        money = 10,
        money_mod = 2,
    },
    atlas = 'Joker',
    pos = { x = 6, y = 5 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_ring_master",
    order = 121,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.money } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop and not context.blueprint then
            if G.GAME.dollars >= to_big(0) then
                local random = math.random(1,2)
                if #G.consumeables.cards == 0 and #G.jokers.cards == 1 then
                    return
                elseif #G.consumeables.cards == 0 and random == 1 then
                    random = 2
                elseif #G.jokers.cards == 1 and random == 2 then
                    random = 1
                end
                if #G.consumeables.cards > 0 and #G.consumeables.cards < G.consumeables.config.card_limit and random == 1 then
                    local eligibleConsumeables = {}
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i].ability.name ~= card.ability.name then
                            eligibleConsumeables[#eligibleConsumeables+1] = G.consumeables.cards[i] 
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = copy_card(pseudorandom_element(eligibleConsumeables, pseudoseed('fam_con_man')), nil)
                            card:add_to_deck()
                            G.consumeables:emplace(card) 
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    local temp_money_mod = card.ability.money_mod
                    card.ability.money = card.ability.money + card.ability.money_mod
                    card.ability.money_mod = card.ability.money_mod + 2
                    return {
                        dollars = -(card.ability.money-temp_money_mod),
                    }
                end
                if #G.jokers.cards > 1 and #G.jokers.cards < G.jokers.config.card_limit and random == 2 then
                    local eligibleJokers = {}
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.name ~= card.ability.name then
                            eligibleJokers[#eligibleJokers+1] = G.jokers.cards[i] 
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local card = copy_card(pseudorandom_element(eligibleJokers, pseudoseed('fam_con_man')), nil)
                            card:add_to_deck()
                            G.jokers:emplace(card) 
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    local temp_money_mod = card.ability.money_mod
                    card.ability.money = card.ability.money + card.ability.money_mod
                    card.ability.money_mod = card.ability.money_mod + 2
                    return {
                        dollars = -(card.ability.money-temp_money_mod),
                    }
                end
            end
        end
    end
}
return {name = "Jokers", items = {con_man}}