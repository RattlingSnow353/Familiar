local set_ed = Card.set_edition
function Card:set_edition(edition, immediate, silent)
    if SMODS.has_enhancement(self, 'm_fam_stainless') then
        return set_ed(self, nil, immediate, silent)
    end
    local temped = edition
    if G.GAME.modifiers.fam_neg_common and (self.config.center.rarity == 1 or self.config.center.rarity == "Common") then
        temped = {negative = true}
    end
    return set_ed(self, temped, immediate, silent)
end

local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(self)
    Backapply_to_runRef(self)
    if self.effect.config.fam_force_edition then
        G.GAME.modifiers.fam_force_edition = self.effect.config.fam_force_edition
        G.E_MANAGER:add_event(Event({
            func = function()
                for c = #G.playing_cards, 1, -1 do
                    local ed_table = {}
                    ed_table[self.effect.config.fam_force_edition] = true
                    G.playing_cards[c]:set_edition(ed_table, true, true);
                end
            
                return true
            end
        }))
    end
    if self.effect.config.fam_force_dual then
        G.GAME.modifiers.fam_force_dual = true
    end
    local se = Card.set_edition
    function Card:set_edition(edition, y, z)
        if G.GAME.modifiers.fam_neg_common and self.config.center.rarity == 1 then
            edition = 'negative'
        end
        return se(self, G.GAME.modifiers.fam_force_edition and {[G.GAME.modifiers.fam_force_edition]=true} or edition, y, z)
    end
    if self.effect.config.shop_rate then
        MenmentosType.shop_rate = self.effect.config.shop_rate
    end
end

local get_idref = Card.get_id
function Card:get_id(base)
    local id = get_idref(self)
    if SMODS.has_no_rank(self) then
        return 0
    end
    if base == true then
        return self.base.id
    end
    if G.jokers then
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.name == "j_fam_smudged_jester" then
                if id == 3 then
                    return 8
                elseif id == 6 then
                    return 9
                elseif id == 13 then
                    return 14
                end
            end
        end
    end
    return id
end

local is_suitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if SMODS.has_no_suit(self) then
        return false
    end
    local ref=is_suitref(self)
    if next(find_joker('Smeared Joker')) then
        if (self.base.suit == 'Spades' or self.ability.is_spade == true) or (self.base.suit == 'Clubs' or self.ability.is_club == true) then
            if suit == 'Spades' or suit == 'Clubs' then
                return true
            end
        end
        if (self.base.suit == 'Hearts' or self.ability.is_heart == true) or (self.base.suit == 'Diamonds' or self.ability.is_diamond == true) then
            if suit == 'Hearts' or suit == 'Diamonds' then
                return true
            end
        end
    else
        if self.ability.is_spade == true then
            set_sprite_suits(self, false)
            if suit == 'Spades' then
                return true
            end
        end
        if self.ability.is_heart == true then
            set_sprite_suits(self, false)
            if suit == 'Hearts' then
                return true
            end
        end
        if self.ability.is_club == true then
            set_sprite_suits(self, false)
            if suit == 'Clubs' then
                return true
            end
        end
        if self.ability.is_diamond == true then
            set_sprite_suits(self, false)
            if suit == 'Diamonds' then
                return true
            end
        end
    end
    return (self.base.suit == suit) or ref
end

local is_faceref = Card.is_face
function Card:is_face(from_boss)
    local ref=is_faceref(self)
    if (self.debuff and not from_boss) or not G.jokers then return end
    local id = self:get_id()
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.name == "j_fam_prosopagnosia" then
            return false
        end
    end
    if id == 11 or id == 12 or id == 13 or next(find_joker("Pareidolia")) then
        return true
    end
    return ref
end

local set_costref = Card.set_cost
function Card:set_cost()
    local ref= set_costref(self)
    if (self.ability.set == 'Tarot' or (self.ability.set == 'Booster' and self.ability.name:find('Arcana'))) and #find_joker('j_fam_taromancer') > 0 then
        self.cost = 0
    end
    return ref
end

local copy_cardref = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    new_card = copy_cardref(other, new_card, card_scale, playing_card, strip_edition)

    if other.ability.suitless then
        new_card.ability.suitless = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_club then
        new_card.ability.is_club = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_diamond then
        new_card.ability.is_diamond = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_spade then
        new_card.ability.is_spade = true
        set_sprite_suits(new_card, false)
    elseif other.ability.is_heart then
        new_card.ability.is_heart = true
        set_sprite_suits(new_card, false)
    end
    

    return new_card
end

local card_drawref = Card.draw
function Card:draw(layer)
    local card_drawref = card_drawref(self, layer)
    if self.ability.set == 'Familiar_Spectrals' then
        self.children.center:draw_shader('booster', nil, self.ARGS.send_to_shader)
    end
    return card_drawref
end

local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front);
    if _center and _center.fifth_layer then
        if _center then
            self.children.floating_sprite4 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fifth_layer)
            self.children.floating_sprite4.role.draw_major = self
            self.children.floating_sprite4.states.hover.can = false
            self.children.floating_sprite4.states.click.can = false
        end
    end
    if _center and _center.fouth_layer then
        if _center then
            self.children.floating_sprite3 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.fouth_layer)
            self.children.floating_sprite3.role.draw_major = self
            self.children.floating_sprite3.states.hover.can = false
            self.children.floating_sprite3.states.click.can = false
        end
    end
    if _center and _center.third_layer then
        if _center then
            self.children.floating_sprite2 = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], _center.third_layer)
            self.children.floating_sprite2.role.draw_major = self
            self.children.floating_sprite2.states.hover.can = false
            self.children.floating_sprite2.states.click.can = false
        end
    end
end