local familiar_seal = {
    object_type = "Seal",
    key = 'familiar_seal',
    config = {
        extra = {},
    },
    atlas = 'Enhancers',
    pos = { x = 4, y = 4 },
    badge_colour = HEX("3c423e"),
    order = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if context.full_hand then
                if #context.full_hand == 1 then
                    local card = create_card("Familiar_Tarots", nil, nil, nil),
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    card:juice_up()
                end
            end
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {familiar_seal}}