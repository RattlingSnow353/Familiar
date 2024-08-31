local forged_signature = {
    object_type = "Joker",
    key = 'forged_signature',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 8, y = 8 },
    loc_txt = {
        ['en-us'] = {
            name = 'Forged Signature',
            text = {
                "When round begins,",
                "add a random {C:attention}playing",
                "{C:attention}card{} with a random",
                "{C:attention}edition{} to your hand",
            }
        }
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_playing_card({front = pseudorandom_element(G.P_CARDS, pseudoseed('forged_card')), center = G.P_CENTERS.c_base}, G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced})
                    _card:set_edition(poll_edition('forged_signature', nil, false, true))
                    G.hand:sort()
                    return true
                end}))

            playing_card_joker_effects({true})
        end
    end
}
return {name = "Forged Signature", items = {forged_signature}}