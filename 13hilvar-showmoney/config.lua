Config = {}

-- Display Settings
Config.UpdateInterval = 1000 -- How often to check for money updates (in milliseconds)
Config.AnimationDuration = 800 -- Duration of money change animation (in milliseconds)

-- Position Settings (you can adjust these if needed)
Config.Position = {
    top = "20px",
    right = "20px"
}

-- Colors (you can customize these)
Config.Colors = {
    money = "#4ADE80",        -- Green color for money
    background = "rgba(0, 0, 0, 0.8)", -- Background color
    border = "rgba(74, 222, 128, 0.3)", -- Border color
    text = "#FFFFFF"          -- Text color
}

-- Font Settings
Config.Font = {
    family = "Gala Condensed",
    fallback = "Arial Narrow, sans-serif",
    size = "20px",
    weight = "500"
}

-- Display Options
Config.ShowDuringDeath = false -- Hide money display when player is dead
Config.ShowDuringMenus = false -- Hide money display when menus are open
Config.AutoHide = true -- Automatically hide in certain scenarios

-- Debug Mode
Config.Debug = false -- Set to true for debug messages