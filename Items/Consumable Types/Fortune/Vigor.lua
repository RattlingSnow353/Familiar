local vigor = {
    object_type = "Consumable",
    key = 'vigor',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 1, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "Vigor",
            text = {
                "Increases rank of",
                "{C:attention}one{} selected card",
                "by {C:attention}3",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
            return true 
        end
    end,
    use = function(self, card)
        for i = 1, #G.hand.highlighted do
            for j = 1, 3 do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local card = G.hand.highlighted[i]
                    local suit_prefix = SMODS.Suits[card.base.suit].card_key
                    local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 then rank_suffix = 'A'
                    end
                    card:juice_up(0.3, 0.5)
                    card:set_base(G.P_CARDS[suit_prefix .. '_' .. rank_suffix])
                return true end }))
            end
        end  
    end,
}
return {name = "Fortune Cards", items = {vigor}}