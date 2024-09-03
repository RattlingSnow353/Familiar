local purple_card = {
    object_type = "Joker",
    key = 'purple_card',
    config = {
        extra = { chips = 0, chip_mod = 20},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 11 },
    loc_txt = {
        ['en-us'] = {
            name = 'Purple Card',
            text = {
                "This Joker gains",
                "{C:blue}+#2#{} Chips when any",
                "{C:attention}Booster Pack{} is skipped",
                "{C:inactive}(Currently {C:blue}+#1#{} {C:inactive}Chips)",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            G.E_MANAGER:add_event(Event({
                func = function() 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.chip_mod}},
                        colour = G.C.CHIPS,
                        delay = 0.45, 
                        card = self
                    }) 
                    return true
                end}))
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips
            }
        end
    end
}
return {name = "Jokers", items = {purple_card}}