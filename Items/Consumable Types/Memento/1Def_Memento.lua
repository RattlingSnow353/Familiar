local Familiar_SpectralsConsumableType = { 
    object_type = "ConsumableType",
    key = 'Familiar_Spectrals',
    collection_rows = { 4,5 },
    primary_colour = HEX("e16363"),
    secondary_colour = HEX("e16363"),
    shop_rate = 0,
    loc_txt = {
        collection = 'Memento Cards',
        name = 'Mementos',
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
local Familiar_SpectralsUndiscoveredSprite = {
    object_type = "UndiscoveredSprite",
	key = "Familiar_Spectrals",
	atlas = "Consumables",
	pos = {
		x = 5,
		y = 2,
	},
    no_overlay = true
}
return {name = "Memento Cards", items = {Familiar_SpectralsConsumableType, Familiar_SpectralsUndiscoveredSprite}}