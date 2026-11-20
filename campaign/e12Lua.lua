-- e12Lua.lua  -  Eden Mission #12 (Lua)
-- Trigger functions finished by hand (SetPiece, Wave1, Wave2, Reinforce1, ToggleRe, ReinforceArrive, EnemyArrive, FireEMP1, TornadoStop, StormStart, StormStop, CheckForFail), from the disassembly of e12.dll.
-- Converted by op2dll from e12.dll. With e12Lua.placement.lua (what every difficulty makes alike),
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
        workers = 41, scientists = 37, kids = 70, food = 5000, ore = 8000, rare_ore = 4000,
        research = { 12000 },
        tech_level = 11,
        kits = { [1] = { "Agridome" }, [2] = { "Residence" }, [3] = { "MedicalCenter" }, [4] = { "MeteorDefense" } },
        view = { 89, 26 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 12,
        units = {
        },
      },
      [3] = {
        research = {  },
        tech_level = 12,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 69, 23 } }, { "Tube", { 69, 33 } }, { "Tube", { 70, 23 } }, { "Tube", { 70, 33 } },
      { "Tube", { 71, 23 } }, { "Tube", { 71, 33 } }, { "Tube", { 77, 35 } }, { "Tube", { 84, 12 } },
      { "Tube", { 88, 40 } }, { "Tube", { 89, 37 } }, { "Tube", { 89, 38 } }, { "Tube", { 89, 39 } },
      { "Tube", { 89, 40 } }, { "Tube", { 107, 15 } }, { "Tube", { 107, 16 } }, { "Tube", { 109, 32 } },
      { "Tube", { 111, 19 } }, { "Tube", { 112, 19 } }, { "Tube", { 113, 19 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 89, 26 } },
      { type = "AdvancedResidence", player = 1, at = { 82, 26 } },
      { type = "AdvancedResidence", player = 1, at = { 82, 19 } },
      { type = "CommonOreSmelter", player = 1, at = { 72, 19 } },
      { type = "RareOreSmelter", player = 1, at = { 72, 37 } },
      { type = "VehicleFactory", player = 1, at = { 72, 28 } },
      { type = "Agridome", player = 1, at = { 98, 23 } },
      { type = "Agridome", player = 1, at = { 98, 28 } },
      { type = "Agridome", player = 1, at = { 106, 23 } },
      { type = "Agridome", player = 1, at = { 106, 28 } },
      { type = "Tokamak", player = 1, at = { 90, 11 } },
      { type = "DIRT", player = 1, at = { 106, 32 } },
      { type = "MedicalCenter", player = 1, at = { 93, 34 } },
      { type = "RobotCommand", player = 1, at = { 85, 35 } },
      { type = "GeothermalPlant", player = 1, at = { 21, 58 } },
      { type = "Spaceport", player = 1, at = { 107, 19 } },
      { type = "AdvancedLab", player = 1, at = { 85, 40 } },
      { type = "StandardLab", player = 1, at = { 76, 11 } },
      { type = "CommonStorage", player = 1, at = { 84, 14 } },
      { type = "Residence", player = 1, at = { 76, 15 } },
      { type = "MedicalCenter", player = 1, at = { 77, 17 } },
      { type = "University", player = 1, at = { 82, 16 } },
      { type = "RareStorage", player = 1, at = { 77, 37 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 77, 23 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 77, 33 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 95, 11 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 84, 10 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 67, 23 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 67, 33 } },
      { type = "StructureFactory", player = 1, at = { 89, 34 } },
      { type = "Garage", player = 1, at = { 77, 26 } },
      { type = "DIRT", player = 1, at = { 93, 37 } },
      { type = "Observatory", player = 1, at = { 94, 28 } },
      { type = "MedicalCenter", player = 1, at = { 110, 28 } },
      { type = "Tokamak", player = 1, at = { 71, 44 } },
      { type = "Nursery", player = 1, at = { 107, 34 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 114, 19 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 110, 32 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 89, 41 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 107, 13 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 66, 6 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 95, 31 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 95, 33 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 95, 35 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 91, 36 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 108, 29 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 91, 27 } },
      { type = "RoboDozer", direction = "North", player = 1, at = { 108, 25 } },
      { type = "Earthworker", direction = "North", player = 1, at = { 85, 21 } },
      { type = "RoboDozer", direction = "North", player = 1, at = { 74, 33 } },
      { type = "Lynx", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 66, 40 } },
      { type = "Lynx", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 67, 14 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 80, 35 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 77, 30 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 73, 40 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 110, 24 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 93, 24 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "West", player = 1, at = { 109, 39 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 72, 12 } },
      { type = "Earthworker", direction = "NorthEast", player = 1, at = { 75, 37 } },
      { type = "RoboSurveyor", direction = "NorthWest", player = 1, at = { 71, 16 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 73, 16 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 98, 31 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthEast", player = 1, at = { 98, 33 } },
      { type = "Panther", weapon = "Laser", direction = "SouthWest", player = 1, at = { 82, 31 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 101, 16 } },
      { type = "Tiger", weapon = "EMP", direction = "NorthEast", player = 1, at = { 111, 17 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 112, 24 } },
      { type = "Tiger", weapon = "Laser", direction = "SouthEast", player = 1, at = { 93, 7 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 114, 27 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 80, 6 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 63, 18 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 78, 44 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 92, 47 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 124, 5 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 76, 16 } },
      { type = "Lynx", weapon = "AcidCloud", direction = "East", player = 1, at = { 85, 46 } },
      { type = "Lynx", weapon = "AcidCloud", direction = "East", player = 1, at = { 66, 28 } },
      { type = "Panther", weapon = "AcidCloud", direction = "East", player = 1, at = { 98, 10 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 86, 29 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 4, 58 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 10, 47 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 5, 5 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 27, 28 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 17, 37 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 21, 58 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 31, 37 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 63, 6 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 63, 6 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 125, 3 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 125, 3 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 34, 59 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 28, 10 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 85, 50 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 85, 50 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 41, scientists = 37, kids = 70, food = 4000, ore = 6000, rare_ore = 3000,
        research = { 12000 },
        tech_level = 11,
        kits = { [1] = { "Tokamak" }, [2] = { "Residence" }, [3] = { "MeteorDefense" }, [4] = { "GuardPost", "ThorsHammer" }, [5] = { "GuardPost", "RailGun" } },
        view = { 89, 26 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 12,
        units = {
        },
      },
      [3] = {
        research = {  },
        tech_level = 12,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 77, 35 } }, { "Tube", { 84, 12 } }, { "Tube", { 85, 37 } }, { "Tube", { 85, 38 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 89, 26 } },
      { type = "AdvancedResidence", player = 1, at = { 82, 26 } },
      { type = "AdvancedResidence", player = 1, at = { 82, 19 } },
      { type = "CommonOreSmelter", player = 1, at = { 72, 19 } },
      { type = "RareOreSmelter", player = 1, at = { 72, 37 } },
      { type = "VehicleFactory", player = 1, at = { 72, 28 } },
      { type = "Agridome", player = 1, at = { 98, 23 } },
      { type = "Agridome", player = 1, at = { 98, 28 } },
      { type = "Agridome", player = 1, at = { 106, 23 } },
      { type = "Agridome", player = 1, at = { 106, 28 } },
      { type = "Tokamak", player = 1, at = { 90, 11 } },
      { type = "DIRT", player = 1, at = { 106, 32 } },
      { type = "MedicalCenter", player = 1, at = { 93, 34 } },
      { type = "RobotCommand", player = 1, at = { 85, 35 } },
      { type = "GeothermalPlant", player = 1, at = { 21, 58 } },
      { type = "Spaceport", player = 1, at = { 107, 19 } },
      { type = "AdvancedLab", player = 1, at = { 85, 40 } },
      { type = "StandardLab", player = 1, at = { 76, 11 } },
      { type = "CommonStorage", player = 1, at = { 84, 14 } },
      { type = "Residence", player = 1, at = { 76, 15 } },
      { type = "MedicalCenter", player = 1, at = { 77, 17 } },
      { type = "University", player = 1, at = { 82, 16 } },
      { type = "RareStorage", player = 1, at = { 77, 37 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 77, 23 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 77, 33 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 95, 11 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 84, 10 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 67, 23 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 67, 33 } },
      { type = "StructureFactory", player = 1, at = { 89, 34 } },
      { type = "DIRT", player = 1, at = { 93, 37 } },
      { type = "Garage", player = 1, at = { 77, 26 } },
      { type = "Observatory", player = 1, at = { 94, 28 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 95, 31 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 95, 33 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 95, 35 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 91, 36 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 108, 29 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 91, 27 } },
      { type = "RoboDozer", direction = "North", player = 1, at = { 108, 25 } },
      { type = "Panther", weapon = "Laser", direction = "NorthWest", player = 1, at = { 110, 24 } },
      { type = "Panther", weapon = "Laser", direction = "NorthEast", player = 1, at = { 93, 24 } },
      { type = "Panther", weapon = "RailGun", direction = "West", player = 1, at = { 109, 39 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 72, 12 } },
      { type = "Earthworker", direction = "North", player = 1, at = { 85, 21 } },
      { type = "Earthworker", direction = "NorthEast", player = 1, at = { 75, 37 } },
      { type = "RoboSurveyor", direction = "NorthWest", player = 1, at = { 71, 16 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 73, 16 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 98, 31 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthEast", player = 1, at = { 98, 33 } },
      { type = "Panther", weapon = "Laser", direction = "SouthWest", player = 1, at = { 82, 31 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 101, 16 } },
      { type = "Tiger", weapon = "EMP", direction = "NorthEast", player = 1, at = { 111, 17 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 112, 24 } },
      { type = "Tiger", weapon = "Laser", direction = "SouthEast", player = 1, at = { 93, 7 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 114, 27 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 80, 6 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 63, 18 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 78, 44 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 92, 47 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 124, 5 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 76, 16 } },
      { type = "Lynx", weapon = "AcidCloud", direction = "East", player = 1, at = { 85, 46 } },
      { type = "Lynx", weapon = "AcidCloud", direction = "East", player = 1, at = { 66, 28 } },
      { type = "Panther", weapon = "AcidCloud", direction = "East", player = 1, at = { 98, 10 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 86, 29 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 4, 58 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 10, 47 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 5, 5 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 27, 28 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 17, 37 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 21, 58 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 31, 37 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 63, 6 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 63, 6 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 125, 3 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 125, 3 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 26, 62 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 85, 50 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 85, 50 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 85, 50 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 41, scientists = 37, kids = 70, food = 3000, ore = 6000, rare_ore = 3000,
        research = { 12000 },
        tech_level = 11,
        kits = { [1] = { "Residence" }, [2] = { "GuardPost", "RailGun" }, [3] = { "Observatory" }, [4] = { "MeteorDefense" } },
        view = { 89, 26 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 12,
        units = {
        },
      },
      [3] = {
        research = {  },
        tech_level = 12,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 85, 37 } }, { "Tube", { 85, 38 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 89, 26 } },
      { type = "AdvancedResidence", player = 1, at = { 82, 26 } },
      { type = "AdvancedResidence", player = 1, at = { 82, 19 } },
      { type = "CommonOreSmelter", player = 1, at = { 72, 19 } },
      { type = "RareOreSmelter", player = 1, at = { 72, 37 } },
      { type = "VehicleFactory", player = 1, at = { 72, 28 } },
      { type = "Agridome", player = 1, at = { 98, 23 } },
      { type = "Agridome", player = 1, at = { 98, 28 } },
      { type = "Agridome", player = 1, at = { 106, 23 } },
      { type = "Agridome", player = 1, at = { 106, 28 } },
      { type = "Tokamak", player = 1, at = { 90, 11 } },
      { type = "DIRT", player = 1, at = { 106, 32 } },
      { type = "MedicalCenter", player = 1, at = { 93, 34 } },
      { type = "RobotCommand", player = 1, at = { 85, 35 } },
      { type = "GeothermalPlant", player = 1, at = { 21, 58 } },
      { type = "Spaceport", player = 1, at = { 107, 19 } },
      { type = "AdvancedLab", player = 1, at = { 85, 40 } },
      { type = "StandardLab", player = 1, at = { 76, 11 } },
      { type = "CommonStorage", player = 1, at = { 84, 14 } },
      { type = "Residence", player = 1, at = { 76, 15 } },
      { type = "MedicalCenter", player = 1, at = { 77, 17 } },
      { type = "University", player = 1, at = { 82, 16 } },
      { type = "RareStorage", player = 1, at = { 77, 37 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 77, 23 } },
      { type = "GuardPost", weapon = "ThorsHammer", player = 1, at = { 77, 33 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 95, 11 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 84, 10 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 67, 23 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 67, 33 } },
      { type = "StructureFactory", player = 1, at = { 89, 34 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 95, 31 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 95, 33 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 95, 35 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 91, 36 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 108, 29 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 91, 27 } },
      { type = "RoboDozer", direction = "North", player = 1, at = { 108, 25 } },
      { type = "Panther", weapon = "Laser", direction = "NorthWest", player = 1, at = { 110, 24 } },
      { type = "Panther", weapon = "Laser", direction = "NorthEast", player = 1, at = { 93, 24 } },
      { type = "Panther", weapon = "RailGun", direction = "West", player = 1, at = { 109, 39 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 72, 12 } },
      { type = "Earthworker", direction = "NorthEast", player = 1, at = { 75, 37 } },
      { type = "RoboSurveyor", direction = "NorthWest", player = 1, at = { 71, 16 } },
      { type = "RoboMiner", direction = "West", player = 1, at = { 73, 16 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 98, 31 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthEast", player = 1, at = { 98, 33 } },
      { type = "Panther", weapon = "Laser", direction = "SouthWest", player = 1, at = { 82, 31 } },
      { type = "Tiger", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 101, 16 } },
      { type = "Tiger", weapon = "EMP", direction = "NorthEast", player = 1, at = { 111, 17 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 112, 24 } },
      { type = "Tiger", weapon = "Laser", direction = "SouthEast", player = 1, at = { 93, 7 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 114, 27 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 80, 6 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 63, 18 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "SouthEast", player = 1, at = { 78, 44 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 92, 47 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 124, 5 } },
      { type = "Tiger", weapon = "EMP", direction = "SouthEast", player = 1, at = { 76, 16 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 85, 46 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 66, 28 } },
      { type = "Panther", weapon = "EMP", direction = "East", player = 1, at = { 98, 10 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 86, 29 } },
      { type = "EvacuationTransport", direction = "NorthWest", player = 1, at = { 86, 29 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 4, 58 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 10, 47 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 5, 5 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 27, 28 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 17, 37 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 21, 58 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 31, 37 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 63, 6 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 63, 6 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 125, 3 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 125, 3 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 21, 46 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 85, 50 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 85, 50 } },
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

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function BringInKids(t) end
function StartEMP3(t) end


-- The evacuation triggers CheckForFail reads (0x1100B334, 0x1100B338): the Rare and Common Metals cargoes.
local t7, t9
-- The tornadoes' trigger (0x1100B310) and the storms' (0x1100B314), which TornadoStop and StormStop turn off.
local tornado_trigger, storm_trigger
-- Where the enemy and its EMP missiles aim (0x1100B358): the colony.
local COLONY = { 72, 19, 106, 34 }
-- EnemyArrive's two lines (0x1100B1E0, 0x1100B1F0): a column at x 115 from y 2, or a row at y 64 from x 35; and its
-- units in line order (GroupType1, 0x1100B200: its records in memory order).
local ENEMY_LINES = { { 115, 2, false }, { 35, 64, true } }
local ENEMY_UNITS = { { "Lynx", "RPG" }, { "Lynx", "Microwave" }, { "Tiger", "Supernova" }, { "Tiger", "ESG" }, { "Lynx", "EMP" } }
-- The waves' and reinforcements' unit blocks, by address, as the DLL ships them (the game's UnitBlock sorts them).
local WAVE_BLOCKS = {
  [0x1100B368] = {
    { type = "Lynx", at = { 128, 26 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 128, 28 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 128, 29 }, direction = "North", weapon = "Microwave" },
    { type = "Tiger", at = { 128, 30 }, direction = "North", weapon = "ESG" },
    { type = "Tiger", at = { 128, 32 }, direction = "North", weapon = "Supernova" },
    { type = "Scorpion", at = { 128, 33 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 34 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Spider", at = { 128, 36 }, direction = "North" },
    { type = "Spider", at = { 128, 37 }, direction = "North" },
    { type = "Spider", at = { 128, 38 }, direction = "North" },
    { type = "Spider", at = { 128, 39 }, direction = "North" },
    { type = "Spider", at = { 128, 40 }, direction = "North" },
    { type = "Spider", at = { 128, 41 }, direction = "North" },
  },
  [0x1100B158] = {
    { type = "Lynx", at = { 128, 26 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 128, 28 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 128, 28 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 128, 29 }, direction = "North", weapon = "Microwave" },
    { type = "Tiger", at = { 128, 30 }, direction = "North", weapon = "ESG" },
    { type = "Tiger", at = { 128, 32 }, direction = "North", weapon = "Supernova" },
    { type = "Scorpion", at = { 128, 33 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 34 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Spider", at = { 128, 36 }, direction = "North" },
    { type = "Spider", at = { 128, 37 }, direction = "North" },
    { type = "Spider", at = { 128, 38 }, direction = "North" },
    { type = "Spider", at = { 128, 39 }, direction = "North" },
    { type = "Spider", at = { 128, 40 }, direction = "North" },
    { type = "Spider", at = { 128, 41 }, direction = "North" },
    { type = "Spider", at = { 128, 42 }, direction = "North" },
    { type = "Spider", at = { 128, 43 }, direction = "North" },
  },
  [0x1100AAF0] = {
    { type = "Lynx", at = { 128, 26 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 128, 27 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 128, 28 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 128, 29 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 128, 28 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 128, 29 }, direction = "North", weapon = "RPG" },
    { type = "Tiger", at = { 128, 30 }, direction = "North", weapon = "ESG" },
    { type = "Tiger", at = { 128, 31 }, direction = "North", weapon = "ESG" },
    { type = "Tiger", at = { 128, 32 }, direction = "North", weapon = "Supernova" },
    { type = "Scorpion", at = { 128, 33 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 34 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 128, 35 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Spider", at = { 128, 36 }, direction = "North" },
    { type = "Spider", at = { 128, 37 }, direction = "North" },
    { type = "Spider", at = { 128, 38 }, direction = "North" },
    { type = "Spider", at = { 128, 39 }, direction = "North" },
    { type = "Spider", at = { 128, 40 }, direction = "North" },
    { type = "Spider", at = { 128, 41 }, direction = "North" },
    { type = "Spider", at = { 128, 42 }, direction = "North" },
    { type = "Spider", at = { 128, 43 }, direction = "North" },
  },
  [0x1100AE20] = {
    { type = "Lynx", at = { 35, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 36, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 39, 64 }, direction = "North", weapon = "Stickyfoam" },
    { type = "Scorpion", at = { 40, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 41, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 42, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 43, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 44, 64 }, direction = "North", weapon = "EnergyCannon" },
  },
  [0x1100B0C8] = {
    { type = "Panther", at = { 83, 2 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 85, 2 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 86, 2 }, direction = "North", weapon = "ESG" },
    { type = "Scorpion", at = { 89, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 90, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 91, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 92, 2 }, direction = "North", weapon = "EnergyCannon" },
  },
  [0x1100AC00] = {
    { type = "Lynx", at = { 35, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 36, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 38, 64 }, direction = "North", weapon = "Stickyfoam" },
    { type = "Lynx", at = { 39, 64 }, direction = "North", weapon = "Stickyfoam" },
    { type = "Scorpion", at = { 40, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 41, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 42, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 43, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 44, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 43, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 44, 64 }, direction = "North", weapon = "EnergyCannon" },
  },
  [0x1100AF30] = {
    { type = "Panther", at = { 83, 2 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 84, 2 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 85, 2 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 86, 2 }, direction = "North", weapon = "ESG" },
    { type = "Scorpion", at = { 89, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 90, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 89, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 90, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 91, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 92, 2 }, direction = "North", weapon = "EnergyCannon" },
  },
  [0x1100B040] = {
    { type = "Lynx", at = { 35, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 36, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 37, 64 }, direction = "North", weapon = "Microwave" },
    { type = "Panther", at = { 38, 64 }, direction = "North", weapon = "Stickyfoam" },
    { type = "Scorpion", at = { 40, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 41, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 42, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 43, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 44, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 43, 64 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 44, 64 }, direction = "North", weapon = "EnergyCannon" },
  },
  [0x1100B288] = {
    { type = "Lynx", at = { 83, 2 }, direction = "North", weapon = "RPG" },
    { type = "Panther", at = { 84, 2 }, direction = "North", weapon = "RPG" },
    { type = "Lynx", at = { 85, 2 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 86, 2 }, direction = "North", weapon = "ESG" },
    { type = "Panther", at = { 87, 2 }, direction = "North", weapon = "ESG" },
    { type = "Scorpion", at = { 89, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 90, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 91, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 92, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 91, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 92, 2 }, direction = "North", weapon = "EnergyCannon" },
  },
  [0x1100AB78] = {
    { type = "Lynx", at = { 115, 2 }, direction = "North", weapon = "RPG" },
    { type = "Lynx", at = { 116, 2 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 117, 2 }, direction = "North", weapon = "EMP" },
    { type = "Scorpion", at = { 119, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 120, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 121, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Spider", at = { 122, 2 }, direction = "North" },
    { type = "Spider", at = { 123, 2 }, direction = "North" },
    { type = "Spider", at = { 124, 2 }, direction = "North" },
  },
  [0x1100B3F0] = {
    { type = "Lynx", at = { 115, 2 }, direction = "North", weapon = "RPG" },
    { type = "Lynx", at = { 116, 2 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 117, 2 }, direction = "North", weapon = "EMP" },
    { type = "Lynx", at = { 118, 2 }, direction = "North", weapon = "EMP" },
    { type = "Scorpion", at = { 119, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 120, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 121, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 121, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Spider", at = { 122, 2 }, direction = "North" },
    { type = "Spider", at = { 123, 2 }, direction = "North" },
    { type = "Spider", at = { 124, 2 }, direction = "North" },
    { type = "Spider", at = { 124, 2 }, direction = "North" },
  },
  [0x1100AD98] = {
    { type = "Lynx", at = { 115, 2 }, direction = "North", weapon = "RPG" },
    { type = "Lynx", at = { 116, 2 }, direction = "North", weapon = "Microwave" },
    { type = "Lynx", at = { 117, 2 }, direction = "North", weapon = "EMP" },
    { type = "Panther", at = { 118, 2 }, direction = "North", weapon = "EMP" },
    { type = "Panther", at = { 118, 2 }, direction = "North", weapon = "RPG" },
    { type = "Scorpion", at = { 119, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 120, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 121, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 121, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 121, 2 }, direction = "North", weapon = "EnergyCannon" },
    { type = "Spider", at = { 122, 2 }, direction = "North" },
    { type = "Spider", at = { 123, 2 }, direction = "North" },
    { type = "Spider", at = { 124, 2 }, direction = "North" },
    { type = "Spider", at = { 124, 2 }, direction = "North" },
  },
}
local wave_blocks = {}
local function wave_block(addr)
  wave_blocks[addr] = wave_blocks[addr] or ai.unit_block(WAVE_BLOCKS[addr])
  return wave_blocks[addr]
end
-- ReinforceArrive's units by block (type and weapon, in the order the game sorted them: `op2dll disasm --block`),
-- made on a line of four.
local ARRIVE_UNITS = {
  [0x1100AEA8] = {
    { "Scorpion", "EnergyCannon" }, { "Lynx", "Microwave" }, { "Scorpion", "EnergyCannon" }, { "Lynx", "RPG" },
    { "Scorpion", "EnergyCannon" }, { "Lynx", "EMP" }, { "Spider" }, { "Spider" }, { "Spider" },
  },
  [0x1100AC88] = {
    { "Scorpion", "EnergyCannon" }, { "Lynx", "Microwave" }, { "Scorpion", "EnergyCannon" },
    { "Scorpion", "EnergyCannon" }, { "Scorpion", "EnergyCannon" }, { "Lynx", "RPG" }, { "Lynx", "EMP" },
    { "Lynx", "EMP" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" },
  },
  [0x1100AD10] = {
    { "Panther", "Microwave" }, { "Panther", "Microwave" }, { "Panther", "RPG" }, { "Scorpion", "EnergyCannon" },
    { "Scorpion", "EnergyCannon" }, { "Panther", "RPG" },
  },
  [0x1100AFB8] = {
    { "Scorpion", "EnergyCannon" }, { "Lynx", "Microwave" }, { "Scorpion", "EnergyCannon" }, { "Panther", "RPG" },
    { "Scorpion", "EnergyCannon" }, { "Scorpion", "EnergyCannon" }, { "Lynx", "RPG" }, { "Scorpion", "EnergyCannon" },
    { "Panther", "EMP" }, { "Lynx", "EMP" }, { "Spider" }, { "Spider" }, { "Spider" }, { "Spider" },
  },
}
-- ReinforceArrive's four lines (0x1100B478 to 0x1100B4A8): a row at y 64 from x 35, a row at y 2 from x 83, a column
-- at x 128 from y 51, a row at y 2 from x 115.
local ARRIVE_LINES = { { 35, 64, true }, { 83, 2, true }, { 128, 51, false }, { 115, 2, true } }
-- SetPiece's calls (0x1100B348); the waves' (0x1100B33C, 0x1100B340), Reinforce1's (0x1100B344), ReinforceArrive's
-- (0x1100B324) and ToggleRe's (0x1100B328) triggers.
local set_pieces = 0
local wave1_trigger, wave2_trigger, reinforce1_trigger, arrive_trigger, toggle_re_trigger

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Meteor1, Meteor2, MeteorRepeat, MeteorStart, Quake1, Quake2, Quake3, StartEnemies, Storm1, StormStart, Tornado

function Meteor1(t)
  local r1 = game.rand(25)
  local r2 = game.rand(24)
  game.create_meteor({ r2 + 100, r1 + 37 }, 1)
end

function Meteor2(t)
  local r1 = game.rand(21)
  local r2 = game.rand(22)
  game.create_meteor({ r2 + 39, r1 + 18 }, 2)
end

function MeteorRepeat(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(32)
    local r2 = game.rand(68)
    game.create_meteor({ r2 + 52, r1 + 10 }, -1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(2)
    local r2 = game.rand(48)
    local r3 = game.rand(82)
    game.create_meteor({ r3 + 42, r2 + 4 }, r1)
  else
    local r1 = game.rand(32)
    local r2 = game.rand(68)
    game.create_meteor({ r2 + 52, r1 + 10 }, -1)
  end
end

function MeteorStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 7000, max = 9000, one_shot = false, on = MeteorRepeat}  -- after 70 to 90 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 8000, max = 9000, one_shot = false, on = MeteorRepeat}  -- after 80 to 90 marks
  else
    trigger.time{min = 7000, max = 9000, one_shot = false, on = MeteorRepeat}  -- after 70 to 90 marks
  end
end

function Quake1(t)
  game.create_earthquake({ 23, 32 }, 1)
end

function Quake2(t)
  game.create_earthquake({ 51, 7 }, 2)
end

function Quake3(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 54, 49 }, 2)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 54, 49 }, 2)
  else
    game.create_earthquake({ 54, 49 }, 3)
  end
end

function StartEnemies(t)
  if players[1].difficulty == "Easy" then
    trigger.count{type = "RLV", cargo = "None", compare = ">=", count = 1, player = 1, one_shot = true, on = StartEMP3}
    trigger.time{min = 8000, max = 10000, one_shot = false, on = FireEMP1}  -- after 80 to 100 marks
  elseif players[1].difficulty == "Normal" then
    trigger.count{type = "RLV", cargo = "None", compare = ">=", count = 1, player = 1, one_shot = true, on = StartEMP3}
    trigger.time{min = 6000, max = 9000, one_shot = false, on = FireEMP1}  -- after 60 to 90 marks
    trigger.time{min = 6000, max = 9000, one_shot = false, on = EnemyArrive}  -- after 60 to 90 marks
  else
    trigger.time{time = 24000, on = SetPiece}  -- after 240 marks
    trigger.count{type = "RLV", cargo = "None", compare = ">=", count = 1, player = 1, one_shot = true, on = SetPiece}
    trigger.time{min = 6000, max = 7700, one_shot = false, on = FireEMP1}  -- after 60 to 77 marks
    trigger.time{min = 6000, max = 9000, one_shot = false, on = EnemyArrive}  -- after 60 to 90 marks
  end
end

function Storm1(t)
  local r1 = game.rand(64)
  local r2 = game.rand(64)
  game.create_lightning({ 1, r2 + 1 }, { 128, r1 + 1 }, 1)
end


function Tornado(t)
  local r1 = game.rand(4)
  game.create_tornado({ ({ 112, 128, 34, 50 })[r1 + 1], ({ 64, 57, 64, 64 })[r1 + 1] }, { ({ 47, 128, 62, 128 })[r1 + 1], ({ 2, 27, 2, 38 })[r1 + 1] }, ({ 23, 19, 14, 16 })[r1 + 1])
end

-- Hard: at mark 300 or when an RLV is made, whichever comes first (0x11003950, 0x11003D30): an EMP missile of
-- the computer's from 0,0 to near the colony's best target for one (up to 5 tiles up and left; the y's draw first),
-- then the two waves.
function SetPiece(t)
  set_pieces = set_pieces + 1
  if set_pieces ~= 1 then return end
  local at = game.find_emp_missile_target(COLONY, 1)
  local dy = game.rand(5)
  local dx = game.rand(5)
  game.create_emp_missile({ x = at.x + dx - 5, y = at.y + dy - 5, raw = true }, { x = 0, y = 0, raw = true }, 2)
  wave1_trigger = trigger.time{min = ({ Easy = 600, Normal = 1200, Hard = 500 })[players[1].difficulty] or 1200,
                               max = 1000, on = Wave1}
  wave2_trigger = trigger.time{min = 1800, max = 2400, on = Wave2}
end

-- SetPiece's first wave (0x11003F00): a group attacking the colony with the difficulty's block, Reinforce1's
-- trigger 10 to 15 marks on.
function Wave1(t)
  wave1_trigger:destroy()
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(COLONY)
  g:add_units(wave_block(({ Easy = 0x1100B368, Normal = 0x1100B158, Hard = 0x1100AAF0 })[players[1].difficulty] or 0x1100B158))
  g:set_lights(true)
  g:set_delete_when_empty(true)
  if reinforce1_trigger then reinforce1_trigger:destroy() end
  reinforce1_trigger = trigger.time{min = 1000, max = 1500, on = Reinforce1}
end

-- SetPiece's second wave (0x11004000): two groups attacking the colony from the south-west and the north, then
-- once ReinforceArrive's trigger (fewer than 8, 10 or 12 vehicles of the computer's) and ToggleRe's timer, off.
function Wave2(t)
  wave2_trigger:destroy()
  local d = players[1].difficulty
  for _, addr in ipairs(({ Easy = { 0x1100AE20, 0x1100B0C8 }, Hard = { 0x1100B040, 0x1100B288 } })[d]
                        or { 0x1100AC00, 0x1100AF30 }) do
    local g = ai.fight_group(ai_player)
    g:do_attack_enemy()
    g:set_rect(COLONY)
    g:add_units(wave_block(addr))
    g:set_lights(true)
    g:set_delete_when_empty(true)
  end
  if arrive_trigger then return end
  local n = ({ Easy = { 8, 3000, 3500 }, Hard = { 12, 2200, 2500 } })[d] or { 10, 2500, 3000 }
  arrive_trigger = trigger.vehicle_count{compare = "<", count = n[1], player = ai_player, one_shot = false, on = ReinforceArrive}
  toggle_re_trigger = trigger.time{min = n[2], max = n[3], one_shot = false, enabled = false, on = ToggleRe}
end

-- 10 to 15 marks after the first wave (0x110042A0): a group attacking the colony from the north.
function Reinforce1(t)
  reinforce1_trigger:destroy()
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(COLONY)
  g:add_units(wave_block(({ Easy = 0x1100AB78, Normal = 0x1100B3F0, Hard = 0x1100AD98 })[players[1].difficulty] or 0x1100B3F0))
  g:set_lights(true)
  g:set_delete_when_empty(true)
end

-- ReinforceArrive's wait over (0x11004350): its timer off and its vehicle count on again.
function ToggleRe(t)
  if toggle_re_trigger then toggle_re_trigger:disable() end
  arrive_trigger:enable()
end

-- The computer down to its count of vehicles (0x11004380): the count off and ToggleRe's timer on, and a group
-- attacking the colony made of the difficulty's block (Normal's drawn of two), East-facing on a line drawn of four.
function ReinforceArrive(t)
  if arrive_trigger then arrive_trigger:disable() end
  toggle_re_trigger:enable()
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(COLONY)
  local d = players[1].difficulty
  local addr = ({ Easy = 0x1100AEA8, Hard = 0x1100AFB8 })[d]
  if not addr then addr = game.rand(2) == 0 and 0x1100AC88 or 0x1100AD10 end
  local line = ARRIVE_LINES[game.rand(4) + 1]
  for i, u in ipairs(ARRIVE_UNITS[addr]) do
    local at = line[3] and { line[1] + i - 1, line[2] } or { line[1], line[2] + i - 1 }
    local made = game.create_unit{type = u[1], player = ai_player, at = at, direction = "East", weapon = u[2],
                                  lights = false, exact = true}
    if made[1] then g:take_unit(made[1]) end
  end
  g:set_lights(true)
  g:set_delete_when_empty(true)
end

-- Every 60 to 90 marks from mark 60 on Normal and Hard (0x11003090): five units attack the colony, East-facing on a
-- line drawn of two, lights on.
function EnemyArrive(t)
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(COLONY)
  local line = ENEMY_LINES[game.rand(2) + 1]
  for i, u in ipairs(ENEMY_UNITS) do
    local at = line[3] and { line[1] + i - 1, line[2] } or { line[1], line[2] + i - 1 }
    local made = game.create_unit{type = u[1], player = ai_player, at = at, direction = "East", weapon = u[2],
                                  lights = false, exact = true}
    if made[1] then g:take_unit(made[1]) end
  end
  g:set_lights(true)
end

-- Every 60 to 100 marks from mark 60 (0x11003C50): an EMP missile of the computer's, from 0,0 to near the colony's
-- best target for one (up to 8 tiles up and left; the y's draw first).
function FireEMP1(t)
  local at = game.find_emp_missile_target(COLONY, 1)
  local dy = game.rand(8)
  local dx = game.rand(8)
  game.create_emp_missile({ x = at.x + dx - 8, y = at.y + dy - 8, raw = true }, { x = 0, y = 0, raw = true }, 2)
end

-- Mark 480 (0x11003240): no more tornadoes.
function TornadoStop(t)
  tornado_trigger:disable()
end

-- Mark 600 (0x11003260): the storms end in 360 marks; until then one every 120 to 140 marks (Easy) or 100 to 120.
function StormStart(t)
  trigger.time{time = 36000, on = StormStop}
  if players[1].difficulty == "Easy" then
    storm_trigger = trigger.time{min = 12000, max = 14000, one_shot = false, on = Storm1}
  else
    storm_trigger = trigger.time{min = 10000, max = 12000, one_shot = false, on = Storm1}
  end
end

-- 360 marks after the storms start (0x11003340): no more.
function StormStop(t)
  if storm_trigger then storm_trigger:disable() end
end

-- Every 40 ticks (0x11004520): the colony's checks; ore only while its cargo hasn't gone.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  if not p:can_build_space() then fail = true end
  if not t9:has_fired(1) and not p:can_accumulate_ore() then fail = true end
  if not t7:has_fired(1) and not p:can_accumulate_rare_ore() then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(false)

  -- The win.
  local t5 = trigger.count{type = "FoodCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t5, "Evacuate 10000 units of food to spacecraft.", {one_shot = true})
  t7 = trigger.count{type = "RareMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t7, "Evacuate 10000 units of Rare Metals to spacecraft.", {one_shot = true})
  t9 = trigger.count{type = "CommonMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t9, "Evacuate 10000 units of Common Metals to spacecraft.", {one_shot = true})
  trigger.set{t5, t7, t9, needed = 3, one_shot = true, on = BringInKids}
  local t12e, t14e, t16e, t18e
  if difficulty == "Easy" then
    t12e = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, one_shot = true}
    mission.victory(t12e, "Launch the Fueling Systems.", {one_shot = true})
    t14e = trigger.count{type = "SensorPackage", compare = ">=", count = 1, one_shot = true}
    mission.victory(t14e, "Launch the Sensor Package.", {one_shot = true})
    t16e = trigger.count{type = "StasisSystems", compare = ">=", count = 1, one_shot = true}
    mission.victory(t16e, "Launch the Stasis Systems.", {one_shot = true})
    t18e = trigger.count{type = "PhoenixModule", compare = ">=", count = 1, one_shot = true}
    mission.victory(t18e, "Launch the Phoenix Module.", {one_shot = true})
  end
  trigger.time{time = 6000, on = StartEnemies}  -- after 60 marks
  if difficulty == "Easy" then
    tornado_trigger = trigger.time{min = 12000, max = 18000, one_shot = false, on = Tornado}  -- after 120 to 180 marks
  elseif difficulty == "Normal" then
    tornado_trigger = trigger.time{min = 10000, max = 16000, one_shot = false, on = Tornado}  -- after 100 to 160 marks
  elseif difficulty == "Hard" then
    tornado_trigger = trigger.time{min = 8000, max = 14000, one_shot = false, on = Tornado}  -- after 80 to 140 marks
  end
  trigger.time{time = 48000, on = TornadoStop}  -- after 480 marks
  if difficulty == "Normal" then
    trigger.time{time = 13000, on = MeteorStart}  -- after 130 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 10000, on = MeteorStart}  -- after 100 marks
  end
  trigger.time{time = 3600, on = Quake1}  -- after 36 marks
  trigger.time{time = 12000, on = Quake2}  -- after 120 marks
  trigger.time{time = 36000, on = Quake3}  -- after 360 marks
  if difficulty == "Easy" then
    trigger.time{time = 72000, on = StormStart}  -- after 720 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 60000, on = StormStart}  -- after 600 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 40000, on = StormStart}  -- after 400 marks
  end
  trigger.time{min = 36000, max = 42000, on = Meteor1}  -- after 360 to 420 marks
  trigger.time{min = 48000, max = 54000, on = Meteor2}  -- after 480 to 540 marks
  mission.failure(trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1})
  players[2]:default_group():set_rect({ 115, 2, 126, 2 })
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

-- Not converted:
-- - BringInKids isn't converted: a count trigger on a cargo
-- - StartEMP3 isn't converted: it calls ScStub::IsInitialized
-- - trigger #11 calls BringInKids, but isn't converted: its member trigger #5 isn't converted
-- - AIProc isn't converted yet (15000 game calls in the first 300 marks with nobody playing)
