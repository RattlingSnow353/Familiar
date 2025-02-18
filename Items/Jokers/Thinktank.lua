local thinktank = {
    object_type = "Joker",
    key = 'thinktank',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 7 },
    loc_txt = {
        ['en-us'] = {
            name = 'Thinktank',
            text = {
                "Copies the ability",
                "of rightmost {C:attention}Joker{}",
            }
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    familiar = "j_brainstorm",
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        local other_joker = nil
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i] == card then
				other_joker = G.jokers.cards[#G.jokers.cards]
			end
		end
		if other_joker and other_joker ~= self then
			context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
			context.blueprint_card = context.blueprint_card or card

			if context.blueprint > #G.jokers.cards + 1 then
				return
			end

			local other_joker_ret, trig = other_joker:calculate_joker(context)
			if other_joker_ret or trig then
				if not other_joker_ret then
					other_joker_ret = {}
				end
				other_joker_ret.card = context.blueprint_card or card
				other_joker_ret.colour = G.C.BLUE
				other_joker_ret.no_callback = true
				return other_joker_ret
			end
		end
    end
}
return {name = "Jokers", items = {thinktank}}