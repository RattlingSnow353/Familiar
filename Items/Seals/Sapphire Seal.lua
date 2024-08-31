local sapphire_seal = {
    object_type = "Seal",
    key = 'sapphire_seal',
    config = {
        extra = {},
    },
    atlas = 'Enhancers',
    pos = { x = 6, y = 4 },
    badge_colour = HEX("0d47a0"),
    loc_txt = {
        label = 'Sapphire Seal',
        name = 'Sapphire Seal',
        text = {
            'Creates a {C:blue}Spectral{} card',
            'if {C:attention}held in hand{} until',
            'the end of round',
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
}
return {name = "Sapphire Seal", items = {sapphire_seal}}