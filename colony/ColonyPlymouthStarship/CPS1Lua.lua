-- CPS1Lua.lua  -  Colony Builder - Plymouth, Starship (Lua)
-- Trigger functions finished by hand (CheckForFail, ScoutWait, ReleaseMorale), from the disassembly of CPS1.dll.
-- Converted by op2dll from CPS1.dll. With CPS1Lua.placement.lua (what every difficulty makes alike),
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
        workers = 28, scientists = 13, kids = 15, food = 3000, ore = 5000,
        research = {  },
        view = { 99, 45 },
        units = {
          { type = "CommandCenter", at = { 99, 45 } },
          { type = "Agridome", at = { 94, 37 } },
          { type = "StructureFactory", at = { 89, 47 } },
          { type = "CommonOreSmelter", at = { 86, 35 } },
          { type = "Tokamak", at = { 79, 43 } },
          { type = "StandardLab", at = { 94, 45 } },
          { type = "CargoTruck", direction = "North", at = { 90, 36 } },
          { type = "CargoTruck", direction = "SouthEast", at = { 90, 38 } },
          { type = "CargoTruck", direction = "South", at = { 88, 38 } },
          { type = "ConVec", direction = "SouthWest", at = { 101, 42 } },
          { type = "ConVec", direction = "SouthWest", at = { 103, 42 } },
          { type = "RoboSurveyor", direction = "West", at = { 83, 42 } },
          { type = "RoboMiner", direction = "NorthWest", at = { 83, 44 } },
          { type = "RoboDozer", direction = "NorthEast", at = { 92, 49 } },
          { type = "Earthworker", direction = "SouthEast", at = { 90, 43 } },
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 86, 38 } }, { "Tube", { 86, 39 } }, { "Tube", { 86, 40 } }, { "Tube", { 86, 41 } },
      { "Tube", { 86, 42 } }, { "Tube", { 86, 43 } }, { "Tube", { 86, 44 } }, { "Tube", { 86, 45 } },
      { "Tube", { 86, 46 } }, { "Tube", { 89, 35 } }, { "Tube", { 90, 35 } }, { "Tube", { 91, 35 } },
      { "Tube", { 92, 35 } }, { "Tube", { 92, 47 } }, { "Tube", { 93, 35 } }, { "Tube", { 93, 47 } },
      { "Tube", { 94, 47 } }, { "Tube", { 95, 47 } }, { "Tube", { 96, 47 } }, { "Tube", { 97, 37 } },
      { "Tube", { 97, 47 } }, { "Tube", { 98, 37 } }, { "Tube", { 98, 47 } }, { "Tube", { 99, 37 } },
      { "Tube", { 99, 38 } }, { "Tube", { 99, 39 } }, { "Tube", { 99, 40 } }, { "Tube", { 99, 41 } },
      { "Tube", { 99, 42 } }, { "Tube", { 99, 43 } }, { "Tube", { 99, 47 } },
    },
    beacons = {
    },
    late_beacons = {
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 108, 22 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 40, 112 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 7, 121 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 47, 72 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 29, 96 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 97, 52 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 19 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 13, 122 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 119, 29 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 99, 11 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 4, 75 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 12, 58 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 5, 5 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 30, 31 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 80, 10 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 47, 57 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 11, 87 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 34, 3 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 7, 32 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 108, 120 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 125, 113 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 72, 122 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 29, 120 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 108, 78 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 76, 91 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 94, 101 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 87, 125 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 120, 92 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 108, 107 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 125, 63 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 53, 98 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 46, 124 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 125, 14 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 29, 106 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 120, 40 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 45, 21 } },
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 25, scientists = 13, kids = 15, food = 2000, ore = 4000,
        research = {  },
        view = { 89, 45 },
        units = {
          { type = "CommandCenter", at = { 89, 45 } },
          { type = "Agridome", at = { 84, 37 } },
          { type = "StructureFactory", at = { 79, 47 } },
          { type = "CommonOreSmelter", at = { 76, 35 } },
          { type = "Tokamak", at = { 69, 43 } },
          { type = "CargoTruck", direction = "North", at = { 80, 36 } },
          { type = "CargoTruck", direction = "SouthEast", at = { 80, 38 } },
          { type = "CargoTruck", direction = "South", at = { 78, 38 } },
          { type = "ConVec", direction = "SouthWest", at = { 91, 42 } },
          { type = "ConVec", direction = "SouthWest", at = { 93, 42 } },
          { type = "RoboSurveyor", direction = "West", at = { 73, 42 } },
          { type = "RoboMiner", direction = "NorthWest", at = { 73, 44 } },
          { type = "RoboDozer", direction = "NorthEast", at = { 82, 49 } },
          { type = "Earthworker", direction = "SouthEast", at = { 80, 43 } },
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 76, 38 } }, { "Tube", { 76, 39 } }, { "Tube", { 76, 40 } }, { "Tube", { 76, 41 } },
      { "Tube", { 76, 42 } }, { "Tube", { 76, 43 } }, { "Tube", { 76, 44 } }, { "Tube", { 76, 45 } },
      { "Tube", { 76, 46 } }, { "Tube", { 79, 35 } }, { "Tube", { 80, 35 } }, { "Tube", { 81, 35 } },
      { "Tube", { 82, 35 } }, { "Tube", { 82, 47 } }, { "Tube", { 83, 35 } }, { "Tube", { 83, 47 } },
      { "Tube", { 84, 47 } }, { "Tube", { 85, 47 } }, { "Tube", { 86, 47 } }, { "Tube", { 87, 37 } },
      { "Tube", { 87, 47 } }, { "Tube", { 88, 37 } }, { "Tube", { 88, 47 } }, { "Tube", { 89, 37 } },
      { "Tube", { 89, 38 } }, { "Tube", { 89, 39 } }, { "Tube", { 89, 40 } }, { "Tube", { 89, 41 } },
      { "Tube", { 89, 42 } }, { "Tube", { 89, 43 } }, { "Tube", { 89, 47 } },
    },
    beacons = {
    },
    late_beacons = {
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 108, 22 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 40, 112 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 7, 121 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 47, 72 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 29, 96 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 97, 52 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 19 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 13, 122 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 119, 29 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 99, 11 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 4, 75 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 12, 58 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 5, 5 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 30, 31 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 80, 10 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 47, 57 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 11, 87 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 34, 3 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 7, 32 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 108, 120 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 125, 113 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 72, 122 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 29, 120 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 108, 78 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 91 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 94, 101 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 87, 125 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 120, 92 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 108, 107 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 125, 63 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 98 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 46, 124 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 125, 14 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 29, 106 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 120, 40 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 45, 21 } },
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 28, scientists = 10, kids = 15, food = 1000, ore = 3000,
        research = {  },
        view = { 89, 45 },
        units = {
          { type = "CommandCenter", at = { 89, 45 } },
          { type = "Agridome", at = { 84, 37 } },
          { type = "StructureFactory", at = { 79, 47 } },
          { type = "CommonOreSmelter", at = { 76, 35 } },
          { type = "Tokamak", at = { 69, 43 } },
          { type = "CargoTruck", direction = "North", at = { 80, 36 } },
          { type = "CargoTruck", direction = "SouthEast", at = { 80, 38 } },
          { type = "CargoTruck", direction = "South", at = { 78, 38 } },
          { type = "ConVec", direction = "SouthWest", at = { 91, 42 } },
          { type = "ConVec", direction = "SouthWest", at = { 93, 42 } },
          { type = "RoboSurveyor", direction = "West", at = { 73, 42 } },
          { type = "RoboMiner", direction = "NorthWest", at = { 73, 44 } },
          { type = "RoboDozer", direction = "NorthEast", at = { 82, 49 } },
          { type = "Earthworker", direction = "SouthEast", at = { 80, 43 } },
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 76, 38 } }, { "Tube", { 76, 39 } }, { "Tube", { 76, 40 } }, { "Tube", { 76, 41 } },
      { "Tube", { 76, 42 } }, { "Tube", { 76, 43 } }, { "Tube", { 76, 44 } }, { "Tube", { 76, 45 } },
      { "Tube", { 76, 46 } }, { "Tube", { 79, 35 } }, { "Tube", { 80, 35 } }, { "Tube", { 81, 35 } },
      { "Tube", { 82, 35 } }, { "Tube", { 82, 47 } }, { "Tube", { 83, 35 } }, { "Tube", { 83, 47 } },
      { "Tube", { 84, 47 } }, { "Tube", { 85, 47 } }, { "Tube", { 86, 47 } }, { "Tube", { 87, 37 } },
      { "Tube", { 87, 47 } }, { "Tube", { 88, 37 } }, { "Tube", { 88, 47 } }, { "Tube", { 89, 37 } },
      { "Tube", { 89, 38 } }, { "Tube", { 89, 39 } }, { "Tube", { 89, 40 } }, { "Tube", { 89, 41 } },
      { "Tube", { 89, 42 } }, { "Tube", { 89, 43 } }, { "Tube", { 89, 47 } },
    },
    beacons = {
    },
    late_beacons = {
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 108, 22 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 40, 112 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 7, 121 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 47, 72 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 29, 96 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 97, 52 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 85, 19 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 13, 122 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 119, 29 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 99, 11 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 4, 75 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 12, 58 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 5, 5 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 30, 31 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 80, 10 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 47, 57 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 11, 87 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 34, 3 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 7, 32 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 108, 120 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 125, 113 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 72, 122 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 29, 120 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 108, 78 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 91 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 94, 101 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 87, 125 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 120, 92 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 108, 107 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 125, 63 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 98 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 46, 124 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 125, 14 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 29, 106 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 94, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 120, 40 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 45, 21 } },
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 105, 1, 128, 1 },
  { 106, 2, 128, 3 },
  { 107, 4, 128, 5 },
  { 108, 6, 113, 6 },
  { 120, 6, 128, 6 },
  { 108, 7, 112, 7 },
  { 121, 7, 128, 8 },
  { 108, 8, 111, 8 },
  { 109, 9, 111, 10 },
  { 120, 9, 128, 9 },
  { 121, 10, 128, 10 },
  { 108, 11, 111, 11 },
  { 122, 11, 128, 11 },
  { 105, 12, 111, 12 },
  { 123, 12, 128, 14 },
  { 104, 13, 113, 13 },
  { 103, 14, 113, 14 },
  { 100, 15, 113, 15 },
  { 120, 15, 128, 15 },
  { 97, 16, 114, 16 },
  { 117, 16, 128, 16 },
  { 96, 17, 108, 17 },
  { 110, 17, 128, 17 },
  { 95, 18, 107, 18 },
  { 111, 18, 127, 18 },
  { 95, 19, 106, 19 },
  { 111, 19, 126, 19 },
  { 94, 20, 105, 20 },
  { 111, 20, 125, 20 },
  { 93, 21, 104, 21 },
  { 112, 21, 124, 21 },
  { 92, 22, 103, 22 },
  { 112, 22, 121, 22 },
  { 89, 23, 102, 23 },
  { 112, 23, 117, 23 },
  { 87, 24, 98, 24 },
  { 111, 24, 117, 24 },
  { 84, 25, 95, 25 },
  { 110, 25, 117, 25 },
  { 83, 26, 94, 26 },
  { 106, 26, 107, 26 },
  { 109, 26, 117, 26 },
  { 83, 27, 90, 27 },
  { 104, 27, 119, 28 },
  { 82, 28, 87, 28 },
  { 79, 29, 86, 29 },
  { 103, 29, 119, 29 },
  { 121, 29, 121, 29 },
  { 78, 30, 85, 30 },
  { 102, 30, 119, 30 },
  { 77, 31, 82, 31 },
  { 101, 31, 119, 31 },
  { 76, 32, 81, 32 },
  { 102, 32, 118, 32 },
  { 75, 33, 82, 33 },
  { 103, 33, 107, 33 },
  { 110, 33, 111, 33 },
  { 74, 34, 82, 34 },
  { 73, 35, 81, 35 },
  { 73, 36, 80, 36 },
  { 74, 37, 80, 38 },
  { 74, 39, 79, 39 },
  { 75, 40, 78, 40 },
  { 76, 41, 77, 41 },
  { 72, 49, 76, 49 },
  { 71, 50, 77, 50 },
  { 71, 51, 78, 52 },
  { 69, 53, 78, 53 },
  { 68, 54, 78, 54 },
  { 68, 55, 76, 55 },
  { 68, 56, 73, 59 },
  { 95, 58, 98, 58 },
  { 92, 59, 99, 59 },
  { 68, 60, 74, 60 },
  { 86, 60, 99, 60 },
  { 67, 61, 78, 61 },
  { 84, 61, 99, 61 },
  { 67, 62, 79, 62 },
  { 82, 62, 97, 62 },
  { 67, 63, 97, 63 },
  { 63, 64, 86, 64 },
  { 88, 64, 96, 64 },
  { 63, 65, 84, 65 },
  { 89, 65, 95, 65 },
  { 62, 66, 81, 66 },
  { 90, 66, 94, 66 },
  { 60, 67, 70, 67 },
  { 73, 67, 78, 67 },
  { 80, 67, 80, 67 },
  { 58, 68, 69, 68 },
  { 75, 68, 75, 68 },
  { 58, 69, 67, 69 },
  { 58, 70, 66, 70 },
  { 37, 71, 41, 71 },
  { 46, 71, 48, 71 },
  { 57, 71, 65, 71 },
  { 35, 72, 64, 72 },
  { 33, 73, 64, 73 },
  { 32, 74, 63, 74 },
  { 31, 75, 63, 75 },
  { 30, 76, 62, 77 },
  { 30, 78, 60, 78 },
  { 29, 79, 39, 79 },
  { 45, 79, 59, 79 },
  { 27, 80, 39, 80 },
  { 46, 80, 52, 81 },
  { 26, 81, 38, 81 },
  { 26, 82, 37, 84 },
  { 45, 82, 50, 83 },
  { 42, 83, 42, 84 },
  { 44, 84, 49, 84 },
  { 25, 85, 38, 85 },
  { 41, 85, 48, 85 },
  { 25, 86, 48, 86 },
  { 24, 87, 47, 88 },
  { 24, 89, 48, 89 },
  { 24, 90, 47, 91 },
  { 24, 92, 44, 92 },
  { 25, 93, 43, 93 },
  { 26, 94, 40, 94 },
  { 42, 94, 42, 94 },
  { 27, 95, 41, 95 },
  { 27, 96, 39, 96 },
  { 27, 97, 38, 97 },
  { 27, 98, 36, 98 },
  { 26, 99, 35, 99 },
  { 25, 100, 34, 100 },
  { 24, 101, 33, 101 },
  { 18, 102, 33, 102 },
  { 12, 103, 34, 103 },
  { 10, 104, 45, 104 },
  { 7, 105, 48, 105 },
  { 6, 106, 49, 106 },
  { 5, 107, 49, 109 },
  { 6, 110, 48, 110 },
  { 7, 111, 24, 111 },
  { 29, 111, 47, 111 },
  { 11, 112, 18, 112 },
  { 30, 112, 46, 112 },
  { 12, 113, 17, 113 },
  { 31, 113, 44, 113 },
  { 14, 114, 15, 114 },
  { 37, 114, 43, 114 },
  { 38, 115, 41, 115 },
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


-- The win's Common Metals and Rare Metals evacuations (the setup's triggers 9 and 11, kept at 0x11008A64 and 0x11008A68):
-- once one has been met, CheckForFail no longer asks for that ore.
local t9, t11

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava1, Lava2, Meteor, MeteorRepeat, Quake, Storm, StormRepeat, Tornado, TornadoRepeat

function Lava1(t)
  game.create_eruption({ 113, 13 }, 200)
end

function Lava2(t)
  game.create_eruption({ 42, 84 }, 200)
end

function Meteor(t)
  local r1 = game.rand(7)
  local r2 = game.rand(3)
  local r3 = game.rand(3)
  if r1 == 0 then
    game.create_meteor({ r3 + 110, r1 + r2 + 55 }, -1)
  elseif r1 == 1 then
    game.create_meteor({ r3 + 75, r1 + r2 + 86 }, -1)
  elseif r1 == 2 then
    game.create_meteor({ r3 + 112, r2 + 107 }, -1)
  elseif r1 == 3 then
    game.create_meteor({ r3 + 33, r1 + r2 + 119 }, -1)
  elseif r1 == 4 then
    game.create_meteor({ r3 + 32, r2 + 49 }, -1)
  elseif r1 == 5 then
    game.create_meteor({ r3 + 26, r1 + r2 + 4 }, -1)
  else
    game.create_meteor({ r3 + 54, r1 + r2 + 36 }, -1)
  end
end

function MeteorRepeat(t)
  trigger.time{min = 18000, max = 54000, one_shot = false, on = Meteor}  -- after 180 to 540 marks
end

function Quake(t)
  local r1 = game.rand(9)
  local r2 = game.rand(3)
  local r3 = game.rand(3)
  if r1 == 0 then
    game.create_earthquake({ r3 + 106, r1 + r2 + 23 }, 3)
  elseif r1 == 1 then
    game.create_earthquake({ r3 + 47, r1 + r2 + 75 }, 3)
  elseif r1 == 2 then
    game.create_earthquake({ r3 + 18, r1 + r2 + 14 }, 4)
  elseif r1 == 3 then
    game.create_earthquake({ r3 + 53, r1 + r2 + 28 }, 2)
  elseif r1 == 4 then
    game.create_earthquake({ r3 + 107, r1 + r2 + 89 }, 4)
  elseif r1 == 5 then
    game.create_earthquake({ r3 + 116, r1 + r2 + 46 }, 3)
  elseif r1 == 6 then
    game.create_earthquake({ r3 + 117, r1 + r2 + 114 }, 2)
  elseif r1 == 7 then
    game.create_earthquake({ r3 + 65, r1 + r2 + 60 }, 4)
  else
    game.create_earthquake({ r3 + 64, r1 + r2 + 8 }, 2)
  end
end

function Storm(t)
  local r1 = game.rand(10)
  local r2 = game.rand(7)
  game.create_lightning({ ({ 14, 29, 117, 113, 122, 3, 14, 61, 72, 42 })[r1 + 1], ({ 125, 59, 3, 82, 123, 83, 4, 12, 101, 80 })[r1 + 1] }, nil, r2 + 14)
end

function StormRepeat(t)
  trigger.time{min = 36000, max = 54000, one_shot = false, on = Storm}  -- after 360 to 540 marks
end

function Tornado(t)
  local r1 = game.rand(6)
  local r2 = game.rand(7)
  game.create_tornado({ ({ 16, 124, 50, 104, 119, 12 })[r1 + 1], ({ 111, 59, 3, 3, 124, 91 })[r1 + 1] }, { ({ 121, 55, 49, 106, 125, 125 })[r1 + 1], ({ 20, 125, 62, 81, 29, 54 })[r1 + 1] }, r2 + 14)
end

function TornadoRepeat(t)
  trigger.time{min = 24000, max = 30000, one_shot = false, on = Tornado}  -- after 240 to 300 marks
end

-- Every 40 ticks: the colony fails at once with fewer than 8 workers or 3 scientists, with nothing that can build
-- for space, or with no income of an ore whose evacuation isn't met yet (0x11002C40).
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = p.workers < 8 or p.scientists < 3
  if not p:can_build_space() then fail = true end
  if not t9:has_fired(1) and not p:can_accumulate_ore() then fail = true end
  if not t11:has_fired(1) and not p:can_accumulate_rare_ore() then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Every 70 to 80 marks: player 2 sends Scouts in at 10,128, one more while a draw of 1 to 3 exceeds how many came, as
-- a fight group that leaves the map at 97,1 - 104,2. From Normal up it stops once player 1 has a Vehicle Factory or
-- the game's Time() (ticks / 4) reaches 40000; it then sets the computer's state to 0, which starts nothing
-- (AIStateChange, 0x11001100: it only ends its two triggers, never made by then) (0x11001920).
function ScoutWait(t)
  local group = ai.fight_group(players[2])
  group:do_exit_map()
  group:set_rect({ 97, 1, 104, 2 })
  group:set_delete_when_empty(true)
  local sent = 0
  while game.rand(3) + 1 > sent do
    sent = sent + 1
    local u = game.create_unit{ type = "Scout", player = 2, at = { 10, 128 }, lights = false, exact = true }[1]
    if u then group:take_unit(u) end
  end
  if players[1].difficulty == "Easy" then return end
  if game.tick() // 4 < 40000 and not players[1]:owns_any("VehicleFactory") then return end
  t:destroy()
end

-- Easy's morale lock lasts 10 ticks: then every player's morale is free (FreeMoraleLevel(-1)).
function ReleaseMorale(t)
  game.free_morale()
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  roll_beacons(BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The beacons the original makes after all its units, so that the units keep its ids.
  for _, b in ipairs(d.late_beacons or {}) do game.create_beacon(b) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 113, 12 }, 1095)
  game.initial_set_tile({ 114, 12 }, 1107)
  game.initial_set_tile({ 113, 13 }, 1118)
  game.initial_set_tile({ 114, 13 }, 1129)
  game.initial_set_tile({ 119, 8 }, 1161)
  game.initial_set_tile({ 120, 8 }, 1172)
  game.initial_set_tile({ 119, 9 }, 1184)
  game.initial_set_tile({ 120, 9 }, 1195)
  game.initial_set_tile({ 42, 82 }, 1140)
  game.initial_set_tile({ 42, 83 }, 1150)
  game.set_daylight_everywhere(false)
  game.set_daylight_moves(true)
  if difficulty == "Easy" then game.morale_steady("Good") end
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end
  if difficulty == "Easy" then
    trigger.time{time = 10, on = ReleaseMorale}  -- after 0 marks
  end

  -- The win.
  local t5 = trigger.count{type = "EvacuationModule", compare = ">=", count = 1, one_shot = true}
  mission.victory(t5, "Evacuate 200 colonists to spacecraft", {one_shot = true})
  local t7 = trigger.count{type = "FoodCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t7, "Evacuate 10000 units of food to spacecraft", {one_shot = true})
  t9 = trigger.count{type = "CommonMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t9, "Evacuate 10000 units of Common Metals to spacecraft", {one_shot = true})
  t11 = trigger.count{type = "RareMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t11, "Evacuate 10000 units of Rare Metals to spacecraft", {one_shot = true})
  local t19 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t19)
  trigger.time{min = 12000, max = 18000, one_shot = false, on = Quake}  -- after 120 to 180 marks
  trigger.time{min = 10000, max = 12000, on = TornadoRepeat}  -- after 100 to 120 marks
  trigger.time{min = 20000, max = 22000, on = StormRepeat}  -- after 200 to 220 marks
  trigger.time{min = 35000, max = 37000, on = MeteorRepeat}  -- after 350 to 370 marks
  trigger.time{min = 64000, max = 82000, on = Lava1}  -- after 640 to 820 marks
  trigger.time{min = 108000, max = 144000, on = Lava2}  -- after 1080 to 1440 marks
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
  trigger.time{min = 7000, max = 8000, one_shot = false, on = ScoutWait}  -- after 70 to 80 marks
end

