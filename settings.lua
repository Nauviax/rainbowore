data:extend({
    {
        type = "string-setting",
        name = "rainbow-ore-whitelist",
        setting_type = "startup",
        allow_blank = true,
		auto_trim = true,
        default_value = "iron-ore,copper-ore,coal,stone,uranium-ore,crude-oil", -- Nauvis, vanilla.
    },
    {
        type = "bool-setting",
        name = "rainbow-ore-use-biochamber",
        setting_type = "startup",
        default_value = false,
    }
})