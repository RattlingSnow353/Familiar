local sploosh = {
    object_type = "Joker",
    key = 'sploosh',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 6, y = 10 },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    familiar = "j_splash",
    order = 52,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for i = 1, #G.hand.cards do
                highlight_card(G.hand.cards[i])
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local id = context.other_card:get_chip_bonus()
            SMODS.calculate_effect({chip_mod = id, message = localize{type='variable',key='a_chips',vars={id}}}, context.other_card)
        end
        if context.joker_main then
            for i = 1, #G.hand.cards do
                highlight_card(G.hand.cards[i],(i-0.999)/(#G.hand.cards-0.998),'down')
            end
        end
    end
}
return {name = "Jokers", items = {sploosh}}
