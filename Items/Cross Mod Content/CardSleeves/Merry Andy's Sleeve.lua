if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local andysleeve = {
        object_type = "Sleeve",
        key = 'andysleeve',
        name = "Merry Andy's Sleeve",
        atlas = 'cardsleeves',
        pos = {x = 0, y = 2},
        config = {
            hand_size = -1,
            discards = 3
        },
        loc_vars = function(self)
            return {
                vars = {
                    -self.config.hand_size,
                    self.config.discards
                }
            }
        end,
    }
    return {name = "Card Sleeves", items = {andysleeve}}
end