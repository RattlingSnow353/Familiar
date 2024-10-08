local familiar_seal = {
    object_type = "Seal",
    key = 'familiar_seal',
    config = {
        extra = {},
    },
    atlas = 'Enhancers',
    pos = { x = 4, y = 4 },
    badge_colour = HEX("3c423e"),
    loc_txt = {
        label = 'Familiar Seal',
        name = 'Familiar Seal',
        text = {
            'Creates a {C:attention}Familiar tarot{} when',
            'only this card is {C:attention}discarded',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.discard and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if #context.full_hand == 1 then
                create_consumable("Familiar_Tarots")
            end
        end
    end
}
return {name = {"Seals", "Memento Cards"}, items = {familiar_seal}}