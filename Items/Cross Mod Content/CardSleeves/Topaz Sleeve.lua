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
        },
        loc_vars = function(self)
            return {
                vars = {
                    self.config.hands,
                    self.config.discards
                }
            }
        end,
        loc_txt = {
            name = "Topaz Sleeve",
            text = {
                "{C:blue}+1{} hand every round,",
                "{C:red}+1{} discard every round",
            }
        }
    }
    return {name = "Cross Mod", items = {topazsleeve}}
end