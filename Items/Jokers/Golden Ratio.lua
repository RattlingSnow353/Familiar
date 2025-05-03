local golden_ratio = {
    object_type = "Joker",
    key = 'golden_ratio',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 1, y = 5 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    familiar = "j_fibonacci",
    order = 31,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local _card = context.other_card
            if _card:get_id() == 14 or _card:get_id() == 6 or _card:get_id() == 8 or _card:get_id() == 3 or _card:get_id() == 9 or SMODS.has_no_rank(_card) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = _card
                }
            end
        end
    end
}
return {name = "Jokers", items = {golden_ratio}}