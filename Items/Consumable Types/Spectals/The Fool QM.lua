local the_fool_qm = {
    object_type = "Consumable",
    key = 'the_fool_qm',
    set = 'Spectral',
    config = { extra = { readd = {}, readdkey = {} } },
    atlas = 'Consumables',
    pos = { x = 6, y = 5 },
    order = 1,
    loc_vars = function(self, info_queue)
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
                    local failreturn = 0
                    for k, joker in pairs(G.P_CENTER_POOLS['Joker']) do
                        for _key, _k in pairs(new_joke) do
                            if joker.key == new_joke[_key] then
                                if self_card.config.center.rarity ~= 4 and joker.rarity == 4 then
                                    failreturn = failreturn + 1
                                    table.insert(card.ability.extra.readd, new_joke[_key])
                                end
                            end
                        end
                    end
                    if failreturn == #new_joke then
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
                local valid_jokes = {}
                for i, jokerKey in ipairs(new_joke) do
                    local exclude = false
                    if card.ability.extra.readd then
                        for _, removed in ipairs(card.ability.extra.readd) do
                            if jokerKey == removed then
                                exclude = true
                                break
                            end
                        end
                    end
                    if not exclude then
                        table.insert(valid_jokes, jokerKey)
                    end
                end

                if #valid_jokes == 0 then
                    return false
                end

                local jester_key = valid_jokes[math.random(1, #valid_jokes)]
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, jester_key, 'jest')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0
                        return true
                    end
                }))
                self_card:start_dissolve()
                return
            end
        end
    end,
}
return {name = {"Spectrals", "Jokers"}, items = {the_fool_qm}}