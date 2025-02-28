local zeus = {
    object_type = "Consumable",
    key = 'zeus',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Flush", xmult = 1.2, xchips = 1.3} },
    atlas = 'Consumables',
    pos = { x = 4, y = 3 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Zeus",
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
return {name = "Sacred Cards", items = {zeus}}