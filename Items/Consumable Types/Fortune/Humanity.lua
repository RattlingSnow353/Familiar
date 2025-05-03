local humanity = {
    object_type = "Consumable",
    key = 'humanity',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_gilded', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 5, y = 1 },
    cost = 3,
    order = 16,
    familiar = "c_devil",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_gilded

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {humanity}}