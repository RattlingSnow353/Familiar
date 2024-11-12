local shade = {
    object_type = "Consumable",
    key = 'shade',
    set = 'Familiar_Spectrals',
    config = { extra = { odds = 4 } },
    atlas = 'Consumables',
    pos = { x = 5, y = 4 },
    in_shop = true,
    loc_txt = {
        ['en-us'] = {
            name = "Shade",
            text = {
                "{C:green,E:1,S:1.1}#3# in #2#{} chance to",
                "create a {C:mult}rare{} joker",
                "{C:green,E:1,S:1.1}#3# in #1#{} chance to",
                "set money to {C:attention}-$10{}",
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, card.ability.extra.odds/2, G.GAME.probabilities.normal } }
    end,
    can_use = function(self, card, area, copier)
        if #G.jokers.cards < G.jokers.config.card_limit then 
            return true 
        end
    end,
    use = function(self, card)
        if pseudorandom('shade1') < G.GAME.probabilities.normal/(card.ability.extra.odds/2) then
            create_joker('Joker', nil, nil, nil, 0.99)
        end
        if pseudorandom('shade2') < G.GAME.probabilities.normal/card.ability.extra.odds then
            if G.GAME.dollars ~= 0 then
                ease_dollars(-(G.GAME.dollars + 10), true)
            end
        end
    end,
}
return {name = "Memento Cards", items = {shade}}