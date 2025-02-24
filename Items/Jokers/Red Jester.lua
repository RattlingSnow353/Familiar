local red_jester = {
    object_type = "Joker",
    key = 'red_jester',
    config = {
        extra = {mult = 1, deckcards = 26},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 10 },
    loc_txt = {
        ['en-us'] = {
            name = 'Red Jester',
            text = {
                "{C:mult}+#1#{} Mult for every two",
                "remaining cards in {C:attention}deck",
                "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult)",
            }
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    familiar = "j_blue_joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.deckcards } }
    end,
    calculate = function(self, card, context)
        card.ability.extra.deckcards = card.ability.extra.mult*(#G.deck.cards/2)
        if #G.deck.cards > 0 and context.joker_main then
            return {
                message = localize{type='variable', key='a_mult', vars={card.ability.extra.mult * (#G.deck.cards/2)}},
                mult_mod = card.ability.extra.mult * (#G.deck.cards/2), 
                colour = G.C.MULT,
            }
        end
    end
}
return {name = "Jokers", items = {red_jester}}