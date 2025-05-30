if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local topazsleeve = {
        object_type = "Sleeve",
        key = 'topazsleeve',
        name = 'Topaz Sleeve',
        atlas = 'cardsleeves',
        pos = {x = 1, y = 0},
        config = {
            hands = 1,
            discards = 1,
            hand_size = -2
        },
        loc_vars = function(self)
            return {
                vars = {
                    self.config.hands,
                    self.config.discards
                    -self.config.hand_size
                }
            }
        end,
    }
    return {name = "Card Sleeves", items = {topazsleeve}}
end