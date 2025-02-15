local gilded = {
    object_type = "Enhancement",
    key = 'gilded',
    loc_txt = {
        name = 'Gilded',
        text = {
            "{C:money}$#1#{} when held in hand",
            "decreases by {C:money}$#2#{} each use",
            "becomes a {C:attention}steel card",
            "after {C:attention}#3#{} uses.",
        }
    },
    pos = {x = 6, y = 0}, 
    atlas = 'Enhancers', 
    config = { p_dollars = 5, dollar_mod = 1, left = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.p_dollars, card.ability.dollar_mod, card.ability.left } }
    end,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand then
            local dollar = card.ability.p_dollars
            card.ability.p_dollars = dollar - card.ability.dollar_mod
            card.ability.left = card.ability.left - 1
            card:juice_up()
            if dollar <= 1 then
                return{
                    dollars = 1,
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Delamination!', colour = G.C.UI.TEXT_INACTIVE}),
                    card:set_ability(G.P_CENTERS.m_steel, nil, true),
                    card:juice_up()
                }
            else
                return{
                    dollars = dollar
                }
            end
        end
    end,

}
return {name = {"Fortune Cards", "Enhancements"}, items = {gilded}}