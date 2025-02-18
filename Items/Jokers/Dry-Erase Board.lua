local dryerase_board = {
    object_type = "Joker",
    key = 'dry_erase_board',
    config = {
        Xchips = 3,
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
    familiar = "j_blackboard",
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
                return {func = function()
                local xchips = G.P_CENTERS.j_fam_dry_erase_board.config.Xchips
                hand_chips = mod_chips(hand_chips * xchips)
                update_hand_text({delay = 0}, {chips = hand_chips})
                card_eval_status_text(card, 'extra', nil, percent, nil,
                {message = 'X'..number_format(xchips),
                edition = true,
                x_chips = true})
            end}
            end
        end
    end
}
return {name = "Jokers", items = {dryerase_board}}
