local crash_landing = {
    object_type = "Joker",
    key = 'crash_landing',
    config = {
        extra = { },
    },
    atlas = 'Joker',
    pos = { x = 8, y = 12 },
    rarity = 3,
    cost = 7,
    familiar = "j_rocket",
    order = 74,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.selling_card then
            if context.card.ability.set == "Planet" and G.GAME.hands[context.card.ability.hand_type].level ~= nil then
                local money = G.GAME.hands[context.card.ability.hand_type].level
                return {
                    dollars = money,
                    colour = G.C.MONEY,
                }
            end
        end
    end,
}
return {name = "Jokers", items = {crash_landing}}