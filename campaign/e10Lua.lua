-- e10Lua.lua  -  Eden Mission #10 (Lua)
-- Trigger functions finished by hand (CheckForFail, EnemyArrive, ScorpionWave, HasThor), from the disassembly of e10.dll.
-- Converted by op2dll from e10.dll. With e10Lua.placement.lua (what every difficulty makes alike),
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
        workers = 36, scientists = 27, kids = 54, food = 2000, ore = 6000, rare_ore = 3000,
        research = { 10000 },
        tech_level = 9,
        kits = { [1] = { "Residence" }, [2] = { "GuardPost", "RailGun" }, [3] = { "GuardPost", "RailGun" } },
        view = { 98, 53 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 10,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 88, 43 } }, { "Tube", { 89, 42 } }, { "Tube", { 89, 43 } }, { "Tube", { 91, 53 } },
      { "Tube", { 92, 53 } }, { "Tube", { 94, 63 } }, { "Tube", { 100, 65 } }, { "Tube", { 104, 51 } },
      { "Tube", { 113, 36 } }, { "Tube", { 114, 56 } }, { "Tube", { 117, 40 } }, { "Tube", { 118, 40 } },
      { "Tube", { 119, 40 } }, { "Tube", { 120, 40 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 98, 53 } },
      { type = "Agridome", player = 1, at = { 103, 46 } },
      { type = "Agridome", player = 1, at = { 103, 40 } },
      { type = "VehicleFactory", player = 1, at = { 93, 47 } },
      { type = "Nursery", player = 1, at = { 111, 46 } },
      { type = "Residence", player = 1, at = { 111, 52 } },
      { type = "Residence", player = 1, at = { 111, 40 } },
      { type = "CommonOreSmelter", player = 1, at = { 107, 60 } },
      { type = "RareOreSmelter", player = 1, at = { 94, 60 } },
      { type = "CommonStorage", player = 1, at = { 112, 60 } },
      { type = "RareStorage", player = 1, at = { 88, 60 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 89, 53 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 100, 66 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 86, 43 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 105, 51 } },
      { type = "StandardLab", player = 1, at = { 100, 60 } },
      { type = "Agridome", player = 1, at = { 110, 36 } },
      { type = "Residence", player = 1, at = { 115, 40 } },
      { type = "Residence", player = 1, at = { 115, 46 } },
      { type = "StructureFactory", player = 1, at = { 93, 40 } },
      { type = "Agridome", player = 1, at = { 115, 36 } },
      { type = "AdvancedLab", player = 1, at = { 94, 65 } },
      { type = "RobotCommand", player = 1, at = { 112, 56 } },
      { type = "Residence", player = 1, at = { 116, 56 } },
      { type = "University", player = 1, at = { 89, 40 } },
      { type = "GeothermalPlant", player = 1, at = { 78, 62 } },
      { type = "Tokamak", player = 1, at = { 125, 47 } },
      { type = "DIRT", player = 1, at = { 98, 38 } },
      { type = "DIRT", player = 1, at = { 119, 59 } },
      { type = "MedicalCenter", player = 1, at = { 118, 46 } },
      { type = "MedicalCenter", player = 1, at = { 119, 56 } },
      { type = "Garage", player = 1, at = { 100, 63 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 84, 69 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 112, 67 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 78, 37 } },
      { type = "Spaceport", player = 1, at = { 123, 39 } },
      { type = "Tokamak", player = 1, at = { 84, 37 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 96, 43 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 96, 45 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 98, 43 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 88, 62 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 114, 60 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 122, 51 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 124, 51 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 122, 53 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 124, 53 } },
      { type = "Scout", direction = "East", player = 1, at = { 98, 44 } },
      { type = "Scout", direction = "East", player = 1, at = { 99, 44 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 117, 44 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 106, 56 } },
      { type = "ConVec", direction = "SouthEast", player = 1, at = { 87, 44 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 90, 54 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 106, 52 } },
      { type = "ConVec", direction = "North", player = 1, at = { 101, 67 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 85, 38 } },
      { type = "Earthworker", direction = "South", player = 1, at = { 113, 40 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 93, 37 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 95, 37 } },
      { type = "Lynx", weapon = "RailGun", direction = "West", player = 1, at = { 83, 63 } },
      { type = "Lynx", weapon = "RailGun", direction = "West", player = 1, at = { 85, 65 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 88, 47 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 88, 49 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 83, 60 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 88, 66 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 86, 47 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 86, 49 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 110, 64 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 108, 65 } },
      { type = "Panther", weapon = "AcidCloud", direction = "East", player = 1, at = { 100, 71 } },
      { type = "Panther", weapon = "AcidCloud", direction = "East", player = 1, at = { 100, 71 } },
      { type = "Panther", weapon = "EMP", direction = "East", player = 1, at = { 81, 40 } },
      { type = "Panther", weapon = "EMP", direction = "East", player = 1, at = { 98, 56 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 114, 63 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 90, 57 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 100, 51 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 122, 32 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 122, 32 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 77, 24 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 77, 24 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 65, 100 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 16, 17 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 118, 94 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 109, 75 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 51, 54 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 106, 8 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 56, 76 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 78, 62 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 15 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 12, 61 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 18, 27 }, beacon = true },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 36, scientists = 27, kids = 54, food = 1500, ore = 4000, rare_ore = 2000,
        research = { 10000 },
        tech_level = 9,
        kits = { [1] = { "Tokamak" }, [2] = { "Spaceport" }, [3] = { "Agridome" }, [4] = { "GuardPost", "RailGun" } },
        view = { 98, 53 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 10,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 94, 63 } }, { "Tube", { 113, 36 } }, { "Tube", { 114, 56 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 98, 53 } },
      { type = "Agridome", player = 1, at = { 103, 46 } },
      { type = "Agridome", player = 1, at = { 103, 40 } },
      { type = "VehicleFactory", player = 1, at = { 93, 47 } },
      { type = "Nursery", player = 1, at = { 111, 46 } },
      { type = "Residence", player = 1, at = { 111, 52 } },
      { type = "Residence", player = 1, at = { 111, 40 } },
      { type = "CommonOreSmelter", player = 1, at = { 107, 60 } },
      { type = "RareOreSmelter", player = 1, at = { 94, 60 } },
      { type = "CommonStorage", player = 1, at = { 112, 60 } },
      { type = "RareStorage", player = 1, at = { 88, 60 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 89, 53 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 100, 66 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 86, 43 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 105, 51 } },
      { type = "StandardLab", player = 1, at = { 100, 60 } },
      { type = "Agridome", player = 1, at = { 110, 36 } },
      { type = "Residence", player = 1, at = { 115, 40 } },
      { type = "Residence", player = 1, at = { 115, 46 } },
      { type = "StructureFactory", player = 1, at = { 93, 40 } },
      { type = "Agridome", player = 1, at = { 115, 36 } },
      { type = "AdvancedLab", player = 1, at = { 94, 65 } },
      { type = "RobotCommand", player = 1, at = { 112, 56 } },
      { type = "Residence", player = 1, at = { 116, 56 } },
      { type = "University", player = 1, at = { 89, 40 } },
      { type = "GeothermalPlant", player = 1, at = { 78, 62 } },
      { type = "DIRT", player = 1, at = { 119, 59 } },
      { type = "MedicalCenter", player = 1, at = { 118, 46 } },
      { type = "MedicalCenter", player = 1, at = { 119, 56 } },
      { type = "Garage", player = 1, at = { 100, 63 } },
      { type = "Tokamak", player = 1, at = { 84, 37 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 96, 43 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 96, 45 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 98, 43 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 88, 62 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 114, 60 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 90, 50 } },
      { type = "ConVec", direction = "SouthEast", player = 1, at = { 87, 44 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 90, 54 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 106, 52 } },
      { type = "ConVec", direction = "North", player = 1, at = { 101, 67 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 85, 38 } },
      { type = "Earthworker", direction = "South", player = 1, at = { 113, 40 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 93, 37 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 95, 37 } },
      { type = "Lynx", weapon = "RailGun", direction = "West", player = 1, at = { 83, 63 } },
      { type = "Lynx", weapon = "RailGun", direction = "West", player = 1, at = { 85, 65 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 88, 47 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 88, 49 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 83, 60 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 88, 66 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 86, 47 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 86, 49 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 110, 64 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 108, 65 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 100, 51 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 122, 32 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 122, 32 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 85, 87 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 37, 35 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 98, 19 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 118, 94 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 118, 94 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 83, 77 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 111, 77 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 78, 62 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 15 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 12, 61 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 18, 27 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 36, scientists = 27, kids = 54, food = 2000, ore = 3000, rare_ore = 2000,
        research = { 10000 },
        tech_level = 9,
        kits = { [1] = { "Tokamak" }, [2] = { "AdvancedLab" }, [3] = { "Spaceport" } },
        view = { 98, 53 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 10,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 112, 58 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 98, 53 } },
      { type = "Agridome", player = 1, at = { 103, 46 } },
      { type = "Agridome", player = 1, at = { 103, 40 } },
      { type = "VehicleFactory", player = 1, at = { 93, 47 } },
      { type = "Nursery", player = 1, at = { 111, 46 } },
      { type = "Residence", player = 1, at = { 111, 52 } },
      { type = "Residence", player = 1, at = { 111, 40 } },
      { type = "CommonOreSmelter", player = 1, at = { 107, 60 } },
      { type = "RareOreSmelter", player = 1, at = { 94, 60 } },
      { type = "CommonStorage", player = 1, at = { 112, 60 } },
      { type = "RareStorage", player = 1, at = { 88, 60 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 89, 53 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 100, 66 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 86, 43 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 105, 51 } },
      { type = "StandardLab", player = 1, at = { 100, 60 } },
      { type = "Agridome", player = 1, at = { 110, 36 } },
      { type = "Residence", player = 1, at = { 115, 40 } },
      { type = "Residence", player = 1, at = { 115, 46 } },
      { type = "StructureFactory", player = 1, at = { 93, 40 } },
      { type = "University", player = 1, at = { 116, 42 } },
      { type = "RobotCommand", player = 1, at = { 112, 56 } },
      { type = "MedicalCenter", player = 1, at = { 118, 46 } },
      { type = "MedicalCenter", player = 1, at = { 118, 40 } },
      { type = "GeoCon", direction = "SouthWest", player = 1, at = { 94, 50 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 112, 64 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 96, 43 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 96, 45 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 98, 43 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 88, 62 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 114, 60 } },
      { type = "ConVec", direction = "SouthEast", player = 1, at = { 87, 44 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 90, 54 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 106, 52 } },
      { type = "ConVec", direction = "North", player = 1, at = { 101, 67 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 85, 38 } },
      { type = "Earthworker", direction = "South", player = 1, at = { 113, 40 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 93, 37 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 95, 37 } },
      { type = "Lynx", weapon = "RailGun", direction = "West", player = 1, at = { 83, 63 } },
      { type = "Lynx", weapon = "RailGun", direction = "West", player = 1, at = { 85, 65 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 88, 47 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 88, 49 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 83, 60 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 88, 66 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 86, 47 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 86, 49 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 110, 64 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 108, 65 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 100, 51 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 100, 51 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 122, 32 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 122, 32 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 65, 100 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 98, 19 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 118, 94 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 118, 94 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 43, 50 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 111, 77 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 83, 72 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 79, 62 }, beacon = true },
      { type = "GeothermalPlant", player = 1, at = { 79, 62 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 15 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 12, 61 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 18, 27 }, beacon = true },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 72, 6, 72, 6 },
  { 71, 7, 73, 7 },
  { 70, 8, 74, 8 },
  { 69, 9, 75, 9 },
  { 68, 10, 76, 10 },
  { 67, 11, 75, 11 },
  { 64, 12, 75, 12 },
  { 63, 13, 74, 14 },
  { 62, 15, 74, 15 },
  { 61, 16, 74, 16 },
  { 57, 17, 74, 17 },
  { 56, 18, 74, 18 },
  { 55, 19, 74, 19 },
  { 57, 20, 75, 20 },
  { 56, 21, 77, 21 },
  { 55, 22, 79, 22 },
  { 55, 23, 80, 23 },
  { 62, 24, 80, 24 },
  { 63, 25, 73, 25 },
  { 75, 25, 80, 25 },
  { 62, 26, 74, 26 },
  { 63, 27, 73, 27 },
  { 63, 28, 74, 28 },
  { 62, 29, 74, 29 },
  { 61, 30, 74, 30 },
  { 60, 31, 76, 31 },
  { 58, 32, 76, 32 },
  { 57, 33, 76, 33 },
  { 56, 34, 76, 34 },
  { 55, 35, 57, 35 },
  { 60, 35, 77, 35 },
  { 54, 36, 55, 36 },
  { 61, 36, 78, 36 },
  { 82, 36, 82, 36 },
  { 53, 37, 54, 37 },
  { 62, 37, 79, 37 },
  { 81, 37, 82, 37 },
  { 51, 38, 53, 38 },
  { 63, 38, 81, 38 },
  { 51, 39, 51, 39 },
  { 68, 39, 80, 39 },
  { 68, 40, 79, 40 },
  { 67, 41, 78, 41 },
  { 64, 42, 78, 42 },
  { 61, 43, 61, 43 },
  { 63, 43, 79, 43 },
  { 60, 44, 61, 44 },
  { 63, 44, 71, 45 },
  { 76, 44, 79, 44 },
  { 45, 45, 46, 45 },
  { 59, 45, 61, 46 },
  { 77, 45, 79, 45 },
  { 44, 46, 49, 46 },
  { 63, 46, 70, 46 },
  { 78, 46, 79, 47 },
  { 43, 47, 50, 47 },
  { 58, 47, 61, 47 },
  { 63, 47, 69, 48 },
  { 43, 48, 51, 48 },
  { 57, 48, 61, 63 },
  { 79, 48, 80, 48 },
  { 44, 49, 54, 49 },
  { 63, 49, 68, 49 },
  { 79, 49, 81, 49 },
  { 48, 50, 54, 50 },
  { 63, 50, 67, 52 },
  { 80, 50, 81, 51 },
  { 49, 51, 54, 53 },
  { 81, 52, 82, 52 },
  { 63, 53, 68, 53 },
  { 48, 54, 54, 55 },
  { 63, 54, 69, 54 },
  { 63, 55, 70, 56 },
  { 47, 56, 54, 56 },
  { 46, 57, 54, 58 },
  { 63, 57, 69, 57 },
  { 63, 58, 68, 58 },
  { 45, 59, 54, 59 },
  { 63, 59, 64, 59 },
  { 44, 60, 54, 62 },
  { 63, 60, 63, 61 },
  { 42, 63, 49, 63 },
  { 54, 63, 54, 63 },
  { 42, 64, 48, 64 },
  { 57, 64, 60, 64 },
  { 42, 65, 47, 65 },
  { 54, 65, 54, 65 },
  { 57, 65, 59, 65 },
  { 41, 66, 44, 66 },
  { 46, 66, 46, 66 },
  { 53, 66, 54, 66 },
  { 57, 66, 58, 66 },
  { 40, 67, 45, 67 },
  { 52, 67, 54, 67 },
  { 57, 67, 57, 68 },
  { 39, 68, 45, 68 },
  { 49, 68, 54, 68 },
  { 37, 69, 45, 69 },
  { 48, 69, 54, 69 },
  { 36, 70, 45, 71 },
  { 47, 70, 54, 71 },
  { 37, 72, 44, 72 },
  { 48, 72, 53, 72 },
  { 40, 73, 43, 73 },
  { 48, 73, 52, 73 },
  { 41, 74, 43, 74 },
  { 48, 74, 51, 74 },
  { 49, 75, 49, 75 },
  { 51, 75, 51, 75 },
  { 50, 76, 51, 76 },
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
    if t.roll then
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


-- The computer player: the game's own AI groups, as the mission sets them up (the game runs them).
local ai_player

local function setup_ai(p)
  ai_player = p
end


-- The triggers CheckForFail reads (0x1100B6B4 to 0x1100B6D4), as the setup makes them on Normal: the Tiger, Panther,
-- Lynx and evacuation counts, the spacecraft components, the Observatory and Meteor Defense.
local t22, t24, t26, t28, t20, t30, t32
-- The waves' groups, made at their first call: EnemyArrive's (0x1100B6DC) and ScorpionWave's (0x1100B6D8); and
-- FirstStrike's repeating EnemyArrive trigger (0x1100B6B0), which HasThor stops.
local enemy_group, scorpion_group, enemy_repeat
-- Where the waves come in (0x1100B4C8 to 0x1100B508): a line's first tile and whether it runs along x (a
-- rectangle one tile high) or along y; the waves' target (0x1100B6E0).
local WAVE_LINES = {
  { 79, 128, true }, { 1, 1, true }, { 1, 32, false }, { 1, 62, false }, { 79, 1, true },
}
local WAVE_RECT = { 88, 40, 109, 61 }
-- EnemyArrive's unit tables, in the order of their records (type at +0, weapon at +0x14; `disasm --block` lists them
-- in another order): GroupType1 (0x1100B518), GroupType1Hard (0x1100B2A0),
-- GroupType2Easy (0x1100B328), GroupType2 (0x1100B5A0), GroupType2Hard (0x1100B3B0), GroupType3Easy (0x1100B438),
-- GroupType3 (0x1100B628).
local SC = { "Scorpion", "EnergyCannon" }
local WAVE_UNITS = {
  type1 = { SC, { "Lynx", "Microwave" }, { "Lynx", "RPG" }, { "Lynx", "Microwave" }, SC, { "Panther", "ESG" }, { "Panther", "EMP" },
    { "Spider" }, { "Spider" }, { "Spider" } },
  type1_hard = { SC, { "Lynx", "Microwave" }, { "Lynx", "RPG" }, { "Lynx", "RPG" }, { "Lynx", "Microwave" }, SC, SC, SC,
    { "Panther", "ESG" }, { "Panther", "EMP" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" } },
  type2_easy = { { "Panther", "Starflare" }, SC, SC, SC, SC, SC, { "Panther", "ESG" } },
  type2 = { { "Panther", "Starflare" }, SC, SC, SC, SC, SC, { "Tiger", "ESG" } },
  type2_hard = { SC, SC, { "Panther", "Starflare" }, SC, SC, SC, { "Tiger", "ESG" }, { "Tiger", "EMP" }, { "Panther", "Stickyfoam" },
    { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" } },
  type3_easy = { { "Lynx", "Microwave" }, { "Lynx", "Microwave" }, SC, SC, SC, SC, { "Panther", "RPG" }, { "Panther", "RPG" },
    { "Lynx", "ESG" }, { "Panther", "EMP" }, { "Panther", "Stickyfoam" }, { "Spider" }, { "Spider" }, { "Spider" } },
  type3 = { { "Lynx", "Microwave" }, { "Lynx", "Microwave" }, SC, SC, SC, SC, { "Panther", "RPG" }, { "Tiger", "RPG" },
    { "Tiger", "ESG" }, { "Tiger", "EMP" }, { "Tiger", "Stickyfoam" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" } },
}
-- Units made one tile apart along a wave's line, into a group.
local function line_up(group, line, units)
  for i, u in ipairs(units) do
    local at = line[3] and { line[1] + i - 1, line[2] } or { line[1], line[2] + i - 1 }
    group:take_unit(game.create_unit{ type = u[1], player = ai_player, at = at, weapon = u[2], exact = true, lights = false }[1])
  end
end
local function wave_group()
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(WAVE_RECT)
  return g
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local FirstStrike, Lava, Meteor1, Meteor2, MeteorRepeat, MeteorStart, Microbe, Quake1, Quake2, QuakeRepeat, QuakeStart, Storm1, Storm2, StormRepeat, StormStart, Tornado1, Tornado2, TornadoRepeat, TornadoStart

function FirstStrike(t)
  if players[1].difficulty == "Easy" then
    trigger.time{time = 1, on = EnemyArrive}  -- after 0 marks
    enemy_repeat = trigger.time{min = 9600, max = 14400, one_shot = false, on = EnemyArrive}  -- after 96 to 144 marks
    trigger.time{min = 5000, max = 6500, one_shot = false, on = ScorpionWave}  -- after 50 to 65 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{time = 1, on = EnemyArrive}  -- after 0 marks
    enemy_repeat = trigger.time{min = 9100, max = 13900, one_shot = false, on = EnemyArrive}  -- after 91 to 139 marks
    trigger.time{min = 2500, max = 3200, one_shot = false, on = ScorpionWave}  -- after 25 to 32 marks
  else
    trigger.time{time = 1, on = EnemyArrive}  -- after 0 marks
    enemy_repeat = trigger.time{min = 8600, max = 13400, one_shot = false, on = EnemyArrive}  -- after 86 to 134 marks
    trigger.time{min = 1800, max = 2400, one_shot = false, on = ScorpionWave}  -- after 18 to 24 marks
  end
end

function Lava(t)
  game.set_tile({ 72, 5 }, 1147)
  game.set_tile({ 72, 6 }, 1158)
  game.create_eruption({ 72, 7 }, 200)
end

function Meteor1(t)
  game.create_meteor({ 97, 43 }, -1)
end

function Meteor2(t)
  game.create_meteor({ 100, 61 }, -1)
end

function MeteorRepeat(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(2)
    local r2 = game.rand(127)
    local r3 = game.rand(127)
    game.create_meteor({ r3 + 1, r2 + 2 }, r1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(2)
    local r2 = game.rand(85)
    local r3 = game.rand(81)
    game.create_meteor({ r3 + 45, r2 + 15 }, r1)
  else
    local r1 = game.rand(85)
    local r2 = game.rand(81)
    game.create_meteor({ r2 + 45, r1 + 15 }, -1)
  end
end

function MeteorStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 4000, max = 5000, one_shot = false, on = MeteorRepeat}  -- after 40 to 50 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 4000, max = 5000, one_shot = false, on = MeteorRepeat}  -- after 40 to 50 marks
  else
    trigger.time{min = 3500, max = 4000, one_shot = false, on = MeteorRepeat}  -- after 35 to 40 marks
  end
end

function Microbe(t)
  if players[1].difficulty == "Easy" then
    game.create_blight({ 2, 128 })
    game.create_blight({ 2, 127 })
    game.create_blight({ 2, 126 })
    game.set_blight_speed(120)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 4064)
  elseif players[1].difficulty == "Normal" then
    game.create_blight({ 2, 128 })
    game.create_blight({ 2, 127 })
    game.create_blight({ 2, 126 })
    game.set_blight_speed(150)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 4064)
  else
    game.create_blight({ 2, 128 })
    game.create_blight({ 2, 127 })
    game.create_blight({ 2, 126 })
    game.set_blight_speed(180)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 4064)
  end
end

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 65, 7 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 65, 7 }, 3)
  else
    game.create_earthquake({ 65, 7 }, 3)
  end
end

function Quake2(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 71, 48 }, 2)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 71, 48 }, 2)
  else
    game.create_earthquake({ 71, 48 }, 3)
  end
end

function QuakeRepeat(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(4)
    local r2 = game.rand(18)
    local r3 = game.rand(118)
    game.create_earthquake({ r3 + 5, r2 + 6 }, r1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(4)
    local r2 = game.rand(20)
    local r3 = game.rand(118)
    game.create_earthquake({ r3 + 5, r2 + 6 }, r1)
  else
    local r1 = game.rand(4)
    local r2 = game.rand(20)
    local r3 = game.rand(118)
    game.create_earthquake({ r3 + 5, r2 + 6 }, r1)
  end
end

function QuakeStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 10000, max = 12000, one_shot = false, on = QuakeRepeat}  -- after 100 to 120 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 7000, max = 10000, one_shot = false, on = QuakeRepeat}  -- after 70 to 100 marks
  else
    trigger.time{min = 4800, max = 5500, one_shot = false, on = QuakeRepeat}  -- after 48 to 55 marks
  end
end

function Storm1(t)
  local r1 = game.rand(128)
  local r2 = game.rand(32)
  local r3 = game.rand(30)
  game.create_lightning({ r3 + 1, 62 }, { -r2 + 129, r1 + 1 }, 6)
end

function Storm2(t)
  local r1 = game.rand(128)
  local r2 = game.rand(32)
  local r3 = game.rand(30)
  game.create_lightning({ r3 + 1, 29 }, { -r2 + 129, r1 + 1 }, 8)
end

function StormRepeat(t)
  local r1 = game.rand(127)
  local r2 = game.rand(30)
  local r3 = game.rand(10)
  local r4 = game.rand(127)
  local r5 = game.rand(30)
  game.create_lightning({ r5 + 1, r4 + 2 }, { -r2 + 129, r1 + 2 }, r3 + 10)
end

function StormStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 9000, max = 11000, one_shot = false, on = StormRepeat}  -- after 90 to 110 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 7000, max = 9000, one_shot = false, on = StormRepeat}  -- after 70 to 90 marks
  else
    trigger.time{min = 4500, max = 5000, one_shot = false, on = StormRepeat}  -- after 45 to 50 marks
  end
end

function Tornado1(t)
  game.create_tornado({ 71, 48 }, { 113, 66 }, 14)
end

function Tornado2(t)
  game.create_tornado({ 101, 76 }, { 80, 25 }, 15)
end

function TornadoRepeat(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(30)
    local r2 = game.rand(110)
    local r3 = game.rand(10)
    local r4 = game.rand(30)
    local r5 = game.rand(110)
    game.create_tornado({ r5 + 10, r4 + 87 }, { r2 + 10, r1 + 87 }, r3 + 10)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(30)
    local r2 = game.rand(80)
    local r3 = game.rand(10)
    local r4 = game.rand(30)
    local r5 = game.rand(80)
    game.create_tornado({ r5 + 40, r4 + 71 }, { r2 + 40, r1 + 71 }, r3 + 10)
  else
    local r1 = game.rand(30)
    local r2 = game.rand(80)
    local r3 = game.rand(10)
    local r4 = game.rand(30)
    local r5 = game.rand(80)
    game.create_tornado({ r5 + 40, r4 + 71 }, { r2 + 40, r1 + 71 }, r3 + 10)
  end
end

function TornadoStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 8000, max = 10000, one_shot = false, on = TornadoRepeat}  -- after 80 to 100 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 5500, max = 8000, one_shot = false, on = TornadoRepeat}  -- after 55 to 80 marks
  else
    trigger.time{min = 3500, max = 4000, one_shot = false, on = TornadoRepeat}  -- after 35 to 40 marks
  end
end

-- Every 40 ticks (0x11003250): too few workers (8) or scientists (3), too little ore (Easy 8000 and 5000 rare,
-- Normal 10000 and 7500, Hard 10000 and 8000) with no way to mine more, a vehicle, spacecraft or building objective
-- unmet with no way to build it, or a technology it needs out of reach fails the colony.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  local ore = ({ Easy = 8000, Normal = 10000, Hard = 10000 })[p.difficulty] or 10000
  local rare = ({ Easy = 5000, Normal = 7500, Hard = 8000 })[p.difficulty] or 7500
  if p.ore < ore and not p:can_accumulate_ore() then fail = true end
  if p.rare_ore < rare and not p:can_accumulate_rare_ore() then fail = true end
  local function missing(list)
    for _, k in ipairs(list) do
      if not k:has_fired(1) then return true end
    end
    return false
  end
  if missing({ t22, t24, t26, t28 }) and not p:can_build_vehicle(1) then fail = true end
  if missing({ t20 }) and not p:can_build_space() then fail = true end
  if missing({ t30, t32 }) and not p:can_build_building() then fail = true end
  for _, tech in ipairs({ 10102, 8051, 8106, 7403, 10101, 8104, 8103 }) do
    if not p:has_tech(tech) and not p:can_do_research(tech) then fail = true end
  end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- A wave into one group, made at the first (0x11002FE0): a table drawn of three by difficulty, then a line drawn
-- (of four on Easy, all lights on; else of five, lights off from the north edge at 1,1 and 79,1).
function EnemyArrive(t)
  if not enemy_group then enemy_group = wave_group() end
  local d = players[1].difficulty
  local k = game.rand(3)
  local units
  if k == 0 then
    units = d == "Hard" and WAVE_UNITS.type1_hard or WAVE_UNITS.type1
  elseif k == 1 then
    units = ({ Easy = WAVE_UNITS.type2_easy, Hard = WAVE_UNITS.type2_hard })[d] or WAVE_UNITS.type2
  else
    units = d == "Hard" and WAVE_UNITS.type3 or WAVE_UNITS.type3_easy
  end
  local r, lights
  if d == "Easy" then
    r, lights = game.rand(4), true
  else
    r = game.rand(5)
    lights = r ~= 1 and r ~= 4
  end
  line_up(enemy_group, WAVE_LINES[r + 1], units)
  enemy_group:set_lights(lights)
end

-- Scorpions (Energy Cannon) into one group, made at the first (0x11003820): from the west edge (Easy, of two) or
-- the west and north edges (of three); 4 to 7 on Easy, 6 to 9 on Normal, 6 to 10 on Hard.
function ScorpionWave(t)
  if not scorpion_group then scorpion_group = wave_group() end
  local d = players[1].difficulty
  local line
  if d == "Easy" then
    line = game.rand(2) ~= 0 and WAVE_LINES[3] or WAVE_LINES[4]
  else
    line = WAVE_LINES[game.rand(3) + 3]
  end
  local n
  if d == "Easy" then n = game.rand(4) + 4
  elseif d == "Hard" then n = game.rand(5) + 6
  else n = game.rand(4) + 6 end
  local units = {}
  for i = 1, n do units[i] = SC end
  line_up(scorpion_group, line, units)
end

-- Artificial Lightning researched: FirstStrike's waves stop and come at a new pace (0x110039A0).
function HasThor(t)
  if enemy_repeat then enemy_repeat:disable() end
  local d = players[1].difficulty
  if d == "Easy" then
    trigger.time{min = 6500, max = 8000, one_shot = false, on = EnemyArrive}
  elseif d == "Normal" then
    trigger.time{min = 5000, max = 6000, one_shot = false, on = EnemyArrive}
  elseif d == "Hard" then
    trigger.time{min = 4500, max = 5200, one_shot = false, on = EnemyArrive}
  end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 72, 5 }, 1140)
  game.initial_set_tile({ 72, 6 }, 1150)
  game.set_daylight_everywhere(false)
  game.free_morale()
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end
  if difficulty == "Easy" then
    trigger.time{time = 7600, on = FirstStrike}  -- after 76 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 5800, on = FirstStrike}  -- after 58 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 4800, on = FirstStrike}  -- after 48 marks
  end

  -- The win.
  local t6 = trigger.resource{resource = "Food", compare = ">=", amount = 4000, player = 1}
  mission.victory(t6, "Have 4000 units of food in storage.")
  local t8, t10, t12, t16, t13, t14, t15, t17, t18, t19
  if difficulty == "Easy" then
    t8 = trigger.resource{resource = "RareOre", compare = ">=", amount = 5000, player = 1}
    mission.victory(t8, "Have 5000 units of Rare Metals in storage.")
    t10 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 8000, player = 1}
    mission.victory(t10, "Have 8000 units of Common Metals in storage.")
    t12 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t12, "Launch the Orbital Package.")
    t20 = trigger.count{type = "CommandModule", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t20, "Launch the Command Module.")
    t16 = trigger.count{type = "HabitatRing", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t16, "Launch the Habitat Ring.")
    t22 = trigger.count{type = "Tiger", compare = ">=", count = 4, player = 1}
    mission.victory(t22, "Have 4 or more Tigers.")
    t24 = trigger.count{type = "Panther", compare = ">=", count = 5, player = 1}
    mission.victory(t24, "Have 5 or more Panthers.")
    t26 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t26, "Have 6 or more Lynx.")
    t13 = trigger.count{type = "Scout", compare = ">=", count = 2, player = 1}
    mission.victory(t13, "Have 2 or more Scouts.")
  elseif difficulty == "Normal" then
    t8 = trigger.resource{resource = "RareOre", compare = ">=", amount = 7500, player = 1}
    mission.victory(t8, "Have 7500 units of Rare Metals in storage.")
    t10 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t10, "Have 10000 units of Common Metals in storage.")
    t12 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t13 = trigger.count{type = "CommandModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t15 = trigger.count{type = "HabitatRing", compare = ">=", count = 1, player = 1}
    t16 = trigger.count{type = "SensorPackage", compare = ">=", count = 1, player = 1}
    t17 = trigger.count{type = "StasisSystems", compare = ">=", count = 1, player = 1}
    t18 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1, player = 1}
    t19 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1, player = 1}
    t20 = trigger.set{t12, t13, t14, t15, t16, t17, t18, t19, needed = 4}
    mission.victory(t20, "Launch 3 more spacecraft components.")
    t22 = trigger.count{type = "Tiger", compare = ">=", count = 6, player = 1}
    mission.victory(t22, "Have 6 or more Tigers.")
    t24 = trigger.count{type = "Panther", compare = ">=", count = 7, player = 1}
    mission.victory(t24, "Have 7 or more Panthers.")
    t26 = trigger.count{type = "Lynx", compare = ">=", count = 8, player = 1}
    mission.victory(t26, "Have 8 or more Lynx.")
  elseif difficulty == "Hard" then
    t8 = trigger.resource{resource = "RareOre", compare = ">=", amount = 8000, player = 1}
    mission.victory(t8, "Have 8000 units of Rare Metals in storage.")
    t10 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t10, "Have 10000 units of Common Metals in storage.")
    t12 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t13 = trigger.count{type = "CommandModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t15 = trigger.count{type = "HabitatRing", compare = ">=", count = 1, player = 1}
    t16 = trigger.count{type = "SensorPackage", compare = ">=", count = 1, player = 1}
    t17 = trigger.count{type = "StasisSystems", compare = ">=", count = 1, player = 1}
    t18 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1, player = 1}
    t19 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1, player = 1}
    t20 = trigger.set{t12, t13, t14, t15, t16, t17, t18, t19, needed = 4}
    mission.victory(t20, "Launch 3 more spacecraft components.")
    t22 = trigger.count{type = "Tiger", compare = ">=", count = 6, player = 1}
    mission.victory(t22, "Have 6 or more Tigers.")
    t24 = trigger.count{type = "Panther", compare = ">=", count = 7, player = 1}
    mission.victory(t24, "Have 7 or more Panthers.")
    t26 = trigger.count{type = "Lynx", compare = ">=", count = 8, player = 1}
    mission.victory(t26, "Have 8 or more Lynx.")
  end
  t28 = trigger.evac{player = 1}
  mission.victory(t28, "Have enough Evacuation Transports for your population.")
  t30 = trigger.operational{type = "Observatory", compare = ">=", count = 1, player = 1, one_shot = false}
  mission.victory(t30, "Build an Observatory.")
  t32 = trigger.operational{type = "MeteorDefense", compare = ">=", count = 1, player = 1, one_shot = false}
  mission.victory(t32, "Build a Meteor Defense structure.")
  local t34 = trigger.research{tech = 10102, player = 1, one_shot = true, on = HasThor}
  mission.victory(t34, "Completely research Artificial Lightning.")
  local t36 = trigger.research{tech = 10101, player = 1, one_shot = true}
  mission.victory(t36, "Completely research Improved Launch Vehicle.")
  local t40 = trigger.resource{resource = "Scientists", compare = ">=", amount = 37, player = 1}
  mission.victory(t40, "Keep at least 37 scientists alive.")
  local t39 = trigger.resource{resource = "Workers", compare = ">=", amount = 41, player = 1}
  mission.victory(t39, "Keep at least 41 workers alive.")
  local t38 = trigger.resource{resource = "Kids", compare = ">=", amount = 70, player = 1}
  mission.victory(t38, "Keep at least 70 children alive.")
  local t58 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t58)
  trigger.time{min = 21000, max = 24000, on = Tornado1}  -- after 210 to 240 marks
  trigger.time{min = 47000, max = 50000, on = Tornado2}  -- after 470 to 500 marks
  trigger.time{min = 42000, max = 45000, on = Quake1}  -- after 420 to 450 marks
  trigger.time{min = 78000, max = 81000, on = Quake2}  -- after 780 to 810 marks
  trigger.time{min = 18000, max = 21000, on = Storm1}  -- after 180 to 210 marks
  trigger.time{min = 36000, max = 39000, on = Storm2}  -- after 360 to 390 marks
  trigger.time{min = 55600, max = 58600, on = Meteor1}  -- after 556 to 586 marks
  trigger.time{min = 65000, max = 68000, on = Meteor2}  -- after 650 to 680 marks
  trigger.time{min = 87100, max = 90100, on = Lava}  -- after 871 to 901 marks
  if difficulty == "Easy" then
    trigger.time{min = 100000, max = 103000, on = Microbe}  -- after 1000 to 1030 marks
    trigger.time{time = 12000, on = MeteorStart}  -- after 120 marks
  elseif difficulty == "Normal" then
    trigger.time{min = 75000, max = 78000, on = Microbe}  -- after 750 to 780 marks
    trigger.time{time = 12000, on = MeteorStart}  -- after 120 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 90000, max = 93000, on = Microbe}  -- after 900 to 930 marks
    trigger.time{time = 9000, on = MeteorStart}  -- after 90 marks
  end
  trigger.time{time = 8000, on = TornadoStart}  -- after 80 marks
  trigger.time{time = 8000, on = QuakeStart}  -- after 80 marks
  if difficulty == "Easy" then
    trigger.time{time = 14000, on = StormStart}  -- after 140 marks
  elseif difficulty == "Normal" or difficulty == "Hard" then
    trigger.time{time = 12000, on = StormStart}  -- after 120 marks
  end
  players[2]:default_group():set_rect({ 79, 128, 99, 128 })
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

