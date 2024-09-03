local Zeus_tag = {
    object_type = "Tag",
    atlas = "Tags",
    pos = { x = 3, y = 2},
    config = {type = 'new_blind_choice'},
    key = "Zeus_tag",
    min_ante = 4,
    loc_txt = {
        name = "Pin of Zeus",
        text = {
            "Gives a free",
            "Pantheon Chest"
        }
    },
    loc_vars = function(self, info_queue)
        info_queue[#info_queue+1] = {set = "Other", key = "p_fam_pantheon_booster_3", vars = {2, 5}}
        return {vars = {}}
    end,
    apply = function(self, _context)
        if _context.type == 'new_blind_choice' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            self:yep('+', G.C.BLACK,function() 
                local key = 'p_fam_pantheon_booster_3'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            self.triggered = true
            return true
        end
    end,
}
return {name = "Tags", items = {Zeus_tag}}