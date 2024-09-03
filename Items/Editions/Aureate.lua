local aureate_shader = {
    object_type = "Shader",
    key = 'aureate', 
    path = 'aureate.fs'
}
local aureate = {
    object_type = "Edition",
    key = 'aureate', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Aureate",
        label = "Aureate",
        text = {
            "{X:money,C:white}$#1#{}"
        }
    },
    config = { p_dollars = 3 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.p_dollars}}
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