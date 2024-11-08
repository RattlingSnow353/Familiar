local sleight_of_hand = {
    object_type = "Voucher",
    key = 'sleight_of_hand',
    loc_txt = {
        name = 'Sleight of Hand',
        text = {
            "{C:attention}+#1#{} hand",
            "{C:mult}-#2#{} discard",
        }
    },
    cost = 15,
    atlas = 'Voucher',
    pos = { x = 5, y = 1 },
    config = { extra = {hands = 1, discards = -1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.hands, -self.config.extra.discards} }
    end,
    requires={'v_fam_pickpocket'},
    redeem = function(self, card, context)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                G.GAME.starting_params.hands = G.GAME.starting_params.hands + card.ability.extra.hands
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
                ease_discard(card.ability.extra.discards)
                return true
            end
        }))
        G.GAME.pool_flags.sleight_of_hand_redeemed = true
    end
}
return {name = "Vouchers", items = {sleight_of_hand}}