local discordia = {
    object_type = "Consumable",
    key = 'discordia',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush Five", softlock = true} },
    atlas = 'Consumables',
    pos = { x = 3, y = 2 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Discordia",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
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