local sample = {
    object_type = "Sticker",
    key = "sample",
	config = { },
	atlas = "Stickers",
	order = 3,
	pos = {x=2,y=0},
	badge_colour = HEX('e37e48'),
	loc_vars = function(self, info_queue, card)
		return { vars = {}}
	end,
}
return {name = {"Stickers"}, items = {sample}}