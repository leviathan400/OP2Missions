-- e05Lua.lua  -  Eden Mission #5 (Lua)
-- Trigger functions finished by hand (CheckForFail, ScoutLeave, PatrolArrive, PatrolLeave, NextRes, PantherObj, ROP, SpaceDone, HasSpacePort), from the disassembly of e05.dll.
-- Converted by op2dll from e05.dll. With e05Lua.placement.lua (what every difficulty makes alike),
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
        workers = 22, scientists = 15, kids = 28, food = 3000, ore = 3000,
        research = { 5000 },
        tech_level = 4,
        kits = { [1] = { "CommandCenter" }, [2] = { "CommonOreSmelter" }, [3] = { "Tokamak" }, [4] = { "StructureFactory" }, [5] = { "Residence" } },
        view = { 33, 70 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 5,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 26, 62 } }, { "Tube", { 27, 62 } }, { "Tube", { 28, 62 } }, { "Tube", { 29, 62 } },
      { "Tube", { 30, 63 } }, { "Tube", { 30, 64 } }, { "Tube", { 42, 64 } }, { "Tube", { 42, 65 } },
      { "Tube", { 42, 66 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 34, 70 } },
      { type = "Agridome", player = 1, at = { 34, 67 } },
      { type = "Tokamak", player = 1, at = { 35, 56 } },
      { type = "Tokamak", player = 1, at = { 44, 55 } },
      { type = "AdvancedLab", player = 1, at = { 30, 60 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 42, 62 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 24, 62 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthWest", player = 1, at = { 25, 75 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthWest", player = 1, at = { 27, 75 } },
      { type = "Lynx", weapon = "Laser", direction = "North", player = 1, at = { 26, 76 } },
      { type = "CommonOreSmelter", player = 1, at = { 39, 66 } },
      { type = "RobotCommand", player = 1, at = { 38, 70 } },
      { type = "StandardLab", player = 1, at = { 30, 70 } },
      { type = "Nursery", player = 1, at = { 34, 73 } },
      { type = "Residence", player = 1, at = { 31, 73 } },
      { type = "StructureFactory", player = 1, at = { 30, 66 } },
      { type = "VehicleFactory", player = 1, at = { 38, 73 } },
      { type = "Residence", player = 1, at = { 38, 77 } },
      { type = "University", player = 1, at = { 38, 80 } },
      { type = "MedicalCenter", player = 1, at = { 35, 83 } },
      { type = "Agridome", player = 1, at = { 38, 83 } },
      { type = "DIRT", player = 1, at = { 31, 83 } },
      { type = "ConVec", direction = "West", player = 1, at = { 26, 67 } },
      { type = "ConVec", direction = "East", player = 1, at = { 24, 67 } },
      { type = "ConVec", direction = "South", player = 1, at = { 22, 65 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 24, 65 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 26, 65 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 33, 61 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 35, 61 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 37, 61 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 33, 63 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 35, 63 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 46, 65 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 42, 65 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 44, 65 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 42, 67 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 44, 67 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 34, 79 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 41, 78 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 42, 71 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 42, 71 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 42, 71 } },
      { type = "RoboMiner", direction = "SouthEast", player = 1, at = { 26, 73 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 24, 71 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 34, 22 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 47, 94 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 14, 33 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 19, 92 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 47, 94 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 55, 108 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 30, 97 }, beacon = true },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 22, scientists = 15, kids = 28, food = 2500, ore = 2000,
        research = { 5000 },
        tech_level = 4,
        kits = { [1] = { "Agridome" }, [2] = { "Residence" }, [3] = { "CommandCenter" } },
        view = { 33, 70 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 5,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 34, 64 } }, { "Tube", { 34, 65 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 34, 70 } },
      { type = "Agridome", player = 1, at = { 34, 67 } },
      { type = "Tokamak", player = 1, at = { 35, 56 } },
      { type = "CommonOreSmelter", player = 1, at = { 39, 66 } },
      { type = "RobotCommand", player = 1, at = { 38, 70 } },
      { type = "StandardLab", player = 1, at = { 30, 70 } },
      { type = "Nursery", player = 1, at = { 34, 73 } },
      { type = "Residence", player = 1, at = { 31, 73 } },
      { type = "StructureFactory", player = 1, at = { 30, 66 } },
      { type = "VehicleFactory", player = 1, at = { 38, 73 } },
      { type = "Residence", player = 1, at = { 38, 77 } },
      { type = "University", player = 1, at = { 38, 80 } },
      { type = "MedicalCenter", player = 1, at = { 35, 83 } },
      { type = "Agridome", player = 1, at = { 38, 83 } },
      { type = "Tokamak", player = 1, at = { 48, 74 } },
      { type = "DIRT", player = 1, at = { 38, 86 } },
      { type = "AdvancedLab", player = 1, at = { 34, 61 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 44, 63 } },
      { type = "ConVec", direction = "West", player = 1, at = { 26, 67 } },
      { type = "ConVec", direction = "East", player = 1, at = { 24, 67 } },
      { type = "ConVec", direction = "South", player = 1, at = { 22, 65 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 24, 65 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 26, 65 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 33, 61 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 35, 61 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 37, 61 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 33, 63 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 35, 63 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 46, 65 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 42, 65 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 44, 65 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 42, 67 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 44, 67 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 44, 67 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 34, 76 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 42, 71 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 42, 71 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 42, 71 } },
      { type = "RoboMiner", direction = "SouthEast", player = 1, at = { 26, 73 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 24, 71 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 44, 7 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 61, 43 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 14, 33 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 12, 110 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 12, 110 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 55, 108 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 30, 97 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 22, scientists = 15, kids = 28, food = 3000, ore = 3000,
        research = { 5000 },
        tech_level = 4,
        kits = { [1] = { "Agridome" }, [2] = { "MedicalCenter" }, [3] = { "DIRT" } },
        view = { 33, 70 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 5,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 40, 80 } }, { "Tube", { 41, 80 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 34, 70 } },
      { type = "Agridome", player = 1, at = { 34, 67 } },
      { type = "Tokamak", player = 1, at = { 35, 56 } },
      { type = "CommonOreSmelter", player = 1, at = { 39, 66 } },
      { type = "RobotCommand", player = 1, at = { 38, 70 } },
      { type = "StandardLab", player = 1, at = { 30, 70 } },
      { type = "Nursery", player = 1, at = { 34, 73 } },
      { type = "Residence", player = 1, at = { 31, 73 } },
      { type = "StructureFactory", player = 1, at = { 30, 66 } },
      { type = "VehicleFactory", player = 1, at = { 38, 73 } },
      { type = "Residence", player = 1, at = { 38, 77 } },
      { type = "University", player = 1, at = { 38, 80 } },
      { type = "AdvancedLab", player = 1, at = { 43, 79 } },
      { type = "ConVec", direction = "West", player = 1, at = { 26, 67 } },
      { type = "ConVec", direction = "East", player = 1, at = { 24, 67 } },
      { type = "ConVec", direction = "South", player = 1, at = { 22, 65 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 24, 65 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 26, 65 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 33, 61 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 35, 61 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 37, 61 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 33, 63 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 35, 63 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 46, 65 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 42, 65 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 44, 65 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 42, 67 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 44, 67 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 42, 71 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 42, 71 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 42, 71 } },
      { type = "RoboMiner", direction = "SouthEast", player = 1, at = { 26, 73 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 24, 71 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 44, 7 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 57, 44 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 14, 33 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 18, 100 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 18, 100 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 61, 90 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 30, 97 }, beacon = true },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 8, 1, 12, 1 },
  { 15, 1, 19, 1 },
  { 9, 2, 10, 3 },
  { 16, 2, 18, 2 },
  { 16, 3, 17, 4 },
  { 9, 4, 11, 4 },
  { 10, 5, 10, 5 },
  { 15, 5, 17, 5 },
  { 10, 6, 11, 6 },
  { 14, 6, 17, 6 },
  { 8, 7, 17, 7 },
  { 8, 8, 16, 8 },
  { 8, 9, 14, 9 },
  { 7, 10, 13, 10 },
  { 6, 11, 13, 11 },
  { 5, 12, 13, 12 },
  { 4, 13, 12, 14 },
  { 3, 15, 12, 15 },
  { 2, 16, 12, 16 },
  { 2, 17, 13, 17 },
  { 1, 18, 13, 19 },
  { 1, 20, 16, 20 },
  { 1, 21, 25, 21 },
  { 6, 22, 26, 22 },
  { 8, 23, 10, 23 },
  { 13, 23, 17, 23 },
  { 20, 23, 28, 23 },
  { 21, 24, 29, 24 },
  { 22, 25, 34, 25 },
  { 23, 26, 38, 26 },
  { 25, 27, 38, 27 },
  { 26, 28, 36, 28 },
  { 26, 29, 35, 30 },
  { 25, 31, 34, 31 },
  { 36, 31, 36, 31 },
  { 22, 32, 35, 32 },
  { 21, 33, 35, 33 },
  { 20, 34, 34, 34 },
  { 19, 35, 26, 35 },
  { 28, 35, 30, 36 },
  { 16, 36, 25, 36 },
  { 15, 37, 24, 37 },
  { 28, 37, 31, 37 },
  { 13, 38, 21, 38 },
  { 29, 38, 31, 39 },
  { 12, 39, 20, 39 },
  { 11, 40, 19, 40 },
  { 28, 40, 30, 41 },
  { 1, 41, 1, 41 },
  { 10, 41, 17, 41 },
  { 1, 42, 2, 42 },
  { 9, 42, 15, 42 },
  { 27, 42, 30, 42 },
  { 1, 43, 5, 43 },
  { 8, 43, 14, 43 },
  { 26, 43, 31, 43 },
  { 64, 43, 64, 43 },
  { 1, 44, 12, 44 },
  { 25, 44, 31, 45 },
  { 55, 44, 58, 44 },
  { 63, 44, 64, 44 },
  { 1, 45, 11, 45 },
  { 54, 45, 59, 45 },
  { 61, 45, 64, 45 },
  { 1, 46, 10, 46 },
  { 26, 46, 31, 46 },
  { 54, 46, 64, 47 },
  { 3, 47, 9, 47 },
  { 27, 47, 31, 47 },
  { 4, 48, 8, 48 },
  { 28, 48, 31, 48 },
  { 53, 48, 64, 48 },
  { 6, 49, 7, 49 },
  { 28, 49, 32, 50 },
  { 51, 49, 60, 49 },
  { 35, 50, 35, 50 },
  { 47, 50, 55, 50 },
  { 27, 51, 36, 51 },
  { 46, 51, 55, 51 },
  { 27, 52, 38, 52 },
  { 45, 52, 50, 52 },
  { 26, 53, 31, 53 },
  { 36, 53, 40, 53 },
  { 44, 53, 49, 53 },
  { 26, 54, 30, 54 },
  { 38, 54, 48, 54 },
  { 28, 55, 29, 55 },
  { 40, 55, 48, 55 },
  { 42, 56, 47, 56 },
  { 44, 57, 45, 57 },
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
    { type = "Scout", at = { 65, 48 }, rotation = 126 },
    { type = "Scout", at = { 65, 47 }, rotation = 126 },
  },
  [2] = {
    { type = "Scout", at = { 65, 48 }, rotation = 126 },
    { type = "Scout", at = { 65, 47 }, rotation = 126 },
    { type = "Lynx", at = { 65, 46 }, rotation = 126, weapon = "Microwave" },
    { type = "Lynx", at = { 65, 49 }, rotation = 126, weapon = "Microwave" },
  },
  [3] = {
    { type = "Scout", at = { 65, 48 }, rotation = 126 },
    { type = "Scout", at = { 65, 47 }, rotation = 126 },
  },
  [4] = {
    { type = "Lynx", at = { 65, 46 }, rotation = 126, weapon = "Microwave" },
    { type = "Lynx", at = { 65, 49 }, rotation = 126, weapon = "Microwave" },
    { type = "Lynx", at = { 64, 48 }, rotation = 126, weapon = "Microwave" },
    { type = "Lynx", at = { 64, 47 }, rotation = 126, weapon = "Microwave" },
    { type = "Lynx", at = { 65, 45 }, rotation = 126, weapon = "Microwave" },
    { type = "Lynx", at = { 65, 50 }, rotation = 126, weapon = "Microwave" },
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


-- The triggers CheckForFail reads (0x1100A7F0 to 0x1100A824): on Normal the eight vehicle counts, the five kits, the
-- EDWARD Satellite.
local t35, t37, t33, t31, t27, t29, t23, t25, t5, t6, t7, t8, t9, t21
-- The scouts' groups (0x1100A7D8, 0x1100A7DC), the patrol's (0x1100A7E0) and how many patrols have come (0x1100A7EC).
local scout_group, scout_group2, patrol_group, patrols = nil, nil, nil, 0
-- The patrol's two routes (0x11008F28, 0x11008F50; `op2dll disasm --route`), where it waits (0x1100A7C8) and its units
-- by route, as the DLL ships them (`op2dll disasm --block --shipped`): Normal's (0x1100A618, 0x1100A6A0), the first on
-- Easy and Hard (0x1100A590, 0x1100A2E8), the later ones (0x1100A480, 0x1100A508).
local PATROL_ROUTES = { { { { 39, 128 }, { 34, 68 }, { 5, 101 } }, 2 }, { { { 2, 101 }, { 34, 68 }, { 61, 48 } }, 2 } }
local PATROL_RECT = { 39, 121, 44, 128 }
local PATROL_UNITS = {
  normal = {
    { { type = "Lynx", at = { 44, 127 }, direction = "North", weapon = "Microwave" }, { type = "Scout", at = { 45, 127 }, direction = "North" },
      { type = "Lynx", at = { 43, 127 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 42, 127 }, direction = "North", weapon = "Microwave" } },
    { { type = "Lynx", at = { 2, 101 }, direction = "North", weapon = "Microwave" }, { type = "Scout", at = { 2, 102 }, direction = "North" },
      { type = "Lynx", at = { 2, 103 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 2, 104 }, direction = "North", weapon = "Microwave" } },
  },
  first = {
    { { type = "Lynx", at = { 44, 127 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 45, 127 }, direction = "North", weapon = "Microwave" },
      { type = "Lynx", at = { 42, 127 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 41, 127 }, direction = "North", weapon = "Microwave" },
      { type = "Lynx", at = { 40, 127 }, direction = "North", weapon = "EMP" } },
    { { type = "Lynx", at = { 2, 101 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 2, 102 }, direction = "North", weapon = "Microwave" },
      { type = "Lynx", at = { 2, 103 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 2, 104 }, direction = "North", weapon = "Microwave" },
      { type = "Lynx", at = { 2, 105 }, direction = "North", weapon = "EMP" } },
  },
  later = {
    { { type = "Lynx", at = { 44, 127 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 45, 127 }, direction = "North", weapon = "Microwave" },
      { type = "Lynx", at = { 43, 127 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 40, 127 }, direction = "North", weapon = "EMP" },
      { type = "Lynx", at = { 39, 127 }, direction = "North", weapon = "RPG" }, { type = "Lynx", at = { 41, 127 }, direction = "North", weapon = "RPG" },
      { type = "Panther", at = { 42, 127 }, direction = "North", weapon = "Microwave" } },
    { { type = "Lynx", at = { 2, 101 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 2, 102 }, direction = "North", weapon = "Microwave" },
      { type = "Lynx", at = { 2, 103 }, direction = "North", weapon = "Microwave" }, { type = "Lynx", at = { 2, 105 }, direction = "North", weapon = "EMP" },
      { type = "Lynx", at = { 2, 106 }, direction = "North", weapon = "RPG" }, { type = "Lynx", at = { 2, 107 }, direction = "North", weapon = "RPG" },
      { type = "Panther", at = { 2, 108 }, direction = "North", weapon = "Microwave" } },
  },
}
-- How many of Easy's two research objectives NextRes has seen (0x1100A7E8).
local nextres_calls = 0
local function new_objective() game.message_at("New Objective", 122, nil, -1, -1) end
local patrol_blocks = {}
local function patrol_block(kind, r)
  local key = kind .. r
  patrol_blocks[key] = patrol_blocks[key] or ai.unit_block(PATROL_UNITS[kind][r])
  return patrol_blocks[key]
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava, Microbe, MoreQuakes, MoreQuakesHard, Quake1, Quake2, Quake3, Quake4, Quake5, Quake6, ScoutArrive, ScoutArriveX

function Lava(t)
  if players[1].difficulty == "Easy" then
    game.set_tile({ 7, 6 }, 1169)
    game.set_tile({ 8, 6 }, 1181)
    game.set_tile({ 7, 7 }, 1192)
    game.set_tile({ 8, 7 }, 1203)
    game.create_eruption({ 9, 8 }, 200)
  elseif players[1].difficulty == "Normal" then
    game.set_tile({ 7, 6 }, 1169)
    game.set_tile({ 8, 6 }, 1181)
    game.set_tile({ 7, 7 }, 1192)
    game.set_tile({ 8, 7 }, 1203)
    game.create_eruption({ 9, 8 }, 170)
  else
    game.set_tile({ 7, 6 }, 1169)
    game.set_tile({ 8, 6 }, 1181)
    game.set_tile({ 7, 7 }, 1192)
    game.set_tile({ 8, 7 }, 1203)
    game.create_eruption({ 9, 8 }, 200)
  end
end

local Microbe_done  -- Microbe does nothing more once it has acted
function Microbe(t)
  if Microbe_done then return end
  if players[1].difficulty == "Easy" then
    game.create_blight({ 29, 127 })
    game.create_blight({ 30, 127 })
    game.create_blight({ 31, 127 })
    game.create_blight({ 32, 127 })
    game.create_blight({ 33, 127 })
    game.create_blight({ 34, 127 })
    game.create_blight({ 35, 127 })
    game.set_blight_speed(75)
    game.message_at("Microbe growth detected!", 152, 1, 1920, 4032)
    Microbe_done = true
  elseif players[1].difficulty == "Normal" then
    game.create_blight({ 29, 127 })
    game.create_blight({ 30, 127 })
    game.create_blight({ 31, 127 })
    game.create_blight({ 32, 127 })
    game.create_blight({ 33, 127 })
    game.create_blight({ 34, 127 })
    game.create_blight({ 35, 127 })
    game.set_blight_speed(180)
    game.message_at("Microbe growth detected!", 152, 1, 1920, 4032)
    Microbe_done = true
  else
    game.create_blight({ 29, 127 })
    game.create_blight({ 30, 127 })
    game.create_blight({ 31, 127 })
    game.create_blight({ 32, 127 })
    game.create_blight({ 33, 127 })
    game.create_blight({ 34, 127 })
    game.create_blight({ 35, 127 })
    game.set_blight_speed(220)
    game.message_at("Microbe growth detected!", 152, 1, 1920, 4032)
    Microbe_done = true
  end
end

function MoreQuakes(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(24)
    local r2 = game.rand(62)
    game.create_earthquake({ r2 + 1, r1 + 2 }, 1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(2)
    local r2 = game.rand(24)
    local r3 = game.rand(62)
    game.create_earthquake({ r3 + 1, r2 + 2 }, r1 + 1)
  else
    local r1 = game.rand(24)
    local r2 = game.rand(62)
    game.create_earthquake({ r2 + 1, r1 + 2 }, 2)
  end
end

function MoreQuakesHard(t)
  local r1 = game.rand(2)
  local r2 = game.rand(6)
  local r3 = game.rand(62)
  game.create_earthquake({ r3, r2 + 29 }, r1 + 2)
end

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 36, 50 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 36, 50 }, 1)
  else
    game.create_earthquake({ 36, 50 }, 2)
  end
end

function Quake2(t)
  game.create_earthquake({ 33, 8 }, 1)
end

function Quake3(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 16, 64 }, 2)
    trigger.time{min = 4800, max = 6000, one_shot = false, on = MoreQuakes}  -- after 48 to 60 marks
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 21, 64 }, 2)
    trigger.time{min = 4800, max = 6000, one_shot = false, on = MoreQuakes}  -- after 48 to 60 marks
  else
    game.create_earthquake({ 23, 64 }, 2)
    trigger.time{min = 4800, max = 6000, one_shot = false, on = MoreQuakes}  -- after 48 to 60 marks
  end
end

function Quake4(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 11, 14 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 11, 14 }, 1)
  else
    game.create_earthquake({ 11, 14 }, 1)
    trigger.time{min = 3000, max = 4000, one_shot = false, on = MoreQuakesHard}  -- after 30 to 40 marks
  end
end

function Quake5(t)
  game.create_earthquake({ 29, 46 }, 3)
end

function Quake6(t)
  local r1 = game.rand(6)
  local r2 = game.rand(6)
  game.create_earthquake({ r2 + 20, r1 + 58 }, 3)
end

function ScoutArrive(t)
  if players[1].difficulty == "Easy" then
    trigger.time{time = 3000, on = ScoutLeave}
    scout_group = ai.fight_group(ai_player)
    scout_group:do_patrol_only()
    scout_group:set_patrol({ { 61, 48 }, { 34, 68 }, { 5, 101 } }, 2)
    scout_group:set_rect({ 61, 41, 64, 51 })
    scout_group:set_combine_fire()
    scout_group:add_units(ai_block(1))
  elseif players[1].difficulty == "Normal" then
    trigger.time{time = 3000, on = ScoutLeave}
    scout_group = ai.fight_group(ai_player)
    scout_group:do_patrol_only()
    scout_group:set_patrol({ { 61, 48 }, { 34, 68 }, { 5, 101 } }, 2)
    scout_group:set_rect({ 61, 41, 64, 51 })
    scout_group:set_combine_fire()
    scout_group:add_units(ai_block(2))
  else
    trigger.time{time = 3000, on = ScoutLeave}
    scout_group = ai.fight_group(ai_player)
    scout_group:do_patrol_only()
    scout_group:set_patrol({ { 61, 48 }, { 34, 68 }, { 5, 101 } }, 2)
    scout_group:set_rect({ 61, 41, 64, 51 })
    scout_group:set_combine_fire()
    scout_group:add_units(ai_block(3))
    trigger.time{time = 500, on = ScoutArriveX}
  end
end

function ScoutArriveX(t)
  scout_group2 = ai.fight_group(ai_player)
  scout_group2:do_attack_enemy()
  scout_group2:set_attack_type("Tokamak")
  scout_group2:set_rect({ 61, 41, 64, 51 })
  scout_group2:set_combine_fire()
  scout_group2:add_units(ai_block(4))
end

-- Every 40 ticks (0x11002E60): the colony's checks.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  local ore, rare = p.ore, p.rare_ore
  for _, u in ipairs(p:units("CargoTruck")) do
    if u.cargo == "CommonMetal" then ore = ore + 1000 end
    if u.cargo == "RareMetal" then rare = rare + 1000 end
  end
  if ore < ({ Easy = 4000, Normal = 5000, Hard = 8000 })[players[1].difficulty] and not p:can_accumulate_ore() then fail = true end
  if rare < 2000 and not p:can_accumulate_rare_ore() then fail = true end
  local missing = false
  for _, k in pairs({ t35, t37, t33, t31, t27, t29, t23, t25 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_vehicle(1) then fail = true end
  local missing = false
  for _, k in pairs({ t5, t6, t7, t8, t9 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_building() then fail = true end
  local missing = false
  for _, k in pairs({ t21 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_space() then fail = true end
  if not p:has_tech(5110) and not p:can_do_research(5110) then fail = true end
  if not p:has_tech(5405) and not p:can_do_research(5405) then fail = true end
  if not p:has_tech(5506) and not p:can_do_research(5506) then fail = true end
  if not p:has_tech(5115) and not p:can_do_research(5115) then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- The scouts leave by 61,41 - 64,51, and the attack ScoutArriveX sent on Hard too (0x11002710).
function ScoutLeave(t)
  scout_group:do_exit_map()
  scout_group:set_rect({ 61, 41, 64, 51 })
  if scout_group2 then
    scout_group2:do_exit_map()
    scout_group2:set_rect({ 61, 41, 64, 51 })
  end
end

-- A patrol, until the Blight comes (Microbe's flag, 0x1100A7E4): it leaves in 40 marks; the first sets the next to
-- come every 50 to 60 marks (Normal) or 60; the patrol group, made once, takes a route drawn of two and the units of
-- that route's end (0x11002930).
function PatrolArrive(t)
  if Microbe_done then return end
  patrols = patrols + 1
  trigger.time{time = 4000, on = PatrolLeave}
  if patrols == 1 then
    if players[1].difficulty == "Normal" then
      trigger.time{min = 5000, max = 6000, one_shot = false, on = PatrolArrive}
    else
      trigger.time{time = 6000, one_shot = false, on = PatrolArrive}
    end
  end
  patrol_group = patrol_group or ai.fight_group(ai_player)
  patrol_group:do_patrol_only()
  patrol_group:set_rect(PATROL_RECT)
  local r = game.rand(2) + 1
  patrol_group:set_patrol(PATROL_ROUTES[r][1], PATROL_ROUTES[r][2])
  patrol_group:set_combine_fire()
  local kind = players[1].difficulty == "Normal" and "normal" or (patrols > 1 and "later" or "first")
  patrol_group:add_units(patrol_block(kind, r))
end

-- The patrol leaves the map from where it waits (0x11002760).
function PatrolLeave(t)
  patrol_group:do_exit_map()
  patrol_group:set_rect(PATROL_RECT)
end

-- Easy, Advanced Combat Chassis or Independant Turret Power Systems researched: after both, research Directional
-- Magnetic Fields (then PantherObj; 0x11002B60).
function NextRes(t)
  nextres_calls = nextres_calls + 1
  if nextres_calls < 2 then return end
  local r = trigger.research{tech = 5506, player = 1, one_shot = true, on = PantherObj}
  mission.victory(r, "Completely research Directional Magnetic Fields.")
  new_objective()
end

-- Easy, Directional Magnetic Fields researched: have 2 Rail Gun Panthers, a vehicle check (t23, slot 0x1100A80C;
-- 0x11002AE0).
function PantherObj(t)
  t23 = trigger.count{type = "Panther", cargo = "RailGun", compare = ">=", count = 2, player = 1}
  mission.victory(t23, "Have 2 or more Rail Gun Panthers.")
  new_objective()
end

-- Easy, Rare Ore Processing researched: research the Space Program (then SpaceDone) and have 2000 Rare Metals in
-- Cargo Trucks (0x11002CD0).
function ROP(t)
  local r = trigger.research{tech = 5405, player = 1, one_shot = true, on = SpaceDone}
  mission.victory(r, "Completely research the Space Program.")
  local c = trigger.count{type = "CargoTruck", cargo = 5, compare = ">=", count = 2, player = 1}
  mission.victory(c, "Have 2000 units of Rare Metals in Cargo Trucks.")
  new_objective()
end

-- Easy, the Space Program researched: build a Spaceport (then HasSpacePort; 0x11002C60).
function SpaceDone(t)
  local s = trigger.operational{type = "Spaceport", compare = ">=", count = 1, player = 1, one_shot = true, on = HasSpacePort}
  mission.victory(s, "Build a Spaceport.")
  new_objective()
end

-- Easy, a Spaceport built: launch a satellite, the space check (t21, slot 0x1100A810; 0x11002BE0).
function HasSpacePort(t)
  t21 = trigger.count{type = "EDWARDSatellite", compare = ">=", count = 1, player = 1, one_shot = true}
  mission.victory(t21, "Launch a satellite.")
  new_objective()
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 7, 6 }, 1161)
  game.initial_set_tile({ 8, 6 }, 1172)
  game.initial_set_tile({ 7, 7 }, 1184)
  game.initial_set_tile({ 8, 7 }, 1195)
  game.set_daylight_everywhere(false)
  game.set_initial_light_level(52)
  game.free_morale()
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end

  -- The win.
  local t15, t17, t19
  if difficulty == "Easy" then
    t5 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t5, "Have a Tokamak kit in storage.")
    t6 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t6, "Have a Structure Factory kit in storage.")
    t7 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t7, "Have a Common Ore Smelter kit in storage.")
    t8 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t8, "Have a Command Center kit in storage.")
    t9 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t9, "Have an Agridome kit in storage.")
    t15 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 2, player = 1}
    mission.victory(t15, "Have 2000 units of food in Cargo Trucks.")
    t17 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 4, player = 1}
    mission.victory(t17, "Have 4000 units of Common Metals in Cargo Trucks.")
    t25 = trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1}
    mission.victory(t25, "Have 4 or more Lynx.")
    t27 = trigger.count{type = "Scout", compare = ">=", count = 2, player = 1}
    mission.victory(t27, "Have 2 or more Scouts.")
  elseif difficulty == "Normal" then
    t5 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t5, "Have a Tokamak kit in storage.")
    t6 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t6, "Have a Structure Factory kit in storage.")
    t7 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t7, "Have a Common Ore Smelter kit in storage.")
    t8 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t8, "Have a Command Center kit in storage.")
    t9 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t9, "Have an Agridome kit in storage.")
    t15 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 3, player = 1}
    mission.victory(t15, "Have 3000 units of food in Cargo Trucks.")
    t17 = trigger.count{type = "CargoTruck", cargo = 5, compare = ">=", count = 2, player = 1}
    mission.victory(t17, "Have 2000 units of Rare Metals in Cargo Trucks.")
    t19 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 5, player = 1}
    mission.victory(t19, "Have 5000 units of Common Metals in Cargo Trucks.")
    t21 = trigger.count{type = "EDWARDSatellite", compare = ">=", count = 1, player = 1}
    mission.victory(t21, "Launch a satellite.")
    t23 = trigger.count{type = "Panther", cargo = "RailGun", compare = ">=", count = 2, player = 1}
    mission.victory(t23, "Have 2 or more Rail Gun Panthers.")
    t25 = trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1}
    mission.victory(t25, "Have 4 or more Lynx.")
    t27 = trigger.count{type = "Scout", compare = ">=", count = 2, player = 1}
    mission.victory(t27, "Have 2 or more Scouts.")
  elseif difficulty == "Hard" then
    t5 = trigger.count{type = "ConVec", cargo = "Tokamak", compare = ">=", count = 1, player = 1}
    mission.victory(t5, "Have a Tokamak kit in a ConVec.")
    t6 = trigger.count{type = "ConVec", cargo = "StructureFactory", compare = ">=", count = 1, player = 1}
    mission.victory(t6, "Have a Structure Factory kit in a ConVec.")
    t9 = trigger.count{type = "ConVec", cargo = "CommonOreSmelter", compare = ">=", count = 1, player = 1}
    mission.victory(t9, "Have a Common Ore Smelter kit in a ConVec.")
    t7 = trigger.count{type = "ConVec", cargo = "CommandCenter", compare = ">=", count = 1, player = 1}
    mission.victory(t7, "Have a Command Center kit in a ConVec.")
    t8 = trigger.count{type = "ConVec", cargo = "Agridome", compare = ">=", count = 1, player = 1}
    mission.victory(t8, "Have an Agridome kit in a ConVec.")
    t15 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 2, player = 1}
    mission.victory(t15, "Have 2000 units of food in Cargo Trucks.")
    t17 = trigger.count{type = "CargoTruck", cargo = 5, compare = ">=", count = 2, player = 1}
    mission.victory(t17, "Have 2000 units of Rare Metals in Cargo Trucks.")
    t19 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 6, player = 1}
    mission.victory(t19, "Have 6000 units of Common Metals in Cargo Trucks.")
    t21 = trigger.count{type = "EDWARDSatellite", compare = ">=", count = 1, player = 1}
    mission.victory(t21, "Launch a satellite.")
    t23 = trigger.count{type = "Panther", cargo = "RailGun", compare = ">=", count = 3, player = 1}
    mission.victory(t23, "Have 3 or more Rail Gun Panthers.")
    t25 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t25, "Have 6 or more Lynx.")
    t27 = trigger.count{type = "Scout", compare = ">=", count = 3, player = 1}
    mission.victory(t27, "Have 3 or more Scouts.")
  end
  t29 = trigger.count{type = "RoboSurveyor", compare = ">=", count = 1, player = 1}
  mission.victory(t29, "Have 1 or more Robo-Surveyors.")
  t31 = trigger.count{type = "Earthworker", compare = ">=", count = 1, player = 1}
  mission.victory(t31, "Have 1 or more Earthworkers.")
  if difficulty == "Easy" then
    t33 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t33, "Have 5 or more ConVecs.")
  elseif difficulty == "Normal" then
    t33 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t33, "Have 5 or more ConVecs.")
    t35 = trigger.count{type = "CargoTruck", cargo = 0, compare = ">=", count = 3, player = 1}
    mission.victory(t35, "Have 3 or more empty Cargo Trucks.")
  elseif difficulty == "Hard" then
    t35 = trigger.count{type = "CargoTruck", cargo = 0, compare = ">=", count = 3, player = 1}
    mission.victory(t35, "Have 3 or more empty Cargo Trucks.")
  end
  t37 = trigger.evac{player = 1}
  mission.victory(t37, "Have enough Evacuation Transports for your population.")
  local t31e, t33e, t35e
  if difficulty == "Easy" then
    t31e = trigger.research{tech = 5110, player = 1, one_shot = true, on = ROP}
    mission.victory(t31e, "Completely research Rare Ore Processing.")
    t33e = trigger.research{tech = 5201, player = 1, one_shot = true, on = NextRes}
    mission.victory(t33e, "Completely research Advanced Combat Chassis.")
    t35e = trigger.research{tech = 5111, player = 1, one_shot = true, on = NextRes}
    mission.victory(t35e, "Completely research Independant Turret Power Systems.")
  end
  local t39 = trigger.research{tech = 5115, player = 1, one_shot = true}
  mission.victory(t39, "Completely research Geothermal Power.")
  local t41 = trigger.research{tech = 5102, player = 1, one_shot = true}
  mission.victory(t41, "Completely research Robot-Assist Mechanic.")
  local t45 = trigger.resource{resource = "Scientists", compare = ">=", amount = 20, player = 1}
  mission.victory(t45, "Keep at least 20 scientists alive.")
  local t44 = trigger.resource{resource = "Workers", compare = ">=", amount = 30, player = 1}
  mission.victory(t44, "Keep at least 30 workers alive.")
  local t43 = trigger.resource{resource = "Kids", compare = ">=", amount = 40, player = 1}
  mission.victory(t43, "Keep at least 40 children alive.")
  local t57 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t57)
  if difficulty == "Easy" or difficulty == "Normal" then
    trigger.time{time = 52000, on = Microbe}  -- after 520 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 69000, on = Microbe}  -- after 690 marks
  end
  trigger.time{time = 21600, on = Quake1}  -- after 216 marks
  trigger.time{time = 27000, on = Quake2}  -- after 270 marks
  trigger.time{time = 18000, on = Quake3}  -- after 180 marks
  if difficulty == "Easy" then
    trigger.time{time = 32533, on = Lava}  -- after 325 marks
    trigger.time{min = 8500, max = 9500, on = Quake4}  -- after 85 to 95 marks
    trigger.time{time = 24000, on = ScoutArrive}  -- after 240 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 39000, on = Lava}  -- after 390 marks
    trigger.time{min = 8500, max = 9500, on = Quake4}  -- after 85 to 95 marks
    trigger.time{time = 24000, on = ScoutArrive}  -- after 240 marks
    trigger.time{time = 40000, on = PatrolArrive}  -- after 400 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 40000, on = Lava}  -- after 400 marks
    trigger.time{min = 3500, max = 4000, on = Quake4}  -- after 35 to 40 marks
    trigger.time{min = 8200, max = 8600, on = Quake5}  -- after 82 to 86 marks
    trigger.time{min = 23000, max = 24000, on = Quake6}  -- after 230 to 240 marks
    trigger.time{time = 25500, on = ScoutArrive}  -- after 255 marks
    trigger.time{time = 40000, on = PatrolArrive}  -- after 400 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

