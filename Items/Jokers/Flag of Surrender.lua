local flag_of_surrender = {
    object_type = "Joker",
    key = 'flag_of_surrender',
    config = {
        extra = {mult = 10, mult_mod = 10},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 2 },
    loc_txt = {
        ['en-us'] = {
            name = 'Flag of Surrender',
            text = {
                "{C:mult}+#1#{} Mult",
                "for each played",
                "{C:attention}hand{} this round",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.mult = (G.GAME.current_round.hands_played + 1) * card.ability.extra.mult_mod
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult, 
                colour = G.C.MULT,
                card = self
            }
        end
    end
}
return {name = "Flag of Surrender", items = {flag_of_surrender}}