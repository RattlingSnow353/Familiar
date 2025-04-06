local tekanaConsumableType = { 
    object_type = "ConsumableType",
    key = 'tekana',
    collection_rows = { 5,6 },
    primary_colour = HEX("02e9ff"),
    secondary_colour = HEX("02e9ff"),
    default = 'c_fam_desolate_wanderer',
    ignore = true,
    loc_txt = {
        collection = 'Tekana Cards',
        name = 'Tekana',
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
local tekanaUndiscoveredSprite = {
    object_type = "UndiscoveredSprite",
	key = "tekana",
	atlas = "Consumables",
    ignore = true,
	pos = {
		x = 6,
		y = 2,
	}
}
return {name = "Tekana Cards", items = {tekanaUndiscoveredSprite, tekanaConsumableType}}