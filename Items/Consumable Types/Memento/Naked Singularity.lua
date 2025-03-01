local naked_singularity = {
    object_type = "Consumable",
    key = 'naked_singularity',
    set = 'Familiar_Spectrals',
    config = { },
    atlas = 'Consumables',
    pos = { x = 9, y = 3 },
    loc_txt = {
        ['en-us'] = {
            name = "Naked Singularity ",
            text = {
                "Upgrade every",
                "{C:legendary,E:1}poker hand{} by",
                "{C:attention}1+i{} Imaginary level"
            }
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        return true 
    end,
    use = function(self, card)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '*', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '*', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1+i'})
        delay(1.3)
        for k, v in pairs(i_hands) do
            mult_level_up_hand(card, k, true, 1)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}
return {name = "Memento Cards", items = {naked_singularity}}