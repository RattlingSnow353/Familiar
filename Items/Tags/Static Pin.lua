local statics = {
    object_type = "Tag",
    key = 'statics', 
    loc_txt = {
        name = "Static Pin",
        text = {
            'Next base edition shop',
            'Jester is free and',
            'becomes {C:dark_edition}Static'
        }
    },
    pos = { x = 0, y = 1},
    atlas = 'Tags',

    config = {type = 'store_joker_modify', edition = 'fam_statics', odds = 4},
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = G.P_CENTERS.e_fam_statics
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
                    context.card:set_edition({fam_statics = true}, true)
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
return {name = "Tags", items = {statics}}