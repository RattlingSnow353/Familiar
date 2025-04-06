local jewel = {
    object_type = "Enhancement",
    key = 'jewel',
    pos = {x = 5, y = 0}, 
    atlas = 'Enhancers', 
    order = 6,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    config = { extra = {Xchips = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.extra.Xchips} }
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {func = function()
                local xchips = G.P_CENTERS.m_fam_jewel.config.extra.Xchips
                hand_chips = mod_chips(hand_chips * xchips)
                update_hand_text({delay = 0}, {chips = hand_chips})
                card_eval_status_text(card, 'extra', nil, percent, nil,
                {message = 'X'..xchips..' Chips',
                edition = true,
                x_chips = true})
            end}
        end
	end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {jewel}}