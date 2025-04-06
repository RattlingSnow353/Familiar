local the_bishop = {
    object_type = "Consumable",
    key = 'the_bishop',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_penalty', max_highlighted = 2 },
    atlas = 'Consumables',
    order = 6,
    pos = { x = 5, y = 0 },
    cost = 3,
    familiar = "c_hierophant",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_penalty

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {the_bishop}}