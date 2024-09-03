local speckle_shader = {
    object_type = "Shader",
    key = 'speckle', 
    path = 'speckled.fs'
}
local speckle = {
    object_type = "Edition",
    key = 'speckle', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Speckled",
        label = "Speckled",
        text = {
            "{C:blue}+rand(){} Chips",
            "{C:red}+rand(){} Mult"
        }
    },
    config = { ranmult = 0, ranchips = 0, mmin = 1, mmax = 5, cmin = 1, cmax = 25, rantextnum =  fam_numbers[math.random(1, 15)], rantextnum2 =  fam_numbers[math.random(1, 15)] },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.ranmult, self.config.ranchips, self.config.rantextnum, self.config.rantextnum2}}
    end,

    in_shop = true,
    weight = 12,
    extra_cost = 2,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,

    shader = 'speckle'
}
return {name = "Editions", items = {speckle, speckle_shader}}