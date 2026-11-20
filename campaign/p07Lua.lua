-- p07Lua.lua  -  Plymouth Mission #7 (Lua)
-- Trigger functions finished by hand (CheckForFail, RestorePeople, RepeatWaves), from the disassembly of p07.dll.
-- Converted by op2dll from p07.dll. With p07Lua.placement.lua (what every difficulty makes alike),
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
        workers = 35, scientists = 25, kids = 0, food = 3000, ore = 3000, rare_ore = 2000,
        research = { 7000 },
        tech_level = 6,
        view = { 101, 19 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 7,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 107, 7 } }, { "Tube", { 108, 7 } }, { "Tube", { 109, 7 } }, { "Tube", { 110, 7 } },
      { "Tube", { 111, 7 } }, { "Tube", { 112, 12 } }, { "Tube", { 112, 19 } }, { "Tube", { 113, 12 } },
      { "Tube", { 113, 13 } }, { "Tube", { 113, 14 } }, { "Tube", { 113, 15 } }, { "Tube", { 113, 16 } },
      { "Tube", { 113, 17 } }, { "Tube", { 113, 18 } }, { "Tube", { 113, 19 } },
    },
    made = {
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 102, 32 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 67, 15 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 21, 51 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 103, 47 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 44, 38 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 39, 3 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 75, 40 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 123, 38 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 123, 38 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 124, 5 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 124, 5 } },
      { type = "CommandCenter", player = 1, at = { 101, 19 } },
      { type = "VehicleFactory", player = 1, at = { 95, 11 } },
      { type = "RareOreSmelter", player = 1, at = { 104, 7 } },
      { type = "AdvancedLab", player = 1, at = { 112, 9 } },
      { type = "Agridome", player = 1, at = { 90, 7 } },
      { type = "Tokamak", player = 1, at = { 84, 18 } },
      { type = "StandardLab", player = 1, at = { 109, 19 } },
      { type = "CommonStorage", player = 1, at = { 96, 4 } },
      { type = "RareStorage", player = 1, at = { 109, 26 } },
      { type = "StandardLab", player = 1, at = { 100, 26 } },
      { type = "CommonOreSmelter", player = 1, at = { 94, 19 } },
      { type = "Tokamak", player = 1, at = { 83, 12 } },
      { type = "Agridome", player = 1, at = { 93, 4 } },
      { type = "RobotCommand", player = 1, at = { 104, 14 } },
      { type = "Garage", player = 1, at = { 100, 14 } },
      { type = "ConVec", weapon = "Tokamak", direction = "East", player = 1, at = { 88, 26 } },
      { type = "ConVec", weapon = "ArachnidFactory", direction = "East", player = 1, at = { 87, 25 } },
      { type = "ConVec", weapon = "GuardPost", topping = "EMP", direction = "East", player = 1, at = { 89, 25 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 95, 6 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 96, 7 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 91, 15 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 93, 15 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 94, 14 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 82, 23 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 82, 25 } },
      { type = "Panther", weapon = "Microwave", direction = "East", player = 1, at = { 90, 28 } },
      { type = "Panther", weapon = "Microwave", direction = "East", player = 1, at = { 92, 28 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 108, 10 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 105, 11 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 106, 13 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 94, 22 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 89, 23 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 87, 23 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 94, 25 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 93, 24 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 94, 16 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 96, 26 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 104, 23 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 107, 25 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 30, scientists = 18, kids = 0, food = 2500, ore = 3500, rare_ore = 2000,
        research = { 7000 },
        tech_level = 6,
        view = { 101, 19 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 7,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 102, 32 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 67, 15 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 2 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 98, 48 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 44, 38 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 9, 34 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 123, 38 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 20, 23 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 124, 5 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 101, 19 } },
      { type = "VehicleFactory", player = 1, at = { 95, 11 } },
      { type = "RareOreSmelter", player = 1, at = { 104, 7 } },
      { type = "AdvancedLab", player = 1, at = { 109, 19 } },
      { type = "CommonStorage", player = 1, at = { 90, 20 } },
      { type = "RareStorage", player = 1, at = { 107, 8 } },
      { type = "StandardLab", player = 1, at = { 100, 26 } },
      { type = "CommonOreSmelter", player = 1, at = { 94, 19 } },
      { type = "Tokamak", player = 1, at = { 83, 12 } },
      { type = "Agridome", player = 1, at = { 93, 4 } },
      { type = "RobotCommand", player = 1, at = { 104, 14 } },
      { type = "Garage", player = 1, at = { 100, 14 } },
      { type = "ConVec", weapon = "Tokamak", direction = "East", player = 1, at = { 88, 26 } },
      { type = "ConVec", weapon = "ArachnidFactory", direction = "East", player = 1, at = { 87, 25 } },
      { type = "ConVec", weapon = "GuardPost", topping = "EMP", direction = "East", player = 1, at = { 89, 25 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 95, 6 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 96, 7 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 91, 15 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 93, 15 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 94, 14 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 82, 23 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 82, 25 } },
      { type = "Panther", weapon = "Microwave", direction = "East", player = 1, at = { 90, 28 } },
      { type = "Panther", weapon = "Microwave", direction = "East", player = 1, at = { 92, 28 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 108, 10 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 105, 11 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 106, 13 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 94, 22 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 89, 23 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 87, 23 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 94, 25 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 93, 24 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 108, 15 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 86, 13 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 105, 23 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 89, 16 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 83, 15 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 30, scientists = 20, kids = 0, food = 2000, ore = 3000, rare_ore = 2000,
        research = { 7000 },
        tech_level = 6,
        view = { 101, 19 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 7,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 102, 32 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 67, 15 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 32, 51 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 99, 50 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 44, 38 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 63, 13 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 123, 38 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 20, 23 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 101, 19 } },
      { type = "VehicleFactory", player = 1, at = { 95, 11 } },
      { type = "RareOreSmelter", player = 1, at = { 104, 7 } },
      { type = "AdvancedLab", player = 1, at = { 109, 19 } },
      { type = "CommonStorage", player = 1, at = { 90, 20 } },
      { type = "RareStorage", player = 1, at = { 105, 19 } },
      { type = "StandardLab", player = 1, at = { 100, 26 } },
      { type = "CommonOreSmelter", player = 1, at = { 94, 19 } },
      { type = "Tokamak", player = 1, at = { 83, 12 } },
      { type = "Agridome", player = 1, at = { 93, 4 } },
      { type = "RobotCommand", player = 1, at = { 104, 14 } },
      { type = "Garage", player = 1, at = { 100, 14 } },
      { type = "ConVec", weapon = "Tokamak", direction = "East", player = 1, at = { 88, 26 } },
      { type = "ConVec", weapon = "ArachnidFactory", direction = "East", player = 1, at = { 87, 25 } },
      { type = "ConVec", weapon = "GuardPost", topping = "EMP", direction = "East", player = 1, at = { 89, 25 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 95, 6 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 96, 7 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 91, 15 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 93, 15 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 94, 14 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 82, 23 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 82, 25 } },
      { type = "Panther", weapon = "Microwave", direction = "East", player = 1, at = { 90, 28 } },
      { type = "Panther", weapon = "Microwave", direction = "East", player = 1, at = { 92, 28 } },
      { type = "RoboSurveyor", direction = "East", player = 1, at = { 108, 10 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 105, 11 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 106, 13 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 94, 22 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 89, 23 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 87, 23 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 94, 25 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Microwave", direction = "East", player = 1, at = { 93, 24 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 104, 25 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 109, 25 } },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 13, 1, 13, 1 },
  { 15, 1, 16, 1 },
  { 18, 1, 20, 1 },
  { 22, 1, 23, 1 },
  { 26, 1, 32, 1 },
  { 36, 1, 44, 1 },
  { 48, 1, 49, 1 },
  { 11, 2, 45, 2 },
  { 47, 2, 53, 2 },
  { 10, 3, 36, 3 },
  { 43, 3, 52, 3 },
  { 98, 3, 99, 3 },
  { 109, 3, 114, 3 },
  { 10, 4, 12, 4 },
  { 15, 4, 15, 4 },
  { 17, 4, 17, 4 },
  { 20, 4, 20, 4 },
  { 24, 4, 24, 4 },
  { 27, 4, 28, 4 },
  { 31, 4, 31, 4 },
  { 50, 4, 54, 4 },
  { 97, 4, 101, 4 },
  { 106, 4, 116, 4 },
  { 10, 5, 11, 6 },
  { 51, 5, 54, 5 },
  { 97, 5, 117, 5 },
  { 52, 6, 54, 6 },
  { 97, 6, 118, 6 },
  { 8, 7, 11, 7 },
  { 52, 7, 55, 7 },
  { 98, 7, 110, 7 },
  { 113, 7, 119, 7 },
  { 6, 8, 11, 8 },
  { 55, 8, 57, 8 },
  { 101, 8, 108, 8 },
  { 115, 8, 119, 8 },
  { 5, 9, 10, 9 },
  { 56, 9, 58, 9 },
  { 116, 9, 119, 9 },
  { 4, 10, 10, 10 },
  { 57, 10, 58, 10 },
  { 116, 10, 120, 10 },
  { 5, 11, 9, 11 },
  { 57, 11, 59, 11 },
  { 117, 11, 120, 11 },
  { 6, 12, 9, 12 },
  { 58, 12, 61, 12 },
  { 65, 12, 70, 12 },
  { 116, 12, 120, 13 },
  { 5, 13, 9, 13 },
  { 60, 13, 71, 13 },
  { 3, 14, 7, 14 },
  { 9, 14, 10, 14 },
  { 61, 14, 72, 16 },
  { 116, 14, 119, 15 },
  { 2, 15, 3, 16 },
  { 10, 15, 11, 15 },
  { 11, 16, 12, 18 },
  { 19, 16, 19, 16 },
  { 116, 16, 120, 16 },
  { 1, 17, 3, 17 },
  { 19, 17, 21, 17 },
  { 62, 17, 72, 17 },
  { 80, 17, 82, 17 },
  { 116, 17, 121, 17 },
  { 1, 18, 2, 18 },
  { 20, 18, 21, 18 },
  { 63, 18, 73, 18 },
  { 79, 18, 83, 19 },
  { 117, 18, 122, 18 },
  { 10, 19, 11, 19 },
  { 19, 19, 20, 19 },
  { 62, 19, 76, 19 },
  { 118, 19, 122, 19 },
  { 10, 20, 10, 20 },
  { 19, 20, 23, 20 },
  { 61, 20, 83, 20 },
  { 119, 20, 121, 20 },
  { 9, 21, 10, 21 },
  { 18, 21, 23, 21 },
  { 61, 21, 88, 21 },
  { 91, 21, 92, 21 },
  { 10, 22, 10, 22 },
  { 18, 22, 22, 22 },
  { 61, 22, 99, 22 },
  { 10, 23, 11, 23 },
  { 14, 23, 14, 23 },
  { 17, 23, 21, 23 },
  { 62, 23, 100, 23 },
  { 8, 24, 20, 24 },
  { 63, 24, 102, 24 },
  { 4, 25, 8, 25 },
  { 12, 25, 12, 25 },
  { 14, 25, 15, 25 },
  { 17, 25, 19, 25 },
  { 65, 25, 103, 25 },
  { 5, 26, 5, 26 },
  { 67, 26, 104, 26 },
  { 70, 27, 104, 27 },
  { 71, 28, 104, 28 },
  { 74, 29, 105, 29 },
  { 80, 30, 105, 30 },
  { 82, 31, 88, 31 },
  { 90, 31, 105, 31 },
  { 91, 32, 104, 32 },
  { 94, 33, 103, 33 },
  { 94, 34, 102, 34 },
  { 95, 35, 101, 35 },
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
-- Its unit tables, as the mission's UnitRecord arrays list them (ai.unit_block).
local AI_UNITS = {
  [1] = {
    { type = "Lynx", at = { 30, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 34, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 38, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 42, 63 }, weapon = "Laser" },
  },
  [2] = {
    { type = "Panther", at = { 1, 13 }, weapon = "RailGun" },
    { type = "Panther", at = { 1, 15 }, weapon = "RailGun" },
    { type = "Panther", at = { 1, 17 }, weapon = "RailGun" },
    { type = "Panther", at = { 1, 19 }, weapon = "RailGun" },
  },
  [3] = {
    { type = "Lynx", at = { 30, 63 }, weapon = "Laser" },
    { type = "Panther", at = { 32, 63 }, weapon = "RailGun" },
    { type = "Lynx", at = { 34, 63 }, weapon = "Laser" },
    { type = "Panther", at = { 36, 63 }, weapon = "RailGun" },
    { type = "Lynx", at = { 38, 63 }, weapon = "Laser" },
    { type = "Panther", at = { 40, 63 }, weapon = "RailGun" },
    { type = "Lynx", at = { 42, 63 }, weapon = "Laser" },
    { type = "Panther", at = { 44, 63 }, weapon = "RailGun" },
  },
  [4] = {
    { type = "Lynx", at = { 121, 1 }, weapon = "Laser" },
    { type = "Lynx", at = { 123, 1 }, weapon = "Laser" },
    { type = "Lynx", at = { 125, 1 }, weapon = "Laser" },
    { type = "Lynx", at = { 127, 1 }, weapon = "RailGun" },
    { type = "Lynx", at = { 129, 1 }, weapon = "RailGun" },
  },
  [5] = {
    { type = "Lynx", at = { 93, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 95, 63 }, weapon = "RailGun" },
  },
  [6] = {
    { type = "Panther", at = { 1, 24 }, weapon = "Laser" },
    { type = "Panther", at = { 1, 26 }, weapon = "Laser" },
  },
  [7] = {
    { type = "Lynx", at = { 93, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 95, 63 }, weapon = "RailGun" },
    { type = "Lynx", at = { 97, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 99, 63 }, weapon = "RailGun" },
    { type = "Lynx", at = { 101, 63 }, weapon = "Laser" },
    { type = "Lynx", at = { 103, 63 }, weapon = "RailGun" },
  },
  [8] = {
    { type = "Lynx", at = { 1, 38 }, weapon = "Laser" },
    { type = "Lynx", at = { 1, 40 }, weapon = "RailGun" },
    { type = "Lynx", at = { 1, 42 }, weapon = "Laser" },
  },
  [9] = {
    { type = "Lynx", at = { 37, 1 }, weapon = "Laser" },
    { type = "Lynx", at = { 39, 1 }, weapon = "RailGun" },
  },
  [10] = {
    { type = "Panther", at = { 37, 1 }, weapon = "Laser" },
    { type = "Panther", at = { 39, 1 }, weapon = "RailGun" },
    { type = "Panther", at = { 41, 1 }, weapon = "RailGun" },
  },
  [11] = {
    { type = "Lynx", at = { 69, 64 }, weapon = "Laser" },
    { type = "Lynx", at = { 71, 64 }, weapon = "Laser" },
    { type = "Panther", at = { 75, 64 }, weapon = "RailGun" },
  },
  [12] = {
    { type = "Lynx", at = { 69, 64 }, weapon = "Laser" },
    { type = "Lynx", at = { 71, 64 }, weapon = "Laser" },
    { type = "Panther", at = { 73, 64 }, weapon = "RailGun" },
    { type = "Panther", at = { 75, 64 }, weapon = "RailGun" },
  },
  [13] = {
    { type = "Lynx", at = { 1, 12 }, weapon = "Laser" },
    { type = "Lynx", at = { 1, 14 }, weapon = "Laser" },
    { type = "Lynx", at = { 1, 16 }, weapon = "Laser" },
    { type = "Lynx", at = { 1, 18 }, weapon = "Laser" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player

local function setup_ai(p)
  ai_player = p
end


-- The colonists the colony came with (0x11009B90 to 0x11009B98), read before the setup sets its own.
local saved_people = { 0, 0, 0 }
-- RepeatWaves' two groups (0x11009BA0, 0x11009BA4): the attackers and the escort that guards them.
local wave_group, escort_group
-- Where the waves come and go (0x11009BA8).
local WAVE_RECT = { 93, 4, 109, 26 }

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Erupt1, Erupt2, Meteor1, Meteor2, MeteorRepeat, MeteorRepeatStart, Microbe, Quake1, Quake2, SmallQuakes, SmallQuakes2, StartQuakes, StartQuakes2, Vortex1, Vortex2, Vortex3, Vortex4, Vortex5, Wave1Arrive, Wave2Arrive, Wave3Arrive, Wave4Arrive, Wave5Arrive

function Erupt1(t)
  if players[1].difficulty == "Easy" then
    game.set_tile({ 24, 18 }, 1104)
    game.set_tile({ 25, 18 }, 1115)
    game.set_tile({ 24, 19 }, 1126)
    game.set_tile({ 25, 19 }, 1137)
    game.create_eruption({ 23, 20 }, 200)
  elseif players[1].difficulty == "Normal" then
    game.set_tile({ 24, 18 }, 1104)
    game.set_tile({ 25, 18 }, 1115)
    game.set_tile({ 24, 19 }, 1126)
    game.set_tile({ 25, 19 }, 1137)
    game.create_eruption({ 23, 20 }, 240)
  else
    game.set_tile({ 24, 18 }, 1104)
    game.set_tile({ 25, 18 }, 1115)
    game.set_tile({ 24, 19 }, 1126)
    game.set_tile({ 25, 19 }, 1137)
    game.create_eruption({ 23, 20 }, 280)
  end
end

function Erupt2(t)
  if players[1].difficulty == "Easy" then
    game.set_tile({ 123, 16 }, 1104)
    game.set_tile({ 124, 16 }, 1115)
    game.set_tile({ 123, 17 }, 1126)
    game.set_tile({ 124, 17 }, 1137)
    game.create_eruption({ 122, 18 }, 200)
  elseif players[1].difficulty == "Normal" then
    game.set_tile({ 123, 16 }, 1104)
    game.set_tile({ 124, 16 }, 1115)
    game.set_tile({ 123, 17 }, 1126)
    game.set_tile({ 124, 17 }, 1137)
    game.create_eruption({ 122, 18 }, 240)
  else
    game.set_tile({ 123, 16 }, 1104)
    game.set_tile({ 124, 16 }, 1115)
    game.set_tile({ 123, 17 }, 1126)
    game.set_tile({ 124, 17 }, 1137)
    game.create_eruption({ 122, 18 }, 280)
  end
end

function Meteor1(t)
  game.create_meteor({ 64, 14 }, 0)
end

function Meteor2(t)
  game.create_meteor({ 115, 11 }, -1)
end

function MeteorRepeat(t)
  local r1 = game.rand(2)
  local r2 = game.rand(47)
  local r3 = game.rand(35)
  game.create_meteor({ r3 + 83, r2 + 2 }, r1)
end

function MeteorRepeatStart(t)
  trigger.time{min = 6000, max = 7000, one_shot = false, on = MeteorRepeat}  -- after 60 to 70 marks
end

local Microbe_done  -- Microbe does nothing more once it has acted
function Microbe(t)
  if Microbe_done then return end
  game.create_blight({ 101, 64 })
  game.create_blight({ 102, 64 })
  game.create_blight({ 103, 64 })
  game.set_blight_speed(120)
  game.message_at("Microbe growth detected!", 152, 1, 4224, 2016)
  Microbe_done = true
end

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 12, 18 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 12, 18 }, 2)
  else
    game.create_earthquake({ 12, 18 }, 2)
  end
end

function Quake2(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 61, 20 }, 3)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 61, 20 }, 4)
  else
    game.create_earthquake({ 61, 20 }, 4)
  end
end

function SmallQuakes(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(4)
    game.create_earthquake({ ({ 126, 123, 125, 124 })[r1 + 1], ({ 15, 21, 4, 11 })[r1 + 1] }, 1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(4)
    game.create_earthquake({ ({ 126, 123, 125, 124 })[r1 + 1], ({ 15, 21, 4, 11 })[r1 + 1] }, 2)
  else
    local r1 = game.rand(4)
    game.create_earthquake({ ({ 126, 123, 125, 124 })[r1 + 1], ({ 15, 21, 4, 11 })[r1 + 1] }, 2)
  end
end

function SmallQuakes2(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(6)
    game.create_earthquake({ ({ 10, 18, 25, 6, 29, 15 })[r1 + 1], ({ 7, 22, 4, 15, 51, 36 })[r1 + 1] }, 1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(6)
    game.create_earthquake({ ({ 10, 18, 25, 6, 29, 15 })[r1 + 1], ({ 7, 22, 4, 15, 51, 36 })[r1 + 1] }, 2)
  else
    local r1 = game.rand(6)
    game.create_earthquake({ ({ 10, 18, 25, 6, 29, 15 })[r1 + 1], ({ 7, 22, 4, 15, 51, 36 })[r1 + 1] }, 2)
  end
end

function StartQuakes(t)
  trigger.time{min = 4000, max = 5000, one_shot = false, on = SmallQuakes}  -- after 40 to 50 marks
end

function StartQuakes2(t)
  trigger.time{min = 3000, max = 4000, one_shot = false, on = SmallQuakes2}  -- after 30 to 40 marks
end

function Vortex1(t)
  game.create_tornado({ 103, 64 }, { 22, 43 }, 14)
end

function Vortex2(t)
  game.create_tornado({ 126, 1 }, { 53, 32 }, 12)
end

function Vortex3(t)
  game.create_tornado({ 26, 38 }, { 10, 32 }, 12)
end

function Vortex4(t)
  game.create_tornado({ 57, 51 }, { 53, 32 }, 12)
end

function Vortex5(t)
  game.create_tornado({ 94, 45 }, { 126, 12 }, 12)
end

function Wave1Arrive(t)
  local fight1 = ai.fight_group(ai_player)
  fight1:do_attack_enemy()
  fight1:set_attack_type("AdvancedLab")
  fight1:set_rect({ 93, 4, 109, 26 })
  fight1:add_units(ai_block(13))
  fight1:set_lights(true)
end

function Wave2Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("RareOreMine")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(11))
    fight1:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("AdvancedLab")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(11))
    fight1:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("AdvancedLab")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(12))
    fight1:set_lights(true)
  end
end

function Wave3Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("AdvancedLab")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(8))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("RareOreSmelter")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(9))
    fight2:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("AdvancedLab")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(8))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("RareOreSmelter")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(9))
    fight2:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("AdvancedLab")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(8))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("RareOreSmelter")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(10))
    fight2:set_lights(true)
  end
end

function Wave4Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("CommonOreSmelter")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(5))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("CommonOreMine")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(6))
    fight2:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("CommonOreSmelter")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(7))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("AdvancedLab")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(6))
    fight2:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("CommonOreSmelter")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(7))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("AdvancedLab")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(6))
    fight2:set_lights(true)
  end
end

function Wave5Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("RareOreSmelter")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(1))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("RareOreMine")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(2))
    fight2:set_lights(true)
    trigger.time{min = 8000, max = 8500, one_shot = false, on = RepeatWaves}
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("RareOreSmelter")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(1))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("AdvancedLab")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(2))
    fight2:set_lights(true)
    trigger.time{min = 4700, max = 5200, one_shot = false, on = RepeatWaves}
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_attack_type("RareOreSmelter")
    fight1:set_rect({ 93, 4, 109, 26 })
    fight1:add_units(ai_block(3))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_attack_type("AdvancedLab")
    fight2:set_rect({ 93, 4, 109, 26 })
    fight2:add_units(ai_block(4))
    fight2:set_lights(true)
    local fight3 = ai.fight_group(ai_player)
    fight3:do_attack_enemy()
    fight3:set_attack_type("AdvancedLab")
    fight3:set_rect({ 93, 4, 109, 26 })
    fight3:add_units(ai_block(2))
    fight3:set_lights(true)
    trigger.time{min = 3900, max = 4400, one_shot = false, on = RepeatWaves}
  end
end

-- Every 40 ticks (0x11003230): the colony's checks. Too few workers or scientists; less Common or Rare Metals in
-- storage than the objective (Cargo Trucks don't count) and no way to mine more; on Hard no Common Storage; or
-- Emergency Response Systems, Health Maintenance or the Space Program out of reach: the colony fails.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 2 then fail = true end
  local need = ({ Easy = { 10000, 7500 }, Normal = { 10000, 10000 }, Hard = { 12000, 10000 } })[p.difficulty]
  if p.ore < need[1] and not p:can_accumulate_ore() then fail = true end
  if p.rare_ore < need[2] and not p:can_accumulate_rare_ore() then fail = true end
  if need[1] > 10000 and #p:buildings("CommonStorage") == 0 then fail = true end
  for _, tech in ipairs({ 3301, 3303, 5405 }) do
    if not p:has_tech(tech) and not p:can_do_research(tech) then fail = true end
  end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Once every objective holds, the colony's colonists are set back to those it came with (0x11003430).
function RestorePeople(t)
  local p = players[1]
  p.workers = saved_people[1]
  p.scientists = saved_people[2]
  p.kids = saved_people[3]
end

-- The waves after the fifth: the two groups, made once, are an attack group and an escort guarding it; a target drawn
-- of three (the Common Ore Mine from the south-east, the Rare Ore Mine from the west, the Smelter from the
-- south-west) and there Laser Panthers join the attackers and EMP and Laser Lynx the escort, by difficulty
-- (0x11002BA0).
function RepeatWaves(t)
  if not wave_group then
    wave_group = ai.fight_group(ai_player)
    escort_group = ai.fight_group(ai_player)
  end
  wave_group:do_attack_enemy()
  wave_group:set_rect(WAVE_RECT)
  escort_group:do_guard_group()
  escort_group:set_target_group(wave_group)
  escort_group:set_rect(WAVE_RECT)
  local target = ({ { { 67, 63 }, "CommonOreMine" }, { { 2, 22 }, "RareOreMine" },
                    { { 4, 63 }, "CommonOreSmelter" } })[game.rand(3) + 1]
  local at, kind = target[1], target[2]
  local n = ({ Easy = { 2, 2, 2 }, Normal = { 4, 2, 1 }, Hard = { 6, 4, 1 } })[players[1].difficulty]
  for _ = 1, n[1] do
    local u = game.create_unit{type = "Panther", weapon = "Laser", player = ai_player, at = at, exact = true}
    wave_group:take_unit(u[1])
  end
  for _ = 1, n[2] do
    local u = game.create_unit{type = "Lynx", weapon = "EMP", player = ai_player, at = at, exact = true}
    escort_group:take_unit(u[1])
  end
  for _ = 1, n[3] do
    local u = game.create_unit{type = "Lynx", weapon = "Laser", player = ai_player, at = at, exact = true}
    escort_group:take_unit(u[1])
  end
  wave_group:set_attack_type(kind)
  wave_group:set_lights(true)
  escort_group:set_lights(true)
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  saved_people = { players[1].workers, players[1].scientists, players[1].kids }
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 24, 18 }, 1095)
  game.initial_set_tile({ 25, 18 }, 1107)
  game.initial_set_tile({ 24, 19 }, 1118)
  game.initial_set_tile({ 25, 19 }, 1129)
  game.set_daylight_everywhere(false)
  if difficulty == "Easy" then game.morale_steady("Good") end
  if difficulty == "Normal" then game.morale_steady("Fair") end
  if difficulty == "Hard" then game.morale_steady("Fair") end
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end

  -- The win.
  local t5 = trigger.research{tech = 5405, player = 1, one_shot = true}
  local rare = difficulty == "Easy" and 7500 or 10000
  local t6 = trigger.resource{resource = "RareOre", compare = ">=", amount = rare}
  mission.victory(t6, "Have " .. rare .. " units of Rare Metals in storage.")
  local common = difficulty == "Hard" and 12000 or 10000
  local t8 = trigger.resource{resource = "CommonOre", compare = ">=", amount = common}
  mission.victory(t8, "Have " .. common .. " units of Common Metals in storage.")
  mission.victory(t5, "Completely research the Space Program.")
  local t11, t12
  if players[1]:has_tech(3301) then
    t11 = trigger.time{time = 10}
  else
    t11 = trigger.research{tech = 3301, player = 1, one_shot = true}
    mission.victory(t11, "Completely research Emergency Response Systems.")
  end
  if players[1]:has_tech(3303) then
    t12 = trigger.time{time = 10}
  else
    t12 = trigger.research{tech = 3303, player = 1, one_shot = true}
    mission.victory(t12, "Completely research Health Maintenance.")
  end
  if difficulty ~= "Hard" and not players[1]:has_tech(5202) then
    local t = trigger.research{tech = 5202, player = 1, one_shot = true}
    mission.victory(t, "Completely research Dissipating Adhesives.")
  end
  trigger.set{t8, t6, t5, t11, t12, needed = 5, one_shot = true, on = RestorePeople}
  local t34 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t34)
  trigger.time{min = 14400, max = 16800, on = Quake1}  -- after 144 to 168 marks
  trigger.time{min = 67200, max = 69600, on = Quake2}  -- after 672 to 696 marks
  trigger.time{min = 7200, max = 9600, on = Meteor1}  -- after 72 to 96 marks
  trigger.time{min = 30000, max = 32400, on = Meteor2}  -- after 300 to 324 marks
  trigger.time{min = 16800, max = 19200, on = Vortex1}  -- after 168 to 192 marks
  trigger.time{min = 46800, max = 49200, on = Vortex2}  -- after 468 to 492 marks
  trigger.time{min = 10000, max = 12400, on = Vortex3}  -- after 100 to 124 marks
  trigger.time{min = 20000, max = 22400, on = Vortex4}  -- after 200 to 224 marks
  trigger.time{min = 27000, max = 29400, on = Vortex5}  -- after 270 to 294 marks
  trigger.time{time = 23232, on = StartQuakes}  -- after 232 marks
  trigger.time{time = 2700, on = StartQuakes2}  -- after 27 marks
  if difficulty == "Easy" then
    trigger.time{time = 45000, on = Erupt1}  -- after 450 marks
    trigger.time{time = 50000, on = Erupt2}  -- after 500 marks
    trigger.time{min = 55000, max = 60000, on = Microbe}  -- after 550 to 600 marks
    trigger.time{min = 8000, max = 8500, on = Wave1Arrive}  -- after 80 to 85 marks
    trigger.time{min = 13000, max = 13500, on = Wave2Arrive}  -- after 130 to 135 marks
    trigger.time{min = 18000, max = 18500, on = Wave3Arrive}  -- after 180 to 185 marks
    trigger.time{min = 23000, max = 23500, on = Wave4Arrive}  -- after 230 to 235 marks
    trigger.time{min = 28000, max = 28500, on = Wave5Arrive}  -- after 280 to 285 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 40000, on = Erupt1}  -- after 400 marks
    trigger.time{time = 49000, on = Erupt2}  -- after 490 marks
    trigger.time{min = 10000, max = 10500, on = MeteorRepeatStart}  -- after 100 to 105 marks
    trigger.time{min = 50000, max = 53000, on = Microbe}  -- after 500 to 530 marks
    trigger.time{min = 6000, max = 6500, on = Wave1Arrive}  -- after 60 to 65 marks
    trigger.time{min = 10700, max = 11200, on = Wave2Arrive}  -- after 107 to 112 marks
    trigger.time{min = 14900, max = 15400, on = Wave3Arrive}  -- after 149 to 154 marks
    trigger.time{min = 20100, max = 20600, on = Wave4Arrive}  -- after 201 to 206 marks
    trigger.time{min = 23800, max = 24300, on = Wave5Arrive}  -- after 238 to 243 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 40000, on = Erupt1}  -- after 400 marks
    trigger.time{time = 48000, on = Erupt2}  -- after 480 marks
    trigger.time{min = 10000, max = 10500, on = MeteorRepeatStart}  -- after 100 to 105 marks
    trigger.time{min = 50000, max = 53000, on = Microbe}  -- after 500 to 530 marks
    trigger.time{min = 7000, max = 7500, on = Wave1Arrive}  -- after 70 to 75 marks
    trigger.time{min = 11800, max = 12300, on = Wave2Arrive}  -- after 118 to 123 marks
    trigger.time{min = 16100, max = 16600, on = Wave3Arrive}  -- after 161 to 166 marks
    trigger.time{min = 20400, max = 20900, on = Wave4Arrive}  -- after 204 to 209 marks
    trigger.time{min = 25200, max = 25700, on = Wave5Arrive}  -- after 252 to 257 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

