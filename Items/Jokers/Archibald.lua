local archibald = {
    object_type = "Joker",
    key = 'archibald',
    config = {
        extra = { money = 50, current_money = 0},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 8 },
    rarity = 4,
    cost = 20,
    blueprint_compat = false,
    familiar = "j_perkeo",
    order = 150,
    soul_pos = {x = 7, y = 9},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_money, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            if #G.consumeables.cards % 2 == 0 and #G.consumeables.cards ~= 0 then
                return {
                    dollars = card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end,
    update = function(self, card, dt)
        if G.consumeables then
            if #G.consumeables.cards % 2 == 0 and #G.consumeables.cards ~= 0 then
                card.ability.extra.current_money = card.ability.extra.money * (#G.consumeables.cards/2)
            elseif #G.consumeables.cards < 2 then
                card.ability.extra.current_money = 0
            end
        end
    end
}
return {name = "Jokers", items = {archibald}}