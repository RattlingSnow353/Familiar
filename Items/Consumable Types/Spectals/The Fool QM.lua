local the_fool_qm = {
    object_type = "Consumable",
    key = 'the_fool_qm',
    set = 'Spectral',
    config = {  },
    atlas = 'Consumables',
    pos = { x = 6, y = 5 },
    loc_txt = {
        ['en-us'] = {
            name = "The Fool?",
            text = {
                "Creates a {C:attention}Jester{} counterpart ",
                "of a selected Joker in hand.",
            }
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.s_fam_sapphire_seal
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.jokers.highlighted and (#G.jokers.highlighted == 1) and G.jokers.highlighted[1] then
            local self_card = G.jokers.highlighted[1]
            for key, _ in pairs(jester_table) do
                if key == self_card.config.center_key then
                    local new_joke = jester_table[key]
                    if #new_joke == 0 then
                        return false
                    end
                    return true 
                end
            end 
        end
    end,
    use = function(self, card)
        local self_card = G.jokers.highlighted[1]
        for key, _ in pairs(jester_table) do
            if key == self_card.config.center_key then
                local new_joke = jester_table[key]
                local jester_key = new_joke[math.random(1, #new_joke)]
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, jester_key, 'jest')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                    end}))   
                self_card:start_dissolve()
                return
            end
        end 
    end,
}
return {name = {"Spectrals", "Jokers"}, items = {the_fool_qm}}