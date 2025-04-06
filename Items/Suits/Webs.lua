local webs = {
    object_type = "Suit",
    key = 'webs',
    card_key = 'W',
    hidden = true,

    hc_atlas = 'SuitsHc',
    lc_atlas = 'Suits',
    hc_ui_atlas = 'UIHc',
    lc_ui_atlas = 'UI',
    ignore = true,
    
    pos = { y = 1 },
    ui_pos = { x = 1, y = 0 },

    hc_colour = HEX("00ffd6"),
    lc_colour = HEX("55d2be"),

    loc_txt = {
        ['en-us'] = {
            singular = "Web",
            plural = 'Webs',
        }
    },

    in_pool = function(self, args)
        if args and args.initial_deck then
            return false
        end
        return G.GAME and G.GAME.Webs
    end,
}
return {name = {"Tekana Cards", "Suits"}, items = {webs}}