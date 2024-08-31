local the_broken = {
    object_type = "Consumable",
    key = 'the_broken',
    set = 'Familiar_Tarots',
    config = { },
    atlas = 'Consumables',
    pos = { x = 0, y = 0 },
    cost = 3,
    loc_txt = {
        ['en-us'] = {
            name = "The Broken",
            text = {
                "Creates a {C:attention}Familiar Consumable",
                "based on the {C:attention}Consumable",
                "you last used",
            }
        }
    },
    loc_vars = function(self, info_queue)
        return { vars = { } }
    end,
    can_use = function(self, card, area, copier)
        if (#G.consumeables.cards <= G.consumeables.config.card_limit or self.area == G.consumeables) and G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool' then
            return true 
        end
    end,
    use = function(self, card)
        if G.GAME.last_tarot_planet == "c_strength" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_vigor'})
        elseif G.GAME.last_tarot_planet == "c_hanged_man" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_martyr'})
        elseif G.GAME.last_tarot_planet == "c_death" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_demise'})
        elseif G.GAME.last_tarot_planet == "c_judgement" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_verdict'})
        elseif G.GAME.last_tarot_planet == "c_high_priestess" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_harlot'})
        elseif G.GAME.last_tarot_planet == "c_wheel_of_fortune" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_cycle_of_fate'}) 
        elseif G.GAME.last_tarot_planet == "c_devil" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_humanity'}) 
        elseif G.GAME.last_tarot_planet == "c_world" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_landscape'}) 
        elseif G.GAME.last_tarot_planet == "c_moon" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_midnight'}) 
        elseif G.GAME.last_tarot_planet == "c_star" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_galaxy'}) 
        elseif G.GAME.last_tarot_planet == "c_sun" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_daylight'}) 
        elseif G.GAME.last_tarot_planet == "c_tower" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_pit'}) 
        elseif G.GAME.last_tarot_planet == "c_heirophant" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_bishop'}) 
        elseif G.GAME.last_tarot_planet == "c_empress" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_queen'}) 
        elseif G.GAME.last_tarot_planet == "c_lovers" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_wed'}) 
        elseif G.GAME.last_tarot_planet == "c_magician" then
            create_consumable("Familiar_Tarots", nil, nil, {forced_key='c_fam_the_illusionist'}) 
        elseif G.GAME.last_tarot_planet == "c_ceres" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_demeter'}) 
        elseif G.GAME.last_tarot_planet == "c_earth" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_terra'}) 
        elseif G.GAME.last_tarot_planet == "c_eris" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_discordia'}) 
        elseif G.GAME.last_tarot_planet == "c_jupiter" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_zeus'}) 
        elseif G.GAME.last_tarot_planet == "c_mars" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_ares'}) 
        elseif G.GAME.last_tarot_planet == "c_mercury" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_hermes'}) 
        elseif G.GAME.last_tarot_planet == "c_neptune" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_poseidon'}) 
        elseif G.GAME.last_tarot_planet == "c_planet_x" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_hecate'}) 
        elseif G.GAME.last_tarot_planet == "c_pluto" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_hades'}) 
        elseif G.GAME.last_tarot_planet == "c_saturn" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_cronus'}) 
        elseif G.GAME.last_tarot_planet == "c_uranus" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_caelus'}) 
        elseif G.GAME.last_tarot_planet == "c_venus" then
            create_consumable("Familiar_Planets", nil, nil, {forced_key='c_fam_aphrodite'}) 
        end
    end,
}
return {name = "The Broken", items = {the_broken}}