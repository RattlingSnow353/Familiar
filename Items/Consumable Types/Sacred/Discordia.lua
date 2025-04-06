local discordia = {
    object_type = "Consumable",
    key = 'discordia',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush Five", softlock = true} },
    atlas = 'Consumables',
    pos = { x = 3, y = 2 },
    cost = 5,
    order = 12,
    familiar = "c_eris",
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
return {name = "Sacred Cards", items = {discordia}}