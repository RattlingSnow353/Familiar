local crimsonotype = {
    object_type = "Joker",
    key = 'crimsonotype',
    config = {
        extra = {},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = 'Crimsonotype',
            text = {
                "Copies ability of",
                "{C:attention}Joker{} to the left",
            }
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        local jokers = G.jokers.cards
        for i = 1, #jokers do
            if jokers[i] == card then
                other_joker = jokers[i-1] 
            end
        end
        if not other_joker then
            return 
        end
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or card
        if context.blueprint > #G.jokers.cards + 1 then 
            return 
        end
        local other_joker_ret = other_joker:calculate_joker(context)
        if other_joker_ret then 
            other_joker_ret.card = context.blueprint_card or card
            other_joker_ret.colour = G.C.RED
            return other_joker_ret
        end
    end
}
return {name = "Crimsonotype", items = {crimsonotype}}