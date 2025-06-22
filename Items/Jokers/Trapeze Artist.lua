local trapeze_artist = {
    object_type = "Joker",
    key = 'trapeze_artist',
    config = {
        Xchips = 2 ,
    },
    atlas = 'Joker',
    pos = { x = 2, y = 1 },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    familiar = "j_acrobat",
    order = 108,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xchips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
    end
}
return {name = "Jokers", items = {trapeze_artist}}