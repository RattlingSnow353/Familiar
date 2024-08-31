local speckle = {
    object_type = "Tag",
    key = 'speckle', 
    loc_txt = {
        name = "Speckled Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Speckled'
        }
    },
    pos = { x = 3, y = 0},
    atlas = 'Tags',

    config = {type = 'store_joker_modify', edition = 'fam_speckle', odds = 4},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_fam_speckle
        return {}
    end,

    apply = function(tag, context)
        if context.type == 'store_joker_modify' then
            local applied = nil
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true

                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION,function()
                    context.card:set_edition({fam_speckle = true}, true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    context.card.temp_edition = nil
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                applied = true

                tag.triggered = true
            end
            return applied
        end
    end,
}
return {name = "Speckled Pin", items = {speckle}}