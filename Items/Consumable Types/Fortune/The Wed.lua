local the_wed = {
    object_type = "Consumable",
    key = 'the_wed',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_split', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 6, y = 0 },
    cost = 3,
    order = 7,
    familiar = "c_lovers",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_split

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {the_wed}}