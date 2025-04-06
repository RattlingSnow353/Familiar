local bard =  {
    object_type = "Joker",
    key = "bard",
    config = {
        extra =  {hand_size = -2, discard_size = 1},
    },
    atlas = 'Joker',
    pos = { x = 0, y = 2 },
    rarity = 1,
    cost = 7,
    blueprint_compat = false,
    familiar = "j_troubadour",
    order = 111,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_size, card.ability.extra.discard_size} }
    end,
    add_to_deck = function(self, card, from_debuff)    
        G.hand:change_size(card.ability.extra.hand_size)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discard_size
        ease_discard(card.ability.extra.discard_size)

    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discard_size
        G.hand:change_size(-card.ability.extra.hand_size)
        ease_discard(-card.ability.extra.discard_size)
    end
}
return {name = "Jokers", items = {bard}}