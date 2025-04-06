local aureate_shader = {
    object_type = "Shader",
    key = 'aureate', 
    path = 'aureate.fs'
}
local aureate = {
    object_type = "Edition",
    key = 'aureate', 
    atlas = 'Joker',
    order = 5,
    pos = { x = 0, y = 0 },
    config = { dollars = 3 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.dollars}}
    end,
    calculate = function(self, card, context)
		if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
			return {
                dollars = G.P_CENTERS.e_fam_aureate.config.dollars,
            }
		end
	end,
    in_shop = true,
    weight = 15,
    extra_cost = 2,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    shader = 'aureate'
}
return {name = "Editions", items = {aureate, aureate_shader}}