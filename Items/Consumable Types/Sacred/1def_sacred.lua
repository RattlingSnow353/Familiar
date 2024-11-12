local Familiar_PlanetsConsumableType = { 
    object_type = "ConsumableType",
    key = 'Familiar_Planets',
    collection_rows = { 6,6 },
    primary_colour = HEX("675baa"),
    secondary_colour = HEX("675baa"),
    loc_txt = {
        collection = 'Sacred Cards',
        name = 'Sacred',
        label = 'Sacred',
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
local Familiar_PlanetsUndiscoveredSprite = {
    object_type = "UndiscoveredSprite",
	key = "Familiar_Planets",
	atlas = "Consumables",
	pos = {
		x = 7,
		y = 2,
	}
}
return {name = "Sacred Cards", items = {Familiar_PlanetsUndiscoveredSprite, Familiar_PlanetsConsumableType}}