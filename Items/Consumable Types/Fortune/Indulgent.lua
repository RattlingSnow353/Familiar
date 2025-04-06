local indulgent = {
    object_type = "Consumable",
    key = 'indulgent',
    set = 'Familiar_Tarots',
    config = { money = 0, max = 60 },
    atlas = 'Consumables',
    pos = { x = 4, y = 1 },
    cost = 3,
    order = 15,
    familiar = "c_temperance",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max, card.ability.money } }
    end,
    can_use = function(self, card, area, copier)
        if G.jokers.highlighted and (#G.jokers.highlighted == 1) and G.jokers.highlighted[1] then
            local self_card = G.jokers.highlighted[1]
            card.ability.money = 0
            card.ability.money = card.ability.money + (self_card.sell_cost * 3)
            card.ability.money = math.min(card.ability.money, card.ability.max)
            return true  
        end
    end,
    use = function(self, card)
        local self_card = G.jokers.highlighted[1]
        card.ability.money = 0
        card.ability.money = card.ability.money + (self_card.sell_cost * 3)
        card.ability.money = math.min(card.ability.money, card.ability.max)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            ease_dollars(card.ability.money, true)
            return true end }))
        delay(0.6)
    end,
}
return {name = {"Fortune Cards"}, items = {indulgent}}