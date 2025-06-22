local mod_path = ''..SMODS.current_mod.path

-- You're not supposed to be here
SMODS.optional_features.quantum_enhancements = true

--SMODS.Shader {
--    key = 'statics', 
--    path = 'statics.fs'
--}

SMODS.Atlas { key = 'Joker', path = 'JokersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Consumables', path = 'TarotsFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Enhancers', path = 'EnhancersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'SuitEffects', path = 'Double_Suit_CardsFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Suits', path = '8BitDeckFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'SuitsHc', path = '8BitDeckFam_opt2.png', px = 71, py = 95 }
SMODS.Atlas { key = 'UI', path = 'ui_assets.png', px = 34, py = 34 }
SMODS.Atlas { key = 'UIHc', path = 'ui_assets_opt2.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Booster', path = 'BoostersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Tags', path = 'TagsFam.png', px = 34, py = 34 }
SMODS.Atlas { key = 'Stickers', path = 'StickersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'Voucher', path = 'VouchersFam.png', px = 71, py = 95 }
SMODS.Atlas { key = 'modicon', path = 'ModIcon.png', px = 32, py = 32 }
if (SMODS.Mods["CardSleeves"] or {}).can_load then
    SMODS.Atlas { key = 'cardsleeves', path = 'CardSleevesFam.png', px = 71, py = 95}
end

local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then lc() end
    G.ARGS.LOC_COLOURS.web = HEX("55d2be") 
    return lc(_c, _default)
end

local folders = NFS.getDirectoryItems(mod_path.."Items")
local objects = {}

local function collect_item_files(base_fs, rel, out)
    for _, name in ipairs(NFS.getDirectoryItems(base_fs)) do
        local abs = base_fs.."/"..name
        local info = NFS.getInfo(abs)
        if info and info.type == "directory" then
            collect_item_files(abs, rel.."/"..name, out)
        elseif info and info.type == "file" and name:match("%.lua$") then
            table.insert(out, rel.."/"..name)
        end
    end
end

local files = {}
collect_item_files(mod_path.."Items", "Items", files)

local function load_items(curr_obj)
    if curr_obj.init then curr_obj:init() end
    if not curr_obj.items then
        print("Warning: curr_obj has no items")
        return
    end
    for _, item in ipairs(curr_obj.items) do
        item.ignore = item.ignore or false
        if SMODS[item.object_type] and not item.ignore then
            SMODS[item.object_type](item)
        elseif CardSleeves and CardSleeves[item.object_type] and not item.ignore then
            CardSleeves[item.object_type](item)
        elseif not item.ignore then
            print("Error loading item "..item.key.." of unknown type "..item.object_type)
        end
        ::continue::
    end
end

for _, rel in ipairs(files) do
    local f, err = SMODS.load_file(rel)
    if not f then
        print("Error loading item file '"..rel.."': "..tostring(err))
    else
        local ok, curr_obj = pcall(f)
        if ok then
            table.insert(objects, curr_obj)
        end
    end
end

table.sort(objects, function(a, b)
    local function get_lowest_order(obj)
        if not obj.items then return math.huge end
        local lowest = math.huge
        for _, item in ipairs(obj.items) do
            if item.order and item.order < lowest then
                lowest = item.order
            end
        end
        return lowest
    end
    return get_lowest_order(a) < get_lowest_order(b)
end)

for _, curr_obj in ipairs(objects) do
    load_items(curr_obj)
end

----------------------------------------------
------------MOD CODE END---------------------