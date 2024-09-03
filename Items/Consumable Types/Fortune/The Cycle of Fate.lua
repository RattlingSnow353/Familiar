local the_cycle_of_fate = {
    object_type = "Consumable",
    key = 'the_cycle_of_fate',
    set = 'Familiar_Tarots',
    config = { extra = { odds = 4 } },
    atlas = 'Consumables',
    pos = { x = 0, y = 1 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Cycle of Fate",
            text = {
                "{C:green,E:1,S:1.1}#2# in #1#{} chance to",
                "make a {C:attention}joker{} Negative.",
                "{C:inactive}(Overrides other Editions){}"
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.odds, '' .. (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    can_use = function(self, card, area, copier)
        if #G.jokers.cards > 0 then 
            return true 
        end
    end,
    use = function(self, card)
        local eligibleJokers = {}
        for i = 1, #G.jokers.cards do
            eligibleJokers[#eligibleJokers+1] = G.jokers.cards[i] 
        end
        local joker = math.random(1,#G.jokers.cards)
        if pseudorandom('cycle_of_fate') < G.GAME.probabilities.normal/card.ability.extra.odds and G.jokers.cards[joker].edition ~= 'negative' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local edition = {negative = true}
                G.jokers.cards[joker]:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
            return true end }))
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.GREY,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4);return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
            return true end }))
        end
        delay(0.6)
    end,
}
return {name = "Fortune Cards", items = {the_cycle_of_fate}}