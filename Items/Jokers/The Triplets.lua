local the_triplets = {
    object_type = "Joker",
    key = 'the_triplets',
    config = {
        poker_hand = "Three of a Kind", Xchips = 3,
    },
    atlas = 'Joker',
    pos = { x = 6, y = 4 },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    familiar = "j_trio",
    order = 132,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips, localize(card.ability.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and next(context.poker_hands[card.ability.poker_hand]) then
            return {func = function()
                local xchips = G.P_CENTERS.j_fam_the_triplets.config.Xchips
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
return {name = "Jokers", items = {the_triplets}}