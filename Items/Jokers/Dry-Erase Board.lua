local dryerase_board = {
    object_type = "Joker",
    key = 'dry_erase_board',
    config = {
        Xchips = 3,
    },
    atlas = 'Joker',
    pos = { x = 2, y = 10 },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    familiar = "j_blackboard",
    order = 48,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips } }
    end,
    calculate = function(self, card, context)
        if context.scoring_hand then
            local red_suits, all_cards = 0, 0
            for _, v in pairs(context.scoring_hand) do
                all_cards = all_cards + 1
                if v:is_suit('Hearts', nil, true) or v:is_suit('Diamonds', nil, true) then
                    red_suits = red_suits + 1
                end
            end
            if context.joker_main and red_suits == all_cards then
                return {
                    xchips = card.ability.Xchips
                }
            end
        end
    end
}
return {name = "Jokers", items = {dryerase_board}}
