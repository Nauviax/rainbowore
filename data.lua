require("rainbowore") -- Load rainbow ore data

-- Define Rainbow ore recipe data for uranium and crude oil, and specific adjustments for vanilla resources
local vanillaRawResouceData = {}
vanillaRawResouceData["uranium-ore"] = {
    disabled = false,
    rainbow_amount_required = 10, -- Old was 5 -> 5, new is 1/2 as good
    energy_required = 5,
    result_count = 5,
    additional_ingredients = {{name="sulfuric-acid",amount=5,type="fluid"}},
    order = "a[conversion]-c[uranium-ore]", -- Last / Sixth
    color = {0.4, 0.7, 0.0}
}
vanillaRawResouceData["crude-oil"] = {
    disabled = false,
    rainbow_amount_required = 5, -- Old was 25 -> 250, new is 4x better
    energy_required = 5,
    result_count = 200,
    additional_ingredients = {{name="water",amount=200,type="fluid"}},
    order = "a[conversion]-b[crude-oil]", -- Second-to-last / Fifth
    color = {0.0, 0.0, 0.1}
}
vanillaRawResouceData["iron-ore"] = {
    order = "a[conversion]-a[earlyores]-a[iron-ore]", -- First
    color = {0.0, 0.5, 1.0}
}
vanillaRawResouceData["copper-ore"] = {
    order = "a[conversion]-a[earlyores]-b[copper-ore]", -- Second
    color = {1.0, 0.5, 0.3}
}
vanillaRawResouceData["stone"] = {
    order = "a[conversion]-a[earlyores]-c[stone]", -- Third
    color = {0.6, 0.4, 0.3}
}
vanillaRawResouceData["coal"] = {
    order = "a[conversion]-a[earlyores]-d[coal]", -- Fourth
    color = {0.0, 0.0, 0.0}
}

-- Use preset rainboworedata customization on the resource
for key, value in pairs(data.raw.resource) do
    if (vanillaRawResouceData[key]) then -- If we have preset data for it
        -- yes yes VSCode I get it, but please shut up.
        ---@diagnostic disable-next-line: inject-field
        value.rainbow_ore_data = vanillaRawResouceData[key] -- Load rainbow ore recipe data into the resource
    end
end