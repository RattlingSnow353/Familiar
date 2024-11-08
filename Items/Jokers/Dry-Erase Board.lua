local dryerase_board = {
    object_type = "Joker",
    key = 'dry-erase_board',
    config = {
        extra = { x_chips = 3 },
    },
    atlas = 'Joker',
    pos = { x = 2, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Dry-Erase Board',
            text = {
                "{X:chips,C:white}X#1#{} Chips if",
                "all cards scored",
                "are {C:hearts}Hearts{} and {C:diamonds}Diamonds",
            }
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips } }
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
                    message = "X"..number_format(card.ability.extra.x_chips),
                    Xchip_mod = card.ability.extra.x_chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
}
return {name = "Jokers", items = {dryerase_board}}
