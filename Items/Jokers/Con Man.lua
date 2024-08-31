local con_man = {
    object_type = "Joker",
    key = 'con_man',
    config = {
        extra = { money = 10 },
    },
    atlas = 'Joker',
    pos = { x = 6, y = 5 },
    loc_txt = {
        ['en-us'] = {
            name = 'Con Man',
            text = {
                "Spend {C:money}$#1#{} dollars to create",
                "a random duplicate of a {C:attention}Joker",
                "or a {C:tarot}Consumable{} you currently have.",
                "{C:inactive}(Must have room){}"

            }
        }
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            if G.GAME.dollars >= card.ability.extra.money then
                local random = math.random(1,2)
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
                        end}))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    ease_dollars(-card.ability.extra.money)
                    card.ability.extra.money = card.ability.extra.money + 2
                end
                if #G.jokers.cards > 0 and #G.jokers.cards < G.jokers.config.card_limit and random == 2 then
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
                        end}))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    ease_dollars(-card.ability.extra.money)
                    card.ability.extra.money = card.ability.extra.money + 2
                end
            end
        end
    end
}
return {name = "Con Man", items = {con_man}}