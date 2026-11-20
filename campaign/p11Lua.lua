-- p11Lua.lua  -  Plymouth Mission #11 (Lua)
-- Trigger functions finished by hand (CheckForFail, Strike, Part2, MainAttack, DoTrickle, StopTrickle, Reinforce, AnnoyStart, Annoy), from the disassembly of p11.dll.
-- Converted by op2dll from p11.dll. With p11Lua.placement.lua (what every difficulty makes alike),
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
        workers = 42, scientists = 23, kids = 60, food = 2600, ore = 6000, rare_ore = 2000,
        research = { 11000 },
        tech_level = 11,
        kits = { [1] = { "Residence" }, [2] = { "MedicalCenter" }, [3] = { "CommonOreSmelter" }, [4] = { "CommandCenter" } },
        view = { 5, 113 },
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
      { "Tube", { 5, 109 } }, { "Tube", { 8, 117 } }, { "Tube", { 8, 123 } }, { "Tube", { 9, 117 } },
      { "Tube", { 9, 123 } }, { "Tube", { 10, 107 } }, { "Tube", { 10, 123 } }, { "Tube", { 11, 107 } },
      { "Tube", { 11, 123 } }, { "Tube", { 29, 115 } }, { "Tube", { 31, 104 } }, { "Tube", { 32, 104 } },
      { "Tube", { 35, 92 } }, { "Tube", { 35, 93 } }, { "Tube", { 35, 94 } }, { "Tube", { 44, 98 } },
      { "Tube", { 53, 109 } }, { "Tube", { 54, 109 } }, { "Tube", { 55, 109 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 119, 97 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 119, 97 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 26, 35 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 35, 68 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 35, 68 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 12, 50 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 102, 12 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 80, 26 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 113, 120 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 77, 89 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 94, 74 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 89 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 16, 105 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 118, 53 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 52 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 5, 113 } },
      { type = "AdvancedLab", player = 1, at = { 5, 123 } },
      { type = "Residence", player = 1, at = { 12, 112 } },
      { type = "Spaceport", player = 1, at = { 17, 117 } },
      { type = "Agridome", player = 1, at = { 19, 126 } },
      { type = "VehicleFactory", player = 1, at = { 30, 124 } },
      { type = "Agridome", player = 1, at = { 26, 115 } },
      { type = "StructureFactory", player = 1, at = { 38, 124 } },
      { type = "Nursery", player = 1, at = { 5, 107 } },
      { type = "University", player = 1, at = { 8, 107 } },
      { type = "ArachnidFactory", player = 1, at = { 44, 100 } },
      { type = "Spider", direction = "East", player = 1, at = { 44, 100 } },
      { type = "Spider", direction = "East", player = 1, at = { 44, 100 } },
      { type = "Spider", direction = "East", player = 1, at = { 44, 100 } },
      { type = "Spider", direction = "East", player = 1, at = { 44, 100 } },
      { type = "Spider", direction = "East", player = 1, at = { 44, 100 } },
      { type = "Spider", direction = "East", player = 1, at = { 44, 100 } },
      { type = "RobotCommand", player = 1, at = { 39, 113 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 29, 95 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 53, 114 } },
      { type = "Agridome", player = 1, at = { 26, 112 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 29, 104 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 11, 105 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 24, 104 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 45, 123 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 9, 106 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 45, 87 } },
      { type = "ConVec", direction = "East", player = 1, at = { 33, 122 } },
      { type = "ConVec", direction = "East", player = 1, at = { 45, 120 } },
      { type = "StandardLab", player = 1, at = { 26, 109 } },
      { type = "CommonOreSmelter", player = 1, at = { 35, 104 } },
      { type = "Garage", player = 1, at = { 35, 113 } },
      { type = "RareOreSmelter", player = 1, at = { 50, 109 } },
      { type = "Residence", player = 1, at = { 40, 96 } },
      { type = "Residence", player = 1, at = { 44, 96 } },
      { type = "MedicalCenter", player = 1, at = { 36, 96 } },
      { type = "MedicalCenter", player = 1, at = { 24, 126 } },
      { type = "DIRT", player = 1, at = { 5, 117 } },
      { type = "DIRT", player = 1, at = { 40, 93 } },
      { type = "Agridome", player = 1, at = { 43, 109 } },
      { type = "MHDGenerator", player = 1, at = { 46, 118 } },
      { type = "MHDGenerator", player = 1, at = { 6, 102 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 30, 115 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 38, 121 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 10, 117 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 35, 90 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 56, 109 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 14, 119 } },
      { type = "ConVec", direction = "NorthEast", player = 1, at = { 40, 126 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 107 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 53, 109 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 111 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 37, 108 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 39, 108 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 38, 110 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 13, 126 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 15, 126 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 29, 100 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 32, 109 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 21, 119 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 4, 115 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 20, 113 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 21, 114 } },
      { type = "Tiger", weapon = "EMP", direction = "East", player = 1, at = { 20, 123 } },
      { type = "Panther", weapon = "RPG", direction = "SouthWest", player = 1, at = { 44, 109 } },
      { type = "Panther", weapon = "RPG", direction = "South", player = 1, at = { 45, 107 } },
      { type = "Panther", weapon = "EMP", direction = "East", player = 1, at = { 46, 112 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 33, 99 } },
      { type = "Lynx", weapon = "Microwave", direction = "South", player = 1, at = { 34, 98 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 36, 99 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 27, 106 } },
      { type = "Tiger", weapon = "ESG", direction = "SouthEast", player = 1, at = { 24, 118 } },
      { type = "Tiger", weapon = "Supernova", direction = "SouthWest", player = 1, at = { 21, 122 } },
      { type = "Lynx", weapon = "ESG", direction = "NorthEast", player = 1, at = { 25, 106 } },
      { type = "Panther", weapon = "Supernova", direction = "SouthWest", player = 1, at = { 44, 111 } },
      { type = "Panther", weapon = "ESG", direction = "NorthWest", player = 1, at = { 49, 104 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 42, scientists = 23, kids = 60, food = 2600, ore = 8000, rare_ore = 2000,
        research = { 11000 },
        tech_level = 11,
        kits = { [1] = { "CommandCenter" } },
        view = { 5, 113 },
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
      { "Tube", { 26, 112 } }, { "Tube", { 26, 113 } }, { "Tube", { 29, 115 } }, { "Tube", { 36, 113 } },
      { "Tube", { 37, 113 } }, { "Tube", { 41, 124 } }, { "Tube", { 42, 124 } }, { "Tube", { 43, 124 } },
      { "Tube", { 44, 124 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 121, 7 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 44, 54 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 44, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 11, 72 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 11, 72 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 12, 50 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 82, 26 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 113, 120 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 77, 89 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 94, 74 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 89 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 16, 105 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 118, 53 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 52 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 5, 113 } },
      { type = "AdvancedLab", player = 1, at = { 5, 123 } },
      { type = "Residence", player = 1, at = { 12, 112 } },
      { type = "Spaceport", player = 1, at = { 17, 117 } },
      { type = "Agridome", player = 1, at = { 19, 126 } },
      { type = "VehicleFactory", player = 1, at = { 30, 124 } },
      { type = "Agridome", player = 1, at = { 26, 115 } },
      { type = "StructureFactory", player = 1, at = { 38, 124 } },
      { type = "Agridome", player = 1, at = { 9, 123 } },
      { type = "University", player = 1, at = { 26, 110 } },
      { type = "Nursery", player = 1, at = { 5, 108 } },
      { type = "RobotCommand", player = 1, at = { 14, 124 } },
      { type = "GuardPost", weapon = "RPG", player = 1, at = { 50, 114 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 45, 124 } },
      { type = "CommonOreSmelter", player = 1, at = { 35, 104 } },
      { type = "Garage", player = 1, at = { 35, 113 } },
      { type = "RareOreSmelter", player = 1, at = { 50, 109 } },
      { type = "Residence", player = 1, at = { 40, 96 } },
      { type = "Residence", player = 1, at = { 44, 96 } },
      { type = "MedicalCenter", player = 1, at = { 36, 96 } },
      { type = "MedicalCenter", player = 1, at = { 24, 126 } },
      { type = "DIRT", player = 1, at = { 5, 117 } },
      { type = "DIRT", player = 1, at = { 40, 93 } },
      { type = "Agridome", player = 1, at = { 43, 109 } },
      { type = "MHDGenerator", player = 1, at = { 46, 118 } },
      { type = "MHDGenerator", player = 1, at = { 6, 102 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 30, 115 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 38, 121 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 10, 117 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 14, 119 } },
      { type = "ConVec", direction = "NorthEast", player = 1, at = { 40, 126 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 107 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 53, 109 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 111 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 37, 108 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 39, 108 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 38, 110 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 13, 126 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 15, 126 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 29, 100 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 32, 109 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 21, 119 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 4, 115 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 20, 113 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 21, 114 } },
      { type = "Tiger", weapon = "EMP", direction = "East", player = 1, at = { 20, 123 } },
      { type = "Panther", weapon = "RPG", direction = "SouthWest", player = 1, at = { 44, 109 } },
      { type = "Panther", weapon = "RPG", direction = "South", player = 1, at = { 45, 107 } },
      { type = "Panther", weapon = "EMP", direction = "East", player = 1, at = { 46, 112 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 33, 99 } },
      { type = "Lynx", weapon = "Microwave", direction = "South", player = 1, at = { 34, 98 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 36, 99 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 27, 106 } },
      { type = "Tiger", weapon = "ESG", direction = "SouthEast", player = 1, at = { 24, 118 } },
      { type = "Lynx", weapon = "ESG", direction = "NorthEast", player = 1, at = { 25, 106 } },
      { type = "Panther", weapon = "Supernova", direction = "SouthWest", player = 1, at = { 44, 111 } },
      { type = "Panther", weapon = "ESG", direction = "NorthWest", player = 1, at = { 49, 104 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 42, scientists = 23, kids = 60, food = 2600, ore = 8000, rare_ore = 2000,
        research = { 11000 },
        tech_level = 11,
        kits = { [1] = { "RobotCommand" } },
        view = { 5, 113 },
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
      { "Tube", { 26, 112 } }, { "Tube", { 26, 113 } }, { "Tube", { 36, 113 } }, { "Tube", { 37, 113 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 121, 7 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 44, 54 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 44, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 11, 72 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 11, 72 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 12, 50 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 82, 26 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 113, 120 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 77, 89 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 94, 74 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 71, 89 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 16, 105 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 118, 53 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 91, 52 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 5, 113 } },
      { type = "AdvancedLab", player = 1, at = { 5, 123 } },
      { type = "Residence", player = 1, at = { 12, 112 } },
      { type = "Spaceport", player = 1, at = { 17, 117 } },
      { type = "Agridome", player = 1, at = { 19, 126 } },
      { type = "VehicleFactory", player = 1, at = { 30, 124 } },
      { type = "Agridome", player = 1, at = { 26, 115 } },
      { type = "StructureFactory", player = 1, at = { 38, 124 } },
      { type = "Agridome", player = 1, at = { 9, 123 } },
      { type = "University", player = 1, at = { 26, 110 } },
      { type = "Nursery", player = 1, at = { 5, 108 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 45, 124 } },
      { type = "CommonOreSmelter", player = 1, at = { 35, 104 } },
      { type = "Garage", player = 1, at = { 35, 113 } },
      { type = "RareOreSmelter", player = 1, at = { 50, 109 } },
      { type = "Residence", player = 1, at = { 40, 96 } },
      { type = "Residence", player = 1, at = { 44, 96 } },
      { type = "MedicalCenter", player = 1, at = { 36, 96 } },
      { type = "MedicalCenter", player = 1, at = { 24, 126 } },
      { type = "DIRT", player = 1, at = { 5, 117 } },
      { type = "DIRT", player = 1, at = { 40, 93 } },
      { type = "Agridome", player = 1, at = { 43, 109 } },
      { type = "MHDGenerator", player = 1, at = { 46, 118 } },
      { type = "MHDGenerator", player = 1, at = { 6, 102 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 30, 115 } },
      { type = "GuardPost", weapon = "EMP", player = 1, at = { 38, 121 } },
      { type = "GuardPost", weapon = "ESG", player = 1, at = { 10, 117 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 14, 119 } },
      { type = "ConVec", direction = "NorthEast", player = 1, at = { 40, 126 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 107 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 53, 109 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 111 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 37, 108 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 39, 108 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 38, 110 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 13, 126 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 15, 126 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 29, 100 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 32, 109 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 21, 119 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 4, 115 } },
      { type = "EvacuationTransport", direction = "West", player = 1, at = { 4, 115 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 20, 113 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 21, 114 } },
      { type = "Tiger", weapon = "EMP", direction = "East", player = 1, at = { 20, 123 } },
      { type = "Panther", weapon = "RPG", direction = "SouthWest", player = 1, at = { 44, 109 } },
      { type = "Panther", weapon = "RPG", direction = "South", player = 1, at = { 45, 107 } },
      { type = "Panther", weapon = "EMP", direction = "East", player = 1, at = { 46, 112 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 33, 99 } },
      { type = "Lynx", weapon = "Microwave", direction = "South", player = 1, at = { 34, 98 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 36, 99 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 27, 106 } },
      { type = "Tiger", weapon = "ESG", direction = "SouthEast", player = 1, at = { 24, 118 } },
      { type = "Lynx", weapon = "ESG", direction = "NorthEast", player = 1, at = { 25, 106 } },
      { type = "Panther", weapon = "Supernova", direction = "SouthWest", player = 1, at = { 44, 111 } },
      { type = "Panther", weapon = "ESG", direction = "NorthWest", player = 1, at = { 49, 104 } },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 110, 1, 128, 6 },
  { 111, 7, 128, 7 },
  { 113, 8, 128, 9 },
  { 114, 10, 128, 10 },
  { 115, 11, 128, 11 },
  { 116, 12, 128, 13 },
  { 116, 14, 123, 16 },
  { 116, 17, 124, 17 },
  { 117, 18, 124, 18 },
  { 116, 19, 124, 19 },
  { 115, 20, 125, 20 },
  { 114, 21, 126, 21 },
  { 113, 22, 127, 22 },
  { 112, 23, 127, 23 },
  { 112, 24, 128, 24 },
  { 113, 25, 128, 25 },
  { 114, 26, 128, 26 },
  { 115, 27, 128, 27 },
  { 116, 28, 128, 28 },
  { 118, 29, 128, 34 },
  { 119, 35, 128, 36 },
  { 120, 37, 128, 37 },
  { 121, 38, 128, 38 },
  { 122, 39, 128, 39 },
  { 121, 40, 128, 40 },
  { 119, 41, 128, 41 },
  { 115, 42, 128, 42 },
  { 113, 43, 128, 43 },
  { 112, 44, 127, 44 },
  { 111, 45, 128, 45 },
  { 110, 46, 128, 46 },
  { 107, 47, 128, 47 },
  { 106, 48, 128, 48 },
  { 105, 49, 128, 50 },
  { 106, 51, 126, 51 },
  { 107, 52, 114, 52 },
  { 116, 52, 116, 52 },
  { 120, 52, 126, 52 },
  { 108, 53, 112, 53 },
  { 120, 53, 125, 53 },
  { 108, 54, 111, 56 },
  { 119, 54, 124, 54 },
  { 119, 55, 123, 56 },
  { 107, 57, 111, 57 },
  { 118, 57, 123, 58 },
  { 106, 58, 112, 58 },
  { 105, 59, 113, 59 },
  { 117, 59, 122, 59 },
  { 104, 60, 113, 60 },
  { 117, 60, 121, 60 },
  { 103, 61, 113, 61 },
  { 117, 61, 119, 61 },
  { 102, 62, 113, 62 },
  { 117, 62, 118, 62 },
  { 102, 63, 112, 63 },
  { 117, 63, 117, 63 },
  { 101, 64, 111, 64 },
  { 100, 65, 111, 67 },
  { 99, 68, 111, 68 },
  { 91, 69, 109, 69 },
  { 90, 70, 108, 70 },
  { 90, 71, 106, 71 },
  { 89, 72, 105, 72 },
  { 87, 73, 93, 73 },
  { 96, 73, 104, 73 },
  { 86, 74, 92, 74 },
  { 96, 74, 103, 74 },
  { 85, 75, 91, 75 },
  { 96, 75, 102, 76 },
  { 83, 76, 89, 76 },
  { 82, 77, 88, 77 },
  { 95, 77, 103, 78 },
  { 78, 78, 87, 78 },
  { 77, 79, 85, 79 },
  { 95, 79, 104, 79 },
  { 73, 80, 84, 80 },
  { 96, 80, 104, 80 },
  { 70, 81, 83, 81 },
  { 97, 81, 104, 81 },
  { 69, 82, 83, 82 },
  { 98, 82, 105, 83 },
  { 68, 83, 78, 83 },
  { 67, 84, 74, 84 },
  { 99, 84, 104, 84 },
  { 67, 85, 71, 85 },
  { 99, 85, 103, 87 },
  { 66, 86, 70, 87 },
  { 66, 88, 69, 91 },
  { 98, 88, 103, 88 },
  { 97, 89, 103, 89 },
  { 96, 90, 103, 90 },
  { 93, 91, 102, 91 },
  { 63, 92, 70, 92 },
  { 92, 92, 100, 92 },
  { 62, 93, 70, 94 },
  { 91, 93, 99, 93 },
  { 93, 94, 97, 94 },
  { 61, 95, 73, 95 },
  { 93, 95, 96, 95 },
  { 61, 96, 75, 96 },
  { 94, 96, 96, 96 },
  { 60, 97, 76, 97 },
  { 95, 97, 96, 97 },
  { 59, 98, 76, 98 },
  { 59, 99, 77, 99 },
  { 59, 100, 67, 100 },
  { 73, 100, 77, 101 },
  { 60, 101, 64, 101 },
  { 74, 102, 80, 102 },
  { 73, 103, 81, 105 },
  { 73, 106, 82, 106 },
  { 73, 107, 83, 107 },
  { 74, 108, 83, 108 },
  { 75, 109, 82, 109 },
  { 72, 110, 81, 110 },
  { 71, 111, 80, 111 },
  { 70, 112, 79, 113 },
  { 71, 114, 79, 114 },
  { 72, 115, 78, 115 },
  { 72, 116, 77, 116 },
  { 72, 117, 76, 117 },
  { 72, 118, 75, 118 },
  { 73, 119, 74, 119 },
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


-- The triggers CheckForFail reads (0x1100B7F0 to 0x1100B808): on Normal the Tiger, Panther, Lynx and evacuation
-- counts, then the spacecraft components.
local t23, t25, t27, t29, t21
-- Strike's trigger (0x1100B7E0) and DoTrickle's (0x1100B7E4), which MainAttack and StopTrickle stop.
local strike_trigger, trickle_trigger
-- Where the attacks go (0x1100B810).
local STRIKE_RECT = { 5, 104, 50, 126 }
-- The map-edge rows the attackers come in on, each unit a tile east of the last: the first tile of each.
local NORTH_WEST, NORTH, NORTH_MID, NORTH_EAST = { 1, 2 }, { 49, 2 }, { 54, 2 }, { 86, 2 }
local SOUTH_EAST, SOUTH_WEST = { 76, 128 }, { 66, 128 }
-- The attackers' types and weapons by block, in the order the DLL walks its records (type at +0, weapon at +0x14 of
-- each 0x20-byte record the block's +0x84 points to); `op2dll disasm --block` lists them in another order.
local STRIKE_UNITS = {
  -- The small strike's, Easy (0x1100B2B8) and otherwise (0x1100B230).
  small_easy = { { "Panther", "Laser" }, { "Panther", "AcidCloud" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" },
                 { "Panther", "ThorsHammer" }, { "Panther", "EMP" }, { "Lynx", "EMP" } },
  small = { { "Panther", "ThorsHammer" }, { "Panther", "AcidCloud" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" },
            { "Panther", "ThorsHammer" }, { "Panther", "EMP" }, { "Panther", "EMP" }, { "Lynx", "EMP" } },
  -- The big strike's first and second (Part2) parts, Easy (0x1100B3E8, 0x1100B538) and otherwise (0x1100B688,
  -- 0x1100B600).
  big_easy = { { "Panther", "RailGun" }, { "Panther", "AcidCloud" }, { "Panther", "RailGun" }, { "Panther", "AcidCloud" },
               { "Panther", "EMP" }, { "Panther", "EMP" } },
  big_easy2 = { { "Tiger", "Laser" }, { "Tiger", "RailGun" }, { "Lynx", "AcidCloud" }, { "Tiger", "ThorsHammer" },
                { "Lynx", "EMP" }, { "Tiger", "EMP" }, { "Lynx", "EMP" } },
  big = { { "Panther", "RailGun" }, { "Panther", "RailGun" }, { "Panther", "RailGun" }, { "Panther", "AcidCloud" },
          { "Panther", "AcidCloud" }, { "Panther", "AcidCloud" }, { "Panther", "EMP" }, { "Panther", "EMP" } },
  big2 = { { "Tiger", "ThorsHammer" }, { "Tiger", "RailGun" }, { "Lynx", "AcidCloud" }, { "Tiger", "RailGun" },
           { "Tiger", "ThorsHammer" }, { "Lynx", "EMP" }, { "Tiger", "EMP" }, { "Lynx", "EMP" } },
  -- StopTrickle's (0x1100B360) and Annoy's (0x1100B470).
  final = { { "Lynx", "Laser" }, { "Panther", "RailGun" }, { "Panther", "AcidCloud" }, { "Tiger", "ThorsHammer" },
            { "Tiger", "RailGun" }, { "Panther", "AcidCloud" }, { "Lynx", "ThorsHammer" }, { "Lynx", "ThorsHammer" },
            { "Lynx", "EMP" }, { "Lynx", "EMP" }, { "Tiger", "EMP" } },
  annoy = { { "Lynx", "Laser" }, { "Lynx", "Laser" }, { "Lynx", "Laser" }, { "Lynx", "ThorsHammer" }, { "Lynx", "EMP" } },
}
-- Reinforce's units (0x1100B758).
local REINFORCE_UNITS = {
  { type = "Lynx", at = { 66, 128 }, direction = "West", weapon = "EMP" },
  { type = "Lynx", at = { 67, 128 }, direction = "West", weapon = "EMP" },
  { type = "Panther", at = { 68, 128 }, direction = "West", weapon = "AcidCloud" },
  { type = "Tiger", at = { 69, 128 }, direction = "West", weapon = "ThorsHammer" },
  { type = "Tiger", at = { 70, 128 }, direction = "West", weapon = "ThorsHammer" },
  { type = "Tiger", at = { 71, 128 }, direction = "West", weapon = "RailGun" },
  { type = "Tiger", at = { 72, 128 }, direction = "West", weapon = "RailGun" },
}
local reinforce_block

-- An attack group of the computer's for STRIKE_RECT.
local function strike_group()
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(STRIKE_RECT)
  return g
end

-- The Spaceport while the colony has one, else the Advanced Lab.
local function strike_target(g)
  g:set_attack_type(#players[1]:buildings("Spaceport") > 0 and "Spaceport" or "AdvancedLab")
end

-- The first n of units, made one by one along an edge row and taken into g.
local function line_units(g, units, edge, n)
  for i = 1, n do
    local made = game.create_unit{type = units[i][1], weapon = units[i][2], player = ai_player,
                                  at = { edge[1] + i - 1, edge[2] }, exact = true}
    if made[1] then g:take_unit(made[1]) end
  end
end

-- A small strike (0x11003790): from one of three edges, 5 to 8 of the block's units (no more than it has); lights
-- off unless from the south or on Easy.
local function small_strike()
  local g = strike_group()
  local easy = players[1].difficulty == "Easy"
  local units = easy and STRIKE_UNITS.small_easy or STRIKE_UNITS.small
  local r, edge, lights = game.rand(3), nil, false
  if r == 0 then
    edge = NORTH_WEST
  elseif r == 1 then
    edge = NORTH
  else
    edge, lights = players[1].difficulty == "Normal" and SOUTH_EAST or SOUTH_WEST, true
  end
  line_units(g, units, edge, math.min(game.rand(4) + 5, #units))
  g:set_lights(easy or lights)
end

-- A big strike (0x11003930), its first part or (Part2) its second: from one of two edges, 5 to 8 of the block's units;
-- lights off unless the first part comes from the south or on Easy.
local function big_strike(first)
  local g = strike_group()
  local easy = players[1].difficulty == "Easy"
  local normal = players[1].difficulty == "Normal"
  local units
  if easy then units = first and STRIKE_UNITS.big_easy or STRIKE_UNITS.big_easy2
  else units = first and STRIKE_UNITS.big or STRIKE_UNITS.big2 end
  local r, edge, lights = game.rand(2), nil, false
  if first then
    if r == 0 then edge = NORTH else edge, lights = normal and SOUTH_EAST or SOUTH_WEST, true end
  else
    if r == 0 then edge = NORTH_WEST else edge = normal and NORTH_MID or NORTH_EAST end
  end
  line_units(g, units, edge, math.min(game.rand(4) + 5, #units))
  g:set_lights(easy or lights)
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava, Meteor1, Meteor1A, Meteor2, Meteor2A, Microbe, MiniQuake, Quake1, Quake2, Quake3, Tornado1, Tornado2, Tornado3

function Lava(t)
  game.set_tile({ 113, 57 }, 1104)
  game.set_tile({ 114, 57 }, 1115)
  game.set_tile({ 113, 58 }, 1126)
  game.set_tile({ 114, 58 }, 1137)
  game.create_eruption({ 113, 59 }, 200)
  trigger.time{min = 6000, max = 12000, one_shot = false, on = MiniQuake}  -- after 60 to 120 marks
end

function Meteor1(t)
  game.create_meteor({ 46, 92 }, -1)
  trigger.time{min = 70, max = 120, on = Meteor1A}  -- after 0 to 1 marks
end

function Meteor1A(t)
  game.create_meteor({ 38, 120 }, -1)
end

function Meteor2(t)
  game.create_meteor({ 78, 115 }, -1)
  trigger.time{min = 70, max = 120, on = Meteor2A}  -- after 0 to 1 marks
end

function Meteor2A(t)
  game.create_meteor({ 53, 47 }, -1)
end

function Microbe(t)
  game.create_blight({ 2, 2 })
  game.create_blight({ 2, 3 })
  game.create_blight({ 2, 4 })
  game.create_blight({ 128, 128 })
  game.create_blight({ 128, 127 })
  game.create_blight({ 127, 127 })
  game.set_blight_speed(300)
  game.message_at("Microbe growth detected!", 152, 1, 1056, 32)
  game.message_at("Microbe growth detected!", 152, 1, 5088, 4064)
end

function MiniQuake(t)
  local r1 = game.rand(128)
  local r2 = game.rand(128)
  game.create_earthquake({ r1 + 1, r2 + 1 }, 2)
end

function Quake1(t)
  game.create_earthquake({ 80, 64 }, 3)
end

function Quake2(t)
  game.create_earthquake({ 72, 92 }, 4)
end

function Quake3(t)
  game.create_earthquake({ 109, 66 }, 5)
  trigger.time{time = 1200, on = Lava}  -- after 12 marks
end

function Tornado1(t)
  game.create_tornado({ 50, 4 }, { 64, 10 }, 18)
end

function Tornado2(t)
  game.create_tornado({ 121, 120 }, { 31, 58 }, 15)
end

function Tornado3(t)
  game.create_tornado({ 4, 14 }, { 94, 2 }, 15)
end

-- Every 40 ticks (0x11003B40): the colony's checks. Too few workers or scientists; less than 10000 Common or Rare
-- Metals in storage (Cargo Trucks don't count) and no way to mine more; a vehicle objective missing and no way to
-- build vehicles; the spacecraft missing and no Spaceport to build it; or the Supernova or Rocket Atmospheric
-- Re-entry System out of reach: the colony fails.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  if p.ore < 10000 and not p:can_accumulate_ore() then fail = true end
  if p.rare_ore < 10000 and not p:can_accumulate_rare_ore() then fail = true end
  local missing = false
  for _, k in ipairs({ t23, t25, t27, t29 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_vehicle(1) then fail = true end
  if not t21:has_fired(1) and not p:can_build_space() then fail = true end
  for _, tech in ipairs({ 8203, 11101 }) do
    if not p:has_tech(tech) and not p:can_do_research(tech) then fail = true end
  end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Every 70 to 90 marks, by the colony's Common and Rare Metals in storage: over 10000 a big strike, its second part 21
-- to 26 marks later; over 4000 a small one; else (not on Easy) one of the two drawn (0x11003DA0).
function Strike(t)
  local p = players[1]
  local stored = p.rare_ore + p.ore
  if stored > 10000 then
    big_strike(true)
    trigger.time{min = 2100, max = 2600, on = Part2}
  elseif stored > 4000 then
    small_strike()
  elseif p.difficulty ~= "Easy" then
    if game.rand(2) ~= 0 then small_strike() else big_strike(true) end
  end
end

-- The big strike's second part (0x11003E50).
function Part2(t)
  big_strike(false)
end

-- The main attack: the strikes stop; a trickle of attackers every 2 to 3 marks for 12 to 18 marks (0x11003E60).
function MainAttack(t)
  if strike_trigger then strike_trigger:disable() end
  trickle_trigger = trigger.time{min = 200, max = 300, one_shot = false, on = DoTrickle}
  trigger.time{min = 1200, max = 1800, on = StopTrickle}
end

-- One or two attackers of a drawn type and weapon each, from one of four edges, for the Spaceport (0x11003EE0).
function DoTrickle(t)
  local g = strike_group()
  strike_target(g)
  local normal = players[1].difficulty == "Normal"
  local edge = ({ NORTH_WEST, NORTH, normal and NORTH_MID or NORTH_EAST, normal and SOUTH_EAST or SOUTH_WEST })[game.rand(4) + 1]
  for i = 1, game.rand(2) + 1 do
    local kind = ({ "Lynx", "Panther", "Tiger" })[game.rand(3) + 1]
    local weapon = ({ "Laser", "EMP", "RailGun" })[game.rand(3) + 1]
    local made = game.create_unit{type = kind, weapon = weapon, player = ai_player,
                                  at = { edge[1] + i - 1, edge[2] }, exact = true}
    if made[1] then g:take_unit(made[1]) end
  end
  g:set_lights(true)
end

-- The trickle ends with the last wave, all eleven of its block from one of three edges; once the computer is down to
-- ten vehicles, Reinforce (0x110040E0).
function StopTrickle(t)
  if trickle_trigger then trickle_trigger:disable() end
  local g = strike_group()
  strike_target(g)
  local normal = players[1].difficulty == "Normal"
  local edge = ({ NORTH_WEST, NORTH, normal and NORTH_MID or NORTH_EAST })[game.rand(3) + 1]
  line_units(g, STRIKE_UNITS.final, edge, #STRIKE_UNITS.final)
  g:set_lights(true)
  trigger.vehicle_count{compare = "<=", count = 10, player = 2, one_shot = true, on = Reinforce}
end

-- Seven more from the south; once the computer has no vehicles left, the annoying raids start (0x11004270).
function Reinforce(t)
  local g = strike_group()
  reinforce_block = reinforce_block or ai.unit_block(REINFORCE_UNITS)
  g:add_units(reinforce_block)
  trigger.vehicle_count{compare = "==", count = 0, player = 2, one_shot = true, on = AnnoyStart}
end

-- A raid every 120 to 180 marks (0x11004300).
function AnnoyStart(t)
  trigger.time{min = 12000, max = 18000, one_shot = false, on = Annoy}
end

-- A raid of 2 to 5 Lynx from one of three edges (0x11004340).
function Annoy(t)
  local g = strike_group()
  local edge = ({ NORTH_WEST, NORTH, players[1].difficulty == "Normal" and SOUTH_EAST or SOUTH_WEST })[game.rand(3) + 1]
  line_units(g, STRIKE_UNITS.annoy, edge, game.rand(4) + 2)
  g:set_lights(true)
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 113, 57 }, 1095)
  game.initial_set_tile({ 114, 57 }, 1107)
  game.initial_set_tile({ 113, 58 }, 1118)
  game.initial_set_tile({ 114, 58 }, 1129)
  game.set_daylight_everywhere(false)
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end
  strike_trigger = trigger.time{min = 7000, max = 9000, one_shot = false, on = Strike}  -- after 70 to 90 marks
  if difficulty == "Easy" then
    trigger.time{min = 73000, max = 77000, on = MainAttack}  -- after 730 to 770 marks
  elseif difficulty == "Normal" then
    trigger.time{min = 83000, max = 87000, on = MainAttack}  -- after 830 to 870 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 93000, max = 97000, on = MainAttack}  -- after 930 to 970 marks
  end

  -- The win.
  local t7 = trigger.resource{resource = "Food", compare = ">=", amount = 4000, player = 1}
  mission.victory(t7, "Have 4000 units of food in storage.")
  local t9
  if difficulty == "Easy" then
    t9 = trigger.resource{resource = "RareOre", compare = ">=", amount = 7500, player = 1}
    mission.victory(t9, "Have 7500 units of Rare Metals in storage.")
  elseif difficulty == "Normal" or difficulty == "Hard" then
    t9 = trigger.resource{resource = "RareOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t9, "Have 10000 units of Rare Metals in storage.")
  end
  local t11 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
  mission.victory(t11, "Have 10000 units of Common Metals in storage.")
  local t15, t17, t13, t14, t16, t18, t19, t20
  if difficulty == "Easy" then
    t21 = trigger.count{type = "CommandModule", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t21, "Place the Command Module in orbit.")
    t15 = trigger.count{type = "HabitatRing", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t15, "Place the Habitat Ring in orbit.")
    t17 = trigger.count{type = "StasisSystems", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t17, "Place the Stasis Systems in orbit.")
    t23 = trigger.count{type = "Tiger", compare = ">=", count = 4, player = 1}
    mission.victory(t23, "Have 4 or more total Tigers.")
    t25 = trigger.count{type = "Panther", compare = ">=", count = 6, player = 1}
    mission.victory(t25, "Have 6 or more total Panthers.")
    t27 = trigger.count{type = "Lynx", compare = ">=", count = 8, player = 1}
    mission.victory(t27, "Have 8 or more total Lynx.")
  elseif difficulty == "Normal" then
    t13 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "CommandModule", compare = ">=", count = 1, player = 1}
    t15 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t16 = trigger.count{type = "HabitatRing", compare = ">=", count = 1, player = 1}
    t17 = trigger.count{type = "SensorPackage", compare = ">=", count = 1, player = 1}
    t18 = trigger.count{type = "StasisSystems", compare = ">=", count = 1, player = 1}
    t19 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1, player = 1}
    t20 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1, player = 1}
    t21 = trigger.set{t13, t14, t15, t16, t17, t18, t19, t20, needed = 4}
    mission.victory(t21, "Launch 3 more spacecraft components.")
    t23 = trigger.count{type = "Tiger", compare = ">=", count = 6, player = 1}
    mission.victory(t23, "Have 6 or more total Tigers.")
    t25 = trigger.count{type = "Panther", compare = ">=", count = 8, player = 1}
    mission.victory(t25, "Have 8 or more total Panthers.")
    t27 = trigger.count{type = "Lynx", compare = ">=", count = 10, player = 1}
    mission.victory(t27, "Have 10 or more total Lynx.")
  elseif difficulty == "Hard" then
    t13 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "CommandModule", compare = ">=", count = 1, player = 1}
    t15 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t16 = trigger.count{type = "HabitatRing", compare = ">=", count = 1, player = 1}
    t17 = trigger.count{type = "SensorPackage", compare = ">=", count = 1, player = 1}
    t18 = trigger.count{type = "StasisSystems", compare = ">=", count = 1, player = 1}
    t19 = trigger.count{type = "OrbitalPackage", compare = ">=", count = 1, player = 1}
    t20 = trigger.count{type = "PhoenixModule", compare = ">=", count = 1, player = 1}
    t21 = trigger.set{t13, t14, t15, t16, t17, t18, t19, t20, needed = 4}
    mission.victory(t21, "Launch 3 more spacecraft components.")
    t23 = trigger.count{type = "Tiger", compare = ">=", count = 7, player = 1}
    mission.victory(t23, "Have 7 or more total Tigers.")
    t25 = trigger.count{type = "Panther", compare = ">=", count = 8, player = 1}
    mission.victory(t25, "Have 8 or more total Panthers.")
    t27 = trigger.count{type = "Lynx", compare = ">=", count = 10, player = 1}
    mission.victory(t27, "Have 10 or more total Lynx.")
  end
  t29 = trigger.evac{player = 1}
  mission.victory(t29, "Have enough Evacuation Transports for your population.")
  local t31 = trigger.research{tech = 8203, player = 1, one_shot = true}
  mission.victory(t31, "Research the Supernova Turret.")
  local t33 = trigger.research{tech = 11101, player = 1, one_shot = true}
  mission.victory(t33, "Research Rocket Atmospheric Re-entry System.")
  local t36 = trigger.resource{resource = "Scientists", compare = ">=", amount = 32, player = 1}
  mission.victory(t36, "Keep at least 32 scientists alive.")
  local t35 = trigger.resource{resource = "Workers", compare = ">=", amount = 48, player = 1}
  mission.victory(t35, "Keep at least 48 workers alive.")
  local t37 = trigger.resource{resource = "Kids", compare = ">=", amount = 80, player = 1}
  mission.victory(t37, "Keep at least 80 children alive.")
  local t50 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t50)
  trigger.time{min = 6000, max = 18000, on = Tornado1}  -- after 60 to 180 marks
  trigger.time{min = 36000, max = 48000, on = Tornado2}  -- after 360 to 480 marks
  trigger.time{min = 60000, max = 72000, on = Tornado3}  -- after 600 to 720 marks
  trigger.time{min = 18000, max = 36000, on = Quake1}  -- after 180 to 360 marks
  trigger.time{min = 36000, max = 54000, on = Quake2}  -- after 360 to 540 marks
  trigger.time{min = 54000, max = 84000, on = Quake3}  -- after 540 to 840 marks
  trigger.time{min = 24000, max = 36000, on = Meteor1}  -- after 240 to 360 marks
  trigger.time{min = 72000, max = 84000, on = Meteor2}  -- after 720 to 840 marks
  trigger.time{time = 140000, on = Microbe}  -- after 1400 marks
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

