local split = {
    object_type = "Enhancement",
    key = 'split',
    pos = {x = 3, y = 1}, 
    atlas = 'Enhancers', 
    order = 3,
    replace_base_card = true,
    overrides_base_rank = true,
    config = { extra = { chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if card.ability.extra.chips ~= 0 then
                SMODS.calculate_effect({chip_mod = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}, card)
            end
        end
	end,
    update = function(self, card, dt)
        if G.play ~= nil then
            if #G.play.cards ~= 0 then
                for i = 1, #G.play.cards do
                    if G.play.cards[i] == card then
                        card.ability.extra.chips = 0
                        if #G.play.cards == 1 and i == 1 then
                            card.ability.no_rank = true
                            card.ability.no_suit = true
                        else
                            if i == 1 then
                                local suit_prefix = G.play.cards[i+1].base.suit
                                card.ability.no_rank = true
                                card.ability.no_suit = false
                                assert(SMODS.change_base(card, suit_prefix))
                            end
                            if i == #G.play.cards then
                                local rank_suffix = G.play.cards[i-1].base.value
                                card.ability.extra.chips = G.play.cards[i-1].base.nominal
                                card.ability.no_suit = true
                                card.ability.no_rank = false
                                assert(SMODS.change_base(card, nil, rank_suffix))
                            end
                            if i > 1 and i < #G.play.cards then
                                local suit_prefix = G.play.cards[i+1].base.suit
                                local rank_suffix = G.play.cards[i-1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                card.ability.extra.chips = G.play.cards[i-1].base.nominal
                                assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                            end
                        end
                    end
                end
            end
        end
        if G.hand ~= nil then
            if #G.hand.highlighted ~= 0 then
                for i = 1, #G.hand.highlighted do
                    if G.hand.highlighted[i] == card then
                        card.ability.extra.chips = 0
                        if #G.hand.highlighted == 1 and i == 1 then
                            card.ability.no_rank = true
                            card.ability.no_suit = true
                        else
                            if i == 1 then
                                local suit_prefix = G.hand.highlighted[i+1].base.suit
                                card.ability.no_rank = true
                                card.ability.no_suit = false
                                assert(SMODS.change_base(card, suit_prefix))
                            end
                            if i == #G.hand.highlighted then
                                local rank_suffix = G.hand.highlighted[i-1].base.value
                                card.ability.extra.chips = G.hand.highlighted[i-1].base.nominal
                                card.ability.no_suit = true
                                card.ability.no_rank = false
                                assert(SMODS.change_base(card, nil, rank_suffix))
                            end
                            if i > 1 and i < #G.hand.highlighted then
                                local suit_prefix = G.hand.highlighted[i+1].base.suit
                                local rank_suffix = G.hand.highlighted[i-1].base.value
                                card.ability.no_rank = false
                                card.ability.no_suit = false
                                card.ability.extra.chips = G.hand.highlighted[i-1].base.nominal
                                assert(SMODS.change_base(card, suit_prefix, rank_suffix))
                            end
                        end
                    end
                end
            end
        end
    end,
}
return {name = {"Fortune Cards", "Enhancements"}, items = {split}}