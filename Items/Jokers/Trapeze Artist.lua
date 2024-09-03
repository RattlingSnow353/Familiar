local trapeze_artist = {
    object_type = "Joker",
    key = 'trapeze_artist',
    config = {
        extra = { fam_x_chips = 3 },
    },
    atlas = 'Joker',
    pos = { x = 2, y = 1 },
    loc_txt = {
        ['en-us'] = {
            name = 'Trapeze Artist',
            text = {
                "{X:chips,C:white}X#1#{} Chips on {C:attention}first",
                "{C:attention}hand{} of round",
            }
        }
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.fam_x_chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                message = "X"..number_format(card.ability.extra.fam_x_chips),
                fam_Xchip_mod = card.ability.extra.fam_x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
return {name = "Jokers", items = {trapeze_artist}}