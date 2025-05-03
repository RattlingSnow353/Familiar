local ham_radio = {
    object_type = "Joker",
    key = 'jester_investor',
    config = {
        unc = 1.5, rar = 2, len = 4,
    },
    atlas = 'Joker',
    pos = { x = 6, y = 14 },
    rarity = 4,
    cost = 5,
    blueprint_compat = false,
    familiar = "j_baseball",
    order = 92,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.unc, card.ability.rar, card.ability.len } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and card ~= context.other_joker then              
            if context.other_joker.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED,
					card = context.other_joker,
				}
			else
                if context.other_joker.config.center.rarity == 2 then
				    return {
                        colour = G.C.RED,
					    x_mult = card.ability.unc,
					    card = context.other_joker
				    }
                elseif context.other_joker.config.center.rarity == 3 then
				    return {
                        colour = G.C.RED,
					    x_mult = card.ability.rar,
					    card = context.other_joker
				    }
                elseif context.other_joker.config.center.rarity == 4 then
				    return {
                        colour = G.C.RED,
					    x_mult = card.ability.len,
					    card = context.other_joker
				    }
                end
			end
        end
    end
}
return {name = "Jokers", items = {ham_radio}}