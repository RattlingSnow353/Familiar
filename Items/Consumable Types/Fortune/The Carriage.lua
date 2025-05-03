local the_carriage = {
    object_type = "Consumable",
    key = 'the_carriage',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_stainless', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 7, y = 0 },
    cost = 3,
    order = 8,
    familiar = "c_chariot",
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_stainless

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {the_carriage}}