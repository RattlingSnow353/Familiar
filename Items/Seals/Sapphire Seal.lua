local sapphire_seal = {
    object_type = "Seal",
    key = 'sapphire_seal',
    config = {
        extra = {},
    },
    atlas = 'Enhancers',
    pos = { x = 6, y = 4 },
    badge_colour = HEX("0d47a0"),
    order = 2,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                local card = create_card("Spectral", nil, nil, nil),
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up()
            end
        end
    end,
}
return {name = {"Seals", "Memento Cards"}, items = {sapphire_seal}}