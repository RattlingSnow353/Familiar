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
        if context.repetition then
            if context.cardarea == G.play then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.scoring_hand[1]
                }
            end
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {maroon_seal}}