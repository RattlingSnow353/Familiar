local gilded = {
    object_type = "Enhancement",
    key = 'gilded',
    loc_txt = {
        name = 'Gilded',
        text = {
            "{C:money}$#1#{} when held in hand",
            "decreases by {C:money}$#2#{} each use",
            "becomes a {C:attention}steel card",
            "after {C:attention}#3#{} uses.",
        }
    },
    pos = {x = 6, y = 0}, 
    atlas = 'Enhancers', 
    config = { extra = {p_dollars = 5, dollar_mod = 1, left = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.p_dollars, self.config.extra.dollar_mod, self.config.extra.left } }
    end,
    calculate = function(self, card, context)
        if not context.repetition_only and context.end_of_round == true then
            if self.config.extra.p_dollars <= 0 then
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = 'Delamination!', colour = G.C.UI.TEXT_INACTIVE})
                card:set_ability(G.P_CENTERS.m_steel, nil, true)
                card:juice_up()
                return
            else
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('$')..self.config.extra.p_dollars, colour = G.C.MONEY})
                ease_dollars(self.config.extra.p_dollars)
                self.config.extra.p_dollars = self.config.extra.p_dollars - self.config.extra.dollar_mod
                self.config.extra.left = self.config.extra.left - 1
                card:juice_up()
                return
            end
        end
    end
}
return {name = {"Fortune Cards", "Enhancements"}, items = {gilded}}