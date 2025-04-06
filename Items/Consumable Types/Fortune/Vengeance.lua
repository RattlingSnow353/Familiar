local vengeance = {
    object_type = "Consumable",
    key = 'vengeance',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_stained_glass', max_highlighted = 1 },
    atlas = 'Consumables',
    pos = { x = 8, y = 0 },
    cost = 3,
    order = 9,
    familiar = "c_justice",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_stained_glass

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {vengeance}}