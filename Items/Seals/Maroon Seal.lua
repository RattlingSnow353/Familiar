local maroon_seal = {
    object_type = "Seal",
    key = 'maroon_seal',
    config = {
        extra = { },
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    badge_colour = HEX("8a0a0a"),
    order = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            if context.scoring_hand[1] == card then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            else 
                return {
                    card_eval_status_text(context.scoring_hand[1], 'extra', nil, nil, nil, {
                        message = 'Again!',
                        colour = G.C.MONEY,
                    }),
                    SMODS.score_card(context.scoring_hand[1], {cardarea = G.play, full_hand = context.full_hand, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands})
                }
            end
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {maroon_seal}}