local underworld_deck = {
    object_type = "Back",
    key = "underworld_deck",
    atlas = 'Enhancers',
    order = 13,
    pos = { x = 2, y = 4 },
    unlocked = false,
    config = {},
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind:get_type() == 'Small' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_dollars(-(G.GAME.dollars), true)

                    create_joker('Joker', nil, nil, {forced_key = 'j_mr_bones', edition = {negative=true}})

                    return true
                end
            }))
        end
    end
}
return {name = "Decks", items = {underworld_deck}}