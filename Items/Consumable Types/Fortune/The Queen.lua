local the_queen = {
    object_type = "Consumable",
    key = 'the_queen',
    set = 'Familiar_Tarots',
    config = { mod_conv = 'm_fam_div', max_highlighted = 2 },
    atlas = 'Consumables',
    pos = { x = 3, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Queen",
            text = {
                "Enhances {C:attention}2{} selected card",
                "into a {C:attention}Div Card{}.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.m_fam_div

        return {vars = {self.config.max_highlighted}}
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {the_queen}}