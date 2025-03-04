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
                "cards used in scoring {C:attention}once",
                "{C:inactive}(If you have a perfect hand){}",
            }
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = false,
    familiar = "j_hanging_chad",
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local temp = 0
            for _, card in ipairs(G.play.cards) do
                if (G.play.cards[1]:get_id() == card:get_id()) then
                    temp = temp + 1
                end
            end
            if temp == #G.play.cards then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
}
return {name = "Jokers", items = {perfect_ballot}}