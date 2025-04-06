local asterism = {
    object_type = "Joker",
    key = 'asterism',
    config = {
        extra = {x_chips = 1, x_chips_mod = 0.3},
    },
    atlas = 'Joker',
    pos = { x = 9, y = 10 },
    rarity = 1,
    cost = 7,
    blueprint_compat = true,
    familiar = "j_constellation",
    order = 55,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips_mod, card.ability.extra.x_chips  } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Familiar_Planets' then
            card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_mod
            G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(card, 'extra', nil, percent, nil,
                {message = '+X'..number_format(card.ability.extra.x_chips_mod),
                x_chips = true}, colour = G.C.CHIPS)) return true
                end}))
            return
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {func = function()
                local xchips = card.ability.extra.x_chips
                hand_chips = mod_chips(hand_chips * xchips)
                update_hand_text({delay = 0}, {chips = hand_chips})
                card_eval_status_text(card, 'extra', nil, percent, nil,
                {message = 'X'..number_format(xchips),
                x_chips = true}, colour = G.C.CHIPS)
            end}
        end
    end
}
return {name = "Jokers", items = {asterism}}