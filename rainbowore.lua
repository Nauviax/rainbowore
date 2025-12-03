local resource_autoplace = require("resource-autoplace")

-- Create Autoplace Control
data:extend({
  {
    type = "autoplace-control",
    name = "rainbow-ore",
    richness = true,
    order = "a",
    category = "resource"
  }
})

local itemPictures = {
  { size = 64, filename = "__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore.png",   scale = 0.5 },
  { size = 64, filename = "__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore-1.png", scale = 0.5 },
  { size = 64, filename = "__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore-2.png", scale = 0.5 },
  { size = 64, filename = "__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore-3.png", scale = 0.5 },
}

-- Create Item
data:extend({
  {
    type = "item",
    name = "rainbow-ore",
    icon = "__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "a",
    stack_size = 50,
    pictures = itemPictures,
    weight = 2000 -- For rocket silo, 2kg
  }
})

-- Create Map Ore
data:extend({
  -- Ore
  {
    type="resource",
    name="rainbow-ore",
    icons={{icon="__rainbowore__/graphics/icons/rainbow-ore/rainbow-ore.png", icon_size=64}},
    order="a",
    map_color = {r = 0.730, g = 0.333, b = 0.827},
    minable = {
      mining_particle = "rainbow-ore-particle",
      mining_time = 1,
      result = "rainbow-ore"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "rainbow-ore",
      order = "z",
      base_density = 10,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 1.1,
      starting_rq_factor_multiplier = 1.5,
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages = {
      sheet =
      {
        filename = "__rainbowore__/graphics/entity/rainbow-ore/hr-rainbow-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
      },
    localised_name = "Rainbow ore"
  },
  -- Particle
  {
    type = "optimized-particle",
    name = "rainbow-ore-particle",
    life_time = 180,
    pictures =
    {
      {
        filename = "__rainbowore__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-1.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__rainbowore__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-2.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__rainbowore__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-3.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__rainbowore__/graphics/particle/rainbow-ore-particle/hr-rainbow-ore-particle-4.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      }
    },
    shadows =
    {
      {
        filename = "__rainbowore__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-1.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__rainbowore__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-2.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__rainbowore__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-3.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      },
      {
        filename = "__rainbowore__/graphics/particle/generic-ore-particle/hr-generic-ore-particle-shadow-4.png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      }
    }
  }
})

-- Add to planet
data.raw.planet.nauvis.map_gen_settings.autoplace_controls["rainbow-ore"] = {}
data.raw.planet.nauvis.map_gen_settings.autoplace_settings.entity.settings["rainbow-ore"] = {}