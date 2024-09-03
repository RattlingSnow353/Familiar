local pickpocket = {
    object_type = "Voucher",
    key = 'pickpocket',
    loc_txt = {
        name = 'Pickpocket',
        text = {
            "{C:blue}+#2#{} hand",
            "{C:attention}+#1#{} hand size",
        }
    },
    cost = 10,
    atlas = 'Voucher',
    pos = { x = 5, y = 0 },
    config = { extra = {hand_size = 2, hands = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.hand_size, self.config.extra.hands} }
    end,
    redeem = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:change_size(card.ability.extra.hand_size)

                G.GAME.starting_params.hands = G.GAME.starting_params.hands + card.ability.extra.hands
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                return true
            end
        }))
        G.GAME.pool_flags.pickpocket_redeemed = true
    end
}
return {name = "Vouchers", items = {pickpocket}}