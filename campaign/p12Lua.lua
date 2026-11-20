-- p12Lua.lua  -  Plymouth Mission #12 (Lua)
-- Trigger functions finished by hand (CheckForFail, GiveOre, ExpandAuxBase, EarlyHarass, fgAttack, DoHarrassAttack, SpidersPresent, KidsDead), from the disassembly of p12.dll.
-- Converted by op2dll from p12.dll. With p12Lua.placement.lua (what every difficulty makes alike),
-- this makes the colony's start: what changes with the difficulty, and the beacons the setup rolls.
-- Games run: Easy 151, Normal 151, Hard 151.
-- Coordinates are the in-game status-bar ones (map file tile + 1); a kit's are relative to its start.

-- Beacons rolled each game, alike at every difficulty: `count` of the `spots` (no two alike) with the
-- `kinds` by pick, anywhere in an `area` (x1, y1, x2, y2), or a tile's kind picked from `ways`.
local BEACONS = {
  rolled = {
  },
}

-- By difficulty (players[1].difficulty), for each player: colonists, stores, research, Structure Factory
-- kits by bay, the camera, units on fixed tiles, units each on a tile rolled in its `area`, and a kit of
-- units on a start rolled from `starts` or anywhere in `start_area`; then the tubes, walls and beacons
-- only this difficulty makes.
local DIFFICULTIES = {
  Easy = {
    players = {
      [1] = {
        workers = 48, scientists = 32, kids = 80, food = 3000, ore = 8000, rare_ore = 2000,
        research = { 12000 },
        tech_level = 11,
        kits = { [1] = { "ReinforcedResidence" }, [2] = { "Agridome" }, [3] = { "GuardPost", "EMP" }, [4] = { "GuardPost", "EMP" }, [5] = { "GuardPost", "RPG" } },
        view = { 217, 33 },
        units = {
        },
      },
      [2] = {
        ore = 14000, rare_ore = 3000,
        research = {  },
        tech_level = 12,
        kits = { [2] = { "GuardPost", "AcidCloud" }, [3] = { "GuardPost", "AcidCloud" }, [4] = { "GuardPost", "AcidCloud" }, [5] = { "GuardPost", "AcidCloud" } },
        units = {
        },
      },
      [3] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 232, 36 } }, { "Tube", { 232, 37 } }, { "Tube", { 232, 38 } }, { "Tube", { 253, 20 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 232, 34 } },
      { type = "RobotCommand", player = 1, at = { 236, 34 } },
      { type = "Nursery", player = 1, at = { 239, 34 } },
      { type = "University", player = 1, at = { 242, 34 } },
      { type = "RareOreSmelter", player = 1, at = { 241, 42 } },
      { type = "CommonOreSmelter", player = 1, at = { 241, 25 } },
      { type = "StructureFactory", player = 1, at = { 250, 34 } },
      { type = "ReinforcedResidence", player = 1, at = { 249, 43 } },
      { type = "Agridome", player = 1, at = { 253, 43 } },
      { type = "Agridome", player = 1, at = { 249, 46 } },
      { type = "MedicalCenter", player = 1, at = { 253, 46 } },
      { type = "ReinforcedResidence", player = 1, at = { 249, 25 } },
      { type = "Agridome", player = 1, at = { 253, 25 } },
      { type = "Agridome", player = 1, at = { 249, 22 } },
      { type = "MedicalCenter", player = 1, at = { 253, 22 } },
      { type = "VehicleFactory", player = 1, at = { 220, 35 } },
      { type = "ArachnidFactory", player = 1, at = { 220, 32 } },
      { type = "Garage", player = 1, at = { 219, 29 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 215, 32 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 215, 36 } },
      { type = "Tokamak", player = 1, at = { 255, 4 } },
      { type = "Tokamak", player = 1, at = { 255, 63 } },
      { type = "Spaceport", player = 1, at = { 227, 40 } },
      { type = "AdvancedLab", player = 1, at = { 232, 40 } },
      { type = "StandardLab", player = 1, at = { 249, 29 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 242, 21 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 217, 38 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 217, 38 } },
      { type = "ConVec", direction = "East", player = 1, at = { 247, 40 } },
      { type = "Tokamak", player = 1, at = { 255, 13 } },
      { type = "CommonStorage", player = 1, at = { 241, 30 } },
      { type = "RareStorage", player = 1, at = { 245, 42 } },
      { type = "DIRT", player = 1, at = { 253, 18 } },
      { type = "DIRT", player = 1, at = { 249, 49 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 242, 45 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 45 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 43 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 242, 28 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 28 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 26 } },
      { type = "ConVec", direction = "East", player = 1, at = { 251, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 253, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 253, 35 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 198, 22 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 198, 24 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 200, 23 } },
      { type = "Spider", direction = "East", player = 1, at = { 202, 22 } },
      { type = "Spider", direction = "East", player = 1, at = { 193, 39 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 191, 43 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 193, 41 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 202, 18 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 200, 16 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 191, 41 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 191, 39 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 41 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 39 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "North", player = 1, at = { 244, 33 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "East", player = 1, at = { 193, 43 } },
      { type = "Lynx", weapon = "Supernova", direction = "East", player = 1, at = { 202, 16 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 200, 18 } },
      { type = "Panther", weapon = "ESG", direction = "East", player = 1, at = { 200, 20 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 43 } },
      { type = "Tiger", weapon = "ESG", direction = "East", player = 1, at = { 198, 16 } },
      { type = "Tiger", weapon = "Supernova", direction = "East", player = 1, at = { 198, 18 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 215, 27 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 215, 41 } },
      { walls = 1 },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 244, 3 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 244, 61 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 244, 3 } },
      { type = "CommonOreMine", player = 1, at = { 244, 61 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 131, 14 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 130, 60 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 30, 7 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 26, 60 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 16, 34 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 14, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 10, 48 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Mid", at = { 3, 27 }, beacon = true },
      { type = "GeothermalPlant", player = 2, at = { 4, 54 } },
      { type = "GeothermalPlant", player = 2, at = { 19, 3 } },
      { type = "RecreationFacility", player = 2, at = { 52, 26 } },
      { type = "StandardLab", player = 2, at = { 52, 35 } },
      { type = "DIRT", player = 2, at = { 52, 30 } },
      { type = "RobotCommand", player = 2, at = { 65, 40 } },
      { type = "Tokamak", player = 2, at = { 52, 50 } },
      { type = "MedicalCenter", player = 2, at = { 47, 35 } },
      { type = "Tokamak", player = 2, at = { 41, 50 } },
      { type = "Tokamak", player = 2, at = { 37, 50 } },
      { type = "Tokamak", player = 2, at = { 59, 50 } },
      { type = "Tokamak", player = 2, at = { 65, 50 } },
      { type = "AdvancedResidence", player = 2, at = { 59, 26 } },
      { type = "CommonStorage", player = 2, at = { 42, 44 } },
      { type = "CommonStorage", player = 2, at = { 43, 29 } },
      { type = "Agridome", player = 2, at = { 52, 40 } },
      { type = "Agridome", player = 2, at = { 59, 40 } },
      { type = "Agridome", player = 2, at = { 59, 31 } },
      { type = "Nursery", player = 2, at = { 60, 36 } },
      { type = "University", player = 2, at = { 65, 36 } },
      { type = "AdvancedResidence", player = 2, at = { 65, 31 } },
      { type = "CommonStorage", player = 2, at = { 52, 43 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 78, 24 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 72, 12 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 71, 44 } },
      { type = "GuardPost", weapon = "AcidCloud", player = 2, at = { 91, 13 } },
      { type = "VehicleFactory", player = 2, at = { 72, 30 } },
      { type = "StructureFactory", player = 2, at = { 72, 26 } },
      { type = "CommonOreMine", player = 2, at = { 3, 27 } },
      { type = "CommonOreMine", player = 2, at = { 10, 48 } },
      { type = "CommonOreSmelter", player = 2, at = { 42, 40 } },
      { type = "RareOreSmelter", player = 2, at = { 42, 19 } },
      { type = "Garage", player = 2, at = { 71, 37 } },
      { type = "CommandCenter", player = 2, at = { 65, 26 } },
      { type = "Garage", player = 2, at = { 72, 17 } },
      { walls = 2 },
      { type = "ConVec", direction = "East", player = 2, at = { 72, 26 } },
      { type = "VehicleFactory", player = 2, at = { 60, 11 } },
      { type = "StructureFactory", player = 2, at = { 54, 15 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 48, 5 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 42, 10 } },
      { type = "AdvancedLab", player = 2, at = { 53, 5 } },
      { type = "CommonStorage", player = 2, at = { 57, 4 } },
      { type = "CommonStorage", player = 2, at = { 59, 4 } },
      { type = "CommonStorage", player = 2, at = { 54, 19 } },
      { type = "CommonStorage", player = 2, at = { 56, 19 } },
      { type = "CommandCenter", player = 2, at = { 54, 11 } },
      { type = "Spaceport", player = 2, at = { 42, 5 } },
      { walls = 3 },
      { type = "CargoTruck", direction = "East", player = 2, at = { 35, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 18, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 13, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 10, 46 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 39, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 26, 16 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 38, 16 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 40, 21 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 10, 19 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 2, at = { 67, 29 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 2, at = { 87, 41 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 2, at = { 66, 19 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 2, at = { 31, 58 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 2, at = { 50, 39 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 48, scientists = 32, kids = 80, food = 1000, ore = 8000, rare_ore = 2000,
        research = { 12000 },
        tech_level = 11,
        view = { 217, 33 },
        units = {
        },
      },
      [2] = {
        ore = 14000, rare_ore = 3000,
        research = {  },
        tech_level = 12,
        kits = { [2] = { "GuardPost", "AcidCloud" }, [3] = { "GuardPost", "AcidCloud" }, [4] = { "GuardPost", "AcidCloud" }, [5] = { "GuardPost", "AcidCloud" } },
        units = {
        },
      },
      [3] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 241, 29 } }, { "Tube", { 249, 28 } }, { "Tube", { 249, 29 } }, { "Tube", { 249, 30 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 232, 34 } },
      { type = "RobotCommand", player = 1, at = { 236, 34 } },
      { type = "Nursery", player = 1, at = { 239, 34 } },
      { type = "University", player = 1, at = { 242, 34 } },
      { type = "RareOreSmelter", player = 1, at = { 241, 42 } },
      { type = "CommonOreSmelter", player = 1, at = { 241, 25 } },
      { type = "StructureFactory", player = 1, at = { 250, 34 } },
      { type = "ReinforcedResidence", player = 1, at = { 249, 43 } },
      { type = "Agridome", player = 1, at = { 253, 43 } },
      { type = "Agridome", player = 1, at = { 249, 46 } },
      { type = "MedicalCenter", player = 1, at = { 253, 46 } },
      { type = "ReinforcedResidence", player = 1, at = { 249, 25 } },
      { type = "Agridome", player = 1, at = { 253, 25 } },
      { type = "Agridome", player = 1, at = { 249, 22 } },
      { type = "MedicalCenter", player = 1, at = { 253, 22 } },
      { type = "VehicleFactory", player = 1, at = { 220, 35 } },
      { type = "ArachnidFactory", player = 1, at = { 220, 32 } },
      { type = "Garage", player = 1, at = { 219, 29 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 215, 32 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 215, 36 } },
      { type = "Tokamak", player = 1, at = { 255, 4 } },
      { type = "Tokamak", player = 1, at = { 255, 63 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 242, 45 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 45 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 43 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 242, 28 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 28 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 26 } },
      { type = "ConVec", direction = "East", player = 1, at = { 251, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 253, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 253, 35 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 198, 22 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 198, 24 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 200, 23 } },
      { type = "Spider", direction = "East", player = 1, at = { 202, 22 } },
      { type = "Spider", direction = "East", player = 1, at = { 193, 39 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 191, 43 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 193, 41 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 202, 18 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 200, 16 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 191, 41 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 191, 39 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 41 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 39 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "North", player = 1, at = { 244, 33 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "East", player = 1, at = { 193, 43 } },
      { type = "Lynx", weapon = "Supernova", direction = "East", player = 1, at = { 202, 16 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 200, 18 } },
      { type = "Panther", weapon = "ESG", direction = "East", player = 1, at = { 200, 20 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 43 } },
      { type = "Tiger", weapon = "ESG", direction = "East", player = 1, at = { 198, 16 } },
      { type = "Tiger", weapon = "Supernova", direction = "East", player = 1, at = { 198, 18 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 215, 27 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 215, 41 } },
      { walls = 1 },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 244, 3 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 244, 61 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 131, 14 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 130, 60 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 30, 7 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 26, 60 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 16, 34 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 14, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 10, 48 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Mid", at = { 3, 27 }, beacon = true },
      { type = "GeothermalPlant", player = 2, at = { 4, 54 } },
      { type = "GeothermalPlant", player = 2, at = { 19, 3 } },
      { type = "RecreationFacility", player = 2, at = { 52, 26 } },
      { type = "StandardLab", player = 2, at = { 52, 35 } },
      { type = "DIRT", player = 2, at = { 52, 30 } },
      { type = "RobotCommand", player = 2, at = { 65, 40 } },
      { type = "Tokamak", player = 2, at = { 52, 50 } },
      { type = "MedicalCenter", player = 2, at = { 47, 35 } },
      { type = "Tokamak", player = 2, at = { 41, 50 } },
      { type = "Tokamak", player = 2, at = { 37, 50 } },
      { type = "Tokamak", player = 2, at = { 59, 50 } },
      { type = "Tokamak", player = 2, at = { 65, 50 } },
      { type = "AdvancedResidence", player = 2, at = { 59, 26 } },
      { type = "CommonStorage", player = 2, at = { 42, 44 } },
      { type = "CommonStorage", player = 2, at = { 43, 29 } },
      { type = "Agridome", player = 2, at = { 52, 40 } },
      { type = "Agridome", player = 2, at = { 59, 40 } },
      { type = "Agridome", player = 2, at = { 59, 31 } },
      { type = "Nursery", player = 2, at = { 60, 36 } },
      { type = "University", player = 2, at = { 65, 36 } },
      { type = "AdvancedResidence", player = 2, at = { 65, 31 } },
      { type = "CommonStorage", player = 2, at = { 52, 43 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 78, 24 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 72, 12 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 71, 44 } },
      { type = "GuardPost", weapon = "AcidCloud", player = 2, at = { 91, 13 } },
      { type = "VehicleFactory", player = 2, at = { 72, 30 } },
      { type = "StructureFactory", player = 2, at = { 72, 26 } },
      { type = "CommonOreMine", player = 2, at = { 3, 27 } },
      { type = "CommonOreMine", player = 2, at = { 10, 48 } },
      { type = "CommonOreSmelter", player = 2, at = { 42, 40 } },
      { type = "RareOreSmelter", player = 2, at = { 42, 19 } },
      { type = "Garage", player = 2, at = { 71, 37 } },
      { type = "CommandCenter", player = 2, at = { 65, 26 } },
      { type = "Garage", player = 2, at = { 72, 17 } },
      { walls = 2 },
      { type = "ConVec", direction = "East", player = 2, at = { 72, 26 } },
      { type = "VehicleFactory", player = 2, at = { 60, 11 } },
      { type = "StructureFactory", player = 2, at = { 54, 15 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 48, 5 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 42, 10 } },
      { type = "AdvancedLab", player = 2, at = { 53, 5 } },
      { type = "CommonStorage", player = 2, at = { 57, 4 } },
      { type = "CommonStorage", player = 2, at = { 59, 4 } },
      { type = "CommonStorage", player = 2, at = { 54, 19 } },
      { type = "CommonStorage", player = 2, at = { 56, 19 } },
      { type = "CommandCenter", player = 2, at = { 54, 11 } },
      { type = "Spaceport", player = 2, at = { 42, 5 } },
      { walls = 3 },
      { type = "CargoTruck", direction = "East", player = 2, at = { 35, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 18, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 13, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 10, 46 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 39, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 26, 16 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 38, 16 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 40, 21 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 10, 19 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 2, at = { 63, 39 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 2, at = { 67, 29 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 2, at = { 87, 41 } },
      { type = "Panther", weapon = "AcidCloud", direction = "East", player = 2, at = { 10, 59 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "East", player = 2, at = { 66, 19 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 2, at = { 31, 58 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 2, at = { 21, 29 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 2, at = { 50, 39 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 48, scientists = 32, kids = 80, food = 1000, ore = 8000, rare_ore = 2000,
        research = { 12000 },
        tech_level = 11,
        view = { 217, 33 },
        units = {
        },
      },
      [2] = {
        ore = 14000, rare_ore = 3000,
        research = {  },
        tech_level = 12,
        kits = { [2] = { "GuardPost", "AcidCloud" }, [3] = { "GuardPost", "AcidCloud" }, [4] = { "GuardPost", "AcidCloud" }, [5] = { "GuardPost", "AcidCloud" } },
        units = {
        },
      },
      [3] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 241, 29 } }, { "Tube", { 249, 28 } }, { "Tube", { 249, 29 } }, { "Tube", { 249, 30 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 232, 34 } },
      { type = "RobotCommand", player = 1, at = { 236, 34 } },
      { type = "Nursery", player = 1, at = { 239, 34 } },
      { type = "University", player = 1, at = { 242, 34 } },
      { type = "RareOreSmelter", player = 1, at = { 241, 42 } },
      { type = "CommonOreSmelter", player = 1, at = { 241, 25 } },
      { type = "StructureFactory", player = 1, at = { 250, 34 } },
      { type = "ReinforcedResidence", player = 1, at = { 249, 43 } },
      { type = "Agridome", player = 1, at = { 253, 43 } },
      { type = "Agridome", player = 1, at = { 249, 46 } },
      { type = "MedicalCenter", player = 1, at = { 253, 46 } },
      { type = "ReinforcedResidence", player = 1, at = { 249, 25 } },
      { type = "Agridome", player = 1, at = { 253, 25 } },
      { type = "Agridome", player = 1, at = { 249, 22 } },
      { type = "MedicalCenter", player = 1, at = { 253, 22 } },
      { type = "VehicleFactory", player = 1, at = { 220, 35 } },
      { type = "ArachnidFactory", player = 1, at = { 220, 32 } },
      { type = "Garage", player = 1, at = { 219, 29 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 215, 32 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 215, 36 } },
      { type = "Tokamak", player = 1, at = { 255, 4 } },
      { type = "Tokamak", player = 1, at = { 255, 63 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 242, 45 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 45 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 43 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 242, 28 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 28 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 244, 26 } },
      { type = "ConVec", direction = "East", player = 1, at = { 251, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 253, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 253, 35 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 198, 22 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 198, 24 } },
      { type = "Scorpion", weapon = "EnergyCannon", direction = "East", player = 1, at = { 200, 23 } },
      { type = "Spider", direction = "East", player = 1, at = { 202, 22 } },
      { type = "Spider", direction = "East", player = 1, at = { 193, 39 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 191, 43 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 193, 41 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 202, 18 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 200, 16 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 191, 41 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 191, 39 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 41 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 39 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 244, 33 } },
      { type = "EvacuationTransport", direction = "North", player = 1, at = { 244, 33 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "East", player = 1, at = { 193, 43 } },
      { type = "Lynx", weapon = "Supernova", direction = "East", player = 1, at = { 202, 16 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 200, 18 } },
      { type = "Panther", weapon = "ESG", direction = "East", player = 1, at = { 200, 20 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 189, 43 } },
      { type = "Tiger", weapon = "ESG", direction = "East", player = 1, at = { 198, 16 } },
      { type = "Tiger", weapon = "Supernova", direction = "East", player = 1, at = { 198, 18 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 215, 27 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 215, 41 } },
      { walls = 1 },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 244, 3 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 244, 61 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 131, 14 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 130, 60 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 30, 7 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 26, 60 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 16, 34 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 14, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 10, 48 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Mid", at = { 3, 27 }, beacon = true },
      { type = "GeothermalPlant", player = 2, at = { 4, 54 } },
      { type = "GeothermalPlant", player = 2, at = { 19, 3 } },
      { type = "RecreationFacility", player = 2, at = { 52, 26 } },
      { type = "StandardLab", player = 2, at = { 52, 35 } },
      { type = "DIRT", player = 2, at = { 52, 30 } },
      { type = "RobotCommand", player = 2, at = { 65, 40 } },
      { type = "Tokamak", player = 2, at = { 52, 50 } },
      { type = "MedicalCenter", player = 2, at = { 47, 35 } },
      { type = "Tokamak", player = 2, at = { 41, 50 } },
      { type = "Tokamak", player = 2, at = { 37, 50 } },
      { type = "Tokamak", player = 2, at = { 59, 50 } },
      { type = "Tokamak", player = 2, at = { 65, 50 } },
      { type = "AdvancedResidence", player = 2, at = { 59, 26 } },
      { type = "CommonStorage", player = 2, at = { 42, 44 } },
      { type = "CommonStorage", player = 2, at = { 43, 29 } },
      { type = "Agridome", player = 2, at = { 52, 40 } },
      { type = "Agridome", player = 2, at = { 59, 40 } },
      { type = "Agridome", player = 2, at = { 59, 31 } },
      { type = "Nursery", player = 2, at = { 60, 36 } },
      { type = "University", player = 2, at = { 65, 36 } },
      { type = "AdvancedResidence", player = 2, at = { 65, 31 } },
      { type = "CommonStorage", player = 2, at = { 52, 43 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 78, 24 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 72, 12 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 71, 44 } },
      { type = "GuardPost", weapon = "AcidCloud", player = 2, at = { 91, 13 } },
      { type = "VehicleFactory", player = 2, at = { 72, 30 } },
      { type = "StructureFactory", player = 2, at = { 72, 26 } },
      { type = "CommonOreMine", player = 2, at = { 3, 27 } },
      { type = "CommonOreMine", player = 2, at = { 10, 48 } },
      { type = "CommonOreSmelter", player = 2, at = { 42, 40 } },
      { type = "RareOreSmelter", player = 2, at = { 42, 19 } },
      { type = "Garage", player = 2, at = { 71, 37 } },
      { type = "CommandCenter", player = 2, at = { 65, 26 } },
      { type = "Garage", player = 2, at = { 72, 17 } },
      { walls = 2 },
      { type = "ConVec", direction = "East", player = 2, at = { 72, 26 } },
      { type = "VehicleFactory", player = 2, at = { 60, 11 } },
      { type = "StructureFactory", player = 2, at = { 54, 15 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 48, 5 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 42, 10 } },
      { type = "AdvancedLab", player = 2, at = { 53, 5 } },
      { type = "CommonStorage", player = 2, at = { 57, 4 } },
      { type = "CommonStorage", player = 2, at = { 59, 4 } },
      { type = "CommonStorage", player = 2, at = { 54, 19 } },
      { type = "CommonStorage", player = 2, at = { 56, 19 } },
      { type = "CommandCenter", player = 2, at = { 54, 11 } },
      { type = "Spaceport", player = 2, at = { 42, 5 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 60, 18 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 2, at = { 37, 13 } },
      { walls = 3 },
      { type = "CargoTruck", direction = "East", player = 2, at = { 35, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 18, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 13, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 10, 46 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 39, 44 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 26, 16 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 38, 16 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 40, 21 } },
      { type = "CargoTruck", direction = "East", player = 2, at = { 10, 19 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 2, at = { 63, 39 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 2, at = { 67, 29 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 2, at = { 87, 41 } },
      { type = "Panther", weapon = "AcidCloud", direction = "East", player = 2, at = { 10, 59 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "East", player = 2, at = { 66, 19 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 2, at = { 31, 58 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 2, at = { 21, 29 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 2, at = { 50, 39 } },
    },
    beacons = {
    },
  },
}

local kits_set = false
local function make_unit(player, u, at, kits, exact)
  local made = game.create_unit{ type = u.type, player = player, at = at, direction = u.direction,
                                 weapon = u.weapon, lights = u.lights, exact = exact }
  if u.cargo and made[1] then made[1]:set_cargo(u.cargo, u.amount) end
  -- A ConVec's kit with its weapon (a Guard Post kit's).
  if u.topping and made[1] then made[1]:set_kit(u.weapon, u.topping) end
  -- A vehicle the setup parks in a Garage: its bay, by the Garage's dock.
  if u.garage and made[1] then made[1]:put_in_garage(u.garage.bay, u.garage.at) end
  if u.type == "StructureFactory" and kits and made[1] then
    for bay, kit in pairs(kits) do made[1]:set_factory_cargo(bay, kit[1], kit[2]) end
    kits_set = true
  end
end

-- One player's start at the chosen difficulty.
function make_player(player, p)
  if p.tech_level then player:set_tech_level(p.tech_level) end
  for _, tech in ipairs(p.research) do player:mark_research(tech) end
  -- Only the numbers the setup sets.
  for _, k in ipairs({ "ore", "rare_ore", "food", "workers", "scientists", "kids" }) do
    if p[k] then player[k] = p[k] end
  end
  for _, u in ipairs(p.units) do make_unit(player, u, u.at, p.kits, true) end
  -- As the setup draws them: the game's own MAP_RECT::RandPt.
  for _, u in ipairs(p.rolled or {}) do make_unit(player, u, game.rand_point(u.area), p.kits, true) end
  local start = p.starts and p.starts[game.rand(#p.starts) + 1]
  local s = p.start_area
  -- A start drawn in a row or a column draws only along it (CPS2: one GetRand(91) for x).
  local function along(lo, hi) return hi > lo and lo + game.rand(hi - lo + 1) or lo end
  if s then start = { along(s[1], s[3]), along(s[2], s[4]) } end
  local function place(t) return start and { start[1] + t[1], start[2] + t[2] } or t end
  -- The original asks for every unit of a kit on one tile; the game finds each a place nearby.
  for _, u in ipairs(p.kit or {}) do make_unit(player, u, place(u.at), p.kits, false) end
  -- A Structure Factory alike at every difficulty is the placement's; its bays are the difficulty's (Eden 1).
  if p.kits and not kits_set then
    local f = player:buildings("StructureFactory")[1]
    if f then
      for bay, kit in pairs(p.kits) do f:set_factory_cargo(bay, kit[1], kit[2]) end
    end
  end
  kits_set = false
  if p.view then player:center_view(place(p.view)) end
end

function make_walls(walls)
  for _, w in ipairs(walls) do
    if w[1] == "Tube" then game.create_tube(w[2]) else game.create_wall(w[1], w[2]) end
  end
end

function make_things(d)
  make_walls(d.walls)
  for _, b in ipairs(d.beacons) do game.create_beacon(b) end
end

local function copy(t)
  local c = {}
  for k, v in pairs(t) do c[k] = v end
  return c
end

-- The difficulty's units and beacons in the order the original makes them; `roll = k` rolls the k-th of `rolled`.
function make_in_order(d, rolled)
  for _, t in ipairs(d.made or {}) do
    if t.walls then
      make_setup_walls(t.walls)
    elseif t.roll then
      roll_beacons({ rolled[t.roll] })
    elseif t.beacon then
      local b = copy(t)
      b.beacon = nil
      game.create_beacon(b)
    else
      make_unit(players[t.player], t, t.at, d.players[t.player] and d.players[t.player].kits, true)
    end
  end
end

function roll_beacons(rolled)
  for _, r in ipairs(rolled) do
    if r.table then
      -- As the setup draws them: an index into its table, again while it repeats one; all picks, then the beacons.
      local picks, seen = {}, {}
      while #picks < r.count do
        local v = game.rand(#r.table)
        if not seen[v] then seen[v] = true picks[#picks + 1] = v end
      end
      for i, v in ipairs(picks) do
        local b = copy(r.kinds[i])
        b.at = r.table[v + 1]
        game.create_beacon(b)
      end
    elseif r.spots then
      local spots = {}
      for i, s in ipairs(r.spots) do spots[i] = s end
      for i = 1, r.count do
        local b = copy(r.kinds[i])
        b.at = table.remove(spots, game.rand(#spots) + 1)
        game.create_beacon(b)
      end
    elseif r.area then
      local a, b = r.area, copy(r)
      b.area, b.draws, b.x_draw, b.base = nil, nil, nil, nil
      if r.draws then
        -- As the setup draws it: two numbers, one added to the base's x and the other to its y.
        local d = { game.rand(r.draws[1]), game.rand(r.draws[2]) }
        b.at = { r.base[1] + d[r.x_draw], r.base[2] + d[3 - r.x_draw] }
      else
        b.at = { a[1] + game.rand(a[3] - a[1] + 1), a[2] + game.rand(a[4] - a[2] + 1) }
      end
      game.create_beacon(b)
    else
      game.create_beacon(r.ways[game.rand(#r.ways) + 1])
    end
  end
end

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function BringInKids(t) end
function RLVTaken(t) end


-- The triggers CheckForFail reads (0x1101314C, 0x11013148): the Rare and Common Metals cargoes.
local t22, t24
-- The computer player (Player[1]), its two bases (0x11013100, 0x11013104) and fight groups (0x11013108 to
-- 0x11013118): a guard, its escort, a raid on Structure Factories, its escort, and the attackers EarlyHarass's and
-- DoHarrassAttack's units join.
local ai_player, base_main, base_aux
local fight_guard, fight_escort, fight_raid, fight_raid_escort, fight_attack
-- The harassment's time triggers: Easy's and Normal's EarlyHarass (0x11013128) and the wait (0x11013120), Hard's
-- fgAttack first.
local harass_trigger, harass_wait
-- The computer player's Spaceport with the RLV (0x11013150), its Spider special target (0x11013134), the KidsDead
-- trigger (0x11013140), the RLV win's trigger (0x1101312C) and TryCapture's (0x11013130).
local rlv_spaceport, spider_trigger, kids_trigger, capture_trigger
local t17

-- Where fgAttack and DoHarrassAttack send the attackers (0x11013030, 0x110130C8, 0x110130D8), by a draw of 5.
local HARASS_RECTS = { { 194, 21, 204, 36 }, { 194, 21, 204, 36 }, { 194, 21, 204, 36 }, { 207, 3, 219, 9 }, { 183, 40, 202, 44 } }
-- The setup's walls and tubes, in its order, at the three points it makes them (0x11003980 on): before the beacons and
-- MainBaseFluff (made first in the placement, the ones by the Tokamaks would push one aside), after the main base's
-- units and after the time triggers. op2dll makes the 7 tubes the setup makes after its map edits (which doze those
-- tiles) after on_init's map edits.
local SETUP_WALLS = {
  {
    { "Wall", { 213, 26 } }, { "Wall", { 213, 27 } }, { "Wall", { 213, 28 } }, { "Wall", { 213, 29 } }, { "Wall", { 213, 30 } }, { "Wall", { 213, 31 } },
    { "Wall", { 213, 37 } }, { "Wall", { 213, 38 } }, { "Wall", { 213, 39 } }, { "Wall", { 213, 40 } }, { "Wall", { 213, 41 } }, { "Wall", { 213, 42 } },
    { "Tube", { 222, 32 } }, { "Tube", { 223, 32 } }, { "Tube", { 223, 35 } }, { "Tube", { 224, 32 } }, { "Tube", { 224, 35 } }, { "Tube", { 225, 32 } },
    { "Tube", { 225, 35 } }, { "Tube", { 226, 32 } }, { "Tube", { 226, 35 } }, { "Tube", { 227, 32 } }, { "Tube", { 227, 35 } }, { "Tube", { 228, 32 } },
    { "Tube", { 228, 35 } }, { "Tube", { 229, 32 } }, { "Tube", { 229, 35 } }, { "Tube", { 230, 32 } }, { "Tube", { 230, 35 } }, { "Tube", { 231, 32 } },
    { "Tube", { 241, 28 } }, { "Tube", { 241, 30 } }, { "Tube", { 241, 31 } }, { "Tube", { 241, 32 } }, { "Tube", { 242, 36 } }, { "Tube", { 242, 37 } },
    { "Tube", { 242, 38 } }, { "Tube", { 242, 39 } }, { "Tube", { 242, 40 } }, { "Tube", { 244, 25 } }, { "Tube", { 244, 42 } }, { "Tube", { 245, 25 } },
    { "Tube", { 245, 34 } }, { "Tube", { 245, 42 } }, { "Tube", { 246, 25 } }, { "Tube", { 246, 34 } }, { "Tube", { 246, 42 } }, { "Tube", { 247, 25 } },
    { "Tube", { 247, 34 } }, { "Tube", { 247, 42 } }, { "Tube", { 249, 27 } }, { "Tube", { 249, 31 } }, { "Tube", { 249, 32 } }, { "Tube", { 250, 37 } },
    { "Tube", { 250, 38 } }, { "Tube", { 250, 39 } }, { "Tube", { 250, 40 } }, { "Tube", { 250, 41 } }
  },
  {
    { "Wall", { 34, 47 } }, { "Wall", { 34, 48 } }, { "Wall", { 34, 49 } }, { "Wall", { 34, 50 } }, { "Wall", { 34, 51 } }, { "Wall", { 34, 52 } },
    { "Wall", { 35, 47 } }, { "Wall", { 35, 51 } }, { "Wall", { 35, 52 } }, { "Wall", { 36, 47 } }, { "Wall", { 36, 52 } }, { "Wall", { 37, 47 } },
    { "Wall", { 37, 52 } }, { "Wall", { 38, 52 } }, { "Wall", { 39, 1 } }, { "Wall", { 39, 52 } }, { "Wall", { 40, 1 } }, { "Wall", { 40, 10 } },
    { "Wall", { 40, 11 } }, { "Wall", { 40, 12 } }, { "Wall", { 40, 47 } }, { "Wall", { 40, 52 } }, { "Wall", { 41, 1 } }, { "Wall", { 41, 12 } },
    { "Wall", { 41, 47 } }, { "Wall", { 41, 52 } }, { "Wall", { 42, 1 } }, { "Tube", { 42, 8 } }, { "Tube", { 42, 9 } }, { "Wall", { 42, 12 } },
    { "Tube", { 42, 45 } }, { "Wall", { 42, 47 } }, { "Wall", { 42, 52 } }, { "Wall", { 43, 1 } }, { "Wall", { 43, 12 } }, { "Tube", { 43, 30 } },
    { "Tube", { 43, 44 } }, { "Wall", { 43, 47 } }, { "Wall", { 43, 48 } }, { "Wall", { 43, 49 } }, { "Wall", { 43, 50 } }, { "Wall", { 43, 51 } },
    { "Wall", { 43, 52 } }, { "Wall", { 44, 1 } }, { "Wall", { 44, 12 } }, { "Tube", { 44, 29 } }, { "Wall", { 45, 1 } }, { "Wall", { 45, 12 } },
    { "Tube", { 45, 40 } }, { "Wall", { 46, 1 } }, { "Tube", { 46, 5 } }, { "Wall", { 46, 12 } }, { "Tube", { 46, 25 } }, { "Tube", { 46, 40 } },
    { "Wall", { 47, 1 } }, { "Tube", { 47, 5 } }, { "Wall", { 47, 12 } }, { "Tube", { 47, 25 } }, { "Tube", { 47, 40 } }, { "Wall", { 48, 1 } },
    { "Wall", { 48, 12 } }, { "Tube", { 48, 25 } }, { "Tube", { 48, 40 } }, { "Wall", { 49, 1 } }, { "Wall", { 49, 12 } }, { "Wall", { 49, 13 } },
    { "Wall", { 49, 14 } }, { "Wall", { 49, 15 } }, { "Wall", { 49, 16 } }, { "Wall", { 49, 17 } }, { "Wall", { 49, 18 } }, { "Tube", { 49, 25 } },
    { "Tube", { 49, 35 } }, { "Tube", { 49, 40 } }, { "Wall", { 49, 47 } }, { "Wall", { 49, 48 } }, { "Wall", { 49, 49 } }, { "Wall", { 49, 50 } },
    { "Wall", { 49, 51 } }, { "Wall", { 49, 52 } }, { "Wall", { 50, 1 } }, { "Tube", { 50, 5 } }, { "Wall", { 50, 21 } }, { "Tube", { 50, 25 } },
    { "Tube", { 50, 35 } }, { "Tube", { 50, 40 } }, { "Wall", { 50, 47 } }, { "Wall", { 50, 52 } }, { "Wall", { 51, 1 } }, { "Tube", { 51, 5 } },
    { "Tube", { 51, 10 } }, { "Wall", { 51, 21 } }, { "Wall", { 51, 47 } }, { "Wall", { 51, 52 } }, { "Wall", { 52, 1 } }, { "Tube", { 52, 10 } },
    { "Wall", { 52, 21 } }, { "Tube", { 52, 28 } }, { "Tube", { 52, 32 } }, { "Tube", { 52, 33 } }, { "Tube", { 52, 37 } }, { "Tube", { 52, 38 } },
    { "Tube", { 52, 44 } }, { "Wall", { 52, 47 } }, { "Wall", { 52, 52 } }, { "Wall", { 53, 1 } }, { "Tube", { 53, 8 } }, { "Tube", { 53, 9 } },
    { "Wall", { 53, 21 } }, { "Tube", { 53, 43 } }, { "Wall", { 53, 47 } }, { "Wall", { 53, 52 } }, { "Wall", { 54, 1 } }, { "Tube", { 54, 13 } },
    { "Tube", { 54, 20 } }, { "Wall", { 54, 21 } }, { "Tube", { 54, 26 } }, { "Wall", { 54, 52 } }, { "Wall", { 55, 1 } }, { "Tube", { 55, 19 } },
    { "Wall", { 55, 21 } }, { "Tube", { 55, 26 } }, { "Tube", { 55, 40 } }, { "Wall", { 55, 52 } }, { "Wall", { 56, 1 } }, { "Tube", { 56, 5 } },
    { "Tube", { 56, 20 } }, { "Wall", { 56, 21 } }, { "Tube", { 56, 26 } }, { "Tube", { 56, 40 } }, { "Wall", { 56, 52 } }, { "Wall", { 57, 1 } },
    { "Tube", { 57, 5 } }, { "Tube", { 57, 11 } }, { "Tube", { 57, 15 } }, { "Tube", { 57, 19 } }, { "Wall", { 57, 21 } }, { "Tube", { 57, 26 } },
    { "Tube", { 57, 40 } }, { "Wall", { 57, 47 } }, { "Wall", { 57, 52 } }, { "Wall", { 58, 1 } }, { "Tube", { 58, 4 } }, { "Tube", { 58, 15 } },
    { "Wall", { 58, 21 } }, { "Wall", { 58, 47 } }, { "Wall", { 58, 52 } }, { "Wall", { 59, 1 } }, { "Tube", { 59, 5 } }, { "Tube", { 59, 15 } },
    { "Tube", { 59, 16 } }, { "Tube", { 59, 17 } }, { "Tube", { 59, 18 } }, { "Tube", { 59, 19 } }, { "Tube", { 59, 20 } }, { "Tube", { 59, 21 } },
    { "Tube", { 59, 22 } }, { "Tube", { 59, 23 } }, { "Tube", { 59, 24 } }, { "Tube", { 59, 29 } }, { "Tube", { 59, 33 } }, { "Tube", { 59, 34 } },
    { "Wall", { 59, 47 } }, { "Wall", { 59, 52 } }, { "Wall", { 60, 1 } }, { "Tube", { 60, 4 } }, { "Tube", { 60, 38 } }, { "Wall", { 60, 47 } },
    { "Wall", { 60, 52 } }, { "Wall", { 61, 1 } }, { "Wall", { 61, 47 } }, { "Wall", { 61, 52 } }, { "Wall", { 62, 1 } }, { "Tube", { 62, 26 } },
    { "Tube", { 62, 36 } }, { "Wall", { 62, 47 } }, { "Wall", { 62, 52 } }, { "Wall", { 63, 1 } }, { "Wall", { 63, 21 } }, { "Tube", { 63, 26 } },
    { "Tube", { 63, 36 } }, { "Wall", { 63, 47 } }, { "Wall", { 63, 52 } }, { "Wall", { 64, 1 } }, { "Wall", { 64, 21 } }, { "Wall", { 64, 47 } },
    { "Wall", { 64, 52 } }, { "Wall", { 65, 1 } }, { "Wall", { 65, 21 } }, { "Tube", { 65, 28 } }, { "Tube", { 65, 29 } }, { "Tube", { 65, 34 } },
    { "Tube", { 65, 38 } }, { "Wall", { 65, 47 } }, { "Wall", { 65, 52 } }, { "Wall", { 66, 1 } }, { "Wall", { 66, 21 } }, { "Wall", { 66, 47 } },
    { "Wall", { 66, 52 } }, { "Wall", { 67, 1 } }, { "Wall", { 67, 21 } }, { "Tube", { 67, 36 } }, { "Wall", { 67, 47 } }, { "Wall", { 67, 48 } },
    { "Wall", { 67, 49 } }, { "Wall", { 67, 50 } }, { "Wall", { 67, 51 } }, { "Wall", { 67, 52 } }, { "Wall", { 68, 1 } }, { "Wall", { 68, 21 } },
    { "Tube", { 68, 26 } }, { "Tube", { 68, 36 } }, { "Wall", { 69, 1 } }, { "Wall", { 69, 21 } }, { "Tube", { 69, 26 } }, { "Tube", { 69, 36 } },
    { "Wall", { 70, 1 } }, { "Wall", { 70, 21 } }, { "Wall", { 70, 46 } }, { "Wall", { 71, 1 } }, { "Wall", { 71, 21 } }, { "Tube", { 71, 38 } },
    { "Tube", { 71, 39 } }, { "Tube", { 71, 40 } }, { "Tube", { 71, 41 } }, { "Tube", { 71, 42 } }, { "Tube", { 71, 43 } }, { "Wall", { 71, 46 } },
    { "Wall", { 72, 1 } }, { "Wall", { 72, 2 } }, { "Wall", { 72, 3 } }, { "Wall", { 72, 4 } }, { "Wall", { 72, 5 } }, { "Wall", { 72, 6 } },
    { "Wall", { 72, 7 } }, { "Wall", { 72, 8 } }, { "Wall", { 72, 9 } }, { "Wall", { 72, 10 } }, { "Tube", { 72, 14 } }, { "Tube", { 72, 15 } },
    { "Tube", { 72, 18 } }, { "Tube", { 72, 19 } }, { "Tube", { 72, 20 } }, { "Tube", { 72, 21 } }, { "Tube", { 72, 22 } }, { "Tube", { 72, 23 } },
    { "Tube", { 72, 24 } }, { "Tube", { 72, 33 } }, { "Tube", { 72, 34 } }, { "Tube", { 72, 35 } }, { "Wall", { 72, 46 } }, { "Wall", { 73, 46 } },
    { "Wall", { 74, 9 } }, { "Wall", { 74, 10 } }, { "Wall", { 74, 12 } }, { "Wall", { 74, 44 } }, { "Wall", { 75, 10 } }, { "Wall", { 75, 12 } },
    { "Wall", { 75, 44 } }, { "Wall", { 76, 12 } }, { "Wall", { 76, 44 } }, { "Wall", { 77, 12 } }, { "Wall", { 77, 44 } }, { "Wall", { 78, 12 } },
    { "Wall", { 78, 13 } }, { "Wall", { 78, 14 } }, { "Wall", { 78, 15 } }, { "Wall", { 78, 16 } }, { "Wall", { 78, 17 } }, { "Wall", { 78, 18 } },
    { "Wall", { 78, 19 } }, { "Wall", { 78, 20 } }, { "Wall", { 78, 21 } }, { "Wall", { 78, 22 } }, { "Wall", { 78, 27 } }, { "Wall", { 78, 28 } },
    { "Wall", { 78, 29 } }, { "Wall", { 78, 30 } }, { "Wall", { 78, 31 } }, { "Wall", { 78, 32 } }, { "Wall", { 78, 33 } }, { "Wall", { 78, 34 } },
    { "Wall", { 78, 35 } }, { "Wall", { 78, 36 } }, { "Wall", { 78, 37 } }, { "Wall", { 78, 38 } }, { "Wall", { 78, 39 } }, { "Wall", { 78, 40 } },
    { "Wall", { 78, 41 } }, { "Wall", { 78, 42 } }, { "Wall", { 78, 43 } }, { "Wall", { 78, 44 } }, { "Wall", { 80, 22 } }, { "Wall", { 80, 23 } },
    { "Wall", { 80, 25 } }, { "Wall", { 80, 27 } }
  },
  {
    { "Wall", { 72, 63 } }, { "Wall", { 73, 63 } }, { "Wall", { 74, 63 } }, { "Wall", { 87, 28 } }, { "Wall", { 87, 31 } }, { "Wall", { 87, 36 } },
    { "Wall", { 87, 39 } }, { "Wall", { 87, 42 } }, { "Wall", { 87, 44 } }, { "Wall", { 87, 45 } }, { "Wall", { 87, 46 } }, { "Wall", { 87, 47 } },
    { "Wall", { 87, 48 } }, { "Wall", { 87, 49 } }, { "Wall", { 87, 50 } }, { "Wall", { 87, 51 } }, { "Wall", { 88, 22 } }, { "Wall", { 88, 23 } },
    { "Wall", { 88, 24 } }, { "Wall", { 88, 25 } }, { "Wall", { 88, 26 } }, { "Wall", { 88, 27 } }, { "Wall", { 88, 28 } }, { "Wall", { 88, 31 } },
    { "Wall", { 88, 32 } }, { "Wall", { 88, 33 } }, { "Wall", { 88, 34 } }, { "Wall", { 88, 35 } }, { "Wall", { 88, 36 } }, { "Wall", { 88, 37 } },
    { "Wall", { 88, 38 } }, { "Wall", { 88, 39 } }, { "Wall", { 88, 42 } }, { "Wall", { 88, 43 } }, { "Wall", { 88, 44 } }, { "Wall", { 89, 8 } },
    { "Wall", { 89, 11 } }, { "Wall", { 90, 8 } }, { "Wall", { 90, 11 } }, { "Wall", { 91, 11 } }, { "Wall", { 92, 3 } }, { "Wall", { 92, 4 } },
    { "Wall", { 92, 5 } }, { "Wall", { 92, 6 } }, { "Wall", { 92, 7 } }, { "Wall", { 92, 8 } }, { "Wall", { 91, 8 } }, { "Wall", { 92, 11 } },
    { "Wall", { 93, 1 } }, { "Wall", { 93, 2 } }, { "Wall", { 93, 3 } }, { "Wall", { 93, 11 } }, { "Wall", { 93, 12 } }, { "Wall", { 93, 13 } },
    { "Wall", { 93, 14 } }
  },
}
function make_setup_walls(i)
  for _, w in ipairs(SETUP_WALLS[i]) do
    if w[1] == "Tube" then game.create_tube(w[2]) else game.create_wall(w[1], w[2]) end
  end
end
-- The setup's unit blocks (`op2dll disasm --block`): MainBase, MainBaseFluff, InitialTowers, AuxBase, AuxBaseBuild,
-- AuxBaseBuildTowers, StartCommTrucks, StartRareTrucks, Normal's and Easy's starting fighters and guards.
local AI_BLOCKS = {
  main = {
    { type = "StructureFactory", at = { 72, 26 } }, { type = "VehicleFactory", at = { 72, 30 } },
    { type = "CommandCenter", at = { 65, 26 } }, { type = "Garage", at = { 71, 37 } }, { type = "Garage", at = { 72, 17 } },
    { type = "CommonOreSmelter", at = { 42, 40 } }, { type = "RareOreSmelter", at = { 42, 19 } },
    { type = "CommonOreMine", at = { 3, 27 } }, { type = "CommonOreMine", at = { 10, 48 } },
  },
  fluff = {
    { type = "AdvancedResidence", at = { 59, 26 } }, { type = "RobotCommand", at = { 65, 40 } },
    { type = "CommonStorage", at = { 52, 43 } }, { type = "CommonStorage", at = { 43, 29 } },
    { type = "CommonStorage", at = { 42, 44 } }, { type = "AdvancedResidence", at = { 65, 31 } },
    { type = "University", at = { 65, 36 } }, { type = "Nursery", at = { 60, 36 } }, { type = "Agridome", at = { 59, 31 } },
    { type = "Agridome", at = { 59, 40 } }, { type = "Agridome", at = { 52, 40 } }, { type = "StandardLab", at = { 52, 35 } },
    { type = "DIRT", at = { 52, 30 } }, { type = "RecreationFacility", at = { 52, 26 } }, { type = "Tokamak", at = { 65, 50 } },
    { type = "Tokamak", at = { 59, 50 } }, { type = "Tokamak", at = { 37, 50 } }, { type = "Tokamak", at = { 41, 50 } },
    { type = "MedicalCenter", at = { 47, 35 } }, { type = "Tokamak", at = { 52, 50 } },
    { type = "GuardPost", at = { 78, 24 }, weapon = "ThorsHammer" }, { type = "GuardPost", at = { 72, 12 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 71, 44 }, weapon = "ThorsHammer" }, { type = "GuardPost", at = { 91, 13 }, weapon = "AcidCloud" },
    { type = "GeothermalPlant", at = { 19, 3 } }, { type = "GeothermalPlant", at = { 4, 54 } },
  },
  towers = {
    { type = "GuardPost", at = { 86, 26 }, weapon = "AcidCloud" }, { type = "GuardPost", at = { 86, 37 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 85, 50 }, weapon = "AcidCloud" }, { type = "GuardPost", at = { 90, 5 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 69, 62 }, weapon = "AcidCloud" },
  },
  aux = {
    { type = "GuardPost", at = { 48, 5 }, weapon = "ThorsHammer" }, { type = "GuardPost", at = { 42, 10 }, weapon = "ThorsHammer" },
    { type = "AdvancedLab", at = { 53, 5 } }, { type = "CommandCenter", at = { 54, 11 } },
    { type = "StructureFactory", at = { 54, 15 } }, { type = "VehicleFactory", at = { 60, 11 } },
    { type = "CommonStorage", at = { 57, 4 } }, { type = "CommonStorage", at = { 59, 4 } },
    { type = "CommonStorage", at = { 54, 19 } }, { type = "CommonStorage", at = { 56, 19 } },
  },
  aux_build = {
    { type = "Tokamak", at = { 69, 4 } }, { type = "Observatory", at = { 49, 10 } }, { type = "AdvancedResidence", at = { 64, 11 } },
    { type = "GuardPost", at = { 64, 7 }, weapon = "ThorsHammer" }, { type = "Tokamak", at = { 65, 17 } },
    { type = "MeteorDefense", at = { 46, 10 } },
  },
  aux_towers = {
    { type = "GuardPost", at = { 37, 13 }, weapon = "ThorsHammer" }, { type = "GuardPost", at = { 60, 18 }, weapon = "ThorsHammer" },
  },
  common_trucks = {
    { type = "CargoTruck", at = { 39, 44 } }, { type = "CargoTruck", at = { 35, 44 } }, { type = "CargoTruck", at = { 18, 44 } },
    { type = "CargoTruck", at = { 13, 44 } }, { type = "CargoTruck", at = { 10, 46 } },
  },
  rare_trucks = {
    { type = "CargoTruck", at = { 10, 19 } }, { type = "CargoTruck", at = { 26, 16 } }, { type = "CargoTruck", at = { 38, 16 } },
    { type = "CargoTruck", at = { 41, 20 } },
  },
  fight = {
    { type = "Tiger", at = { 66, 19 }, weapon = "ThorsHammer" }, { type = "Panther", at = { 63, 39 }, weapon = "ThorsHammer" },
    { type = "Panther", at = { 67, 29 }, weapon = "RailGun" }, { type = "Panther", at = { 87, 41 }, weapon = "RailGun" },
    { type = "Panther", at = { 10, 59 }, weapon = "AcidCloud" },
  },
  guard = {
    { type = "Lynx", at = { 50, 39 }, weapon = "EMP" }, { type = "Lynx", at = { 20, 29 }, weapon = "EMP" },
    { type = "Lynx", at = { 30, 59 }, weapon = "RailGun" },
  },
  easy_fight = {
    { type = "Panther", at = { 66, 19 }, weapon = "ThorsHammer" }, { type = "Panther", at = { 67, 29 }, weapon = "RailGun" },
    { type = "Panther", at = { 87, 41 }, weapon = "RailGun" },
  },
  easy_guard = { { type = "Lynx", at = { 50, 39 }, weapon = "EMP" }, { type = "Lynx", at = { 30, 59 }, weapon = "RailGun" } },
}
-- The main base's tubes (0x1100CFF0), after the ones touching 65,26.
local AI_TUBES = {
  { 74, 26 }, { 75, 26 }, { 76, 26 }, { 77, 26 }, { 78, 26 }, { 79, 26 }, { 80, 26 }, { 81, 26 }, { 82, 26 }, { 83, 26 },
  { 84, 26 }, { 85, 26 }, { 84, 27 }, { 84, 28 }, { 84, 29 }, { 84, 30 }, { 84, 31 }, { 84, 32 }, { 84, 33 }, { 84, 34 },
  { 84, 35 }, { 84, 36 }, { 84, 37 }, { 85, 37 }, { 84, 38 }, { 84, 39 }, { 84, 40 }, { 84, 41 }, { 84, 42 }, { 84, 43 },
  { 84, 44 }, { 84, 45 }, { 84, 46 }, { 84, 47 }, { 84, 48 }, { 84, 49 }, { 84, 50 }, { 70, 51 }, { 71, 51 }, { 72, 51 },
  { 73, 51 }, { 74, 51 }, { 75, 51 }, { 76, 51 }, { 77, 51 }, { 78, 51 }, { 79, 51 }, { 80, 51 }, { 81, 51 }, { 82, 51 },
  { 83, 51 }, { 84, 51 }, { 70, 52 }, { 70, 53 }, { 70, 54 }, { 70, 55 }, { 70, 56 }, { 70, 57 }, { 70, 58 }, { 70, 59 },
  { 70, 60 }, { 70, 61 }, { 84, 5 }, { 85, 5 }, { 86, 5 }, { 87, 5 }, { 88, 5 }, { 89, 5 }, { 84, 6 }, { 84, 7 },
  { 84, 8 }, { 84, 9 }, { 84, 10 }, { 84, 11 }, { 84, 12 }, { 84, 13 }, { 85, 13 }, { 86, 13 }, { 87, 13 }, { 88, 13 },
  { 89, 13 }, { 90, 13 }, { 84, 14 }, { 84, 15 }, { 84, 16 }, { 84, 17 }, { 84, 18 }, { 84, 19 }, { 84, 20 }, { 84, 21 },
  { 84, 22 }, { 84, 23 }, { 84, 24 }, { 84, 25 },
}
local ai_unit_blocks = {}
local function ai_unit_block(name)
  ai_unit_blocks[name] = ai_unit_blocks[name] or ai.unit_block(AI_BLOCKS[name])
  return ai_unit_blocks[name]
end
-- op2dll makes the units the setup's AddUnits and CreateUnit make; the groups take them where they stand (the game
-- may have put a vehicle a tile or two off its block's). `look` finds a unit without taking it, taken or not (the
-- mining groups' mines and smelters are the main base's).
local taken = {}
local function find_unit(kind, at, look)
  for r = 0, 2 do
    for _, u in ipairs(game.units_in_rect({ at[1] - r, at[2] - r, at[1] + r, at[2] + r })) do
      if u.owner == 1 and u.type == kind and (look or not taken[u.id]) then
        if not look then taken[u.id] = true end
        return u
      end
    end
  end
end
-- A group takes a block's units in the order the game made them (their ids), as AddUnits adds each one it makes:
-- a mining group hands out its trucks' routes, and a fight group its units' places, in that order.
local function take_block(group, name)
  local found = {}
  for _, r in ipairs(AI_BLOCKS[name]) do
    local u = find_unit(r.type, r.at)
    if u then found[#found + 1] = u end
  end
  table.sort(found, function(a, b) return a.id < b.id end)
  for _, u in ipairs(found) do group:take_unit(u) end
end

-- The bases (0x11003980 to the time triggers): the main one at 37,22 - 73,45 builds its ConVecs, Repair Vehicle and
-- Earthworker, keeps its tubes and has Guard Post (Acid Cloud) kits in its Structure Factory; the second at 39,2 -
-- 65,14 has the Spaceport with the RLV.
local function setup_ai_bases(difficulty)
  ai_player = players[2]
  base_main = ai.building_group(ai_player)
  base_main:set_rect({ 37, 22, 73, 45 })
  take_block(base_main, "main")
  base_main:record_unit_block(ai_unit_block("main"), base_main)
  base_main:record_unit_block(ai_unit_block("fluff"))
  base_main:record_unit_block(ai_unit_block("towers"))
  base_main:record_veh_reinforce_group(base_main, 1000)
  base_main:set_targ_count("ConVec", nil, 2)
  base_main:set_targ_count("RepairVehicle", nil, 1)
  base_main:set_targ_count("Earthworker", nil, 1)
  base_main:record_tubes_touching({ 65, 26 })
  for _, at in ipairs(AI_TUBES) do base_main:record_tube(at) end
  local convec = find_unit("ConVec", { 72, 26 })
  if convec then base_main:take_unit(convec) end
  -- Only the main base's Structure Factory has the kits (op2dll's start loads both).
  local aux_factory = find_unit("StructureFactory", { 54, 15 }, true)
  if aux_factory then
    for bay = 2, 5 do aux_factory:set_factory_cargo(bay, "None") end
  end
  base_aux = ai.building_group(ai_player)
  base_aux:set_rect({ 39, 2, 65, 14 })
  take_block(base_aux, "aux")
  local spaceport = find_unit("Spaceport", { 42, 5 })
  rlv_spaceport = spaceport
  if spaceport then
    base_aux:take_unit(spaceport)
    spaceport:set_factory_cargo(1, "RLV")
  end
  base_aux:record_unit_block(ai_unit_block("aux"), base_aux)
  base_aux:record_unit_block(ai_unit_block("aux_build"))
  base_aux:record_unit_block(ai_unit_block("aux_towers"))
  if difficulty == "Hard" then take_block(base_aux, "aux_towers") end
  base_aux:record_veh_reinforce_group(base_aux, 1000)
  base_aux:set_targ_count("ConVec", nil, 2)
end

-- After the time triggers: the two mining groups, the five fight groups (all waiting in 33,2 - 81,45) and what the
-- bases build for the guard and its escort, fewer on Easy.
local function setup_ai_army(difficulty)
  local mine1 = ai.mining_group(ai_player)
  take_block(mine1, "common_trucks")
  mine1:setup(find_unit("CommonOreMine", { 10, 48 }, true), find_unit("CommonOreSmelter", { 42, 40 }, true), { 37, 37, 47, 44 })
  local mine2 = ai.mining_group(ai_player)
  take_block(mine2, "rare_trucks")
  mine2:setup(find_unit("RareOreMine", { 3, 27 }, true), find_unit("RareOreSmelter", { 42, 19 }, true), { 38, 16, 47, 22 })
  local AREA = { 33, 2, 81, 45 }
  fight_guard = ai.fight_group(ai_player)
  fight_guard:do_guard_rect()
  fight_guard:set_rect(AREA)
  fight_guard:add_guarded_rect({ 82, 2, 97, 45 })
  fight_guard:add_guarded_rect({ 29, 45, 83, 64 })
  fight_escort = ai.fight_group(ai_player)
  fight_escort:do_guard_group()
  fight_escort:set_target_group(fight_guard)
  fight_escort:set_rect(AREA)
  fight_escort:set_follow_mode(0)
  fight_raid = ai.fight_group(ai_player)
  fight_raid:do_attack_enemy()
  fight_raid:set_attack_type("StructureFactory")
  fight_raid:set_rect(AREA)
  fight_raid_escort = ai.fight_group(ai_player)
  fight_raid_escort:do_guard_group()
  fight_raid_escort:set_target_group(fight_raid)
  fight_raid_escort:set_rect(AREA)
  fight_raid_escort:set_follow_mode(1)
  fight_attack = ai.fight_group(ai_player)
  fight_attack:do_attack_enemy()
  fight_attack:set_rect(AREA)
  base_main:record_veh_reinforce_group(fight_guard, 10)
  base_main:record_veh_reinforce_group(fight_escort, 5)
  base_aux:record_veh_reinforce_group(fight_guard, 10)
  base_aux:record_veh_reinforce_group(fight_escort, 5)
  local easy = difficulty == "Easy"
  for _, w in ipairs({ "ThorsHammer", "RailGun", "AcidCloud", "Laser" }) do fight_guard:set_targ_count("Tiger", w, 2) end
  for _, w in ipairs({ "ThorsHammer", "RailGun", "AcidCloud", "Laser" }) do fight_guard:set_targ_count("Panther", w, easy and 2 or 6) end
  take_block(fight_guard, easy and "easy_fight" or "fight")
  local lynx = easy and { 1, 2, 2, 1, 1 } or { 3, 6, 4, 3, 3 }
  for i, w in ipairs({ "ThorsHammer", "EMP", "AcidCloud", "Laser", "RailGun" }) do fight_escort:set_targ_count("Lynx", w, lynx[i]) end
  take_block(fight_escort, easy and "easy_guard" or "guard")
end

-- The guard and its escort send units to the attackers: each with a draw of `n`, moved when it is below `below`.
local function send_units(n, below)
  for _, g in ipairs({ { fight_guard, n[1] }, { fight_escort, n[2] } }) do
    for _, u in ipairs(g[1]:units()) do
      if game.rand(g[2]) < below then
        g[1]:remove_unit(u)
        fight_attack:take_unit(u)
      end
    end
  end
end
local function harass_rect()
  fight_attack:set_rect(HARASS_RECTS[game.rand(5) + 1])
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Meteor, Microbe, Storm, Tornado, TornadoStart

function Meteor(t)
  local r1 = game.rand(56)
  local r2 = game.rand(190)
  game.create_meteor({ r2 + 33, r1 + 3 }, -1)
end

function Microbe(t)
  if players[1].difficulty == "Easy" then
    game.create_blight({ 170, 63 })
    game.create_blight({ 170, 64 })
    game.set_blight_speed(120)
    game.message_at("Microbe growth detected!", 152, 1, 6432, 1984)
  elseif players[1].difficulty == "Normal" then
    game.create_blight({ 170, 63 })
    game.create_blight({ 170, 64 })
    game.set_blight_speed(140)
    game.message_at("Microbe growth detected!", 152, 1, 6432, 1984)
  else
    game.create_blight({ 170, 63 })
    game.create_blight({ 170, 64 })
    game.set_blight_speed(140)
    game.message_at("Microbe growth detected!", 152, 1, 6432, 1984)
  end
end

function Storm(t)
  local r1 = game.rand(4)
  if r1 < 1 then
    local r2 = game.rand(256)
    local r3 = game.rand(63)
    game.create_lightning({ 1, r3 + 2 }, { r2 + 1, 32 }, 1)
  elseif r1 < 2 then
    local r2 = game.rand(63)
    local r3 = game.rand(63)
    game.create_lightning({ 256, r3 + 2 }, { 1, r2 + 1 }, 2)
  else
    local r2 = game.rand(256)
    local r3 = game.rand(256)
    if r1 == 2 then
      game.create_lightning({ r3 + 1, 2 }, { r2 + 1, 64 }, 1)
    else
      game.create_lightning({ r3 + 1, 64 }, { r2 + 1, 2 }, 2)
    end
  end
end

function Tornado(t)
  local r1 = game.rand(4)
  if r1 < 1 then
    local r2 = game.rand(27)
    local r3 = game.rand(40)
    local r4 = game.rand(5)
    game.create_tornado({ r2 + 71, 2 }, { 71, 2 }, r4 + 16)
  elseif r1 < 2 then
    local r2 = game.rand(40)
    local r3 = game.rand(40)
    local r4 = game.rand(5)
    game.create_tornado({ 71, r3 + 2 }, { 71, r3 + 2 }, r4 + 16)
  else
    local r2 = game.rand(54)
    local r3 = game.rand(64)
    local r4 = game.rand(5)
    if r1 == 2 then
      game.create_tornado({ r2 + 159, 2 }, { 180, 2 }, r4 + 16)
    else
      game.create_tornado({ 180, r3 + 2 }, { r2 + 159, r3 + 2 }, r4 + 16)
    end
  end
end

function TornadoStart(t)
  local r1 = game.rand(4)
  if r1 < 1 then
    local r2 = game.rand(27)
    local r3 = game.rand(40)
    local r4 = game.rand(5)
    game.create_tornado({ r2 + 71, 2 }, { 71, 2 }, r4 + 16)
  elseif r1 < 2 then
    local r2 = game.rand(40)
    local r3 = game.rand(40)
    local r4 = game.rand(5)
    game.create_tornado({ 71, r3 + 2 }, { 71, r3 + 2 }, r4 + 16)
  else
    local r2 = game.rand(54)
    local r3 = game.rand(64)
    local r4 = game.rand(5)
    if r1 == 2 then
      game.create_tornado({ r2 + 159, 2 }, { 180, 2 }, r4 + 16)
    else
      game.create_tornado({ 180, r3 + 2 }, { r2 + 159, r3 + 2 }, r4 + 16)
    end
  end
  trigger.time{min = 54000, max = 72000, one_shot = false, on = Tornado}  -- after 540 to 720 marks
end

-- Every 40 ticks (0x110031B0): too few workers (8) or scientists (3), no way to build spacecraft, or a metals cargo
-- not yet sent with no way to mine that ore fails the mission.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  if not p:can_build_space() then fail = true end
  if not t24:has_fired(1) and not p:can_accumulate_ore() then fail = true end
  if not t22:has_fired(1) and not p:can_accumulate_rare_ore() then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Every 20 marks (0x110046F0): the computer player gets 1000 ore a difficulty step (none on Easy) and 250 rare ore.
function GiveOre(t)
  local step = ({ Easy = 0, Normal = 1, Hard = 2 })[players[1].difficulty] or 1
  ai_player.ore = ai_player.ore + 1000 * step
  ai_player.rare_ore = ai_player.rare_ore + 250
end

-- After 100 to 110 marks (0x110046C0): the second base builds its Tokamaks, Observatory, Residence, Meteor Defense and
-- Guard Posts.
function ExpandAuxBase(t)
  base_aux:record_unit_block(ai_unit_block("aux_build"))
  base_aux:record_unit_block(ai_unit_block("aux_towers"))
end

-- Easy and Normal, every 50 to 100 marks (0x11004B30): a new attack group at 37,22 - 73,45 takes each unit of the
-- guard and its escort with a chance of 1 in 5; the next harassment is drawn anew.
function EarlyHarass(t)
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect({ 37, 22, 73, 45 })
  g:set_delete_when_empty(true)
  for _, src in ipairs({ fight_guard, fight_escort }) do
    for _, u in ipairs(src:units()) do
      if game.rand(5) == 0 then
        src:remove_unit(u)
        g:take_unit(u)
      end
    end
  end
  harass_trigger:destroy()
  harass_trigger = trigger.time{min = 5000, max = 10000, on = EarlyHarass}
  if players[1].difficulty == "Hard" then g:set_lights(game.rand(2) == 0) end
end

-- Hard, every 80 to 120 marks (0x110043B0): the attackers go for the colony at one of three places, drawn; the
-- harassment that follows in 40 to 200 marks (DoHarrassAttack) replaces any waiting.
function fgAttack(t)
  fight_attack:do_attack_enemy()
  harass_rect()
  if harass_wait then harass_wait:destroy() end
  harass_wait = trigger.time{min = 4000, max = 20000, on = DoHarrassAttack}
end

-- Hard (0x11004460): the attackers wait at one of the three places and take every unit of the guard (each with a draw
-- of 5) and 7 in 8 of its escort's; then, 4 times in 5, another fgAttack in 80 to 120 marks, else they attack at once
-- and the next harassment comes in 40 to 200 marks. Their lights are off 1 time in 3.
function DoHarrassAttack(t)
  fight_attack:do_guard_rect()
  harass_rect()
  send_units({ 5, 8 }, 7)
  if harass_wait then harass_wait:destroy() end
  if game.rand(5) < 4 then
    harass_wait = trigger.time{min = 8000, max = 12000, on = fgAttack}
  else
    fight_attack:do_attack_enemy()
    harass_rect()
    if harass_wait then harass_wait:destroy() end
    harass_wait = trigger.time{min = 4000, max = 20000, on = DoHarrassAttack}
  end
  if players[1].difficulty == "Hard" then fight_attack:set_lights(game.rand(3) ~= 0) end
end

-- A Spider beside the RLV's Spaceport (0x11002C50): once the Spaceport is EMPed, the special target and KidsDead stop,
-- the RLV win's trigger starts, the Spaceport launches, "RLV Captured" is posted and TryCapture runs every 20 ticks.
function SpidersPresent(t)
  if not rlv_spaceport.is_emped then return end
  spider_trigger:disable()
  kids_trigger:disable()
  t17:enable()
  rlv_spaceport:clear_special_target()
  rlv_spaceport:launch_at_pixel(0, 0)
  game.message_at("RLV Captured", 169, nil, -1, -1)
  capture_trigger = trigger.time{time = 20, one_shot = false, on = TryCapture}
end

-- Every 20 ticks after the capture (0x11002CF0): once the computer player has an RLV, the human player takes it.
function TryCapture(t)
  if players[2].rlv_count > 0 then
    capture_trigger:disable()
    players[1]:capture_rlv(1)
  end
end

-- The computer player's Spaceport is gone (0x11002E40): the children can't be saved; the mission fails.
function KidsDead(t)
  mission.failure(trigger.time{time = 1})
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.set_cell_type({ 1, 25 }, 21)
  game.initial_set_tile({ 1, 25 }, 921)
  game.set_cell_type({ 1, 26 }, 21)
  game.initial_set_tile({ 1, 26 }, 921)
  game.set_cell_type({ 1, 27 }, 21)
  game.initial_set_tile({ 1, 27 }, 921)
  game.set_cell_type({ 1, 28 }, 21)
  game.initial_set_tile({ 1, 28 }, 921)
  game.set_cell_type({ 2, 25 }, 21)
  game.initial_set_tile({ 2, 25 }, 921)
  game.set_cell_type({ 3, 25 }, 21)
  game.initial_set_tile({ 3, 25 }, 921)
  game.set_cell_type({ 4, 25 }, 21)
  game.initial_set_tile({ 4, 25 }, 921)
  game.set_cell_type({ 5, 19 }, 21)
  game.initial_set_tile({ 5, 19 }, 409)
  game.set_cell_type({ 5, 20 }, 21)
  game.initial_set_tile({ 5, 20 }, 409)
  game.set_cell_type({ 5, 21 }, 21)
  game.initial_set_tile({ 5, 21 }, 921)
  game.set_cell_type({ 5, 22 }, 21)
  game.initial_set_tile({ 5, 22 }, 921)
  game.set_cell_type({ 5, 23 }, 21)
  game.initial_set_tile({ 5, 23 }, 921)
  game.set_cell_type({ 5, 24 }, 21)
  game.initial_set_tile({ 5, 24 }, 921)
  game.set_cell_type({ 5, 25 }, 21)
  game.initial_set_tile({ 5, 25 }, 921)
  game.set_cell_type({ 5, 26 }, 21)
  game.initial_set_tile({ 5, 26 }, 921)
  game.set_cell_type({ 5, 27 }, 21)
  game.initial_set_tile({ 5, 27 }, 921)
  game.set_cell_type({ 5, 28 }, 21)
  game.initial_set_tile({ 5, 28 }, 921)
  game.set_cell_type({ 6, 19 }, 21)
  game.initial_set_tile({ 6, 19 }, 921)
  game.set_cell_type({ 6, 20 }, 21)
  game.initial_set_tile({ 6, 20 }, 921)
  game.set_cell_type({ 6, 21 }, 21)
  game.initial_set_tile({ 6, 21 }, 921)
  game.set_cell_type({ 6, 22 }, 21)
  game.initial_set_tile({ 6, 22 }, 921)
  game.set_cell_type({ 6, 23 }, 21)
  game.initial_set_tile({ 6, 23 }, 921)
  game.set_cell_type({ 6, 24 }, 21)
  game.initial_set_tile({ 6, 24 }, 921)
  game.set_cell_type({ 6, 25 }, 21)
  game.initial_set_tile({ 6, 25 }, 921)
  game.set_cell_type({ 6, 26 }, 21)
  game.initial_set_tile({ 6, 26 }, 921)
  game.set_cell_type({ 6, 27 }, 21)
  game.initial_set_tile({ 6, 27 }, 921)
  game.set_cell_type({ 6, 28 }, 21)
  game.initial_set_tile({ 6, 28 }, 921)
  game.set_cell_type({ 7, 18 }, 21)
  game.initial_set_tile({ 7, 18 }, 921)
  game.set_cell_type({ 7, 19 }, 21)
  game.initial_set_tile({ 7, 19 }, 921)
  game.set_cell_type({ 7, 20 }, 21)
  game.initial_set_tile({ 7, 20 }, 921)
  game.set_cell_type({ 7, 21 }, 21)
  game.initial_set_tile({ 7, 21 }, 921)
  game.set_cell_type({ 7, 22 }, 21)
  game.initial_set_tile({ 7, 22 }, 921)
  game.set_cell_type({ 7, 23 }, 21)
  game.initial_set_tile({ 7, 23 }, 921)
  game.set_cell_type({ 8, 18 }, 21)
  game.initial_set_tile({ 8, 18 }, 921)
  game.set_cell_type({ 8, 19 }, 21)
  game.initial_set_tile({ 8, 19 }, 921)
  game.set_cell_type({ 8, 20 }, 21)
  game.initial_set_tile({ 8, 20 }, 921)
  game.set_cell_type({ 8, 21 }, 21)
  game.initial_set_tile({ 8, 21 }, 921)
  game.set_cell_type({ 8, 22 }, 21)
  game.initial_set_tile({ 8, 22 }, 921)
  game.set_cell_type({ 8, 23 }, 21)
  game.initial_set_tile({ 8, 23 }, 409)
  game.set_cell_type({ 8, 43 }, 21)
  game.initial_set_tile({ 8, 43 }, 409)
  game.set_cell_type({ 8, 44 }, 21)
  game.initial_set_tile({ 8, 44 }, 921)
  game.set_cell_type({ 8, 45 }, 21)
  game.initial_set_tile({ 8, 45 }, 921)
  game.set_cell_type({ 8, 46 }, 21)
  game.initial_set_tile({ 8, 46 }, 921)
  game.set_cell_type({ 8, 47 }, 21)
  game.initial_set_tile({ 8, 47 }, 921)
  game.set_cell_type({ 8, 48 }, 21)
  game.initial_set_tile({ 8, 48 }, 921)
  game.set_cell_type({ 8, 49 }, 21)
  game.initial_set_tile({ 8, 49 }, 921)
  game.set_cell_type({ 9, 18 }, 21)
  game.initial_set_tile({ 9, 18 }, 921)
  game.set_cell_type({ 9, 19 }, 21)
  game.initial_set_tile({ 9, 19 }, 921)
  game.set_cell_type({ 9, 20 }, 21)
  game.initial_set_tile({ 9, 20 }, 921)
  game.set_cell_type({ 9, 21 }, 21)
  game.initial_set_tile({ 9, 21 }, 921)
  game.set_cell_type({ 9, 22 }, 21)
  game.initial_set_tile({ 9, 22 }, 921)
  game.set_cell_type({ 9, 43 }, 21)
  game.initial_set_tile({ 9, 43 }, 409)
  game.set_cell_type({ 9, 44 }, 21)
  game.initial_set_tile({ 9, 44 }, 921)
  game.set_cell_type({ 9, 45 }, 21)
  game.initial_set_tile({ 9, 45 }, 921)
  game.set_cell_type({ 9, 46 }, 21)
  game.initial_set_tile({ 9, 46 }, 921)
  game.set_cell_type({ 10, 18 }, 21)
  game.initial_set_tile({ 10, 18 }, 921)
  game.set_cell_type({ 10, 19 }, 21)
  game.initial_set_tile({ 10, 19 }, 921)
  game.set_cell_type({ 10, 20 }, 21)
  game.initial_set_tile({ 10, 20 }, 921)
  game.set_cell_type({ 10, 21 }, 21)
  game.initial_set_tile({ 10, 21 }, 921)
  game.set_cell_type({ 10, 22 }, 21)
  game.initial_set_tile({ 10, 22 }, 921)
  game.set_cell_type({ 10, 43 }, 21)
  game.initial_set_tile({ 10, 43 }, 409)
  game.set_cell_type({ 10, 44 }, 21)
  game.initial_set_tile({ 10, 44 }, 409)
  game.set_cell_type({ 10, 45 }, 21)
  game.initial_set_tile({ 10, 45 }, 921)
  game.set_cell_type({ 10, 46 }, 21)
  game.initial_set_tile({ 10, 46 }, 921)
  game.set_cell_type({ 11, 18 }, 21)
  game.initial_set_tile({ 11, 18 }, 921)
  game.set_cell_type({ 11, 19 }, 21)
  game.initial_set_tile({ 11, 19 }, 921)
  game.set_cell_type({ 11, 20 }, 21)
  game.initial_set_tile({ 11, 20 }, 921)
  game.set_cell_type({ 11, 21 }, 21)
  game.initial_set_tile({ 11, 21 }, 921)
  game.set_cell_type({ 11, 22 }, 21)
  game.initial_set_tile({ 11, 22 }, 409)
  game.set_cell_type({ 11, 43 }, 21)
  game.initial_set_tile({ 11, 43 }, 409)
  game.set_cell_type({ 11, 44 }, 21)
  game.initial_set_tile({ 11, 44 }, 409)
  game.set_cell_type({ 11, 45 }, 21)
  game.initial_set_tile({ 11, 45 }, 921)
  game.set_cell_type({ 11, 46 }, 21)
  game.initial_set_tile({ 11, 46 }, 921)
  game.set_cell_type({ 12, 18 }, 21)
  game.initial_set_tile({ 12, 18 }, 921)
  game.set_cell_type({ 12, 19 }, 21)
  game.initial_set_tile({ 12, 19 }, 921)
  game.set_cell_type({ 12, 43 }, 21)
  game.initial_set_tile({ 12, 43 }, 409)
  game.set_cell_type({ 12, 44 }, 21)
  game.initial_set_tile({ 12, 44 }, 409)
  game.set_cell_type({ 12, 45 }, 21)
  game.initial_set_tile({ 12, 45 }, 409)
  game.set_cell_type({ 12, 46 }, 21)
  game.initial_set_tile({ 12, 46 }, 921)
  game.set_cell_type({ 12, 47 }, 21)
  game.initial_set_tile({ 12, 47 }, 921)
  game.set_cell_type({ 12, 48 }, 21)
  game.initial_set_tile({ 12, 48 }, 921)
  game.set_cell_type({ 12, 49 }, 21)
  game.initial_set_tile({ 12, 49 }, 921)
  game.set_cell_type({ 13, 18 }, 21)
  game.initial_set_tile({ 13, 18 }, 921)
  game.set_cell_type({ 13, 19 }, 21)
  game.initial_set_tile({ 13, 19 }, 921)
  game.set_cell_type({ 13, 43 }, 21)
  game.initial_set_tile({ 13, 43 }, 409)
  game.set_cell_type({ 13, 44 }, 21)
  game.initial_set_tile({ 13, 44 }, 409)
  game.set_cell_type({ 14, 16 }, 21)
  game.initial_set_tile({ 14, 16 }, 409)
  game.set_cell_type({ 14, 17 }, 21)
  game.initial_set_tile({ 14, 17 }, 921)
  game.set_cell_type({ 14, 18 }, 21)
  game.initial_set_tile({ 14, 18 }, 921)
  game.set_cell_type({ 14, 19 }, 21)
  game.initial_set_tile({ 14, 19 }, 921)
  game.set_cell_type({ 14, 43 }, 21)
  game.initial_set_tile({ 14, 43 }, 409)
  game.set_cell_type({ 14, 44 }, 21)
  game.initial_set_tile({ 14, 44 }, 409)
  game.set_cell_type({ 15, 16 }, 21)
  game.initial_set_tile({ 15, 16 }, 409)
  game.set_cell_type({ 15, 17 }, 21)
  game.initial_set_tile({ 15, 17 }, 409)
  game.set_cell_type({ 15, 18 }, 21)
  game.initial_set_tile({ 15, 18 }, 921)
  game.set_cell_type({ 15, 19 }, 21)
  game.initial_set_tile({ 15, 19 }, 921)
  game.set_cell_type({ 15, 43 }, 21)
  game.initial_set_tile({ 15, 43 }, 409)
  game.set_cell_type({ 15, 44 }, 21)
  game.initial_set_tile({ 15, 44 }, 409)
  game.set_cell_type({ 16, 16 }, 21)
  game.initial_set_tile({ 16, 16 }, 409)
  game.set_cell_type({ 16, 17 }, 21)
  game.initial_set_tile({ 16, 17 }, 409)
  game.set_cell_type({ 16, 43 }, 21)
  game.initial_set_tile({ 16, 43 }, 409)
  game.set_cell_type({ 16, 44 }, 21)
  game.initial_set_tile({ 16, 44 }, 409)
  game.set_cell_type({ 17, 16 }, 21)
  game.initial_set_tile({ 17, 16 }, 409)
  game.set_cell_type({ 17, 17 }, 21)
  game.initial_set_tile({ 17, 17 }, 921)
  game.set_cell_type({ 17, 43 }, 21)
  game.initial_set_tile({ 17, 43 }, 409)
  game.set_cell_type({ 17, 44 }, 21)
  game.initial_set_tile({ 17, 44 }, 409)
  game.set_cell_type({ 18, 16 }, 21)
  game.initial_set_tile({ 18, 16 }, 409)
  game.set_cell_type({ 18, 17 }, 21)
  game.initial_set_tile({ 18, 17 }, 921)
  game.set_cell_type({ 18, 43 }, 21)
  game.initial_set_tile({ 18, 43 }, 409)
  game.set_cell_type({ 18, 44 }, 21)
  game.initial_set_tile({ 18, 44 }, 409)
  game.set_cell_type({ 19, 16 }, 21)
  game.initial_set_tile({ 19, 16 }, 409)
  game.set_cell_type({ 19, 17 }, 21)
  game.initial_set_tile({ 19, 17 }, 921)
  game.set_cell_type({ 19, 43 }, 21)
  game.initial_set_tile({ 19, 43 }, 409)
  game.set_cell_type({ 19, 44 }, 21)
  game.initial_set_tile({ 19, 44 }, 409)
  game.set_cell_type({ 20, 16 }, 21)
  game.initial_set_tile({ 20, 16 }, 409)
  game.set_cell_type({ 20, 17 }, 21)
  game.initial_set_tile({ 20, 17 }, 921)
  game.set_cell_type({ 20, 43 }, 21)
  game.initial_set_tile({ 20, 43 }, 409)
  game.set_cell_type({ 20, 44 }, 21)
  game.initial_set_tile({ 20, 44 }, 409)
  game.set_cell_type({ 21, 16 }, 21)
  game.initial_set_tile({ 21, 16 }, 921)
  game.set_cell_type({ 21, 17 }, 21)
  game.initial_set_tile({ 21, 17 }, 921)
  game.set_cell_type({ 21, 43 }, 21)
  game.initial_set_tile({ 21, 43 }, 409)
  game.set_cell_type({ 21, 44 }, 21)
  game.initial_set_tile({ 21, 44 }, 409)
  game.set_cell_type({ 22, 16 }, 21)
  game.initial_set_tile({ 22, 16 }, 921)
  game.set_cell_type({ 22, 17 }, 21)
  game.initial_set_tile({ 22, 17 }, 921)
  game.set_cell_type({ 22, 43 }, 21)
  game.initial_set_tile({ 22, 43 }, 409)
  game.set_cell_type({ 22, 44 }, 21)
  game.initial_set_tile({ 22, 44 }, 409)
  game.set_cell_type({ 23, 16 }, 21)
  game.initial_set_tile({ 23, 16 }, 921)
  game.set_cell_type({ 23, 17 }, 21)
  game.initial_set_tile({ 23, 17 }, 921)
  game.set_cell_type({ 23, 43 }, 21)
  game.initial_set_tile({ 23, 43 }, 921)
  game.set_cell_type({ 23, 44 }, 21)
  game.initial_set_tile({ 23, 44 }, 921)
  game.set_cell_type({ 24, 16 }, 21)
  game.initial_set_tile({ 24, 16 }, 921)
  game.set_cell_type({ 24, 17 }, 21)
  game.initial_set_tile({ 24, 17 }, 921)
  game.set_cell_type({ 24, 43 }, 21)
  game.initial_set_tile({ 24, 43 }, 921)
  game.set_cell_type({ 24, 44 }, 21)
  game.initial_set_tile({ 24, 44 }, 921)
  game.set_cell_type({ 25, 16 }, 21)
  game.initial_set_tile({ 25, 16 }, 921)
  game.set_cell_type({ 25, 17 }, 21)
  game.initial_set_tile({ 25, 17 }, 921)
  game.set_cell_type({ 25, 43 }, 21)
  game.initial_set_tile({ 25, 43 }, 921)
  game.set_cell_type({ 25, 44 }, 21)
  game.initial_set_tile({ 25, 44 }, 921)
  game.set_cell_type({ 26, 16 }, 21)
  game.initial_set_tile({ 26, 16 }, 921)
  game.set_cell_type({ 26, 17 }, 21)
  game.initial_set_tile({ 26, 17 }, 921)
  game.set_cell_type({ 26, 43 }, 21)
  game.initial_set_tile({ 26, 43 }, 921)
  game.set_cell_type({ 26, 44 }, 21)
  game.initial_set_tile({ 26, 44 }, 921)
  game.set_cell_type({ 27, 16 }, 21)
  game.initial_set_tile({ 27, 16 }, 921)
  game.set_cell_type({ 27, 17 }, 21)
  game.initial_set_tile({ 27, 17 }, 921)
  game.set_cell_type({ 27, 43 }, 21)
  game.initial_set_tile({ 27, 43 }, 921)
  game.set_cell_type({ 27, 44 }, 21)
  game.initial_set_tile({ 27, 44 }, 921)
  game.set_cell_type({ 28, 16 }, 21)
  game.initial_set_tile({ 28, 16 }, 921)
  game.set_cell_type({ 28, 17 }, 21)
  game.initial_set_tile({ 28, 17 }, 921)
  game.set_cell_type({ 28, 43 }, 21)
  game.initial_set_tile({ 28, 43 }, 921)
  game.set_cell_type({ 28, 44 }, 21)
  game.initial_set_tile({ 28, 44 }, 921)
  game.set_cell_type({ 29, 16 }, 21)
  game.initial_set_tile({ 29, 16 }, 921)
  game.set_cell_type({ 29, 17 }, 21)
  game.initial_set_tile({ 29, 17 }, 921)
  game.set_cell_type({ 29, 43 }, 21)
  game.initial_set_tile({ 29, 43 }, 921)
  game.set_cell_type({ 29, 44 }, 21)
  game.initial_set_tile({ 29, 44 }, 921)
  game.set_cell_type({ 30, 16 }, 21)
  game.initial_set_tile({ 30, 16 }, 921)
  game.set_cell_type({ 30, 17 }, 21)
  game.initial_set_tile({ 30, 17 }, 921)
  game.set_cell_type({ 30, 41 }, 21)
  game.initial_set_tile({ 30, 41 }, 921)
  game.set_cell_type({ 30, 42 }, 21)
  game.initial_set_tile({ 30, 42 }, 921)
  game.set_cell_type({ 30, 43 }, 21)
  game.initial_set_tile({ 30, 43 }, 921)
  game.set_cell_type({ 30, 44 }, 21)
  game.initial_set_tile({ 30, 44 }, 921)
  game.set_cell_type({ 31, 16 }, 21)
  game.initial_set_tile({ 31, 16 }, 921)
  game.set_cell_type({ 31, 17 }, 21)
  game.initial_set_tile({ 31, 17 }, 921)
  game.set_cell_type({ 31, 41 }, 21)
  game.initial_set_tile({ 31, 41 }, 409)
  game.set_cell_type({ 31, 42 }, 21)
  game.initial_set_tile({ 31, 42 }, 409)
  game.set_cell_type({ 31, 43 }, 21)
  game.initial_set_tile({ 31, 43 }, 409)
  game.set_cell_type({ 31, 44 }, 21)
  game.initial_set_tile({ 31, 44 }, 409)
  game.set_cell_type({ 32, 16 }, 21)
  game.initial_set_tile({ 32, 16 }, 921)
  game.set_cell_type({ 32, 17 }, 21)
  game.initial_set_tile({ 32, 17 }, 921)
  game.set_cell_type({ 32, 42 }, 21)
  game.initial_set_tile({ 32, 42 }, 409)
  game.set_cell_type({ 32, 43 }, 21)
  game.initial_set_tile({ 32, 43 }, 409)
  game.set_cell_type({ 32, 44 }, 21)
  game.initial_set_tile({ 32, 44 }, 409)
  game.set_cell_type({ 33, 16 }, 21)
  game.initial_set_tile({ 33, 16 }, 921)
  game.set_cell_type({ 33, 17 }, 21)
  game.initial_set_tile({ 33, 17 }, 921)
  game.set_cell_type({ 33, 42 }, 21)
  game.initial_set_tile({ 33, 42 }, 409)
  game.set_cell_type({ 33, 43 }, 21)
  game.initial_set_tile({ 33, 43 }, 409)
  game.set_cell_type({ 33, 44 }, 21)
  game.initial_set_tile({ 33, 44 }, 409)
  game.set_cell_type({ 34, 16 }, 21)
  game.initial_set_tile({ 34, 16 }, 921)
  game.set_cell_type({ 34, 17 }, 21)
  game.initial_set_tile({ 34, 17 }, 409)
  game.set_cell_type({ 34, 24 }, 21)
  game.initial_set_tile({ 34, 24 }, 409)
  game.set_cell_type({ 34, 42 }, 21)
  game.initial_set_tile({ 34, 42 }, 409)
  game.set_cell_type({ 34, 43 }, 21)
  game.initial_set_tile({ 34, 43 }, 409)
  game.set_cell_type({ 34, 44 }, 21)
  game.initial_set_tile({ 34, 44 }, 409)
  game.set_cell_type({ 35, 16 }, 21)
  game.initial_set_tile({ 35, 16 }, 409)
  game.set_cell_type({ 35, 17 }, 21)
  game.initial_set_tile({ 35, 17 }, 409)
  game.set_cell_type({ 35, 18 }, 21)
  game.initial_set_tile({ 35, 18 }, 409)
  game.set_cell_type({ 35, 19 }, 21)
  game.initial_set_tile({ 35, 19 }, 409)
  game.set_cell_type({ 35, 20 }, 21)
  game.initial_set_tile({ 35, 20 }, 409)
  game.set_cell_type({ 35, 21 }, 21)
  game.initial_set_tile({ 35, 21 }, 409)
  game.set_cell_type({ 35, 24 }, 21)
  game.initial_set_tile({ 35, 24 }, 409)
  game.set_cell_type({ 35, 41 }, 21)
  game.initial_set_tile({ 35, 41 }, 409)
  game.set_cell_type({ 35, 42 }, 21)
  game.initial_set_tile({ 35, 42 }, 409)
  game.set_cell_type({ 35, 43 }, 21)
  game.initial_set_tile({ 35, 43 }, 409)
  game.set_cell_type({ 35, 44 }, 21)
  game.initial_set_tile({ 35, 44 }, 409)
  game.set_cell_type({ 36, 16 }, 21)
  game.initial_set_tile({ 36, 16 }, 409)
  game.set_cell_type({ 36, 17 }, 21)
  game.initial_set_tile({ 36, 17 }, 409)
  game.set_cell_type({ 36, 18 }, 21)
  game.initial_set_tile({ 36, 18 }, 409)
  game.set_cell_type({ 36, 19 }, 21)
  game.initial_set_tile({ 36, 19 }, 409)
  game.set_cell_type({ 36, 20 }, 21)
  game.initial_set_tile({ 36, 20 }, 409)
  game.set_cell_type({ 36, 21 }, 21)
  game.initial_set_tile({ 36, 21 }, 409)
  game.set_cell_type({ 36, 22 }, 21)
  game.initial_set_tile({ 36, 22 }, 409)
  game.set_cell_type({ 36, 23 }, 21)
  game.initial_set_tile({ 36, 23 }, 409)
  game.set_cell_type({ 36, 24 }, 21)
  game.initial_set_tile({ 36, 24 }, 409)
  game.set_cell_type({ 36, 25 }, 21)
  game.initial_set_tile({ 36, 25 }, 409)
  game.set_cell_type({ 36, 41 }, 21)
  game.initial_set_tile({ 36, 41 }, 409)
  game.set_cell_type({ 36, 42 }, 21)
  game.initial_set_tile({ 36, 42 }, 409)
  game.set_cell_type({ 36, 43 }, 21)
  game.initial_set_tile({ 36, 43 }, 409)
  game.set_cell_type({ 36, 44 }, 21)
  game.initial_set_tile({ 36, 44 }, 409)
  game.set_cell_type({ 37, 16 }, 21)
  game.initial_set_tile({ 37, 16 }, 409)
  game.set_cell_type({ 37, 17 }, 21)
  game.initial_set_tile({ 37, 17 }, 409)
  game.set_cell_type({ 37, 18 }, 21)
  game.initial_set_tile({ 37, 18 }, 409)
  game.set_cell_type({ 37, 19 }, 21)
  game.initial_set_tile({ 37, 19 }, 409)
  game.set_cell_type({ 37, 20 }, 21)
  game.initial_set_tile({ 37, 20 }, 409)
  game.set_cell_type({ 37, 21 }, 21)
  game.initial_set_tile({ 37, 21 }, 409)
  game.set_cell_type({ 37, 22 }, 21)
  game.initial_set_tile({ 37, 22 }, 409)
  game.set_cell_type({ 37, 23 }, 21)
  game.initial_set_tile({ 37, 23 }, 409)
  game.set_cell_type({ 37, 24 }, 21)
  game.initial_set_tile({ 37, 24 }, 409)
  game.set_cell_type({ 37, 25 }, 21)
  game.initial_set_tile({ 37, 25 }, 409)
  game.set_cell_type({ 37, 26 }, 21)
  game.initial_set_tile({ 37, 26 }, 409)
  game.set_cell_type({ 37, 27 }, 21)
  game.initial_set_tile({ 37, 27 }, 409)
  game.set_cell_type({ 37, 35 }, 21)
  game.initial_set_tile({ 37, 35 }, 409)
  game.set_cell_type({ 37, 36 }, 21)
  game.initial_set_tile({ 37, 36 }, 409)
  game.set_cell_type({ 37, 37 }, 21)
  game.initial_set_tile({ 37, 37 }, 409)
  game.set_cell_type({ 37, 38 }, 21)
  game.initial_set_tile({ 37, 38 }, 409)
  game.set_cell_type({ 37, 39 }, 21)
  game.initial_set_tile({ 37, 39 }, 409)
  game.set_cell_type({ 37, 40 }, 21)
  game.initial_set_tile({ 37, 40 }, 409)
  game.set_cell_type({ 37, 41 }, 21)
  game.initial_set_tile({ 37, 41 }, 409)
  game.set_cell_type({ 37, 42 }, 21)
  game.initial_set_tile({ 37, 42 }, 409)
  game.set_cell_type({ 37, 43 }, 21)
  game.initial_set_tile({ 37, 43 }, 409)
  game.set_cell_type({ 37, 44 }, 21)
  game.initial_set_tile({ 37, 44 }, 409)
  game.set_cell_type({ 38, 16 }, 21)
  game.initial_set_tile({ 38, 16 }, 409)
  game.set_cell_type({ 38, 17 }, 21)
  game.initial_set_tile({ 38, 17 }, 409)
  game.set_cell_type({ 38, 18 }, 21)
  game.initial_set_tile({ 38, 18 }, 409)
  game.set_cell_type({ 38, 19 }, 21)
  game.initial_set_tile({ 38, 19 }, 409)
  game.set_cell_type({ 38, 20 }, 21)
  game.initial_set_tile({ 38, 20 }, 409)
  game.set_cell_type({ 38, 21 }, 21)
  game.initial_set_tile({ 38, 21 }, 409)
  game.set_cell_type({ 38, 22 }, 21)
  game.initial_set_tile({ 38, 22 }, 409)
  game.set_cell_type({ 38, 23 }, 21)
  game.initial_set_tile({ 38, 23 }, 409)
  game.set_cell_type({ 38, 24 }, 21)
  game.initial_set_tile({ 38, 24 }, 409)
  game.set_cell_type({ 38, 25 }, 21)
  game.initial_set_tile({ 38, 25 }, 409)
  game.set_cell_type({ 38, 26 }, 21)
  game.initial_set_tile({ 38, 26 }, 409)
  game.set_cell_type({ 38, 27 }, 21)
  game.initial_set_tile({ 38, 27 }, 409)
  game.set_cell_type({ 38, 35 }, 21)
  game.initial_set_tile({ 38, 35 }, 409)
  game.set_cell_type({ 38, 36 }, 21)
  game.initial_set_tile({ 38, 36 }, 409)
  game.set_cell_type({ 38, 37 }, 21)
  game.initial_set_tile({ 38, 37 }, 409)
  game.set_cell_type({ 38, 38 }, 21)
  game.initial_set_tile({ 38, 38 }, 409)
  game.set_cell_type({ 38, 39 }, 21)
  game.initial_set_tile({ 38, 39 }, 409)
  game.set_cell_type({ 38, 40 }, 21)
  game.initial_set_tile({ 38, 40 }, 409)
  game.set_cell_type({ 38, 41 }, 21)
  game.initial_set_tile({ 38, 41 }, 409)
  game.set_cell_type({ 38, 42 }, 21)
  game.initial_set_tile({ 38, 42 }, 409)
  game.set_cell_type({ 38, 43 }, 21)
  game.initial_set_tile({ 38, 43 }, 409)
  game.set_cell_type({ 38, 44 }, 21)
  game.initial_set_tile({ 38, 44 }, 409)
  game.set_cell_type({ 39, 7 }, 21)
  game.initial_set_tile({ 39, 7 }, 409)
  game.set_cell_type({ 39, 16 }, 21)
  game.initial_set_tile({ 39, 16 }, 409)
  game.set_cell_type({ 39, 22 }, 21)
  game.initial_set_tile({ 39, 22 }, 409)
  game.set_cell_type({ 39, 23 }, 21)
  game.initial_set_tile({ 39, 23 }, 409)
  game.set_cell_type({ 39, 24 }, 21)
  game.initial_set_tile({ 39, 24 }, 409)
  game.set_cell_type({ 39, 25 }, 21)
  game.initial_set_tile({ 39, 25 }, 409)
  game.set_cell_type({ 39, 26 }, 21)
  game.initial_set_tile({ 39, 26 }, 409)
  game.set_cell_type({ 39, 27 }, 21)
  game.initial_set_tile({ 39, 27 }, 409)
  game.set_cell_type({ 39, 35 }, 21)
  game.initial_set_tile({ 39, 35 }, 409)
  game.set_cell_type({ 39, 36 }, 21)
  game.initial_set_tile({ 39, 36 }, 409)
  game.set_cell_type({ 39, 37 }, 21)
  game.initial_set_tile({ 39, 37 }, 409)
  game.set_cell_type({ 39, 43 }, 21)
  game.initial_set_tile({ 39, 43 }, 409)
  game.set_cell_type({ 39, 44 }, 21)
  game.initial_set_tile({ 39, 44 }, 409)
  game.set_cell_type({ 40, 16 }, 21)
  game.initial_set_tile({ 40, 16 }, 409)
  game.set_cell_type({ 40, 22 }, 21)
  game.initial_set_tile({ 40, 22 }, 409)
  game.set_cell_type({ 40, 35 }, 21)
  game.initial_set_tile({ 40, 35 }, 409)
  game.set_cell_type({ 40, 36 }, 21)
  game.initial_set_tile({ 40, 36 }, 409)
  game.set_cell_type({ 40, 37 }, 21)
  game.initial_set_tile({ 40, 37 }, 409)
  game.set_cell_type({ 40, 43 }, 21)
  game.initial_set_tile({ 40, 43 }, 409)
  game.set_cell_type({ 40, 44 }, 21)
  game.initial_set_tile({ 40, 44 }, 409)
  game.set_cell_type({ 41, 16 }, 21)
  game.initial_set_tile({ 41, 16 }, 409)
  game.set_cell_type({ 41, 22 }, 21)
  game.initial_set_tile({ 41, 22 }, 409)
  game.set_cell_type({ 41, 37 }, 21)
  game.initial_set_tile({ 41, 37 }, 409)
  game.set_cell_type({ 41, 45 }, 21)
  game.initial_set_tile({ 41, 45 }, 409)
  game.set_cell_type({ 42, 16 }, 21)
  game.initial_set_tile({ 42, 16 }, 409)
  game.set_cell_type({ 42, 22 }, 21)
  game.initial_set_tile({ 42, 22 }, 409)
  game.set_cell_type({ 42, 30 }, 21)
  game.initial_set_tile({ 42, 30 }, 409)
  game.set_cell_type({ 42, 37 }, 21)
  game.initial_set_tile({ 42, 37 }, 409)
  game.set_cell_type({ 43, 16 }, 21)
  game.initial_set_tile({ 43, 16 }, 409)
  game.set_cell_type({ 43, 22 }, 21)
  game.initial_set_tile({ 43, 22 }, 409)
  game.set_cell_type({ 43, 37 }, 21)
  game.initial_set_tile({ 43, 37 }, 409)
  game.set_cell_type({ 43, 45 }, 21)
  game.initial_set_tile({ 43, 45 }, 409)
  game.set_cell_type({ 44, 16 }, 21)
  game.initial_set_tile({ 44, 16 }, 409)
  game.set_cell_type({ 44, 21 }, 21)
  game.initial_set_tile({ 44, 21 }, 409)
  game.set_cell_type({ 44, 22 }, 21)
  game.initial_set_tile({ 44, 22 }, 409)
  game.set_cell_type({ 44, 30 }, 21)
  game.initial_set_tile({ 44, 30 }, 409)
  game.set_cell_type({ 44, 35 }, 21)
  game.initial_set_tile({ 44, 35 }, 409)
  game.set_cell_type({ 44, 36 }, 21)
  game.initial_set_tile({ 44, 36 }, 409)
  game.set_cell_type({ 44, 37 }, 21)
  game.initial_set_tile({ 44, 37 }, 409)
  game.set_cell_type({ 44, 42 }, 21)
  game.initial_set_tile({ 44, 42 }, 409)
  game.set_cell_type({ 44, 43 }, 21)
  game.initial_set_tile({ 44, 43 }, 409)
  game.set_cell_type({ 44, 44 }, 21)
  game.initial_set_tile({ 44, 44 }, 409)
  game.set_cell_type({ 45, 16 }, 21)
  game.initial_set_tile({ 45, 16 }, 409)
  game.set_cell_type({ 45, 17 }, 21)
  game.initial_set_tile({ 45, 17 }, 409)
  game.set_cell_type({ 45, 18 }, 21)
  game.initial_set_tile({ 45, 18 }, 409)
  game.set_cell_type({ 45, 19 }, 21)
  game.initial_set_tile({ 45, 19 }, 409)
  game.set_cell_type({ 45, 20 }, 21)
  game.initial_set_tile({ 45, 20 }, 409)
  game.set_cell_type({ 45, 21 }, 21)
  game.initial_set_tile({ 45, 21 }, 409)
  game.set_cell_type({ 45, 22 }, 21)
  game.initial_set_tile({ 45, 22 }, 409)
  game.set_cell_type({ 45, 27 }, 21)
  game.initial_set_tile({ 45, 27 }, 409)
  game.set_cell_type({ 45, 37 }, 21)
  game.initial_set_tile({ 45, 37 }, 409)
  game.set_cell_type({ 45, 38 }, 21)
  game.initial_set_tile({ 45, 38 }, 409)
  game.set_cell_type({ 45, 39 }, 21)
  game.initial_set_tile({ 45, 39 }, 409)
  game.set_cell_type({ 45, 41 }, 21)
  game.initial_set_tile({ 45, 41 }, 409)
  game.set_cell_type({ 45, 42 }, 21)
  game.initial_set_tile({ 45, 42 }, 409)
  game.set_cell_type({ 45, 43 }, 21)
  game.initial_set_tile({ 45, 43 }, 409)
  game.set_cell_type({ 45, 44 }, 21)
  game.initial_set_tile({ 45, 44 }, 409)
  game.set_cell_type({ 46, 16 }, 21)
  game.initial_set_tile({ 46, 16 }, 409)
  game.set_cell_type({ 46, 17 }, 21)
  game.initial_set_tile({ 46, 17 }, 409)
  game.set_cell_type({ 46, 18 }, 21)
  game.initial_set_tile({ 46, 18 }, 409)
  game.set_cell_type({ 46, 19 }, 21)
  game.initial_set_tile({ 46, 19 }, 409)
  game.set_cell_type({ 46, 20 }, 21)
  game.initial_set_tile({ 46, 20 }, 409)
  game.set_cell_type({ 46, 21 }, 21)
  game.initial_set_tile({ 46, 21 }, 409)
  game.set_cell_type({ 46, 22 }, 21)
  game.initial_set_tile({ 46, 22 }, 409)
  game.set_cell_type({ 46, 23 }, 21)
  game.initial_set_tile({ 46, 23 }, 409)
  game.set_cell_type({ 46, 24 }, 21)
  game.initial_set_tile({ 46, 24 }, 409)
  game.set_cell_type({ 46, 26 }, 21)
  game.initial_set_tile({ 46, 26 }, 409)
  game.set_cell_type({ 46, 27 }, 21)
  game.initial_set_tile({ 46, 27 }, 409)
  game.set_cell_type({ 46, 37 }, 21)
  game.initial_set_tile({ 46, 37 }, 409)
  game.set_cell_type({ 46, 38 }, 21)
  game.initial_set_tile({ 46, 38 }, 409)
  game.set_cell_type({ 46, 39 }, 21)
  game.initial_set_tile({ 46, 39 }, 409)
  game.set_cell_type({ 46, 41 }, 21)
  game.initial_set_tile({ 46, 41 }, 409)
  game.set_cell_type({ 46, 42 }, 21)
  game.initial_set_tile({ 46, 42 }, 409)
  game.set_cell_type({ 46, 43 }, 21)
  game.initial_set_tile({ 46, 43 }, 409)
  game.set_cell_type({ 46, 44 }, 21)
  game.initial_set_tile({ 46, 44 }, 409)
  game.set_cell_type({ 47, 16 }, 21)
  game.initial_set_tile({ 47, 16 }, 409)
  game.set_cell_type({ 47, 17 }, 21)
  game.initial_set_tile({ 47, 17 }, 409)
  game.set_cell_type({ 47, 18 }, 21)
  game.initial_set_tile({ 47, 18 }, 409)
  game.set_cell_type({ 47, 19 }, 21)
  game.initial_set_tile({ 47, 19 }, 409)
  game.set_cell_type({ 47, 20 }, 21)
  game.initial_set_tile({ 47, 20 }, 409)
  game.set_cell_type({ 47, 21 }, 21)
  game.initial_set_tile({ 47, 21 }, 409)
  game.set_cell_type({ 47, 22 }, 21)
  game.initial_set_tile({ 47, 22 }, 409)
  game.set_cell_type({ 47, 23 }, 21)
  game.initial_set_tile({ 47, 23 }, 409)
  game.set_cell_type({ 47, 24 }, 21)
  game.initial_set_tile({ 47, 24 }, 409)
  game.set_cell_type({ 47, 26 }, 21)
  game.initial_set_tile({ 47, 26 }, 409)
  game.set_cell_type({ 47, 27 }, 21)
  game.initial_set_tile({ 47, 27 }, 409)
  game.set_cell_type({ 47, 37 }, 21)
  game.initial_set_tile({ 47, 37 }, 409)
  game.set_cell_type({ 47, 38 }, 21)
  game.initial_set_tile({ 47, 38 }, 409)
  game.set_cell_type({ 47, 39 }, 21)
  game.initial_set_tile({ 47, 39 }, 409)
  game.set_cell_type({ 47, 41 }, 21)
  game.initial_set_tile({ 47, 41 }, 409)
  game.set_cell_type({ 47, 42 }, 21)
  game.initial_set_tile({ 47, 42 }, 409)
  game.set_cell_type({ 47, 43 }, 21)
  game.initial_set_tile({ 47, 43 }, 409)
  game.set_cell_type({ 47, 44 }, 21)
  game.initial_set_tile({ 47, 44 }, 409)
  game.set_cell_type({ 48, 24 }, 21)
  game.initial_set_tile({ 48, 24 }, 409)
  game.set_cell_type({ 48, 26 }, 21)
  game.initial_set_tile({ 48, 26 }, 409)
  game.set_cell_type({ 48, 27 }, 21)
  game.initial_set_tile({ 48, 27 }, 409)
  game.set_cell_type({ 48, 28 }, 21)
  game.initial_set_tile({ 48, 28 }, 409)
  game.set_cell_type({ 48, 29 }, 21)
  game.initial_set_tile({ 48, 29 }, 409)
  game.set_cell_type({ 48, 30 }, 21)
  game.initial_set_tile({ 48, 30 }, 409)
  game.set_cell_type({ 48, 31 }, 21)
  game.initial_set_tile({ 48, 31 }, 409)
  game.set_cell_type({ 48, 32 }, 21)
  game.initial_set_tile({ 48, 32 }, 409)
  game.set_cell_type({ 48, 37 }, 21)
  game.initial_set_tile({ 48, 37 }, 409)
  game.set_cell_type({ 48, 38 }, 21)
  game.initial_set_tile({ 48, 38 }, 409)
  game.set_cell_type({ 48, 39 }, 21)
  game.initial_set_tile({ 48, 39 }, 409)
  game.set_cell_type({ 48, 41 }, 21)
  game.initial_set_tile({ 48, 41 }, 409)
  game.set_cell_type({ 49, 24 }, 21)
  game.initial_set_tile({ 49, 24 }, 409)
  game.set_cell_type({ 49, 26 }, 21)
  game.initial_set_tile({ 49, 26 }, 409)
  game.set_cell_type({ 49, 27 }, 21)
  game.initial_set_tile({ 49, 27 }, 409)
  game.set_cell_type({ 49, 28 }, 21)
  game.initial_set_tile({ 49, 28 }, 409)
  game.set_cell_type({ 49, 29 }, 21)
  game.initial_set_tile({ 49, 29 }, 409)
  game.set_cell_type({ 49, 30 }, 21)
  game.initial_set_tile({ 49, 30 }, 409)
  game.set_cell_type({ 49, 31 }, 21)
  game.initial_set_tile({ 49, 31 }, 409)
  game.set_cell_type({ 49, 32 }, 21)
  game.initial_set_tile({ 49, 32 }, 409)
  game.set_cell_type({ 49, 33 }, 21)
  game.initial_set_tile({ 49, 33 }, 409)
  game.set_cell_type({ 49, 34 }, 21)
  game.initial_set_tile({ 49, 34 }, 409)
  game.set_cell_type({ 49, 36 }, 21)
  game.initial_set_tile({ 49, 36 }, 409)
  game.set_cell_type({ 49, 37 }, 21)
  game.initial_set_tile({ 49, 37 }, 409)
  game.set_cell_type({ 49, 38 }, 21)
  game.initial_set_tile({ 49, 38 }, 409)
  game.set_cell_type({ 49, 39 }, 21)
  game.initial_set_tile({ 49, 39 }, 409)
  game.set_cell_type({ 49, 41 }, 21)
  game.initial_set_tile({ 49, 41 }, 409)
  game.set_cell_type({ 50, 32 }, 21)
  game.initial_set_tile({ 50, 32 }, 409)
  game.set_cell_type({ 50, 37 }, 21)
  game.initial_set_tile({ 50, 37 }, 409)
  game.set_cell_type({ 50, 41 }, 21)
  game.initial_set_tile({ 50, 41 }, 409)
  game.set_cell_type({ 51, 32 }, 21)
  game.initial_set_tile({ 51, 32 }, 409)
  game.set_cell_type({ 51, 37 }, 21)
  game.initial_set_tile({ 51, 37 }, 409)
  game.set_cell_type({ 51, 44 }, 21)
  game.initial_set_tile({ 51, 44 }, 409)
  game.set_cell_type({ 53, 20 }, 21)
  game.initial_set_tile({ 53, 20 }, 409)
  game.set_cell_type({ 53, 32 }, 21)
  game.initial_set_tile({ 53, 32 }, 409)
  game.set_cell_type({ 53, 37 }, 21)
  game.initial_set_tile({ 53, 37 }, 409)
  game.set_cell_type({ 53, 44 }, 21)
  game.initial_set_tile({ 53, 44 }, 409)
  game.set_cell_type({ 54, 24 }, 21)
  game.initial_set_tile({ 54, 24 }, 409)
  game.set_cell_type({ 54, 25 }, 21)
  game.initial_set_tile({ 54, 25 }, 409)
  game.set_cell_type({ 54, 27 }, 21)
  game.initial_set_tile({ 54, 27 }, 409)
  game.set_cell_type({ 54, 32 }, 21)
  game.initial_set_tile({ 54, 32 }, 409)
  game.set_cell_type({ 54, 37 }, 21)
  game.initial_set_tile({ 54, 37 }, 409)
  game.set_cell_type({ 55, 20 }, 21)
  game.initial_set_tile({ 55, 20 }, 409)
  game.set_cell_type({ 55, 24 }, 21)
  game.initial_set_tile({ 55, 24 }, 409)
  game.set_cell_type({ 55, 25 }, 21)
  game.initial_set_tile({ 55, 25 }, 409)
  game.set_cell_type({ 55, 27 }, 21)
  game.initial_set_tile({ 55, 27 }, 409)
  game.set_cell_type({ 55, 28 }, 21)
  game.initial_set_tile({ 55, 28 }, 409)
  game.set_cell_type({ 55, 29 }, 21)
  game.initial_set_tile({ 55, 29 }, 409)
  game.set_cell_type({ 55, 30 }, 21)
  game.initial_set_tile({ 55, 30 }, 409)
  game.set_cell_type({ 55, 31 }, 21)
  game.initial_set_tile({ 55, 31 }, 409)
  game.set_cell_type({ 55, 32 }, 21)
  game.initial_set_tile({ 55, 32 }, 409)
  game.set_cell_type({ 55, 33 }, 21)
  game.initial_set_tile({ 55, 33 }, 409)
  game.set_cell_type({ 55, 34 }, 21)
  game.initial_set_tile({ 55, 34 }, 409)
  game.set_cell_type({ 55, 35 }, 21)
  game.initial_set_tile({ 55, 35 }, 409)
  game.set_cell_type({ 55, 36 }, 21)
  game.initial_set_tile({ 55, 36 }, 409)
  game.set_cell_type({ 55, 37 }, 21)
  game.initial_set_tile({ 55, 37 }, 409)
  game.set_cell_type({ 55, 38 }, 21)
  game.initial_set_tile({ 55, 38 }, 409)
  game.set_cell_type({ 55, 39 }, 21)
  game.initial_set_tile({ 55, 39 }, 409)
  game.set_cell_type({ 55, 41 }, 21)
  game.initial_set_tile({ 55, 41 }, 409)
  game.set_cell_type({ 56, 24 }, 21)
  game.initial_set_tile({ 56, 24 }, 409)
  game.set_cell_type({ 56, 25 }, 21)
  game.initial_set_tile({ 56, 25 }, 409)
  game.set_cell_type({ 56, 27 }, 21)
  game.initial_set_tile({ 56, 27 }, 409)
  game.set_cell_type({ 56, 28 }, 21)
  game.initial_set_tile({ 56, 28 }, 409)
  game.set_cell_type({ 56, 29 }, 21)
  game.initial_set_tile({ 56, 29 }, 409)
  game.set_cell_type({ 56, 30 }, 21)
  game.initial_set_tile({ 56, 30 }, 409)
  game.set_cell_type({ 56, 31 }, 21)
  game.initial_set_tile({ 56, 31 }, 409)
  game.set_cell_type({ 56, 32 }, 21)
  game.initial_set_tile({ 56, 32 }, 409)
  game.set_cell_type({ 56, 33 }, 21)
  game.initial_set_tile({ 56, 33 }, 409)
  game.set_cell_type({ 56, 34 }, 21)
  game.initial_set_tile({ 56, 34 }, 409)
  game.set_cell_type({ 56, 35 }, 21)
  game.initial_set_tile({ 56, 35 }, 409)
  game.set_cell_type({ 56, 36 }, 21)
  game.initial_set_tile({ 56, 36 }, 409)
  game.set_cell_type({ 56, 37 }, 21)
  game.initial_set_tile({ 56, 37 }, 409)
  game.set_cell_type({ 56, 38 }, 21)
  game.initial_set_tile({ 56, 38 }, 409)
  game.set_cell_type({ 56, 39 }, 21)
  game.initial_set_tile({ 56, 39 }, 409)
  game.set_cell_type({ 56, 41 }, 21)
  game.initial_set_tile({ 56, 41 }, 409)
  game.set_cell_type({ 57, 20 }, 21)
  game.initial_set_tile({ 57, 20 }, 409)
  game.set_cell_type({ 57, 32 }, 21)
  game.initial_set_tile({ 57, 32 }, 409)
  game.set_cell_type({ 57, 33 }, 21)
  game.initial_set_tile({ 57, 33 }, 409)
  game.set_cell_type({ 57, 34 }, 21)
  game.initial_set_tile({ 57, 34 }, 409)
  game.set_cell_type({ 57, 35 }, 21)
  game.initial_set_tile({ 57, 35 }, 409)
  game.set_cell_type({ 57, 36 }, 21)
  game.initial_set_tile({ 57, 36 }, 409)
  game.set_cell_type({ 57, 37 }, 21)
  game.initial_set_tile({ 57, 37 }, 409)
  game.set_cell_type({ 57, 41 }, 21)
  game.initial_set_tile({ 57, 41 }, 409)
  game.set_cell_type({ 58, 5 }, 21)
  game.initial_set_tile({ 58, 5 }, 409)
  game.set_cell_type({ 58, 33 }, 21)
  game.initial_set_tile({ 58, 33 }, 409)
  game.set_cell_type({ 60, 5 }, 21)
  game.initial_set_tile({ 60, 5 }, 409)
  game.set_cell_type({ 60, 33 }, 21)
  game.initial_set_tile({ 60, 33 }, 409)
  game.set_cell_type({ 61, 33 }, 21)
  game.initial_set_tile({ 61, 33 }, 409)
  game.set_cell_type({ 62, 5 }, 21)
  game.initial_set_tile({ 62, 5 }, 409)
  game.set_cell_type({ 62, 24 }, 21)
  game.initial_set_tile({ 62, 24 }, 409)
  game.set_cell_type({ 62, 25 }, 21)
  game.initial_set_tile({ 62, 25 }, 409)
  game.set_cell_type({ 62, 27 }, 21)
  game.initial_set_tile({ 62, 27 }, 409)
  game.set_cell_type({ 62, 28 }, 21)
  game.initial_set_tile({ 62, 28 }, 409)
  game.set_cell_type({ 62, 29 }, 21)
  game.initial_set_tile({ 62, 29 }, 409)
  game.set_cell_type({ 62, 30 }, 21)
  game.initial_set_tile({ 62, 30 }, 409)
  game.set_cell_type({ 62, 31 }, 21)
  game.initial_set_tile({ 62, 31 }, 409)
  game.set_cell_type({ 62, 32 }, 21)
  game.initial_set_tile({ 62, 32 }, 409)
  game.set_cell_type({ 62, 33 }, 21)
  game.initial_set_tile({ 62, 33 }, 409)
  game.set_cell_type({ 62, 34 }, 21)
  game.initial_set_tile({ 62, 34 }, 409)
  game.set_cell_type({ 62, 35 }, 21)
  game.initial_set_tile({ 62, 35 }, 409)
  game.set_cell_type({ 62, 37 }, 21)
  game.initial_set_tile({ 62, 37 }, 409)
  game.set_cell_type({ 62, 38 }, 21)
  game.initial_set_tile({ 62, 38 }, 409)
  game.set_cell_type({ 62, 39 }, 21)
  game.initial_set_tile({ 62, 39 }, 409)
  game.set_cell_type({ 62, 40 }, 21)
  game.initial_set_tile({ 62, 40 }, 409)
  game.set_cell_type({ 62, 41 }, 21)
  game.initial_set_tile({ 62, 41 }, 409)
  game.set_cell_type({ 63, 28 }, 21)
  game.initial_set_tile({ 63, 28 }, 409)
  game.set_cell_type({ 64, 5 }, 21)
  game.initial_set_tile({ 64, 5 }, 1670)
  game.set_cell_type({ 64, 28 }, 21)
  game.initial_set_tile({ 64, 28 }, 409)
  game.set_cell_type({ 66, 28 }, 21)
  game.initial_set_tile({ 66, 28 }, 409)
  game.set_cell_type({ 67, 28 }, 21)
  game.initial_set_tile({ 67, 28 }, 409)
  game.set_cell_type({ 67, 34 }, 21)
  game.initial_set_tile({ 67, 34 }, 409)
  game.set_cell_type({ 67, 35 }, 21)
  game.initial_set_tile({ 67, 35 }, 409)
  game.set_cell_type({ 67, 37 }, 21)
  game.initial_set_tile({ 67, 37 }, 409)
  game.set_cell_type({ 67, 38 }, 21)
  game.initial_set_tile({ 67, 38 }, 409)
  game.set_cell_type({ 68, 24 }, 21)
  game.initial_set_tile({ 68, 24 }, 409)
  game.set_cell_type({ 68, 25 }, 21)
  game.initial_set_tile({ 68, 25 }, 409)
  game.set_cell_type({ 68, 27 }, 21)
  game.initial_set_tile({ 68, 27 }, 409)
  game.set_cell_type({ 68, 28 }, 21)
  game.initial_set_tile({ 68, 28 }, 409)
  game.set_cell_type({ 68, 29 }, 21)
  game.initial_set_tile({ 68, 29 }, 409)
  game.set_cell_type({ 68, 30 }, 21)
  game.initial_set_tile({ 68, 30 }, 409)
  game.set_cell_type({ 68, 31 }, 21)
  game.initial_set_tile({ 68, 31 }, 409)
  game.set_cell_type({ 68, 32 }, 21)
  game.initial_set_tile({ 68, 32 }, 409)
  game.set_cell_type({ 68, 33 }, 21)
  game.initial_set_tile({ 68, 33 }, 409)
  game.set_cell_type({ 68, 34 }, 21)
  game.initial_set_tile({ 68, 34 }, 409)
  game.set_cell_type({ 68, 35 }, 21)
  game.initial_set_tile({ 68, 35 }, 409)
  game.set_cell_type({ 68, 37 }, 21)
  game.initial_set_tile({ 68, 37 }, 409)
  game.set_cell_type({ 68, 38 }, 21)
  game.initial_set_tile({ 68, 38 }, 409)
  game.set_cell_type({ 69, 33 }, 21)
  game.initial_set_tile({ 69, 33 }, 409)
  game.set_cell_type({ 69, 34 }, 21)
  game.initial_set_tile({ 69, 34 }, 409)
  game.set_cell_type({ 70, 33 }, 21)
  game.initial_set_tile({ 70, 33 }, 409)
  game.set_cell_type({ 70, 34 }, 21)
  game.initial_set_tile({ 70, 34 }, 409)
  game.set_cell_type({ 71, 33 }, 21)
  game.initial_set_tile({ 71, 33 }, 409)
  game.set_cell_type({ 71, 34 }, 21)
  game.initial_set_tile({ 71, 34 }, 409)
  -- The tubes and walls the setup makes on tiles its map edits changed, after them.
  make_walls({
    { "Tube", { 46, 24 } }, { "Tube", { 46, 23 } }, { "Tube", { 46, 22 } }, { "Tube", { 46, 21 } }, { "Tube", { 46, 20 } }, { "Tube", { 46, 19 } },
    { "Tube", { 45, 19 } },
  })
  game.set_daylight_everywhere(difficulty == "Easy" or difficulty == "Normal")
  setup_ai_bases(difficulty)
  trigger.time{min = 10000, max = 11000, on = ExpandAuxBase}  -- after 100 to 110 marks
  trigger.time{min = 2000, max = 2000, one_shot = false, on = GiveOre}  -- every 20 marks
  if difficulty == "Hard" then
    -- Kept where the harassment's wait goes (0x11003D0F: 0x11013120), so the first fgAttack ends it.
    harass_wait = trigger.time{min = 8000, max = 12000, one_shot = false, on = fgAttack}  -- every 80 to 120 marks
  else
    harass_trigger = trigger.time{min = 5000, max = 10000, on = EarlyHarass}  -- after 50 to 100 marks
  end
  setup_ai_army(difficulty)

  -- The win.
  local t20 = trigger.count{type = "FoodCargo", compare = ">=", count = 1, player = 1}
  mission.victory(t20, "Evacuate 10000 units of food to spacecraft.")
  t22 = trigger.count{type = "RareMetalsCargo", compare = ">=", count = 1, player = 1}
  mission.victory(t22, "Evacuate 10000 units of Rare Metals to spacecraft.")
  t24 = trigger.count{type = "CommonMetalsCargo", compare = ">=", count = 1, player = 1}
  mission.victory(t24, "Evacuate 10000 units of Common Metals to spacecraft.")
  local t27e, t29e, t31
  if difficulty == "Easy" then
    t27e = trigger.count{type = "SensorPackage", compare = ">=", count = 1, one_shot = true}
    mission.victory(t27e, "Launch Sensor Package.", {one_shot = true})
    t29e = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1, one_shot = true}
    mission.victory(t29e, "Launch Orbital Package.", {one_shot = true})
    t31 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1, one_shot = true}
    mission.victory(t31, "Launch Phoenix Module.", {one_shot = true})
  end
  t17 = trigger.time{time = 1, enabled = false, on = RLVTaken}
  mission.victory(t17, "Capture the Eden RLV.", {one_shot = true})
  spider_trigger = trigger.special_target{target = rlv_spaceport, type = "Spider", one_shot = false, on = SpidersPresent}
  local t32 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t32)
  kids_trigger = trigger.count{type = "Spaceport", cargo = "None", compare = "<", count = 1, player = 2, one_shot = true, on = KidsDead}
  trigger.time{min = 18000, max = 48000, on = TornadoStart}  -- after 180 to 480 marks
  trigger.time{min = 36000, max = 90000, one_shot = false, on = Storm}  -- after 360 to 900 marks
  trigger.time{min = 108000, max = 112000, one_shot = false, on = Meteor}  -- after 1080 to 1120 marks
  if difficulty == "Easy" then
    trigger.time{time = 180000, on = Microbe}  -- after 1800 marks
  elseif difficulty == "Normal" or difficulty == "Hard" then
    trigger.time{time = 100000, on = Microbe}  -- after 1000 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

-- Not converted:
-- - condition #27's trigger #17 is made off, and what switches it on isn't converted: this win never comes
-- - BringInKids isn't converted: it calls CreateUnit
-- - RLVTaken isn't converted: it calls FightGroup::DoGuardRect
-- - trigger #26 calls BringInKids, but isn't converted: its member trigger #20 isn't converted
