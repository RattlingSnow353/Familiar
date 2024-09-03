local the_martyr = {
    object_type = "Consumable",
    key = 'the_martyr',
    set = 'Familiar_Tarots',
    config = { extra = 2 },
    atlas = 'Consumables',
    pos = { x = 2, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Martyr",
            text = {
                "Creates {C:attention}2{} random cards",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier, context)
        if (G.hand and not G.shop) or (G.hand) then
            return true 
        end
    end,
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function() 
                local cards = {}
                for i=1, self.config.extra do
                    cards[i] = true
                    local _suit, _rank = nil, nil
                    _rank = pseudorandom_element({'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'}, pseudoseed('incantation_create'))
                    _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('incantation_create'))
                    _suit = _suit or 'S'; _rank = _rank or 'A'
                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank]}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                end
                playing_card_joker_effects(cards)
        return true end }))
    end,
}
return {name = "Fortune Cards", items = {the_martyr}}