local the_illusionist = {
    object_type = "Consumable",
    key = 'the_illusionist',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_charmed', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 1, y = 0 },
    cost = 3,
    order = 2,
    familiar = "c_magician",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_charmed

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {the_illusionist}}