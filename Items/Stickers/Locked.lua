local locked = {
    object_type = "Sticker",
    key = "locked",
	config = { extra = {  } },
	atlas = "Stickers",
	order = 4,
	pos = {x=3,y=0},
	badge_colour = HEX('c7c7c7'),
	loc_vars = function(self, info_queue, card)
		return { vars = {G.GAME.probabilities.normal or 1}}
	end,
	calculate = function(self, card, context)
		
	end
}
return {name = {"Stickers"}, items = {locked}}