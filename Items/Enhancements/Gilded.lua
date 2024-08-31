local gilded = {
    object_type = "Enhancement",
    key = 'gilded',
    loc_txt = {
        name = 'Gilded',
        text = {
            "{C:money}$#1#{} when held in hand",
            "decreases by {C:money}$#2#{} each use",
            "becomes a {C:attention}steel card",
            "after {C:attention}#1#{} uses.",
        }
    },
    pos = {x = 6, y = 0}, 
    atlas = 'Enhancers', 
    config = { extra = {p_dollars = 5, dollar_mod = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.p_dollars, self.config.extra.dollar_mod} }
    end,
}
return {name = "Gilded", items = {gilded}}