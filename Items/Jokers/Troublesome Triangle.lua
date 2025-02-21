local troublesome_triangle = {
    object_type = "Joker",
    key = 'troublesome_triangle',
    config = {
        extra = {mult = 1, money = 3},
    },
    atlas = 'Joker',
    pos = { x = 9, y = 11 },
    loc_txt = {
        ['en-us'] = {
            name = 'Troublesome Triangle',
            text = {
                "Whenever a {C:attention}3{} is played,",
                "{C:dark_edition,E:1}Chaos reigns supreme!{}",
            }
        }
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    familiar = "j_square",
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if to_big(G.GAME.dollars) > to_big(0) then
            if to_big(G.GAME.dollars) % to_big(5) and to_big(G.GAME.dollars) ~= to_big(0) then
                card.ability.extra.mult = to_big(G.GAME.dollars) / to_big(5)
            end
        end
        if context.cardarea == G.play and context.individual and not context.end_of_round and context.other_card:get_id() == 3 then
            if pseudorandom('troublesome_triangle') < (1 / 3) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_mult',
                        vars={card.ability.extra.mult}
                    },
                    mult_mod = card.ability.extra.mult
                }
            else
                if pseudorandom('troublesome_triangle') < (1 / 2) then
                    if #G.deck.cards == 0 then
                        return {
                            message = "You cant stop the bridge between our worlds from coming, but it would be fun to watch you try!",
                            colour = G.C.MONEY,
                        }
                    else
                        local tempnum1 = 0
                        for i = 1, #G.deck.cards do 
                            if G.deck.cards[i].base.rank == "3" then
                                tempnum1 = tempnum1 + 1
                            end
                        end
                        if tempnum1 == #G.deck.cards then
                            return {
                                message = "At the end of the day, its just chaos, chaos, chaos!",
                                colour = G.C.MONEY,
                            }
                        else
                            local tem = math.random(1, #G.deck.cards)
                            if G.deck.cards[tem]:get_id() == 3 then
                                while G.deck.cards[tem]:get_id() == 3 do
                                    tem = math.random(1, #G.deck.cards)
                                end
                            end
                            for i = 1, #G.deck.cards do 
                                if G.deck.cards[i] == G.deck.cards[tem] then
                                    return {
                                        card_eval_status_text(card, 'extra', nil, 0.5, nil, {
                                            message = "It's funny how dumb you are!",
                                            colour = G.C.MONEY,
                                        }),
                                        SMODS.change_base(G.deck.cards[i], nil, "3")
                                    }
                                end
                            end
                        end
                    end
                else
                    if #G.hand.cards == 0 then
                        return {
                                message = "You can run, but Ill still be in your nightmares!",
                                colour = G.C.MONEY,
                        }
                    else
                        local destroyed_cards = pseudorandom_element(G.hand.cards, pseudoseed('random_destroy'))
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.1,
                            func = function() 
                                local card = destroyed_cards
                                card:start_dissolve()
                                return true end }))
                        return {
                            dollars = card.ability.extra.money,
                            card_eval_status_text(card, 'extra', nil, 0.5, nil, {
                                message = "Pain is hilarious!",
                                colour = G.C.MONEY,
                            }),
                        }
                    end
                end
            end
        end
    end
}
return {name = "Jokers", items = {troublesome_triangle}}