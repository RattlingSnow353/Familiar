local statics_shader = {
    object_type = "Shader",
    key = 'statics', 
    path = 'statics.fs'
}
local statics = {
    object_type = "Edition",
    key = 'statics', 
    atlas = 'Joker',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = "Static",
        label = "Static",
        text = {
            "{X:chips,C:white} X#1# {} Chips"
        }
    },
    config = { Xchips = 1.5 },
    loc_vars = function(self, info_queue)
        return {vars = {self.config.Xchips}}
    end,

    in_shop = true,
    weight = 7,
    extra_cost = 5,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.post_joker or (context.main_scoring and context.cardarea == G.play) then
            return {func = function()
                local xchips = G.P_CENTERS.e_fam_statics.config.Xchips
                hand_chips = mod_chips(hand_chips * xchips)
                update_hand_text({delay = 0}, {chips = hand_chips})
                card_eval_status_text(card, 'extra', nil, percent, nil,
                {message = 'X'..xchips..' Chips',
                edition = true,
                x_chips = true})
            end}
        end
    end,

    shader = 'statics'
}
return {name = "Editions", items = {statics, statics_shader}}