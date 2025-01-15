local professor =  {
    object_type = "Joker",
    key = "professor",
    config = {
       extra = 1
    },
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        ['en-us'] = {
            name = 'Professor',
            text = {
                "{C:blue}+#1#{} hand each round",
            }
        }
    },
    rarity = 1,
    cost = 7,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra } }
	end,
    add_to_deck = function(self, card, from_debuff)    
        ease_hands_played(card.ability.extra)
    end,
    remove_from_deck = function(self, card, from_debuff)
        ease_hands_played(-card.ability.extra)
    end
}
return {name = "Jokers", items = {professor}}