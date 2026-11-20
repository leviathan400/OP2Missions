-- e08Lua.lua  -  Eden Mission #8 (Lua)
-- Trigger functions finished by hand (CheckForFail, DualDone, SkydockDone, EnemyArrive1N, EnemyArrive2N, EnemyArrive3N, EnemyArrive4N, EnemyArrive5N, EnemyArrive6N, EnemyArrive1Q, EnemyArrive2Q, EnemyArrive4Q), from the disassembly of e08.dll.
-- Converted by op2dll from e08.dll. With e08Lua.placement.lua (what every difficulty makes alike),
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
        workers = 30, scientists = 20, kids = 40, food = 2000, ore = 4000, rare_ore = 1000,
        research = { 8000 },
        tech_level = 7,
        view = { 27, 60 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 8,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 17, 70 } }, { "Tube", { 18, 70 } }, { "Tube", { 18, 74 } }, { "Tube", { 20, 73 } },
      { "Tube", { 30, 77 } }, { "Tube", { 30, 78 } }, { "Tube", { 32, 56 } }, { "Tube", { 32, 57 } },
      { "Tube", { 32, 58 } }, { "Tube", { 33, 72 } }, { "Tube", { 33, 73 } }, { "Tube", { 35, 66 } },
      { "Tube", { 36, 60 } }, { "Tube", { 37, 60 } }, { "Tube", { 37, 68 } }, { "Tube", { 37, 72 } },
      { "Tube", { 38, 60 } }, { "Tube", { 39, 60 } }, { "Tube", { 40, 66 } }, { "Tube", { 40, 70 } },
      { "Tube", { 41, 62 } }, { "Tube", { 41, 70 } }, { "Tube", { 42, 70 } }, { "Tube", { 43, 70 } },
      { "Tube", { 45, 74 } }, { "Tube", { 45, 75 } }, { "Tube", { 45, 76 } }, { "Tube", { 46, 59 } },
      { "Tube", { 47, 59 } }, { "Tube", { 48, 59 } }, { "Tube", { 48, 71 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 5, 41 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 5, 41 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 71 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 54, 71 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 21, 87 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 55, 7 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 39, 38 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 37, 84 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 116 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 13, 33 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 43, 51 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 53, 46 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 31, 103 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 27, 60 } },
      { type = "Agridome", player = 1, at = { 33, 60 } },
      { type = "CommonOreSmelter", player = 1, at = { 28, 66 } },
      { type = "RareStorage", player = 1, at = { 16, 66 } },
      { type = "StructureFactory", player = 1, at = { 20, 66 } },
      { type = "CommonStorage", player = 1, at = { 24, 59 } },
      { type = "University", player = 1, at = { 39, 62 } },
      { type = "Nursery", player = 1, at = { 43, 62 } },
      { type = "Agridome", player = 1, at = { 20, 71 } },
      { type = "Agridome", player = 1, at = { 37, 66 } },
      { type = "Residence", player = 1, at = { 20, 75 } },
      { type = "Residence", player = 1, at = { 33, 66 } },
      { type = "Tokamak", player = 1, at = { 21, 49 } },
      { type = "StandardLab", player = 1, at = { 37, 70 } },
      { type = "RobotCommand", player = 1, at = { 42, 66 } },
      { type = "Residence", player = 1, at = { 38, 74 } },
      { type = "Agridome", player = 1, at = { 39, 60 } },
      { type = "AdvancedLab", player = 1, at = { 45, 71 } },
      { type = "RareOreSmelter", player = 1, at = { 32, 53 } },
      { type = "Spaceport", player = 1, at = { 32, 75 } },
      { type = "VehicleFactory", player = 1, at = { 33, 69 } },
      { type = "DIRT", player = 1, at = { 39, 57 } },
      { type = "DIRT", player = 1, at = { 46, 71 } },
      { type = "MedicalCenter", player = 1, at = { 43, 60 } },
      { type = "MedicalCenter", player = 1, at = { 16, 74 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 12, 61 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 15, 70 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 28, 78 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 43, 76 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 48, 57 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 26, 44 } },
      { type = "GeothermalPlant", player = 1, at = { 53, 46 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 35, 61 } },
      { type = "Lynx", weapon = "RailGun", direction = "North", player = 1, at = { 47, 61 } },
      { type = "Lynx", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 49, 73 } },
      { type = "Panther", weapon = "Laser", direction = "NorthWest", player = 1, at = { 35, 79 } },
      { type = "RoboDozer", direction = "South", player = 1, at = { 46, 56 } },
      { type = "RoboDozer", direction = "West", player = 1, at = { 31, 79 } },
      { type = "RepairVehicle", direction = "SouthWest", player = 1, at = { 40, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 22, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 30, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 29, 61 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 28, 50 } },
      { type = "RoboMiner", direction = "South", player = 1, at = { 21, 58 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 21, 60 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 31, 56 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 33, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 35, 56 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 25, 70 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 25, 72 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 27, 70 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 27, 72 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 29, 72 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 29, 70 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 31, 72 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 23, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 16, 58 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 16, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 18, 58 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 18, 60 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 27, 54 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 30, scientists = 20, kids = 40, food = 2000, ore = 4000, rare_ore = 1500,
        research = { 8000 },
        tech_level = 7,
        kits = { [1] = { "Agridome" }, [2] = { "Spaceport" }, [3] = { "RareOreSmelter" }, [4] = { "Residence" } },
        view = { 27, 60 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 8,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 20, 73 } }, { "Tube", { 26, 62 } }, { "Tube", { 35, 66 } }, { "Tube", { 37, 68 } },
      { "Tube", { 37, 72 } }, { "Tube", { 40, 66 } }, { "Tube", { 40, 70 } }, { "Tube", { 41, 70 } },
      { "Tube", { 42, 70 } }, { "Tube", { 43, 70 } }, { "Tube", { 44, 70 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 36, 23 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 54, 71 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 54, 71 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 50, 88 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 50, 88 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 16, 97 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 55, 7 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 39, 38 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 37, 84 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 116 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 13, 33 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 43, 51 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 45, 56 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 33, 95 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 27, 60 } },
      { type = "Agridome", player = 1, at = { 33, 60 } },
      { type = "CommonOreSmelter", player = 1, at = { 28, 66 } },
      { type = "RareStorage", player = 1, at = { 16, 66 } },
      { type = "StructureFactory", player = 1, at = { 20, 66 } },
      { type = "Tokamak", player = 1, at = { 27, 49 } },
      { type = "Agridome", player = 1, at = { 20, 71 } },
      { type = "Agridome", player = 1, at = { 37, 66 } },
      { type = "Residence", player = 1, at = { 20, 75 } },
      { type = "Residence", player = 1, at = { 33, 66 } },
      { type = "Tokamak", player = 1, at = { 21, 49 } },
      { type = "StandardLab", player = 1, at = { 37, 70 } },
      { type = "RobotCommand", player = 1, at = { 42, 66 } },
      { type = "Residence", player = 1, at = { 38, 74 } },
      { type = "DIRT", player = 1, at = { 41, 74 } },
      { type = "MedicalCenter", player = 1, at = { 37, 60 } },
      { type = "AdvancedLab", player = 1, at = { 46, 70 } },
      { type = "University", player = 1, at = { 24, 62 } },
      { type = "VehicleFactory", player = 1, at = { 24, 74 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 22, 64 } },
      { type = "Scout", direction = "SouthWest", player = 1, at = { 19, 58 } },
      { type = "RoboDozer", direction = "SouthWest", player = 1, at = { 44, 62 } },
      { type = "GeoCon", direction = "SouthWest", player = 1, at = { 36, 53 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 33, 71 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 19, 62 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 41, 62 } },
      { type = "Nursery", player = 1, at = { 33, 63 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 22, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 30, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 29, 61 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 28, 50 } },
      { type = "RoboMiner", direction = "South", player = 1, at = { 21, 58 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 21, 60 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 31, 56 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 33, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 35, 56 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 25, 70 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 25, 72 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 27, 70 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 27, 72 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 29, 72 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 29, 70 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 31, 72 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 23, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 16, 58 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 16, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 18, 58 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 18, 60 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 27, 54 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 30, scientists = 20, kids = 40, food = 2000, ore = 4000, rare_ore = 2000,
        research = { 8000 },
        tech_level = 7,
        kits = { [1] = { "AdvancedLab" }, [2] = { "Spaceport" }, [3] = { "DIRT" }, [4] = { "Residence" } },
        view = { 27, 60 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 8,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 36, 23 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 54, 71 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 54, 71 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 16, 97 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 63, 107 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 63, 107 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 55, 7 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 39, 38 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 37, 84 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 116 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 13, 33 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 43, 51 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 53, 46 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 31, 103 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 27, 60 } },
      { type = "Agridome", player = 1, at = { 33, 60 } },
      { type = "CommonOreSmelter", player = 1, at = { 28, 66 } },
      { type = "RareStorage", player = 1, at = { 16, 66 } },
      { type = "StructureFactory", player = 1, at = { 20, 66 } },
      { type = "Nursery", player = 1, at = { 27, 57 } },
      { type = "University", player = 1, at = { 33, 63 } },
      { type = "Residence", player = 1, at = { 37, 60 } },
      { type = "Residence", player = 1, at = { 27, 63 } },
      { type = "Agridome", player = 1, at = { 20, 74 } },
      { type = "VehicleFactory", player = 1, at = { 33, 69 } },
      { type = "Tokamak", player = 1, at = { 27, 49 } },
      { type = "RobotCommand", player = 1, at = { 20, 71 } },
      { type = "RareOreSmelter", player = 1, at = { 38, 66 } },
      { type = "MedicalCenter", player = 1, at = { 17, 71 } },
      { type = "StandardLab", player = 1, at = { 33, 66 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 35, 61 } },
      { type = "GeoCon", direction = "South", player = 1, at = { 21, 54 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 22, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 30, 68 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 29, 61 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 28, 50 } },
      { type = "RoboMiner", direction = "South", player = 1, at = { 21, 58 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 21, 60 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 31, 56 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 33, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 35, 56 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 25, 70 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 25, 72 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 27, 70 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 27, 72 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 29, 72 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 29, 70 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 31, 72 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 23, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 16, 58 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 16, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 18, 58 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 18, 60 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 27, 54 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 27, 54 } },
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


-- The triggers CheckForFail reads (0x1100AB70 to 0x1100AB8C), as the setup makes them on Normal: the Panther, Lynx,
-- Scout and evacuation counts, the Ion Drive, Fusion Drive or Fueling Systems and Skydock in orbit.
local t19, t21, t23, t25, t11, t15, t17
-- Slots the objective callbacks fill: DualDone's three Tigers (0x1100AB70), SkydockDone's modules on Easy
-- (0x1100AB84, 0x1100AB88).
local dual_tigers, skydock_ion, skydock_fusion
-- Where a wave comes in, by GetRand(3) (0x1100AA30, 0x1100AA40, 0x1100AA50): its first tile and whether its units
-- line up along x (a rectangle one tile high) or along y. Its target (0x1100AB90).
local ENEMY_LINES = { { 23, 128, true }, { 62, 9, false }, { 1, 23, false } }
local ENEMY_RECT = { 20, 49, 33, 66 }
-- The waves' unit tables by index (the jump table at 0x11002F88): the first when GetRand(2) isn't 0 (always on
-- Easy), else the second; in the order of their records (type at +0, weapon at +0x14).
local SC = { "Scorpion", "EnergyCannon" }
local ENEMY_UNITS = {
  { { { "Lynx", "Microwave" }, { "Lynx", "Microwave" } },
    { { "Lynx", "Microwave" }, { "Panther", "RPG" }, { "Lynx", "Microwave" } } },
  { { { "Panther", "RPG" }, { "Lynx", "Stickyfoam" } },
    { { "Panther", "RPG" }, { "Panther", "RPG" }, { "Lynx", "Microwave" }, { "Tiger", "ESG" }, { "Lynx", "Stickyfoam" } } },
  { { SC, SC, { "Lynx", "EMP" }, { "Spider" } },
    { SC, SC, { "Panther", "RPG" }, { "Lynx", "EMP" }, { "Spider" } } },
  { { SC, SC, { "Lynx", "EMP" }, { "Lynx", "EMP" }, { "Spider" }, { "Spider" } },
    { SC, SC, SC, SC, { "Lynx", "EMP" }, { "Lynx", "EMP" }, { "Lynx", "EMP" }, { "Spider" }, { "Spider" } } },
  { { { "Panther", "RPG" } },
    { { "Panther", "RPG" }, { "Panther", "ESG" } } },
  { { SC, SC, { "Lynx", "Microwave" }, { "Lynx", "EMP" }, { "Lynx", "EMP" }, { "Spider" } },
    { SC, SC, { "Lynx", "Microwave" }, { "Lynx", "Microwave" }, { "Lynx", "Microwave" }, { "Lynx", "EMP" }, { "Lynx", "EMP" },
      { "Lynx", "EMP" }, { "Spider" } } },
  { { { "Panther", "Starflare" }, { "Panther", "RPG" } },
    { { "Panther", "Supernova" }, { "Panther", "RPG" }, { "Panther", "Stickyfoam" } } },
  { { { "Tiger", "RPG" }, { "Lynx", "Stickyfoam" } },
    { { "Tiger", "ESG" }, { "Tiger", "ESG" }, { "Lynx", "Stickyfoam" } } },
  { { SC, { "Lynx", "RPG" }, { "Lynx", "Stickyfoam" }, { "Spider" } },
    { SC, SC, { "Lynx", "RPG" }, { "Lynx", "RPG" }, { "Lynx", "Stickyfoam" }, { "Lynx", "Stickyfoam" }, { "Spider" } } },
  { { { "Panther", "RPG" }, { "Panther", "EMP" } },
    { { "Panther", "ESG" }, { "Panther", "EMP" }, { "Panther", "EMP" }, { "Panther", "Stickyfoam" } } },
  { { { "Panther", "Starflare" }, { "Panther", "EMP" } },
    { { "Tiger", "Supernova" }, { "Tiger", "ESG" }, { "Tiger", "ESG" }, { "Tiger", "EMP" } } },
}
-- A wave (0x11002D70): a new attacking group; a table drawn between `lo` and `hi`, its kind drawn off Easy first;
-- the units made one tile apart along a line drawn of three, then their lights on.
local function enemy_arrive(lo, hi)
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(ENEMY_RECT)
  local first = players[1].difficulty == "Easy" or game.rand(2) ~= 0
  local k = game.rand(hi - lo + 1) + lo
  local units = ENEMY_UNITS[k + 1][first and 1 or 2]
  local line = ENEMY_LINES[game.rand(3) + 1]
  for i, u in ipairs(units) do
    local at = line[3] and { line[1] + i - 1, line[2] } or { line[1], line[2] + i - 1 }
    g:take_unit(game.create_unit{ type = u[1], player = ai_player, at = at, weapon = u[2], exact = true, lights = false }[1])
  end
  g:set_lights(true)
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local EnemyRepeat6N, Meteor1, Meteor2, MeteorEasyRepeater, MeteorMedRepeater, MeteorStarter, Microbe, Quake1, Quake2, Quake3, Quake4, Quake5, QuakeRepeater, QuakeStarter, Storm1, Storm2, StormMedRepeater, StormStarter

function EnemyRepeat6N(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 6500, max = 6800, one_shot = false, on = EnemyArrive6N}  -- after 65 to 68 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 6500, max = 6800, one_shot = false, on = EnemyArrive6N}  -- after 65 to 68 marks
  else
    trigger.time{min = 4500, max = 5000, one_shot = false, on = EnemyArrive6N}  -- after 45 to 50 marks
  end
end

function Meteor1(t)
  if players[1].difficulty == "Easy" then
    game.create_meteor({ 25, 60 }, 0)
    trigger.time{min = 300, max = 600, on = Meteor2}  -- after 3 to 6 marks
  elseif players[1].difficulty == "Normal" then
    game.create_meteor({ 25, 60 }, 0)
    trigger.time{min = 3600, max = 4600, on = Meteor2}  -- after 36 to 46 marks
  else
    game.create_meteor({ 25, 60 }, 0)
    trigger.time{min = 300, max = 600, on = Meteor2}  -- after 3 to 6 marks
  end
end

function Meteor2(t)
  game.create_meteor({ 34, 59 }, 1)
end

function MeteorEasyRepeater(t)
  local r1 = game.rand(56)
  local r2 = game.rand(49)
  game.create_meteor({ r2 + 8, r1 + 30 }, 0)
end

function MeteorMedRepeater(t)
  local r1 = game.rand(2)
  local r2 = game.rand(55)
  local r3 = game.rand(40)
  game.create_meteor({ r3 + 12, r2 + 35 }, r1)
end

function MeteorStarter(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 10500, max = 11500, one_shot = false, on = MeteorEasyRepeater}  -- after 105 to 115 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 6000, max = 7000, one_shot = false, on = MeteorMedRepeater}  -- after 60 to 70 marks
  else
    trigger.time{min = 5200, max = 6000, one_shot = false, on = MeteorMedRepeater}  -- after 52 to 60 marks
  end
end

function Microbe(t)
  if players[1].difficulty == "Easy" then
    game.create_blight({ 1, 51 })
    game.create_blight({ 1, 52 })
    game.create_blight({ 1, 53 })
    game.set_blight_speed(300)
    game.message_at("Microbe growth detected!", 152, 1, 1024, 1600)
  elseif players[1].difficulty == "Normal" then
    game.create_blight({ 1, 51 })
    game.create_blight({ 1, 52 })
    game.create_blight({ 1, 53 })
    game.set_blight_speed(240)
    game.message_at("Microbe growth detected!", 152, 1, 1024, 1600)
  else
    game.create_blight({ 1, 51 })
    game.create_blight({ 1, 52 })
    game.create_blight({ 1, 53 })
    game.set_blight_speed(300)
    game.message_at("Microbe growth detected!", 152, 1, 1024, 1600)
  end
end

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 17, 17 }, 3)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 17, 17 }, 2)
  else
    game.create_earthquake({ 17, 17 }, 3)
  end
end

function Quake2(t)
  game.create_earthquake({ 31, 92 }, 2)
  trigger.time{min = 3600, max = 4800, on = Quake3}  -- after 36 to 48 marks
end

function Quake3(t)
  game.create_earthquake({ 13, 54 }, 2)
  trigger.time{min = 3600, max = 4800, on = Quake4}  -- after 36 to 48 marks
end

function Quake4(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 47, 50 }, 2)
    trigger.time{min = 3600, max = 4800, on = Quake5}  -- after 36 to 48 marks
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 47, 50 }, 1)
    trigger.time{min = 3600, max = 4800, on = Quake5}  -- after 36 to 48 marks
  else
    game.create_earthquake({ 47, 50 }, 2)
    trigger.time{min = 3600, max = 4800, on = Quake5}  -- after 36 to 48 marks
  end
end

function Quake5(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 34, 24 }, 2)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 33, 48 }, 2)
  else
    game.create_earthquake({ 34, 24 }, 2)
  end
end

function QuakeRepeater(t)
  local r1 = game.rand(2)
  local r2 = game.rand(48)
  local r3 = game.rand(64)
  game.create_earthquake({ r3, r2 + 81 }, r1 + 1)
end

function QuakeStarter(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 8000, max = 9000, one_shot = false, on = QuakeRepeater}  -- after 80 to 90 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 3000, max = 4000, one_shot = false, on = QuakeRepeater}  -- after 30 to 40 marks
  else
    trigger.time{min = 3000, max = 4000, one_shot = false, on = QuakeRepeater}  -- after 30 to 40 marks
  end
end

function Storm1(t)
  game.create_lightning({ 62, 5 }, { 0, 101 }, 14)
end

function Storm2(t)
  game.create_lightning({ 32, 2 }, { 3, 128 }, 20)
end

function StormMedRepeater(t)
  local r1 = game.rand(12)
  local r2 = game.rand(63)
  local r3 = game.rand(20)
  local r4 = game.rand(63)
  game.create_lightning({ r4, r3 + 1 }, { r2, r1 + 111 }, 14)
end

function StormStarter(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 10500, max = 11500, one_shot = false, on = StormMedRepeater}  -- after 105 to 115 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 7200, max = 7500, one_shot = false, on = StormMedRepeater}  -- after 72 to 75 marks
  else
    trigger.time{min = 5200, max = 5800, one_shot = false, on = StormMedRepeater}  -- after 52 to 58 marks
  end
end

-- Every 40 ticks (0x11003710): too few workers (8) or scientists (3), too little ore (10000; rare 4000 on Easy,
-- else 5000) with no way to mine more, a vehicle objective unmet with no way to build vehicles, a space objective
-- unmet with no way to build for space, or Dual-Turret Weapons (8201) or 3901 out of reach fails the colony.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  if p.ore < 10000 and not p:can_accumulate_ore() then fail = true end
  if p.rare_ore < (p.difficulty == "Easy" and 4000 or 5000) and not p:can_accumulate_rare_ore() then fail = true end
  local function missing(slots, n)
    local m = false
    for i = 1, n do
      if slots[i] and not slots[i]:has_fired(1) then m = true end
    end
    return m
  end
  if missing({ dual_tigers, t19, t21, t23, t25 }, 5) and not p:can_build_vehicle(1) then fail = true end
  local space = p.difficulty == "Easy" and { skydock_ion, skydock_fusion, t11 } or { t11, t15, t17 }
  if missing(space, 3) and not p:can_build_space() then fail = true end
  for _, tech in ipairs({ 3901, 8201 }) do
    if not p:has_tech(tech) and not p:can_do_research(tech) then fail = true end
  end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Dual-Turret Weapons researched: a new objective, three Tigers (0x110039D0).
function DualDone(t)
  dual_tigers = trigger.count{type = "Tiger", compare = ">=", count = 3, player = 1}
  mission.victory(dual_tigers, "Have 3 or more Tigers.")
  game.message_at("New Objective", 122, nil, -1, -1)
end

-- The Skydock in orbit: on Easy, new objectives, the Ion Drive and Fusion Drive modules (0x11003A50).
function SkydockDone(t)
  if players[1].difficulty ~= "Easy" then return end
  skydock_ion = trigger.count{type = "IonDriveModule", compare = ">=", count = 1, player = 1, one_shot = true}
  mission.victory(skydock_ion, "Place the Ion Drive module in orbit.")
  skydock_fusion = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1, one_shot = true}
  mission.victory(skydock_fusion, "Place the Fusion Drive module in orbit.")
  game.message_at("New Objective", 122, nil, -1, -1)
end

-- A wave of the tables 0 to 1 (0x11002FF0, on to 0x11002D70).
function EnemyArrive1N(t) enemy_arrive(0, 1) end

-- A wave of the tables 0 to 3 (0x11003000, on to 0x11002D70).
function EnemyArrive2N(t) enemy_arrive(0, 3) end

-- A wave of the tables 3 to 5 (0x11003010, on to 0x11002D70).
function EnemyArrive3N(t) enemy_arrive(3, 5) end

-- A wave of the tables 4 to 6 (0x11003020, on to 0x11002D70).
function EnemyArrive4N(t) enemy_arrive(4, 6) end

-- A wave of the tables 6 to 8 (0x11003030, on to 0x11002D70).
function EnemyArrive5N(t) enemy_arrive(6, 8) end

-- A wave of the tables 7 to 10 (0x11003040, on to 0x11002D70).
function EnemyArrive6N(t) enemy_arrive(7, 10) end

-- A wave of the tables 0 to 1 (0x11002FC0, on to 0x11002D70).
function EnemyArrive1Q(t) enemy_arrive(0, 1) end

-- A wave of the tables 2 to 4 (0x11002FD0, on to 0x11002D70).
function EnemyArrive2Q(t) enemy_arrive(2, 4) end

-- A wave of the tables 5 to 10 (0x11002FE0, on to 0x11002D70).
function EnemyArrive4Q(t) enemy_arrive(5, 10) end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(false)
  game.free_morale()

  -- The win.
  local t5, t7, t9, t13, t14
  if difficulty == "Easy" then
    t5 = trigger.resource{resource = "Food", compare = ">=", amount = 3000, player = 1}
    mission.victory(t5, "Have 3000 units of food in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 4000, player = 1}
    mission.victory(t7, "Have 4000 units of Rare Metals in storage.")
    t9 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 8000, player = 1}
    mission.victory(t9, "Have 8000 units of Common Metals in storage.")
  elseif difficulty == "Normal" then
    t5 = trigger.resource{resource = "Food", compare = ">=", amount = 4000, player = 1}
    mission.victory(t5, "Have 4000 units of food in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 7500, player = 1}
    mission.victory(t7, "Have 7500 units of Rare Metals in storage.")
    t9 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t9, "Have 10000 units of Common Metals in storage.")
    t11 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t11, "Place the Ion Drive Module in orbit.")
    t13 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t15 = trigger.set{t13, t14, needed = 1}
    mission.victory(t15, "Place the Fusion Drive Module OR the Fueling Systems in orbit.")
  elseif difficulty == "Hard" then
    t5 = trigger.resource{resource = "Food", compare = ">=", amount = 4000, player = 1}
    mission.victory(t5, "Have 4000 units of food in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 8000, player = 1}
    mission.victory(t7, "Have 8000 units of Rare Metals in storage.")
    t9 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t9, "Have 10000 units of Common Metals in storage.")
    t11 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t11, "Place the Ion Drive Module in orbit.")
    t13 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t15 = trigger.set{t13, t14, needed = 1}
    mission.victory(t15, "Place the Fusion Drive Module OR the Fueling Systems in orbit.")
  end
  t17 = trigger.count{type = "Skydock", compare = ">=", count = 1, player = 1, one_shot = true, on = SkydockDone}
  mission.victory(t17, "Place the Skydock in orbit.")
  local t19h
  if difficulty == "Easy" then
    t19 = trigger.count{type = "Panther", compare = ">=", count = 4, player = 1}
    mission.victory(t19, "Have 4 or more Panthers.")
    t21 = trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1}
    mission.victory(t21, "Have 4 or more Lynx.")
    t23 = trigger.count{type = "Scout", compare = ">=", count = 2, player = 1}
    mission.victory(t23, "Have 2 or more Scouts.")
  elseif difficulty == "Normal" then
    t19 = trigger.count{type = "Panther", compare = ">=", count = 4, player = 1}
    mission.victory(t19, "Have 4 or more Panthers.")
    t21 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t21, "Have 6 or more Lynx.")
    t23 = trigger.count{type = "Scout", compare = ">=", count = 3, player = 1}
    mission.victory(t23, "Have 3 or more Scouts.")
  elseif difficulty == "Hard" then
    t19h = trigger.count{type = "Tiger", compare = ">=", count = 4, player = 1}
    mission.victory(t19h, "Have 4 or more Tigers.")
    t19 = trigger.count{type = "Panther", compare = ">=", count = 5, player = 1}
    mission.victory(t19, "Have 5 or more Panthers.")
    t21 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t21, "Have 6 or more Lynx.")
    t23 = trigger.count{type = "Scout", compare = ">=", count = 3, player = 1}
    mission.victory(t23, "Have 3 or more Scouts.")
  end
  t25 = trigger.evac{player = 1}
  mission.victory(t25, "Have enough Evacuation Transports for your population.")
  local t27
  if difficulty == "Easy" or difficulty == "Normal" then
    t27 = trigger.research{tech = 8201, player = 1, one_shot = true, on = DualDone}
    mission.victory(t27, "Completely research Dual-Turret Weapons Systems.")
  end
  local t31 = trigger.resource{resource = "Scientists", compare = ">=", amount = 27, player = 1}
  mission.victory(t31, "Keep at least 27 scientists alive.")
  local t30 = trigger.resource{resource = "Workers", compare = ">=", amount = 36, player = 1}
  mission.victory(t30, "Keep at least 36 workers alive.")
  local t29 = trigger.resource{resource = "Kids", compare = ">=", amount = 54, player = 1}
  mission.victory(t29, "Keep at least 54 children alive.")
  local t55 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t55)
  if difficulty == "Easy" then
    trigger.time{time = 6000, on = StormStarter}  -- after 60 marks
    trigger.time{time = 6000, on = MeteorStarter}  -- after 60 marks
    trigger.time{time = 2000, on = QuakeStarter}  -- after 20 marks
    trigger.time{time = 68400, on = Microbe}  -- after 684 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 6000, on = StormStarter}  -- after 60 marks
    trigger.time{time = 8000, on = MeteorStarter}  -- after 80 marks
    trigger.time{time = 6000, on = QuakeStarter}  -- after 60 marks
    trigger.time{time = 3600, on = Quake1}  -- after 36 marks
    trigger.time{time = 48000, on = Quake2}  -- after 480 marks
    trigger.time{time = 32400, on = Meteor1}  -- after 324 marks
    trigger.time{min = 39600, max = 45600, on = Storm2}  -- after 396 to 456 marks
    trigger.time{time = 69400, on = Microbe}  -- after 694 marks
    trigger.time{min = 6000, max = 8000, on = EnemyArrive1N}  -- after 60 to 80 marks
    trigger.time{min = 12000, max = 15000, on = EnemyArrive2N}  -- after 120 to 150 marks
    trigger.time{min = 12000, max = 15000, on = EnemyArrive2N}  -- after 120 to 150 marks
    trigger.time{min = 19000, max = 22000, on = EnemyArrive3N}  -- after 190 to 220 marks
    trigger.time{min = 19000, max = 22000, on = EnemyArrive3N}  -- after 190 to 220 marks
    trigger.time{min = 27000, max = 31000, on = EnemyArrive4N}  -- after 270 to 310 marks
    trigger.time{min = 27000, max = 31000, on = EnemyArrive4N}  -- after 270 to 310 marks
    trigger.time{min = 35000, max = 40000, on = EnemyArrive5N}  -- after 350 to 400 marks
    trigger.time{min = 35000, max = 40000, on = EnemyArrive5N}  -- after 350 to 400 marks
    trigger.time{min = 45000, max = 48000, on = EnemyArrive6N}  -- after 450 to 480 marks
    trigger.time{min = 45000, max = 48000, on = EnemyArrive6N}  -- after 450 to 480 marks
    trigger.time{time = 48000, on = EnemyRepeat6N}  -- after 480 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 8400, on = StormStarter}  -- after 84 marks
    trigger.time{time = 11000, on = MeteorStarter}  -- after 110 marks
    trigger.time{time = 2000, on = QuakeStarter}  -- after 20 marks
    trigger.time{time = 3600, on = Quake1}  -- after 36 marks
    trigger.time{time = 48000, on = Quake2}  -- after 480 marks
    trigger.time{time = 32400, on = Meteor1}  -- after 324 marks
    trigger.time{min = 8400, max = 14400, on = Storm1}  -- after 84 to 144 marks
    trigger.time{min = 39600, max = 45600, on = Storm2}  -- after 396 to 456 marks
    trigger.time{time = 74000, on = Microbe}  -- after 740 marks
    trigger.time{min = 5800, max = 7800, on = EnemyArrive1N}  -- after 58 to 78 marks
    trigger.time{min = 10000, max = 12000, on = EnemyArrive2N}  -- after 100 to 120 marks
    trigger.time{min = 10000, max = 12000, on = EnemyArrive2N}  -- after 100 to 120 marks
    trigger.time{min = 15000, max = 17000, on = EnemyArrive3N}  -- after 150 to 170 marks
    trigger.time{min = 15000, max = 17000, on = EnemyArrive3N}  -- after 150 to 170 marks
    trigger.time{min = 21000, max = 23000, on = EnemyArrive4N}  -- after 210 to 230 marks
    trigger.time{min = 21000, max = 23000, on = EnemyArrive4N}  -- after 210 to 230 marks
    trigger.time{min = 21000, max = 23000, on = EnemyArrive4N}  -- after 210 to 230 marks
    trigger.time{min = 27200, max = 30200, on = EnemyArrive5N}  -- after 272 to 302 marks
    trigger.time{min = 27200, max = 30200, on = EnemyArrive5N}  -- after 272 to 302 marks
    trigger.time{min = 27200, max = 30200, on = EnemyArrive5N}  -- after 272 to 302 marks
    trigger.time{min = 35400, max = 38400, on = EnemyArrive6N}  -- after 354 to 384 marks
    trigger.time{min = 35400, max = 38400, on = EnemyArrive6N}  -- after 354 to 384 marks
    trigger.time{min = 35400, max = 38400, on = EnemyArrive6N}  -- after 354 to 384 marks
    trigger.time{time = 38400, on = EnemyRepeat6N}  -- after 384 marks
  end
  players[2]:default_group():set_rect({ 1, 23, 1, 34 })
  if difficulty == "Easy" then
    trigger.time{min = 8000, max = 10000, on = EnemyArrive1Q}  -- after 80 to 100 marks
    trigger.time{min = 14000, max = 32000, on = EnemyArrive2Q}  -- after 140 to 320 marks
    trigger.time{min = 14000, max = 32000, on = EnemyArrive2Q}  -- after 140 to 320 marks
    trigger.time{min = 38000, max = 48000, on = EnemyArrive4Q}  -- after 380 to 480 marks
    trigger.time{min = 38000, max = 48000, on = EnemyArrive4Q}  -- after 380 to 480 marks
    trigger.time{min = 38000, max = 48000, on = EnemyArrive4Q}  -- after 380 to 480 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

