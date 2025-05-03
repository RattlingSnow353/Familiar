local clown = {
    object_type = "Joker",
    key = 'clown',
    config = {
        extra = { },
    },
    atlas = 'Joker',
    pos = { x = 4, y = 1 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    familiar = "j_mime",
    ignore = true,
    order = 19,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if G.hand ~= nil then
            for i=1, #G.hand.cards do
                if context.first_hand_drawn then
                    G.hand.cards[i].ability.trigger1 = false
                    G.hand.cards[i].ability.trigger2 = true
                end
                if context.hand_drawn or context.before then
                    if G.hand.cards[i].ability.trigger1 then
                        G.hand.cards[i].ability.trigger1 = false
                        G.hand.cards[i].ability.trigger2 = true
                    end
                end
                if context.after or context.pre_discard or context.final_scoring_step or context.end_of_round then
                    if G.hand.cards[i].ability.trigger2 then
                        G.hand.cards[i].ability.trigger1 = true
                        G.hand.cards[i].ability.trigger2 = false
                    end
                end
            end
        end
        if context.selling_card then
            for i=1, #G.deck.cards do
                if next(SMODS.get_enhancements(G.deck.cards[i])) then
			        if G.deck.cards[i].ability.effect ~= "c_base" then 
			            fam_ability_calulate(G.deck.cards[i], "/", 2, { h_x_chips = 1, extra_value = true }, { "h_", "perma_h_" }, false)
                        G.deck.cards[i].ability.trigger2 = nil
                        G.deck.cards[i].ability.trigger1 = nil
                    end
                end
            end
            for i=1, #G.hand.cards do
                if next(SMODS.get_enhancements(G.hand.cards[i])) then
			        if G.hand.cards[i].ability.effect ~= "c_base" then 
			            fam_ability_calulate(G.hand.cards[i], "/", 2, { h_x_chips = 1, extra_value = true }, { "h_", "perma_h_" }, false)
                        G.hand.cards[i].ability.trigger2 = nil
                        G.hand.cards[i].ability.trigger1 = nil
                    end
                end
            end
        end
    end,
    update = function(self, card, dt)
        if G.hand ~= nil then
            for i=1, #G.hand.cards do
                if G.hand.cards[i].ability.trigger1 then
                    if next(SMODS.get_enhancements(G.hand.cards[i])) then
			            if G.hand.cards[i].ability.effect ~= "c_base" then 
			                fam_ability_calulate(G.hand.cards[i], "/", 2, { h_x_chips = 1, extra_value = true }, { "h_", "perma_h_" }, false)
                            G.hand.cards[i].ability.trigger1 = false
                        end
                    end
                end
                if G.hand.cards[i].ability.trigger2 then
                    if next(SMODS.get_enhancements(G.hand.cards[i])) then
			            if G.hand.cards[i].ability.effect ~= "c_base" then 
			                fam_ability_calulate(G.hand.cards[i], "*", 2, { h_x_chips = 1, extra_value = true }, { "h_", "perma_h_" }, false)
                            G.hand.cards[i].ability.trigger2 = false
                        end
                    end
                end
            end
		end
    end,
}
return {name = "Jokers", items = {clown}}