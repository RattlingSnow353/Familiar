if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local amethystsleeve = {
        object_type = "Sleeve",
        key = 'amythestsleeve',
        name = 'Amethyst Sleeve',
        atlas = 'cardsleeves',
        pos = {x = 0, y = 0},
        config = {
            hand_size = 5
        },
        loc_vars = function(self)
            return { vars = {self.config.hand_size} }
        end,
        loc_txt = {
            name = "Amethyst Sleeve",
            text = {
                "{C:attention}+5{} hand size"
            }
        }
    }
    return {name = "Cross Mod", items = {amethystsleeve}}
end