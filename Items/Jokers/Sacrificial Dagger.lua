local sacrificial_dagger = {
    object_type = "Joker",
    key = 'sacrificial_dagger',
    config = {
        extra = {stockpile = 0, stock_mod = 15, base_joker_config = 0, base_joker_starting_params = 0, joker_stock = 1},
    },
    atlas = 'Joker',
    pos = { x = 5, y = 5 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_ceremonial",
    order = 21,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.stockpile, card.ability.extra.stock_mod, card.ability.extra.joker_stock, card.ability.extra.base_joker_starting_params  } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i; break end
            end
            if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
                local sliced_card = G.jokers.cards[my_pos+1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.joker_buffer = 0
                    card.ability.extra.stockpile = card.ability.extra.stockpile + sliced_card.sell_cost
                    card:juice_up(0.8, 0.8)
                    sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                    play_sound('slice1', 0.96+math.random()*0.08)
                    local joker_amt = math.floor(card.ability.extra.stockpile/15)
                    G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - card.ability.extra.base_joker_starting_params
                    G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.base_joker_config
                    G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + joker_amt
                    G.jokers.config.card_limit = G.jokers.config.card_limit + joker_amt
                    card.ability.extra.base_joker_starting_params = joker_amt
                    card.ability.extra.base_joker_config = joker_amt
                return true end }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_stock', vars = {sliced_card.sell_cost}}, colour = G.C.FILTER, no_juice = true})
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots - card.ability.extra.base_joker_starting_params
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.base_joker_config
	end,
}
return {name = "Jokers", items = {sacrificial_dagger}}