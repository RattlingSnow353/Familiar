local dumpster_fire_tag = {
    object_type = "Tag",
    atlas = "Tags",
    pos = { x = 2, y = 3},
    config = {type = 'ante_start_bonus', discards = 2, cur_ante = 0},
    key = "dumpster_fire_tag",
    order = 11,
    min_ante = 2,
    ignore = true,
    loc_vars = function(self, info_queue)
        return {vars = {}}
    end,
    apply = function(self, tag, context)
        if context.type == self.config.type then
            tag:yep('+', G.C.RED ,function() 
                return true
            end)
            ease_discard(tag.config.discards) 
            G.GAME.round_resets.fam_temp_discards = true
            G.GAME.round_resets.fam_temp_discards_ante = G.GAME.round_resets.ante
            tag.triggered = true
        end
    end,
}
return {name = "Tags", items = {dumpster_fire_tag}}