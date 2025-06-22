local jewel = {
    object_type = "Enhancement",
    key = 'jewel',
    pos = {x = 5, y = 0}, 
    atlas = 'Enhancers', 
    order = 6,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = {Xchips = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.Xchips} }
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
	end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {jewel}}