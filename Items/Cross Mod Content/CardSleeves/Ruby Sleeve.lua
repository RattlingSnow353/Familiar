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
        loc_txt = {
            name = "Ruby Sleeve",
            text = {
                "Start with {C:attention}2 copies{}",
                "of Playback,",
                "{C:red}+2{} discards every round.",
                "{C:blue}-1{} hand every round."
            }
        }
    }
    return {name = "Cross Mod", items = {rubysleeve}}
end