local hecate = {
    object_type = "Consumable",
    key = 'hecate',
    set = 'Familiar_Planets',
    config = { extra = {hand = "Five of a Kind", xmult = 1.25, xchips = 1.75, softlock = true} },
    atlas = 'Consumables',
    pos = { x = 9, y = 2 },
    cost = 5,
    loc_txt = {
        ['en-us'] = {
            name = "Hecate",
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
        mult_level_up_hand(card, card.ability.extra.hand, false, card.ability.extra.xmult, card.ability.extra.xchips)
    end,
}
return {name = "Sacred Cards", items = {hecate}}