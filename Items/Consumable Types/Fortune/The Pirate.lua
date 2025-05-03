local the_pirate = {
    object_type = "Consumable",
    key = 'the_pirate',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_jewel', max_highlighted = 1 },
    atlas = 'Consumables',
    pos = { x = 9, y = 0 },
    cost = 3,
    order = 10,
    familiar = "c_hermit",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_jewel

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {the_pirate}}