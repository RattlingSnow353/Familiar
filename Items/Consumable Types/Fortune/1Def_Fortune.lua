local Familiar_TarotsConsumableType = { 
    object_type = "ConsumableType",
    key = 'Familiar_Tarots',
    collection_rows = { 5,6 },
    primary_colour = HEX("2e3530"),
    secondary_colour = HEX("2e3530"),
    loc_txt = {
        collection = 'Fortune Cards',
        name = 'Fortune',
        label = 'Fortune',
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            },
        },
    },
}
local Familiar_TarotsUndiscoveredSprite = {
    object_type = "UndiscoveredSprite",
    key = "Familiar_Tarots",
    atlas = "Consumables",
    pos = {
        x = 6,
        y = 2,
    }
}

return {name = "Fortune Cards", items = {Familiar_TarotsUndiscoveredSprite, Familiar_TarotsConsumableType}}