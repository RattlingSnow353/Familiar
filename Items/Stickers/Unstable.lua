local unstable = {
    object_type = "Sticker",
    key = "unstable",
	config = { extra = { odds = 3 } },
	atlas = "Stickers",
	order = 2,
	pos = {x=1,y=0},
	badge_colour = HEX('8d67e7'),
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal or 1}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.repetition and context.game_over == false and not context.blueprint then
			if pseudorandom('unstable') < G.GAME.probabilities.normal / 3 then
				SMODS.debuff_card(card,true,"unstablesticker")
				return {
					message = 'Debuffed'
				}
			else
				SMODS.debuff_card(card,false,"unstablesticker")
			end
		end
	end
}
return {name = {"Stickers"}, items = {unstable}}