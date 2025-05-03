if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local silversleeve = {
        object_type = "Sleeve",
        key = 'silversleeve',
        name = 'Silver Sleeve',
        atlas = 'cardsleeves',
        pos = {x = 0, y = 1},
        config = {
            joker_slot = 2,
            hands = -1,
            discards = -1,
        },
        loc_vars = function(self)
            return {
                vars = {
                    self.config.joker_slot,
                    -self.config.hands,
                    -self.config.discards
                }
            }
        end,
    }
    return {name = "Card Sleeves", items = {silversleeve}}
end