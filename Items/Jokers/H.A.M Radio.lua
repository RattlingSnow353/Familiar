local ham_radio = {
    object_type = "Joker",
    key = 'ham_radio',
    config = {
        h_x_mult = 1.25,
    },
    atlas = 'Joker',
    pos = { x = 8, y = 15 },
    loc_txt = {
        ['en-us'] = {
            name = 'H.A.M Radio',
            text = {
                "Each {C:attention}10{} or {C:attention}4{} held",
                "in hand gives",
                "{C:mult}X#1#{} Mult",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    familiar = "j_walkie_talkie",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_mult } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.individual and not context.end_of_round and (context.other_card:get_id() == 10 or context.other_card:get_id() == 4) then
			if context.other_card.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
                    colour = G.C.RED,
					x_mult = card.ability.h_x_mult,
					card = card
				}
			end
        end
    end
}
return {name = "Jokers", items = {ham_radio}}