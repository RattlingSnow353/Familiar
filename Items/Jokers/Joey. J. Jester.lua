local joey_j_jester = {
    object_type = "Joker",
    key = 'joey_j_jester',
	config = {
        Xchips = 1.2,
    },
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 4,
    order = 1,
    blueprint_compat = true,
    familiar = "j_joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                xchips = card.ability.Xchips
            }
        end
    end
}
return {name = "Jokers", items = {joey_j_jester}}