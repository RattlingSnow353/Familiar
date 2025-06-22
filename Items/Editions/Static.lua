local statics_shader = {
    object_type = "Shader",
    key = 'statics', 
    path = 'statics.fs'
}
local statics = {
    object_type = "Edition",
    key = 'statics', 
    atlas = 'Joker',
    order = 2,
    pos = { x = 0, y = 0 },
    config = { Xchips = 1.5 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.Xchips}}
    end,

    in_shop = true,
    weight = 7,
    extra_cost = 5,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
    end,

    shader = 'statics'
}
return {name = "Editions", items = {statics, statics_shader}}