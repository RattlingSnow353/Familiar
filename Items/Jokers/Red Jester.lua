local red_jester = {
    object_type = "Joker",
    key = 'red_jester',
    config = {
        extra = {mult = 1, deckcards = 26},
    },
    atlas = 'Joker',
    pos = { x = 7, y = 10 },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    familiar = "j_blue_joker",
    order = 53,
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
                card = self
            }
        end
    end
}
return {name = "Jokers", items = {red_jester}}