local sixers_scrapbook = {
    object_type = "Joker",
    key = 'sixers_scrapbook',
    config = {
        extra = { highlighted_limit = 1 },
    },
    atlas = 'Joker',
    pos = { x = 6, y = 6 },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    familiar = "j_four_fingers",
    order = 18,
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.highlighted_limit } }
	end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.highlighted_limit = math.floor(card.ability.extra.highlighted_limit)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.extra.highlighted_limit
        G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + card.ability.extra.highlighted_limit
        G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit + card.ability.extra.highlighted_limit
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - card.ability.extra.highlighted_limit
        G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit - card.ability.extra.highlighted_limit
        G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit - card.ability.extra.highlighted_limit
		if G.hand.config.highlighted_limit < 5 then G.hand.config.highlighted_limit = 5 end
		G.hand:unhighlight_all()
	end,
}
return {name = "Jokers", items = {sixers_scrapbook}}