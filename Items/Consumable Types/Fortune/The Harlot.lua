local the_harlot = {
    object_type = "Consumable",
    key = 'the_harlot',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 2, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Harlot",
            text = {
                "Creates a {C:attention}planet{} card",
                "of your {C:attention}most{} used poker hand",
                "{C:inactive}(Must have room){}"
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then 
            return true 
        end
    end,
    use = function(self, card)
        local _planet, _hand, _tally = nil, nil, 0
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end
        if _hand then
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == _hand then
                    _planet = v.key
                end
            end
        end
        create_consumable("Planet",'pl1',nil,{forced_key = _planet}, true, true)
    end,
}
return {name = "The Harlot", items = {the_harlot}}