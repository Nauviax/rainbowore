-- Optionally allow biochamber conversion. Will add organic-or-hand-crafting to the mk1 assembler if enabled.
local use_biochamber = mods["space-age"] and settings.startup["rainbow-ore-use-biochamber"].value

local function Process(resource)

    local result = resource.minable.result and resource.minable.result or resource.minable.results[1] -- Either string or result object (Normally fluid)
    local is_fluid = result.type and result.type == "fluid"

    local rainbow_amount_required = 5
    local energy_required = 1
    local result_count = is_fluid and 10 * rainbow_amount_required or rainbow_amount_required -- 10x more fluid, to try and be more useful.
    local additional_ingredients = nil
    local order = nil
    local color = nil

    -- Load any preset info set during data stage
    if resource.rainbow_ore_data then
        if (resource.rainbow_ore_data.rainbow_amount_required ~= nil) then
            rainbow_amount_required = resource.rainbow_ore_data.rainbow_amount_required
        end
        if (resource.rainbow_ore_data.energy_required ~= nil) then
            energy_required = resource.rainbow_ore_data.energy_required
        end
        if (resource.rainbow_ore_data.result_count ~= nil) then
            result_count = resource.rainbow_ore_data.result_count
        end
        if (resource.rainbow_ore_data.additional_ingredients ~= nil) then
            additional_ingredients = resource.rainbow_ore_data.additional_ingredients
        end
        if (resource.rainbow_ore_data.order ~= nil) then
            order = resource.rainbow_ore_data.order
        end
        if (resource.rainbow_ore_data.color ~= nil) then
            color = resource.rainbow_ore_data.color
        end
    end

    -- Create the recipe
    local recipe = {
        type = "recipe",
        name = "rainbow-to-"..resource.name,
        localised_name = { "recipe-name.rainbow-ore-conversion", is_fluid and {"fluid-name."..resource.name} or {"item-name."..resource.name} },
        energy_required = energy_required,
        enabled = false, -- Now unlocked by tech
        ingredients = { {name="rainbow-ore", amount=rainbow_amount_required, type="item"} }, -- Rest inserted below
        results = {{name=result.name and result.name or result, amount=result_count, type=result.type and result.type or "item"}},
        subgroup = "raw-material",
        crafting_machine_tint = { primary = color, secondary = color, tertiary = color, quaternary = color }
    }
    if additional_ingredients then -- If there are extra ingredients specified for this resource, add them now
        for _, ingredient in ipairs(additional_ingredients) do
            table.insert(recipe.ingredients, ingredient)
        end
    end
    if is_fluid or additional_ingredients then
        recipe.category = use_biochamber and "organic-or-chemistry" or "chemistry"
    else
        recipe.category = use_biochamber and "organic-or-hand-crafting" or "crafting"
    end
    if order then
        recipe.order = order
    else
        recipe.order = "a[conversion]-e[other]-"..resource.order -- Default to last, which will normally just be non-vanilla resources
    end
    log("Created rainbow ore recipe for "..resource.name)
    log("color: "..serpent.line(color))

    data:extend({recipe})
end

-- LUA DOESN'T HAVE A TABLE.CONTAINS FUNCTION???
local function table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- Initialize the technologies effects list, include chem plant.
local techEffects = {
    {
        type = "unlock-recipe",
        recipe = "chemical-plant" -- So that oil can be used without oil on map
    }
}

-- Get whitelist string from settings, split by comma. If the resource is not in the whitelist, skip it.
local whitelist = tostring(settings.startup["rainbow-ore-whitelist"].value)
local whitelistTable = {}
for name in whitelist:gmatch("[^,]+") do
    table.insert(whitelistTable, name)
end

-- For every resource,
for _, resource in pairs(data.raw.resource) do
    -- Process if in whitelist
    if (table_contains(whitelistTable, resource.name)) then
        Process(resource)
        -- Add an unlock effect to the technologies effects list
        table.insert(techEffects, {
            type = "unlock-recipe",
            recipe = "rainbow-to-"..resource.name
        })
        -- Clear my mod data if it exists
        ---@diagnostic disable-next-line: inject-field
        resource.rainbow_ore_data = nil
    end
end

-- Add technology for rainbow ore
data:extend(
    {{
        type = "technology",
        name = "rainbow-ore-tech",
        localised_name = {"technology-name.rainbow-ore-tech"},
        icon = "__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore.png",
        icon_size = 64,
        effects = techEffects,
        prerequisites = {},
        research_trigger = {
            type = "mine-entity",
            entity = "rainbow-ore"
        },
        order = "a-a-a",
    }}
)

-- If use_biochamber, then add "organic-or-hand-crafting" to the mk1 assembler, allowing it to craft conversion recipies.
if use_biochamber and data.raw["assembling-machine"]["assembling-machine-1"] then
    table.insert(data.raw["assembling-machine"]["assembling-machine-1"].crafting_categories, "organic-or-hand-crafting")
end