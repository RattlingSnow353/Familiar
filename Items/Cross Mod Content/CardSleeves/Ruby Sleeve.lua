if (SMODS.Mods["CardSleeves"] or {}).can_load then
    local rubysleeve = {
        object_type = "Sleeve",
        key = 'rubysleeve',
        name = 'Ruby Sleeve',
        atlas = 'cardsleeves',
        pos = {x = 2, y = 0},
        config = {
        },
        loc_vars = function(self)
        self.config = {
            consumables = { 'c_fam_playback', 'c_fam_playback' }, 
            discards = 2,
            hands = -1
        }
        end,
    }
    return {name = "Card Sleeves", items = {rubysleeve}}
end