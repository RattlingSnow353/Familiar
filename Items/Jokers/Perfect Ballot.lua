local perfect_ballot = {
    object_type = "Joker",
    key = 'perfect_ballot',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 9, y = 6 },
    loc_txt = {
        ['en-us'] = {
            name = 'Perfect Ballot',
            text = {
                "Retrigger {C:attention}all{} played",
                "cards used in scoring",
                "{C:attention}once",
            }
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}
return {name = "Jokers", items = {perfect_ballot}}