local debit_card = {
    object_type = "Joker",
    key = 'debit_card',
    config = {
        extra = { cash = 0, last_cash = 0, interest = 15, remove = false },
    },
    atlas = 'Joker',
    pos = { x = 5, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = 'Debit Card',
            text = {
                "Store half of cash-out money",
                "earn {C:money}$1{} more interest",
                "for every {C:money}$#2#{}",
                "{C:inactive}(Current balance: {C:money}$#1#{}){}"
            }
        }
    },
    rarity = 2,
    cost = 1,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cash, card.ability.extra.interest } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            G.GAME.interest_amount = G.GAME.interest_amount - math.floor(card.ability.extra.last_cash/card.ability.extra.interest)
            card.ability.extra_value = math.ceil(card.ability.extra.cash/3)*2
            card:set_cost()
            card.ability.extra.remove = false
        end
        if context.end_of_round and context.cardarea == G.jokers then
            G.GAME.interest_amount = G.GAME.interest_amount + math.floor(card.ability.extra.cash/card.ability.extra.interest)
            card.ability.extra_value = math.ceil(card.ability.extra.cash/3)*2
            card:set_cost()
            card.ability.extra.remove = true
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.remove then
            G.GAME.interest_amount = G.GAME.interest_amount - math.floor(card.ability.extra.last_cash/card.ability.extra.interest)
        end
    end
}
return {name = "Jokers", items = {debit_card}}