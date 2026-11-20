-- CEP1Lua.lua  -  Colony Builder - Eden, Population (Lua)
-- Trigger functions finished by hand (CheckForFail, Lava, ScoutArrive, ScoutLeave), from the disassembly of CEP1.dll.
-- Converted by op2dll from CEP1.dll. With CEP1Lua.placement.lua (what every difficulty makes alike),
-- this makes the colony's start: what changes with the difficulty, and the beacons the setup rolls.
-- Games run: Easy 1124, Normal 1066, Hard 1066.
-- Coordinates are the in-game status-bar ones (map file tile + 1); a kit's are relative to its start.

-- By difficulty (players[1].difficulty), for each player: colonists, stores, research, Structure Factory
-- kits by bay, the camera, units on fixed tiles, units each on a tile rolled in its `area`, and a kit of
-- units on a start rolled from `starts` or anywhere in `start_area`; then the tubes, walls and beacons
-- only this difficulty makes, and the beacons it rolls.
local DIFFICULTIES = {
  Easy = {
    players = {
      [1] = {
        workers = 25, scientists = 20, kids = 30, food = 3000, ore = 5000,
        research = { 3304, 3305 },
        kits = { [1] = { "Residence" }, [2] = { "Tokamak" } },
        view = { 38, 53 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 27, 51 } }, { "Tube", { 27, 56 } }, { "Tube", { 41, 46 } }, { "Tube", { 42, 46 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 38, 53 } },
      { type = "Agridome", player = 1, at = { 38, 46 } },
      { type = "StructureFactory", player = 1, at = { 27, 53 } },
      { type = "CommonOreSmelter", player = 1, at = { 49, 52 } },
      { type = "Tokamak", player = 1, at = { 24, 41 } },
      { type = "Agridome", player = 1, at = { 32, 51 } },
      { type = "Residence", player = 1, at = { 27, 49 } },
      { type = "Residence", player = 1, at = { 27, 58 } },
      { type = "StandardLab", player = 1, at = { 38, 56 } },
      { type = "Nursery", player = 1, at = { 44, 46 } },
      { type = "University", player = 1, at = { 24, 49 } },
      { type = "Residence", player = 1, at = { 23, 54 } },
      { type = "ConVec", weapon = "CommandCenter", direction = "East", player = 1, at = { 42, 49 } },
      { type = "ConVec", weapon = "CommonOreSmelter", direction = "East", player = 1, at = { 42, 51 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 31, 46 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 48, 48 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 33, 47 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 42, 35 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 42, 35 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 45, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 47, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 49, 56 } },
      { type = "ConVec", direction = "East", player = 1, at = { 30, 57 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 30, 47 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 32, 48 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 41, 46 } },
      { roll = 1 },
      { roll = 2 },
      { roll = 3 },
      { roll = 4 },
      { roll = 5 },
      { roll = 6 },
      { roll = 7 },
      { roll = 8 },
      { roll = 9 },
      { roll = 10 },
      { roll = 11 },
      { roll = 12 },
      { roll = 13 },
      { roll = 14 },
      { roll = 15 },
      { roll = 16 },
      { roll = 17 },
      { roll = 18 },
      { roll = 19 },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 200, 10 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 71, 251 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 200, 144 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 163, 30 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 161, 120 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 63, 203 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 250, 249 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 162, 156 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 92, 156 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 148 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 48, 222 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 137, 200 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 151, 11 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 208, 48 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 186, 104 }, beacon = true },
    },
    beacons = {
    },
    rolled = {
      { count = 3, kinds = {
          { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random" },
        },
        table = {
          { 122, 5 }, { 147, 35 }, { 5, 143 }, { 19, 95 }, { 9, 19 }, { 84, 67 }, { 137, 114 }, { 144, 73 },
          { 71, 158 }, { 9, 216 }, { 8, 156 }, { 18, 192 }, { 29, 199 }, { 34, 238 }, { 9, 230 }, { 42, 228 },
          { 45, 191 }, { 174, 62 }, { 145, 88 },
        } },
      { count = 2, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random" },
          { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random" },
        },
        table = {
          { 168, 208 }, { 106, 224 }, { 193, 230 }, { 184, 252 }, { 110, 252 }, { 140, 222 }, { 146, 247 }, { 167, 234 },
          { 124, 234 }, { 179, 216 }, { 192, 202 },
        } },
      { count = 2, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random" },
        },
        table = {
          { 156, 165 }, { 106, 189 }, { 187, 136 }, { 210, 129 }, { 230, 156 }, { 229, 79 }, { 193, 28 }, { 156, 13 },
          { 233, 18 }, { 246, 56 }, { 190, 75 }, { 82, 248 },
        } },
      { count = 4, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random" },
          { type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random" },
        },
        table = {
          { 179, 198 }, { 250, 209 }, { 249, 176 }, { 239, 165 }, { 205, 115 }, { 226, 92 }, { 241, 70 }, { 243, 30 },
          { 246, 5 }, { 250, 133 }, { 238, 104 }, { 228, 141 },
        } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", area = { 59, 16, 74, 28 }, draws = { 13, 16 }, x_draw = 2, base = { 59, 16 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 73, 108, 85, 121 }, draws = { 14, 13 }, x_draw = 2, base = { 73, 108 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 110, 241, 121, 249 }, draws = { 9, 12 }, x_draw = 2, base = { 110, 241 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 212, 227, 223, 237 }, draws = { 11, 12 }, x_draw = 2, base = { 212, 227 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 243, 169, 255, 174 }, draws = { 6, 13 }, x_draw = 2, base = { 243, 169 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 219, 119, 226, 129 }, draws = { 11, 8 }, x_draw = 2, base = { 219, 119 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 206, 111, 215, 118 }, draws = { 8, 10 }, x_draw = 2, base = { 206, 111 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 105, 251, 116 }, draws = { 12, 15 }, x_draw = 2, base = { 237, 105 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 229, 47, 240, 58 }, draws = { 12, 12 }, x_draw = 2, base = { 229, 47 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 53, 109, 64, 120 }, draws = { 12, 12 }, x_draw = 2, base = { 53, 109 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 19, 240, 27, 248 }, draws = { 9, 9 }, x_draw = 2, base = { 19, 240 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 110, 6, 122, 19 }, draws = { 14, 13 }, x_draw = 2, base = { 110, 6 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 135, 249, 138 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 135 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 139, 249, 142 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 139 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 143, 249, 146 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 143 } },
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 20, scientists = 15, kids = 25, food = 2000, ore = 5000,
        research = { 3304, 3305 },
        kits = { [1] = { "Residence" }, [2] = { "Agridome" }, [3] = { "University" } },
        view = { 38, 53 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 27, 56 } }, { "Tube", { 27, 57 } }, { "Tube", { 41, 46 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 38, 53 } },
      { type = "Agridome", player = 1, at = { 38, 46 } },
      { type = "StructureFactory", player = 1, at = { 27, 53 } },
      { type = "CommonOreSmelter", player = 1, at = { 49, 52 } },
      { type = "Tokamak", player = 1, at = { 24, 41 } },
      { type = "StandardLab", player = 1, at = { 27, 59 } },
      { type = "Residence", player = 1, at = { 43, 46 } },
      { type = "Nursery", player = 1, at = { 23, 54 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 39, 58 } },
      { type = "ConVec", weapon = "Residence", direction = "East", player = 1, at = { 33, 46 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 55, 31 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 45, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 47, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 49, 56 } },
      { type = "ConVec", direction = "East", player = 1, at = { 30, 57 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 30, 47 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 32, 48 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 41, 46 } },
      { roll = 1 },
      { roll = 2 },
      { roll = 3 },
      { roll = 4 },
      { roll = 5 },
      { roll = 6 },
      { roll = 7 },
      { roll = 8 },
      { roll = 9 },
      { roll = 10 },
      { roll = 11 },
      { roll = 12 },
      { roll = 13 },
      { roll = 14 },
      { roll = 15 },
      { roll = 16 },
      { roll = 17 },
      { roll = 18 },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 200, 10 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 71, 251 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 200, 144 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 163, 30 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 161, 120 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 63, 203 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 250, 249 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 162, 156 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 92, 156 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 148 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 48, 222 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 137, 200 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 151, 11 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 208, 48 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 186, 104 }, beacon = true },
    },
    beacons = {
    },
    rolled = {
      { count = 3, kinds = {
          { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random" },
        },
        table = {
          { 122, 5 }, { 147, 35 }, { 5, 143 }, { 19, 95 }, { 9, 19 }, { 84, 67 }, { 137, 114 }, { 144, 73 },
          { 71, 158 }, { 9, 216 }, { 8, 156 }, { 18, 192 }, { 29, 199 }, { 34, 238 }, { 9, 230 }, { 42, 228 },
          { 45, 191 }, { 174, 62 }, { 145, 88 },
        } },
      { count = 2, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random" },
          { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random" },
        },
        table = {
          { 168, 208 }, { 106, 224 }, { 193, 230 }, { 184, 252 }, { 110, 252 }, { 140, 222 }, { 146, 247 }, { 167, 234 },
          { 124, 234 }, { 179, 216 }, { 192, 202 },
        } },
      { count = 2, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random" },
        },
        table = {
          { 156, 165 }, { 106, 189 }, { 187, 136 }, { 210, 129 }, { 230, 156 }, { 229, 79 }, { 193, 28 }, { 156, 13 },
          { 233, 18 }, { 246, 56 }, { 190, 75 }, { 82, 248 },
        } },
      { count = 4, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random" },
          { type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random" },
        },
        table = {
          { 179, 198 }, { 250, 209 }, { 249, 176 }, { 239, 165 }, { 205, 115 }, { 226, 92 }, { 241, 70 }, { 243, 30 },
          { 246, 5 }, { 250, 133 }, { 238, 104 }, { 228, 141 },
        } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 73, 108, 85, 121 }, draws = { 14, 13 }, x_draw = 2, base = { 73, 108 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 110, 241, 121, 249 }, draws = { 9, 12 }, x_draw = 2, base = { 110, 241 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 212, 227, 223, 237 }, draws = { 11, 12 }, x_draw = 2, base = { 212, 227 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 243, 169, 255, 174 }, draws = { 6, 13 }, x_draw = 2, base = { 243, 169 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 219, 119, 226, 129 }, draws = { 11, 8 }, x_draw = 2, base = { 219, 119 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 206, 111, 215, 118 }, draws = { 8, 10 }, x_draw = 2, base = { 206, 111 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 105, 251, 116 }, draws = { 12, 15 }, x_draw = 2, base = { 237, 105 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 229, 47, 240, 58 }, draws = { 12, 12 }, x_draw = 2, base = { 229, 47 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 53, 109, 64, 120 }, draws = { 12, 12 }, x_draw = 2, base = { 53, 109 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 19, 240, 27, 248 }, draws = { 9, 9 }, x_draw = 2, base = { 19, 240 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 110, 6, 122, 19 }, draws = { 14, 13 }, x_draw = 2, base = { 110, 6 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 135, 249, 138 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 135 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 139, 249, 142 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 139 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 143, 249, 146 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 143 } },
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 25, scientists = 10, kids = 15, food = 1000, ore = 5000,
        research = { 3304 },
        kits = { [1] = { "Agridome" }, [2] = { "Nursery" } },
        view = { 38, 53 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 35, 46 } }, { "Tube", { 36, 46 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 38, 53 } },
      { type = "Agridome", player = 1, at = { 38, 46 } },
      { type = "StructureFactory", player = 1, at = { 27, 53 } },
      { type = "CommonOreSmelter", player = 1, at = { 49, 52 } },
      { type = "Tokamak", player = 1, at = { 24, 41 } },
      { type = "Residence", player = 1, at = { 33, 46 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 67, 38 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 45, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 47, 56 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 49, 56 } },
      { type = "ConVec", direction = "East", player = 1, at = { 30, 57 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 30, 47 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 32, 48 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 41, 46 } },
      { roll = 1 },
      { roll = 2 },
      { roll = 3 },
      { roll = 4 },
      { roll = 5 },
      { roll = 6 },
      { roll = 7 },
      { roll = 8 },
      { roll = 9 },
      { roll = 10 },
      { roll = 11 },
      { roll = 12 },
      { roll = 13 },
      { roll = 14 },
      { roll = 15 },
      { roll = 16 },
      { roll = 17 },
      { roll = 18 },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 200, 10 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 71, 251 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 200, 144 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 163, 30 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 161, 120 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 63, 203 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 250, 249 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 162, 156 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 92, 156 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 148 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 48, 222 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 137, 200 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 151, 11 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 208, 48 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 186, 104 }, beacon = true },
    },
    beacons = {
    },
    rolled = {
      { count = 3, kinds = {
          { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random" },
        },
        table = {
          { 122, 5 }, { 147, 35 }, { 5, 143 }, { 19, 95 }, { 9, 19 }, { 84, 67 }, { 137, 114 }, { 144, 73 },
          { 71, 158 }, { 9, 216 }, { 8, 156 }, { 18, 192 }, { 29, 199 }, { 34, 238 }, { 9, 230 }, { 42, 228 },
          { 45, 191 }, { 174, 62 }, { 145, 88 },
        } },
      { count = 2, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random" },
          { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random" },
        },
        table = {
          { 168, 208 }, { 106, 224 }, { 193, 230 }, { 184, 252 }, { 110, 252 }, { 140, 222 }, { 146, 247 }, { 167, 234 },
          { 124, 234 }, { 179, 216 }, { 192, 202 },
        } },
      { count = 2, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random" },
        },
        table = {
          { 156, 165 }, { 106, 189 }, { 187, 136 }, { 210, 129 }, { 230, 156 }, { 229, 79 }, { 193, 28 }, { 156, 13 },
          { 233, 18 }, { 246, 56 }, { 190, 75 }, { 82, 248 },
        } },
      { count = 4, kinds = {
          { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random" },
          { type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random" },
          { type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random" },
        },
        table = {
          { 179, 198 }, { 250, 209 }, { 249, 176 }, { 239, 165 }, { 205, 115 }, { 226, 92 }, { 241, 70 }, { 243, 30 },
          { 246, 5 }, { 250, 133 }, { 238, 104 }, { 228, 141 },
        } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 73, 108, 85, 121 }, draws = { 14, 13 }, x_draw = 2, base = { 73, 108 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 110, 241, 121, 249 }, draws = { 9, 12 }, x_draw = 2, base = { 110, 241 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 212, 227, 223, 237 }, draws = { 11, 12 }, x_draw = 2, base = { 212, 227 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 243, 169, 255, 174 }, draws = { 6, 13 }, x_draw = 2, base = { 243, 169 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", area = { 219, 119, 226, 129 }, draws = { 11, 8 }, x_draw = 2, base = { 219, 119 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 206, 111, 215, 118 }, draws = { 8, 10 }, x_draw = 2, base = { 206, 111 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 105, 251, 116 }, draws = { 12, 15 }, x_draw = 2, base = { 237, 105 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 229, 47, 240, 58 }, draws = { 12, 12 }, x_draw = 2, base = { 229, 47 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 53, 109, 64, 120 }, draws = { 12, 12 }, x_draw = 2, base = { 53, 109 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 19, 240, 27, 248 }, draws = { 9, 9 }, x_draw = 2, base = { 19, 240 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 110, 6, 122, 19 }, draws = { 14, 13 }, x_draw = 2, base = { 110, 6 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 135, 249, 138 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 135 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 139, 249, 142 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 139 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", area = { 237, 143, 249, 146 }, draws = { 4, 13 }, x_draw = 2, base = { 237, 143 } },
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 175, 8, 175, 8 },
  { 174, 9, 176, 9 },
  { 173, 10, 177, 10 },
  { 172, 11, 178, 11 },
  { 171, 12, 179, 12 },
  { 171, 13, 180, 13 },
  { 171, 14, 181, 14 },
  { 170, 15, 181, 15 },
  { 169, 16, 181, 16 },
  { 168, 17, 182, 17 },
  { 165, 18, 183, 18 },
  { 166, 19, 186, 19 },
  { 167, 20, 169, 20 },
  { 171, 20, 187, 20 },
  { 172, 21, 188, 21 },
  { 172, 22, 189, 22 },
  { 172, 23, 190, 23 },
  { 171, 24, 190, 24 },
  { 171, 25, 191, 25 },
  { 170, 26, 192, 26 },
  { 170, 27, 193, 27 },
  { 169, 28, 194, 28 },
  { 168, 29, 176, 29 },
  { 179, 29, 195, 29 },
  { 167, 30, 175, 30 },
  { 179, 30, 196, 31 },
  { 167, 31, 174, 31 },
  { 166, 32, 169, 32 },
  { 180, 32, 197, 33 },
  { 165, 33, 166, 33 },
  { 181, 34, 197, 34 },
  { 181, 35, 198, 35 },
  { 182, 36, 198, 36 },
  { 182, 37, 199, 37 },
  { 183, 38, 200, 38 },
  { 184, 39, 200, 39 },
  { 185, 40, 200, 40 },
  { 186, 41, 200, 41 },
  { 186, 42, 201, 45 },
  { 187, 46, 201, 46 },
  { 188, 47, 202, 47 },
  { 189, 48, 203, 48 },
  { 190, 49, 206, 49 },
  { 192, 50, 206, 50 },
  { 192, 51, 207, 51 },
  { 193, 52, 206, 52 },
  { 196, 53, 205, 53 },
  { 198, 54, 204, 54 },
  { 201, 55, 203, 55 },
  { 188, 75, 188, 75 },
  { 187, 76, 188, 78 },
  { 186, 79, 188, 79 },
  { 185, 80, 187, 80 },
  { 184, 81, 186, 82 },
  { 184, 83, 187, 83 },
  { 184, 84, 188, 85 },
  { 183, 86, 188, 88 },
  { 182, 89, 187, 91 },
  { 181, 92, 187, 92 },
  { 180, 93, 187, 93 },
  { 179, 94, 187, 94 },
  { 178, 95, 187, 95 },
  { 177, 96, 187, 96 },
  { 176, 97, 187, 97 },
  { 175, 98, 187, 98 },
  { 175, 99, 186, 99 },
  { 175, 100, 185, 100 },
  { 174, 101, 185, 101 },
  { 173, 102, 185, 104 },
  { 173, 105, 186, 105 },
  { 171, 106, 186, 107 },
  { 169, 108, 186, 108 },
  { 168, 109, 186, 110 },
  { 169, 111, 186, 113 },
  { 169, 114, 185, 114 },
  { 170, 115, 185, 116 },
  { 164, 117, 165, 117 },
  { 171, 117, 185, 117 },
  { 162, 118, 165, 118 },
  { 172, 118, 185, 118 },
  { 162, 119, 167, 119 },
  { 173, 119, 186, 119 },
  { 163, 120, 168, 120 },
  { 174, 120, 186, 122 },
  { 165, 121, 169, 121 },
  { 166, 122, 170, 122 },
  { 166, 123, 171, 123 },
  { 173, 123, 186, 123 },
  { 166, 124, 187, 125 },
  { 165, 126, 188, 126 },
  { 163, 127, 188, 127 },
  { 163, 128, 189, 129 },
  { 162, 130, 189, 130 },
  { 161, 131, 189, 131 },
  { 161, 132, 190, 132 },
  { 159, 133, 190, 133 },
  { 158, 134, 192, 134 },
  { 158, 135, 193, 135 },
  { 158, 136, 194, 136 },
  { 159, 137, 194, 137 },
  { 161, 138, 195, 138 },
  { 162, 139, 196, 139 },
  { 165, 140, 165, 140 },
  { 167, 140, 197, 140 },
  { 168, 141, 198, 141 },
  { 136, 142, 138, 142 },
  { 169, 142, 199, 142 },
  { 135, 143, 140, 143 },
  { 170, 143, 201, 144 },
  { 134, 144, 141, 144 },
  { 133, 145, 142, 145 },
  { 171, 145, 200, 145 },
  { 132, 146, 145, 146 },
  { 172, 146, 198, 147 },
  { 132, 147, 150, 147 },
  { 130, 148, 152, 148 },
  { 173, 148, 199, 149 },
  { 129, 149, 155, 149 },
  { 129, 150, 156, 150 },
  { 173, 150, 201, 150 },
  { 130, 151, 158, 151 },
  { 173, 151, 202, 151 },
  { 131, 152, 139, 152 },
  { 142, 152, 159, 152 },
  { 174, 152, 202, 152 },
  { 132, 153, 136, 153 },
  { 144, 153, 162, 153 },
  { 175, 153, 203, 153 },
  { 144, 154, 164, 154 },
  { 178, 154, 204, 154 },
  { 145, 155, 164, 155 },
  { 179, 155, 205, 155 },
  { 147, 156, 164, 156 },
  { 181, 156, 205, 156 },
  { 148, 157, 164, 160 },
  { 182, 157, 205, 157 },
  { 184, 158, 206, 158 },
  { 185, 159, 206, 159 },
  { 186, 160, 207, 160 },
  { 133, 161, 133, 161 },
  { 146, 161, 164, 161 },
  { 187, 161, 207, 161 },
  { 129, 162, 138, 162 },
  { 142, 162, 164, 162 },
  { 175, 162, 175, 163 },
  { 187, 162, 208, 162 },
  { 124, 163, 163, 163 },
  { 188, 163, 208, 164 },
  { 121, 164, 162, 164 },
  { 175, 164, 176, 164 },
  { 118, 165, 161, 165 },
  { 175, 165, 177, 165 },
  { 190, 165, 209, 165 },
  { 114, 166, 161, 166 },
  { 176, 166, 177, 166 },
  { 193, 166, 209, 166 },
  { 113, 167, 161, 167 },
  { 176, 167, 178, 167 },
  { 194, 167, 207, 167 },
  { 112, 168, 161, 168 },
  { 177, 168, 179, 168 },
  { 195, 168, 206, 168 },
  { 111, 169, 161, 169 },
  { 178, 169, 179, 169 },
  { 197, 169, 205, 169 },
  { 110, 170, 161, 171 },
  { 178, 170, 180, 170 },
  { 179, 171, 181, 171 },
  { 110, 172, 124, 172 },
  { 127, 172, 161, 173 },
  { 180, 172, 182, 172 },
  { 109, 173, 122, 174 },
  { 180, 173, 183, 173 },
  { 126, 174, 161, 174 },
  { 180, 174, 184, 175 },
  { 108, 175, 121, 179 },
  { 125, 175, 161, 175 },
  { 124, 176, 161, 177 },
  { 181, 176, 185, 177 },
  { 125, 178, 161, 183 },
  { 182, 178, 185, 178 },
  { 183, 179, 186, 180 },
  { 108, 180, 120, 180 },
  { 108, 181, 119, 181 },
  { 184, 181, 186, 181 },
  { 108, 182, 113, 182 },
  { 185, 182, 187, 182 },
  { 109, 183, 112, 183 },
  { 185, 183, 188, 184 },
  { 126, 184, 161, 184 },
  { 125, 185, 161, 185 },
  { 185, 185, 189, 185 },
  { 125, 186, 160, 186 },
  { 186, 186, 190, 186 },
  { 125, 187, 159, 187 },
  { 187, 187, 190, 187 },
  { 125, 188, 158, 188 },
  { 188, 188, 192, 188 },
  { 124, 189, 157, 189 },
  { 189, 189, 193, 189 },
  { 121, 190, 157, 190 },
  { 192, 190, 194, 190 },
  { 120, 191, 141, 191 },
  { 146, 191, 157, 191 },
  { 193, 191, 194, 191 },
  { 119, 192, 140, 192 },
  { 148, 192, 157, 192 },
  { 193, 192, 195, 192 },
  { 118, 193, 130, 193 },
  { 148, 193, 156, 193 },
  { 194, 193, 198, 193 },
  { 115, 194, 129, 194 },
  { 195, 194, 200, 194 },
  { 114, 195, 124, 195 },
  { 126, 195, 128, 195 },
  { 197, 195, 202, 195 },
  { 114, 196, 123, 196 },
  { 198, 196, 204, 196 },
  { 114, 197, 120, 197 },
  { 199, 197, 205, 197 },
  { 200, 198, 206, 198 },
  { 201, 199, 207, 199 },
  { 202, 200, 208, 200 },
  { 202, 201, 209, 201 },
  { 202, 202, 210, 202 },
  { 204, 203, 205, 203 },
  { 207, 203, 211, 203 },
  { 207, 204, 212, 204 },
  { 207, 205, 213, 205 },
  { 209, 206, 213, 206 },
  { 209, 207, 214, 208 },
  { 213, 209, 215, 210 },
  { 214, 211, 216, 211 },
  { 214, 212, 217, 212 },
  { 213, 213, 217, 213 },
  { 215, 214, 217, 214 },
  { 215, 215, 218, 215 },
  { 215, 216, 219, 216 },
  { 216, 217, 219, 218 },
  { 215, 219, 219, 220 },
  { 215, 221, 220, 221 },
  { 213, 222, 220, 222 },
  { 215, 223, 220, 224 },
  { 216, 225, 221, 227 },
  { 216, 228, 220, 228 },
  { 216, 229, 219, 229 },
  { 215, 230, 219, 231 },
  { 216, 232, 219, 232 },
  { 216, 233, 218, 234 },
  { 214, 234, 214, 235 },
  { 216, 235, 217, 235 },
  { 214, 236, 217, 237 },
  { 214, 238, 218, 241 },
  { 214, 242, 219, 242 },
  { 214, 243, 220, 244 },
  { 214, 245, 221, 246 },
  { 215, 247, 222, 247 },
  { 215, 248, 224, 248 },
  { 216, 249, 225, 251 },
  { 219, 252, 225, 252 },
  { 220, 253, 225, 253 },
  { 221, 254, 226, 255 },
}

local kits_set = false
local function make_unit(player, u, at, kits, exact)
  local made = game.create_unit{ type = u.type, player = player, at = at, direction = u.direction,
                                 weapon = u.weapon, lights = u.lights, exact = exact }
  if u.cargo and made[1] then made[1]:set_cargo(u.cargo, u.amount) end
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

function make_things(d)
  for _, w in ipairs(d.walls) do
    if w[1] == "Tube" then game.create_tube(w[2]) else game.create_wall(w[1], w[2]) end
  end
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

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function BigWave3(t) end
function ResAcid(t) end
function ResEMP(t) end
function ResRailGun(t) end
function ResStarflare(t) end
function ResThor(t) end
function ResearchedBig(t) end
function ResearchedMed(t) end
function ResearchedWeapons(t) end


-- The scouts' group (0x1100CBE4) and which of Lava's three eruptions have come (0x1100CBEC).
local scout_group
local lava_used = { false, false, false }

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Meteor, MeteorOnBase, MeteorRepeat, Quake, Storm, StormOnBase, StormRepeat, Tornado, TornadoRepeat, VortexOnBase

function Meteor(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(9)
    local r2 = game.rand(2)
    if r2 < 1 then
      local r3 = game.rand(70)
      local r4 = game.rand(170)
      game.create_meteor({ r4 + 88, r3 + 182 }, ({ -1, 0, 0, 0, 0, 0, 0, 0, 0 })[r1 + 1])
    else
      local r3 = game.rand(168)
      local r4 = game.rand(89)
      game.create_meteor({ r4 + 3, r3 + 5 }, ({ -1, 0, 0, 0, 0, 0, 0, 0, 0 })[r1 + 1])
    end
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(2)
    if r1 < 1 then
      local r2 = game.rand(70)
      local r3 = game.rand(170)
      game.create_meteor({ r3 + 88, r2 + 182 }, -1)
    else
      local r2 = game.rand(168)
      local r3 = game.rand(89)
      game.create_meteor({ r3 + 3, r2 + 5 }, -1)
    end
  else
    local r1 = game.rand(2)
    if r1 < 1 then
      local r2 = game.rand(70)
      local r3 = game.rand(170)
      game.create_meteor({ r3 + 88, r2 + 182 }, -1)
    else
      local r2 = game.rand(168)
      local r3 = game.rand(89)
      game.create_meteor({ r3 + 3, r2 + 5 }, -1)
    end
  end
end

function MeteorOnBase(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(9)
    local r2 = game.rand(60)
    local r3 = game.rand(56)
    game.create_meteor({ r3 + 1, r2 + 14 }, ({ -1, 0, 0, 0, 0, 0, 0, 0, 0 })[r1 + 1])
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(64)
    local r2 = game.rand(60)
    game.create_meteor({ r2 + 1, r1 + 23 }, -1)
  else
    local r1 = game.rand(64)
    local r2 = game.rand(60)
    game.create_meteor({ r2 + 1, r1 + 23 }, -1)
  end
end

function MeteorRepeat(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 3000, max = 4000, one_shot = false, on = MeteorOnBase}  -- after 30 to 40 marks
    trigger.time{min = 1000, max = 2000, one_shot = false, on = Meteor}  -- after 10 to 20 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 4000, max = 6000, one_shot = false, on = MeteorOnBase}  -- after 40 to 60 marks
    trigger.time{min = 11000, max = 22000, one_shot = false, on = Meteor}  -- after 110 to 220 marks
  else
    trigger.time{min = 3000, max = 4000, one_shot = false, on = MeteorOnBase}  -- after 30 to 40 marks
    trigger.time{min = 3000, max = 4000, one_shot = false, on = Meteor}  -- after 30 to 40 marks
  end
end

function Quake(t)
  local r1 = game.rand(16)
  local r2 = game.rand(3)
  local r3 = game.rand(3)
  if r1 == 0 then
    game.create_earthquake({ r3 + 175, r1 + r2 + 5 }, 3)
  elseif r1 == 1 then
    game.create_earthquake({ r3 + 167, r1 + r2 + 148 }, 4)
  elseif r1 == 2 then
    game.create_earthquake({ r3 + 175, r1 + r2 + 158 }, 3)
  elseif r1 == 3 then
    game.create_earthquake({ r3 + 74, r1 + r2 + 251 }, 3)
  elseif r1 == 4 then
    game.create_earthquake({ r3 + 17, r1 + r2 + 25 }, 1)
  elseif r1 == 5 then
    game.create_earthquake({ r3 + 184, r2 + 20 }, 2)
  elseif r1 == 6 then
    game.create_earthquake({ r3 + 201, r1 + r2 + 45 }, 3)
  elseif r1 == 7 then
    game.create_earthquake({ r3 + 151, r1 + r2 + 126 }, 1)
  elseif r1 == 8 then
    game.create_earthquake({ r3 + 236, r1 + r2 + 219 }, 3)
  elseif r1 == 9 then
    game.create_earthquake({ r3 + 166, r1 + r2 + 185 }, 2)
  elseif r1 == 10 then
    game.create_earthquake({ r3 + 51, r2 + 222 }, 3)
  elseif r1 == 11 then
    game.create_earthquake({ r3 + 81, r1 + r2 + 82 }, 2)
  elseif r1 == 12 then
    game.create_earthquake({ r3 + 148, r1 + r2 + 30 }, 1)
  elseif r1 == 13 then
    game.create_earthquake({ r3 + 153, r1 + r2 + 219 }, 1)
  elseif r1 == 14 then
    game.create_earthquake({ r3 + 238, r1 + r2 + 101 }, 2)
  else
    game.create_earthquake({ r3 + 229, r1 + r2 - 1 }, 3)
  end
end

function Storm(t)
  local r1 = game.rand(7)
  local r2 = game.rand(255)
  local r3 = game.rand(255)
  game.create_lightning({ r3 + 1, r2 + 2 }, { 256, 256 }, r1 + 14)
end

function StormOnBase(t)
  local r1 = game.rand(7)
  local r2 = game.rand(64)
  local r3 = game.rand(64)
  game.create_lightning({ r3 + 1, r2 + 2 }, { 256, 256 }, r1 + 14)
end

function StormRepeat(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 8000, max = 12000, one_shot = false, on = StormOnBase}  -- after 80 to 120 marks
    trigger.time{min = 3000, max = 4000, one_shot = false, on = Storm}  -- after 30 to 40 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 9000, max = 13000, one_shot = false, on = StormOnBase}  -- after 90 to 130 marks
    trigger.time{min = 10000, max = 19000, one_shot = false, on = Storm}  -- after 100 to 190 marks
  else
    trigger.time{min = 8000, max = 12000, one_shot = false, on = StormOnBase}  -- after 80 to 120 marks
    trigger.time{min = 12000, max = 21000, one_shot = false, on = Storm}  -- after 120 to 210 marks
  end
end

function Tornado(t)
  local r1 = game.rand(7)
  local r2 = game.rand(255)
  local r3 = game.rand(245)
  game.create_tornado({ r3 + 11, r2 + 2 }, { 256, 256 }, r1 + 14)
end

function TornadoRepeat(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 13000, max = 20000, one_shot = false, on = VortexOnBase}  -- after 130 to 200 marks
    trigger.time{min = 4000, max = 6000, one_shot = false, on = Tornado}  -- after 40 to 60 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Tornado}  -- after 120 to 180 marks
  else
    trigger.time{min = 13000, max = 20000, one_shot = false, on = VortexOnBase}  -- after 130 to 200 marks
    trigger.time{min = 10000, max = 17000, one_shot = false, on = Tornado}  -- after 100 to 170 marks
  end
end

function VortexOnBase(t)
  local r1 = game.rand(7)
  local r2 = game.rand(64)
  local r3 = game.rand(64)
  game.create_tornado({ r3 + 1, r2 + 2 }, { 256, 256 }, r1 + 14)
end

-- Every 40 ticks: the colony fails at once with fewer than 8 workers or 3 scientists, or with no Nursery, no
-- University and nothing that can build one (0x11005290).
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  if p.workers < 8 or p.scientists < 3
      or (not p:owns_any("Nursery") and not p:owns_any("University") and not p:can_build_building()) then
    mission.failure(trigger.time{time = 1})
  end
end

-- At 150, 270 and 550 colonists: one of three eruptions not yet seen, drawn again while it has been (at 175,9; at
-- 175,163; or at 163,154 and 172,150), spreading 200 (0x11002E80).
function Lava(t)
  local i = game.rand(3)
  while lava_used[i + 1] do i = game.rand(3) end
  lava_used[i + 1] = true
  if i == 0 then
    game.create_eruption({ 175, 9 }, 200)
  elseif i == 1 then
    game.create_eruption({ 175, 163 }, 200)
  else
    game.create_eruption({ 163, 154 }, 200)
    game.create_eruption({ 172, 150 }, 200)
  end
end

-- At tick 7000: two Scouts of player 2 come in at 1,191 and patrol 90,144 - 13,39 - 131,78 (the route at 0x1100B1D8);
-- 100 marks later they leave by 113,1 - 119,2 (0x110051F0).
function ScoutArrive(t)
  trigger.time{time = 10000, on = ScoutLeave}
  scout_group = ai.fight_group(players[2])
  scout_group:do_patrol_only()
  scout_group:set_patrol({ { 90, 144 }, { 13, 39 }, { 131, 78 } }, 2)
  scout_group:set_rect({ 113, 1, 119, 2 })
  scout_group:add_units(ai.unit_block{
    { type = "Scout", at = { 1, 191 }, classification = 9 },
    { type = "Scout", at = { 1, 191 }, classification = 9 },
  })
end

-- The scouts leave the map by 113,1 - 119,2 (0x110051D0).
function ScoutLeave(t)
  scout_group:do_exit_map()
  scout_group:set_rect({ 113, 1, 119, 2 })
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, d.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 164, 153 }, 1095)
  game.initial_set_tile({ 165, 153 }, 1107)
  game.initial_set_tile({ 164, 154 }, 1118)
  game.initial_set_tile({ 165, 154 }, 1129)
  game.initial_set_tile({ 170, 149 }, 1161)
  game.initial_set_tile({ 171, 149 }, 1172)
  game.initial_set_tile({ 170, 150 }, 1184)
  game.initial_set_tile({ 171, 150 }, 1195)
  game.initial_set_tile({ 175, 7 }, 1140)
  game.initial_set_tile({ 175, 8 }, 1150)
  game.initial_set_tile({ 175, 161 }, 1140)
  game.initial_set_tile({ 175, 162 }, 1150)
  game.set_daylight_everywhere(false)
  game.set_daylight_moves(true)
  if difficulty == "Easy" then game.morale_steady("Good") end
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end

  -- The win.
  local t5 = trigger.resource{resource = "Colonists", compare = ">=", amount = 600, player = 1, one_shot = true}
  mission.victory(t5, "Build your population to 600 colonists.")
  local t25 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t25)
  trigger.resource{resource = "Colonists", compare = ">", amount = 150, player = 1, one_shot = true, on = Lava}
  trigger.resource{resource = "Colonists", compare = ">", amount = 270, player = 1, one_shot = true, on = Lava}
  trigger.resource{resource = "Colonists", compare = ">", amount = 550, player = 1, one_shot = true, on = Lava}
  trigger.resource{resource = "Colonists", compare = ">", amount = 160, player = 1, one_shot = true, on = StormRepeat}
  trigger.resource{resource = "Colonists", compare = ">", amount = 90, player = 1, one_shot = true, on = TornadoRepeat}
  trigger.resource{resource = "Colonists", compare = ">", amount = 280, player = 1, one_shot = true, on = MeteorRepeat}
  trigger.time{min = 8000, max = 13000, one_shot = false, on = Quake}  -- after 80 to 130 marks
  trigger.research{tech = 3851, player = 1, one_shot = true, on = ResearchedWeapons}  -- ResearchedWeapons isn't converted
  trigger.research{tech = 5201, player = 1, one_shot = true, on = ResearchedMed}  -- ResearchedMed isn't converted
  trigger.research{tech = 8201, player = 1, one_shot = true, on = ResearchedBig}  -- ResearchedBig isn't converted
  trigger.time{time = 7000, on = ScoutArrive}  -- after 70 marks
  trigger.resource{resource = "Colonists", compare = ">", amount = 470, player = 1, one_shot = true, on = BigWave3}  -- BigWave3 isn't converted
  trigger.resource{resource = "Colonists", compare = ">", amount = 540, player = 1, one_shot = true, on = BigWave3}  -- BigWave3 isn't converted
  trigger.research{tech = 7102, player = 1, one_shot = true, on = ResStarflare}  -- ResStarflare isn't converted
  trigger.research{tech = 5506, player = 1, one_shot = true, on = ResRailGun}  -- ResRailGun isn't converted
  trigger.research{tech = 5508, player = 1, one_shot = true, on = ResEMP}  -- ResEMP isn't converted
  trigger.research{tech = 8503, player = 1, one_shot = true, on = ResAcid}  -- ResAcid isn't converted
  trigger.research{tech = 10102, player = 1, one_shot = true, on = ResThor}  -- ResThor isn't converted
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

-- Not converted:
-- - BigWave3 isn't converted: it calls CreateFightGroup
-- - ResAcid isn't converted: it calls nothing
-- - ResEMP isn't converted: it calls nothing
-- - ResRailGun isn't converted: it calls nothing
-- - ResStarflare isn't converted: it calls nothing
-- - ResThor isn't converted: it calls nothing
-- - ResearchedBig isn't converted: it calls nothing
-- - ResearchedMed isn't converted: it calls nothing
-- - ResearchedWeapons isn't converted: it calls nothing
