local the_bishop = {
    object_type = "Consumable",
    key = 'the_bishop',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_penalty', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 5, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Bishop",
            text = {
                "Enhances {C:attention}2{} selected card",
                "into a {C:attention}Penalty Card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_penalty

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = "The Bishop", items = {the_bishop}}