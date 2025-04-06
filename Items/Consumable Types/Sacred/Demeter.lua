local demeter = {
    object_type = "Consumable",
    key = 'demeter',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush House", softlock = true} },
    atlas = 'Consumables',
    pos = { x = 8, y = 2 },
    cost = 5,
    order = 11,
    familiar = "c_ceres",
    loc_vars = function(self, info_queue, card)
        return { vars = {i_hands[card.ability.extra.hand].i_level, i_hands[card.ability.extra.hand].s_x_mult, i_hands[card.ability.extra.hand].s_x_chips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, 1)
    end,
}
return {name = "Sacred Cards", items = {demeter}}