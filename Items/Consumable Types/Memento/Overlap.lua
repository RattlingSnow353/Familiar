local overlap = {
    object_type = "Consumable",
    key = 'overlap',
    set = 'Familiar_Spectrals',
    config = { extra = { minus_hand = 2 } },
    atlas = 'Consumables',
    pos = { x = 6, y = 4 },
    order = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.minus_hand } }
    end,
    can_use = function(self, card, area, copier)
        if G.hand and (#G.hand.highlighted <= 1) and #G.hand.highlighted ~= 0 then
            return true 
        end
    end,
    use = function(self, card)
        for i=1, #G.hand.cards do
            local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.cards do
            local card = G.hand.highlighted[1]
            local _suit = card:get_suit()
            if _suit == "Diamonds" then
                G.hand.cards[i].ability.is_diamond = true
            elseif _suit == 'Hearts' then
                G.hand.cards[i].ability.is_heart = true
            elseif _suit == 'Clubs' then
                G.hand.cards[i].ability.is_club = true
            elseif _suit == 'Spades' then
                G.hand.cards[i].ability.is_spade = true
            else
                return
            end
            set_sprite_suits(G.hand.cards[i], true)
        end  
        G.hand:change_size(-card.ability.extra.minus_hand)
        delay(0.2)
        for i=1, #G.hand.cards do
            local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
        end
    end,
}
return {name = "Memento Cards", items = {overlap}}