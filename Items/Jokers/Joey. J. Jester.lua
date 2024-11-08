local joey_j_jester = {
    object_type = "Joker",
    key = 'joey_j_jester',
	config = {
        extra = { x_chips = 1.2 },
    },
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Joey. J. Jester',
            text = {
                "{X:chips,C:white}X#1#{} Chips",
            }
        }
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                message = "X"..number_format(card.ability.extra.x_chips),
                Xchip_mod = card.ability.extra.x_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
return {name = "Jokers", items = {joey_j_jester}}