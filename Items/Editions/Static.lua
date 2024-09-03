local statics_shader = {
    object_type = "Shader",
    key = 'statics', 
    path = 'statics.fs'
}
local statics = {
    object_type = "Edition",
    key = 'statics', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Static",
        label = "Static",
        text = {
            "{X:chips,C:white} X#1# {} Chips"
        }
    },
    config = { fam_x_chips = 1.5 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.fam_x_chips}}
    end,

    in_shop = true,
    weight = 7,
    extra_cost = 5,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    shader = 'statics'
}
return {name = "Editions", items = {statics, statics_shader}}