local hermes = {
    object_type = "Consumable",
    key = 'hermes',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Pair"} },
    atlas = 'Consumables',
    pos = { x = 0, y = 3 },
    cost = 5,
    order = 1,
    familiar = "c_mercury",
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
return {name = "Sacred Cards", items = {hermes}}