local maroon_seal = {
    object_type = "Seal",
    key = 'maroon_seal',
    config = {
        extra = { },
    },
    atlas = 'Enhancers',
    pos = { x = 5, y = 4 },
    badge_colour = HEX("8a0a0a"),
    loc_txt = {
        label = 'Maroon Seal',
        name = 'Maroon Seal',
        text = {
            'Retrigger leftmost',
            'card {C:attention}1{} time',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            SMODS.score_card(context.scoring_hand[1], {cardarea = G.play, full_hand = context.full_hand, scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands})
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {maroon_seal}}