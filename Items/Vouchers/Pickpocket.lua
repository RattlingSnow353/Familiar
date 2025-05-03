local pickpocket = {
    object_type = "Voucher",
    key = 'pickpocket',
    cost = 10,
    atlas = 'Voucher',
    order = 13,
    pos = { x = 5, y = 0 },
    config = { extra = {hand_size = 2, discards = -1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.hand_size, -self.config.extra.discards} }
    end,
    redeem = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand:change_size(card.ability.extra.hand_size)
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
                ease_discard(card.ability.extra.discards)
                return true
            end
        }))
        G.GAME.pool_flags.pickpocket_redeemed = true
    end
}
return {name = "Vouchers", items = {pickpocket}}