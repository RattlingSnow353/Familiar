local joey_j_jester = {
    object_type = "Joker",
    key = 'joey_j_jester',
	config = {
        Xchips = 1.2,
    },
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    order = 1,
    blueprint_compat = true,
    familiar = "j_joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {func = function()
                local xchips = G.P_CENTERS.j_fam_joey_j_jester.config.Xchips
                hand_chips = mod_chips(hand_chips * xchips)
                update_hand_text({delay = 0}, {chips = hand_chips})
                card_eval_status_text(card, 'extra', nil, percent, nil,
                {message = 'X'..number_format(xchips),
                edition = true,
                x_chips = true})
            end}
        end
    end
}
return {name = "Jokers", items = {joey_j_jester}}