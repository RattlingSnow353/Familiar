local cronus = {
    object_type = "Consumable",
    key = 'cronus',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Straight", xmult = 1.25, xchips = 1.75} },
    atlas = 'Consumables',
    pos = { x = 5, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Cronus",
            text = {
                "(lvl:#1#+i) Imaginary Level Up",
                "{C:attention}#4#",
                "{C:red}X#2#{} Mult and",
                "{C:blue}X#3#{} chips",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.hands[card.ability.extra.hand].level, card.ability.extra.xmult, card.ability.extra.xchips, card.ability.extra.hand } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips, 1)
    end,
}
return {name = "Sacred Cards", items = {cronus}}