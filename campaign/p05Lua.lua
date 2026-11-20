-- p05Lua.lua  -  Plymouth Mission #5 (Lua)
-- Trigger functions finished by hand (CheckForFail, Microbe, ScoutLeave, MoreUnits), from the disassembly of p05.dll.
-- Converted by op2dll from p05.dll. With p05Lua.placement.lua (what every difficulty makes alike),
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
        workers = 22, scientists = 12, kids = 32, food = 3000, ore = 5000,
        research = { 5000 },
        tech_level = 4,
        kits = { [1] = { "Agridome" }, [2] = { "Residence" }, [3] = { "CommandCenter" }, [4] = { "CommonOreSmelter" }, [5] = { "StructureFactory" } },
        view = { 64, 28 },
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
      { "Tube", { 51, 24 } }, { "Tube", { 52, 24 } }, { "Tube", { 53, 24 } }, { "Tube", { 57, 37 } },
      { "Tube", { 76, 27 } }, { "Tube", { 76, 28 } }, { "Tube", { 77, 31 } }, { "Tube", { 78, 36 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 63, 28 } },
      { type = "Agridome", player = 1, at = { 69, 25 } },
      { type = "Tokamak", player = 1, at = { 58, 20 } },
      { type = "CommonOreSmelter", player = 1, at = { 56, 25 } },
      { type = "RobotCommand", player = 1, at = { 70, 31 } },
      { type = "StandardLab", player = 1, at = { 65, 33 } },
      { type = "Residence", player = 1, at = { 74, 31 } },
      { type = "Nursery", player = 1, at = { 70, 35 } },
      { type = "VehicleFactory", player = 1, at = { 57, 31 } },
      { type = "StructureFactory", player = 1, at = { 51, 30 } },
      { type = "Tokamak", player = 1, at = { 66, 17 } },
      { type = "University", player = 1, at = { 63, 23 } },
      { type = "Residence", player = 1, at = { 57, 35 } },
      { type = "Agridome", player = 1, at = { 46, 30 } },
      { type = "Residence", player = 1, at = { 46, 27 } },
      { type = "Agridome", player = 1, at = { 74, 34 } },
      { type = "AdvancedLab", player = 1, at = { 76, 24 } },
      { type = "MedicalCenter", player = 1, at = { 78, 34 } },
      { type = "DIRT", player = 1, at = { 79, 31 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 51, 22 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 81, 24 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 78, 37 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 57, 38 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthEast", player = 1, at = { 50, 34 } },
      { type = "Lynx", weapon = "Microwave", direction = "South", player = 1, at = { 52, 34 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 51, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 84, 28 } },
      { type = "RoboDozer", direction = "SouthWest", player = 1, at = { 73, 28 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 69, 21 } },
      { type = "ConVec", direction = "SouthEast", player = 1, at = { 59, 36 } },
      { type = "ConVec", direction = "West", player = 1, at = { 77, 28 } },
      { type = "ConVec", direction = "North", player = 1, at = { 57, 27 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 75, 37 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 22 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 58, 24 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 50, 24 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 58, 26 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 71, 26 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 71, 23 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 67, 37 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 64, 38 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 63, 36 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 49, 20 } },
      { type = "RoboMiner", direction = "SouthEast", player = 1, at = { 60, 19 } },
      { type = "RoboSurveyor", direction = "North", player = 1, at = { 61, 21 } },
      { type = "Earthworker", direction = "West", player = 1, at = { 54, 29 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 64, 26 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 92, 7 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 48, 51 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 32, 11 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 72, 53 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 110, 40 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 110, 40 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 22, scientists = 12, kids = 32, food = 2400, ore = 4000,
        research = { 5000 },
        tech_level = 4,
        kits = { [1] = { "AdvancedLab" }, [2] = { "CommandCenter" } },
        view = { 64, 28 },
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
      { "Tube", { 77, 31 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 63, 28 } },
      { type = "Agridome", player = 1, at = { 69, 25 } },
      { type = "Tokamak", player = 1, at = { 58, 20 } },
      { type = "CommonOreSmelter", player = 1, at = { 56, 25 } },
      { type = "RobotCommand", player = 1, at = { 70, 31 } },
      { type = "StandardLab", player = 1, at = { 65, 33 } },
      { type = "Residence", player = 1, at = { 74, 31 } },
      { type = "Nursery", player = 1, at = { 76, 27 } },
      { type = "VehicleFactory", player = 1, at = { 57, 31 } },
      { type = "StructureFactory", player = 1, at = { 51, 30 } },
      { type = "Tokamak", player = 1, at = { 66, 17 } },
      { type = "University", player = 1, at = { 63, 23 } },
      { type = "Residence", player = 1, at = { 57, 35 } },
      { type = "Agridome", player = 1, at = { 46, 30 } },
      { type = "MedicalCenter", player = 1, at = { 79, 34 } },
      { type = "DIRT", player = 1, at = { 79, 31 } },
      { type = "RoboDozer", direction = "SouthWest", player = 1, at = { 73, 28 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 69, 21 } },
      { type = "ConVec", direction = "SouthEast", player = 1, at = { 59, 36 } },
      { type = "ConVec", direction = "West", player = 1, at = { 77, 28 } },
      { type = "ConVec", direction = "North", player = 1, at = { 57, 27 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 75, 37 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 22 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 58, 24 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 50, 24 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 58, 26 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 71, 26 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 71, 23 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 67, 37 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 64, 38 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 63, 36 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 49, 20 } },
      { type = "RoboMiner", direction = "SouthEast", player = 1, at = { 60, 19 } },
      { type = "RoboSurveyor", direction = "North", player = 1, at = { 61, 21 } },
      { type = "Earthworker", direction = "West", player = 1, at = { 54, 29 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 64, 26 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 86, 15 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 48, 51 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 32, 11 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 32, 11 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 110, 40 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 67, 56 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 22, scientists = 12, kids = 32, food = 1800, ore = 3000,
        research = { 5000 },
        tech_level = 4,
        kits = { [1] = { "Agridome" }, [2] = { "Residence" }, [3] = { "Tokamak" }, [4] = { "MedicalCenter" }, [5] = { "DIRT" } },
        view = { 64, 28 },
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
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 63, 28 } },
      { type = "Agridome", player = 1, at = { 69, 25 } },
      { type = "Tokamak", player = 1, at = { 58, 20 } },
      { type = "CommonOreSmelter", player = 1, at = { 56, 25 } },
      { type = "RobotCommand", player = 1, at = { 70, 31 } },
      { type = "StandardLab", player = 1, at = { 65, 33 } },
      { type = "Residence", player = 1, at = { 74, 31 } },
      { type = "Nursery", player = 1, at = { 76, 27 } },
      { type = "VehicleFactory", player = 1, at = { 57, 31 } },
      { type = "StructureFactory", player = 1, at = { 51, 30 } },
      { type = "University", player = 1, at = { 63, 23 } },
      { type = "AdvancedLab", player = 1, at = { 51, 25 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 69, 21 } },
      { type = "ConVec", direction = "SouthEast", player = 1, at = { 59, 36 } },
      { type = "ConVec", direction = "West", player = 1, at = { 47, 34 } },
      { type = "ConVec", direction = "North", player = 1, at = { 57, 27 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 45, 29 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 53, 22 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 58, 24 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 50, 24 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 58, 26 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 71, 26 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 71, 23 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 67, 37 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 64, 38 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 63, 36 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 49, 20 } },
      { type = "RoboMiner", direction = "SouthEast", player = 1, at = { 60, 19 } },
      { type = "RoboSurveyor", direction = "North", player = 1, at = { 61, 21 } },
      { type = "Earthworker", direction = "West", player = 1, at = { 54, 29 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 64, 26 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 98, 8 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 85, 53 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 110, 40 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 33, 47 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 33, 47 } },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 39, 1, 42, 1 },
  { 50, 1, 53, 1 },
  { 15, 2, 17, 2 },
  { 38, 2, 43, 2 },
  { 49, 2, 53, 3 },
  { 15, 3, 18, 3 },
  { 39, 3, 44, 3 },
  { 15, 4, 19, 4 },
  { 29, 4, 30, 4 },
  { 39, 4, 45, 4 },
  { 48, 4, 53, 4 },
  { 60, 4, 61, 4 },
  { 15, 5, 21, 5 },
  { 27, 5, 33, 5 },
  { 41, 5, 54, 5 },
  { 59, 5, 62, 5 },
  { 16, 6, 34, 6 },
  { 41, 6, 62, 6 },
  { 17, 7, 18, 7 },
  { 21, 7, 36, 7 },
  { 41, 7, 63, 7 },
  { 22, 8, 38, 8 },
  { 40, 8, 66, 8 },
  { 29, 9, 67, 9 },
  { 30, 10, 71, 10 },
  { 32, 11, 53, 11 },
  { 56, 11, 63, 11 },
  { 65, 11, 74, 11 },
  { 32, 12, 52, 12 },
  { 57, 12, 63, 12 },
  { 69, 12, 74, 12 },
  { 32, 13, 51, 13 },
  { 58, 13, 61, 14 },
  { 70, 13, 70, 13 },
  { 73, 13, 76, 13 },
  { 31, 14, 50, 14 },
  { 74, 14, 79, 14 },
  { 84, 14, 84, 14 },
  { 100, 14, 101, 14 },
  { 30, 15, 49, 15 },
  { 76, 15, 85, 15 },
  { 99, 15, 103, 15 },
  { 112, 15, 112, 15 },
  { 29, 16, 49, 16 },
  { 76, 16, 88, 16 },
  { 99, 16, 104, 16 },
  { 111, 16, 113, 16 },
  { 28, 17, 33, 17 },
  { 35, 17, 35, 18 },
  { 39, 17, 46, 17 },
  { 77, 17, 89, 17 },
  { 99, 17, 105, 17 },
  { 110, 17, 113, 17 },
  { 26, 18, 33, 18 },
  { 44, 18, 45, 18 },
  { 77, 18, 91, 18 },
  { 97, 18, 105, 18 },
  { 109, 18, 110, 19 },
  { 26, 19, 34, 19 },
  { 77, 19, 92, 19 },
  { 97, 19, 106, 19 },
  { 24, 20, 33, 20 },
  { 78, 20, 106, 20 },
  { 108, 20, 109, 20 },
  { 22, 21, 30, 21 },
  { 79, 21, 109, 21 },
  { 21, 22, 29, 22 },
  { 79, 22, 88, 22 },
  { 90, 22, 109, 23 },
  { 20, 23, 21, 23 },
  { 23, 23, 23, 23 },
  { 26, 23, 29, 23 },
  { 80, 23, 86, 23 },
  { 17, 24, 22, 24 },
  { 26, 24, 27, 24 },
  { 80, 24, 84, 24 },
  { 91, 24, 108, 24 },
  { 16, 25, 21, 25 },
  { 26, 25, 26, 26 },
  { 80, 25, 83, 25 },
  { 92, 25, 107, 25 },
  { 14, 26, 21, 26 },
  { 98, 26, 107, 26 },
  { 13, 27, 21, 27 },
  { 23, 27, 25, 27 },
  { 100, 27, 107, 27 },
  { 12, 28, 20, 28 },
  { 103, 28, 106, 28 },
  { 11, 29, 19, 29 },
  { 105, 29, 106, 29 },
  { 10, 30, 19, 30 },
  { 7, 31, 18, 31 },
  { 7, 32, 17, 32 },
  { 11, 33, 16, 33 },
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
    { type = "Scout", at = { 129, 60 }, direction = "West" },
    { type = "Scout", at = { 129, 61 }, direction = "West" },
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "Laser" },
  },
  [2] = {
    { type = "Scout", at = { 129, 60 }, direction = "West" },
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "Laser" },
  },
  [3] = {
    { type = "Scout", at = { 129, 60 }, direction = "West" },
    { type = "Scout", at = { 129, 61 }, direction = "West" },
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 64 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 129, 65 }, direction = "West", weapon = "Laser" },
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

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function AdvDone(t) end
function ITPSDone(t) end
function RareDone(t) end
function ReleaseMorale(t) end


-- The triggers CheckForFail reads (0x1100AED8 to 0x1100AF0C): on Normal the evacuation, ConVec, Earthworker,
-- Robo-Miner, Robo-Surveyor, Panther, RPG Panther, Lynx and EMP Lynx counts, then the five kits.
local t33, t40, t32, t30, t31, t24, t25, t21, t22, t5, t6, t7, t8, t9
-- The scouts' group (0x1100AEC8), Microbe's calls (0x1100AED0) and the Hard waves so far (0x1100AED4).
local scout_group, microbe_calls, waves = nil, 0, 0
-- Where the waves come in (0x1100ADA8).
local WAVE_RECT = { 119, 60, 129, 63 }
-- The waves' units as the DLL ships them (`op2dll disasm --block --shipped`): Easy's (0x1100AC00); Normal's before
-- the Blight (0x1100AB78) and after (0x1100A958); Hard's by draw and wave (0x1100AE40, 0x1100AC90, 0x1100ADB8,
-- 0x1100AD20) and the second group from the west (0x1100A9E0).
local WAVE_UNITS = {
  easy = {
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "Laser" },
  },
  normal = {
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "RailGun" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 128, 64 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 129, 64 }, direction = "West", weapon = "Laser" },
  },
  normal_late = {
    { type = "Panther", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 129, 63 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 64 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 129, 64 }, direction = "West", weapon = "RailGun" },
  },
  hard = {
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "RailGun" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 64 }, direction = "West", weapon = "RailGun" },
  },
  hard_late = {
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "RailGun" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 128, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 64 }, direction = "West", weapon = "RailGun" },
  },
  hard_big = {
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "RailGun" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 129, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 64 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 129, 64 }, direction = "West", weapon = "Laser" },
  },
  hard_big_late = {
    { type = "Lynx", at = { 129, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 129, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "RailGun" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 62 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 128, 63 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 128, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 129, 65 }, direction = "West", weapon = "Laser" },
    { type = "Panther", at = { 128, 64 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 129, 64 }, direction = "West", weapon = "Laser" },
  },
  west = {
    { type = "Lynx", at = { 1, 57 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 1, 56 }, direction = "West", weapon = "RailGun" },
    { type = "Lynx", at = { 1, 55 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 1, 54 }, direction = "West", weapon = "RailGun" },
    { type = "Panther", at = { 1, 53 }, direction = "West", weapon = "Laser" },
  },
}
local wave_blocks = {}
local function wave_block(kind)
  wave_blocks[kind] = wave_blocks[kind] or ai.unit_block(WAVE_UNITS[kind])
  return wave_blocks[kind]
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava, Lightning1, Meteor1, Meteor2, Meteor3, MeteorMedStart, MeteorOften, Quake1, Quake2, ScoutArrive

function Lava(t)
  game.set_tile({ 14, 1 }, 1169)
  game.set_tile({ 15, 1 }, 1181)
  game.set_tile({ 14, 2 }, 1192)
  game.set_tile({ 15, 2 }, 1203)
  game.create_eruption({ 15, 2 }, 200)
end

function Lightning1(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(7)
    local r2 = game.rand(64)
    game.create_lightning({ 1, r2 + 1 }, { 97, 31 }, r1 + 10)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(7)
    local r2 = game.rand(64)
    game.create_lightning({ 1, r2 + 1 }, { 97, 31 }, r1 + 10)
  else
    local r1 = game.rand(20)
    local r2 = game.rand(7)
    local r3 = game.rand(35)
    game.create_lightning({ 1, r3 + 15 }, { 97, r1 + 20 }, r2 + 10)
  end
end

function Meteor1(t)
  game.create_meteor({ 62, 28 }, 0)
end

function Meteor2(t)
  local r1 = game.rand(2)
  game.create_meteor({ 52, 25 }, r1)
end

function Meteor3(t)
  local r1 = game.rand(2)
  game.create_meteor({ 72, 29 }, r1)
end

function MeteorMedStart(t)
  trigger.time{min = 4500, max = 4900, one_shot = false, on = MeteorOften}  -- after 45 to 49 marks
end

function MeteorOften(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(2)
    local r2 = game.rand(36)
    local r3 = game.rand(86)
    game.create_meteor({ r3 + 25, r2 + 8 }, r1)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(2)
    local r2 = game.rand(36)
    local r3 = game.rand(86)
    game.create_meteor({ r3 + 25, r2 + 8 }, r1)
  else
    local r1 = game.rand(64)
    local r2 = game.rand(128)
    game.create_meteor({ r2 + 1, r1 + 2 }, -1)
  end
end

function Quake1(t)
  game.create_earthquake({ 62, 11 }, 2)
end

function Quake2(t)
  game.create_earthquake({ 46, 17 }, 2)
end

function ScoutArrive(t)
  if players[1].difficulty == "Easy" then
    trigger.time{time = 3600, on = ScoutLeave}
    scout_group = ai.fight_group(ai_player)
    scout_group:do_patrol_only()
    scout_group:set_rect({ 119, 60, 129, 63 })
    scout_group:set_patrol({ { 119, 60 }, { 53, 26 }, { 9, 51 } }, 2)
    scout_group:set_combine_fire()
    scout_group:add_units(ai_block(1))
  elseif players[1].difficulty == "Normal" then
    trigger.time{time = 3600, on = ScoutLeave}
    scout_group = ai.fight_group(ai_player)
    scout_group:do_patrol_only()
    scout_group:set_rect({ 119, 60, 129, 63 })
    scout_group:set_patrol({ { 119, 60 }, { 53, 26 }, { 9, 51 } }, 2)
    scout_group:set_combine_fire()
    scout_group:add_units(ai_block(2))
  else
    trigger.time{time = 3600, on = ScoutLeave}
    scout_group = ai.fight_group(ai_player)
    scout_group:do_patrol_only()
    scout_group:set_rect({ 119, 60, 129, 63 })
    scout_group:set_patrol({ { 119, 60 }, { 53, 26 }, { 9, 51 } }, 2)
    scout_group:set_combine_fire()
    scout_group:add_units(ai_block(3))
  end
end

-- Every 40 ticks (0x110031E0): the colony's checks.
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
  if ore < ({ Easy = 4000, Normal = 5000, Hard = 6000 })[players[1].difficulty] and not p:can_accumulate_ore() then fail = true end
  if rare < 2000 and not p:can_accumulate_rare_ore() then fail = true end
  local missing = false
  for _, k in pairs({ t33, t40, t32, t30, t31, t24, t25, t21, t22 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_vehicle(1) then fail = true end
  local missing = false
  for _, k in pairs({ t5, t6, t7, t8, t9 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_building() then fail = true end
  if not p:has_tech(5110) and not p:can_do_research(5110) then fail = true end
  if not p:has_tech(5602) and not p:can_do_research(5602) then fail = true end
  if not p:has_tech(5111) and not p:can_do_research(5111) then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- The Blight on four tiles with a message, at its second call only (four Panthers, or mark 480): by the west edge on
-- Easy and Hard, south of the base on Normal; spreading by difficulty (0x11002800).
function Microbe(t)
  microbe_calls = microbe_calls + 1
  if microbe_calls ~= 2 then return end
  local d = players[1].difficulty
  if d == "Normal" then
    for _, at in ipairs({ { 32, 63 }, { 32, 64 }, { 33, 63 }, { 33, 64 } }) do game.create_blight(at) end
    game.set_blight_speed(240)
    game.message_at("Microbe growth detected!", 152, 1, 2016, 1952)
  else
    for _, at in ipairs({ { 2, 61 }, { 2, 62 }, { 3, 61 }, { 3, 62 } }) do game.create_blight(at) end
    game.set_blight_speed(d == "Easy" and 180 or 260)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 1920)
  end
end

-- The scouts leave the way they came, and the waves (MoreUnits) start: every 72 to 96 marks on Easy, 58 to 70 on
-- Normal, 48 to 60 on Hard (0x11002BA0).
function ScoutLeave(t)
  scout_group:do_exit_map()
  scout_group:set_rect(WAVE_RECT)
  local d = players[1].difficulty
  if d == "Easy" then
    trigger.time{min = 7200, max = 9600, one_shot = false, on = MoreUnits}
  elseif d == "Normal" then
    trigger.time{min = 5800, max = 7000, one_shot = false, on = MoreUnits}
  else
    trigger.time{min = 4800, max = 6000, one_shot = false, on = MoreUnits}
  end
end

-- A wave from the east that attacks: Normal's grows once the Blight has come; Hard's is drawn of two sizes (one in
-- three the larger), larger from its third, and from its fifth a second group comes from the west, lights off
-- (0x11002A20).
function MoreUnits(t)
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_rect(WAVE_RECT)
  local d = players[1].difficulty
  if d == "Easy" then
    g:add_units(wave_block("easy"))
  elseif d == "Normal" then
    g:add_units(wave_block(microbe_calls > 2 and "normal_late" or "normal"))
  else
    waves = waves + 1
    if game.rand(3) == 2 then
      g:add_units(wave_block(waves >= 3 and "hard_big_late" or "hard_big"))
    else
      g:add_units(wave_block(waves >= 3 and "hard_late" or "hard"))
      if waves >= 5 then
        local west = ai.fight_group(ai_player)
        west:do_attack_enemy()
        west:set_rect(WAVE_RECT)
        west:set_lights(false)
        west:add_units(wave_block("west"))
      end
    end
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
  game.initial_set_tile({ 14, 1 }, 1161)
  game.initial_set_tile({ 15, 1 }, 1172)
  game.initial_set_tile({ 14, 2 }, 1184)
  game.initial_set_tile({ 15, 2 }, 1195)
  game.set_daylight_everywhere(false)
  game.set_initial_light_level(90)
  if difficulty == "Easy" then game.morale_steady("Good") end
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end
  if difficulty == "Easy" then
    trigger.time{time = 10, on = ReleaseMorale}  -- after 0 marks  -- ReleaseMorale isn't converted
  end

  -- The win.
  local t17, t16, t15, t34
  if difficulty == "Easy" then
    t5 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t5, "Have a Tokamak kit in storage.")
    t6 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t6, "Have a Structure Factory kit in storage.")
    t7 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t7, "Have a Smelter kit in storage.")
    t8 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t8, "Have a Command Center kit in storage.")
    t9 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t9, "Have an Agridome kit in storage.")
    t17 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 2, player = 1}
    mission.victory(t17, "Have 2000 units of food in Cargo Trucks.")
    t16 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 4, player = 1}
    mission.victory(t16, "Have 4000 units of Common Metals in Cargo Trucks.")
    t21 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t21, "Have 6 or more Lynx.")
  elseif difficulty == "Normal" then
    t5 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t5, "Have a Tokamak kit in storage.")
    t6 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t6, "Have a Structure Factory kit in storage.")
    t7 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t7, "Have a Smelter kit in storage.")
    t8 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t8, "Have a Command Center kit in storage.")
    t9 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t9, "Have an Agridome kit in storage.")
    t17 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 3, player = 1}
    mission.victory(t17, "Have 3000 units of food in Cargo Trucks.")
    t16 = trigger.count{type = "CargoTruck", cargo = 5, compare = ">=", count = 2, player = 1}
    mission.victory(t16, "Have 2000 units of Rare Metals in Cargo Trucks.")
    t15 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 5, player = 1}
    mission.victory(t15, "Have 5000 units of Common Metals in Cargo Trucks.")
    t24 = trigger.count{type = "Panther", compare = ">=", count = 4, player = 1}
    mission.victory(t24, "Have 4 or more total Panthers.")
    t25 = trigger.count{type = "Panther", cargo = "RPG", compare = ">=", count = 2, player = 1}
    mission.victory(t25, "Have 2 or more RPG Panthers.")
    t21 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t21, "Have 6 or more total Lynx.")
    t22 = trigger.count{type = "Lynx", cargo = "EMP", compare = ">=", count = 2, player = 1}
    mission.victory(t22, "Have 2 or more EMP Lynx.")
    t34 = trigger.count{type = "Spider", compare = ">=", count = 2}
    mission.victory(t34, "Have 2 or more Spiders.")
  elseif difficulty == "Hard" then
    t5 = trigger.count{type = "ConVec", cargo = "Tokamak", compare = ">=", count = 1, player = 1}
    mission.victory(t5, "Have a Tokamak kit in a ConVec.")
    t6 = trigger.count{type = "ConVec", cargo = "StructureFactory", compare = ">=", count = 1, player = 1}
    mission.victory(t6, "Have a Structure Factory kit in a ConVec.")
    t9 = trigger.count{type = "ConVec", cargo = "CommonOreSmelter", compare = ">=", count = 1, player = 1}
    mission.victory(t9, "Have a Smelter kit in a ConVec.")
    t7 = trigger.count{type = "ConVec", cargo = "CommandCenter", compare = ">=", count = 1, player = 1}
    mission.victory(t7, "Have a Command Center kit in a ConVec.")
    t8 = trigger.count{type = "ConVec", cargo = "Agridome", compare = ">=", count = 1, player = 1}
    mission.victory(t8, "Have an Agridome kit in a ConVec.")
    t17 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 3, player = 1}
    mission.victory(t17, "Have 3000 units of food in Cargo Trucks.")
    t16 = trigger.count{type = "CargoTruck", cargo = 5, compare = ">=", count = 3, player = 1}
    mission.victory(t16, "Have 3000 units of Rare Metals in Cargo Trucks.")
    t15 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 6, player = 1}
    mission.victory(t15, "Have 6000 units of Common Metals in Cargo Trucks.")
    t24 = trigger.count{type = "Panther", compare = ">=", count = 4, player = 1}
    mission.victory(t24, "Have 4 or more total Panthers.")
    t25 = trigger.count{type = "Panther", cargo = "RPG", compare = ">=", count = 2, player = 1}
    mission.victory(t25, "Have 2 or more RPG Panthers.")
    t21 = trigger.count{type = "Lynx", compare = ">=", count = 8, player = 1}
    mission.victory(t21, "Have 8 or more total Lynx.")
    t22 = trigger.count{type = "Lynx", cargo = "EMP", compare = ">=", count = 3, player = 1}
    mission.victory(t22, "Have 3 or more EMP Lynx.")
    t34 = trigger.count{type = "Spider", compare = ">=", count = 3}
    mission.victory(t34, "Have 3 or more Spiders.")
  end
  t31 = trigger.count{type = "RoboSurveyor", compare = ">=", count = 1, player = 1}
  mission.victory(t31, "Have 1 or more Robo-Surveyors.")
  t30 = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
  mission.victory(t30, "Have 1 or more Robo-Miners.")
  t32 = trigger.count{type = "Earthworker", compare = ">=", count = 1, player = 1}
  mission.victory(t32, "Have 1 or more Earthworkers.")
  t33 = trigger.evac{player = 1}
  mission.victory(t33, "Have enough Evacuation Transports for your population.")
  local t32e, t34e, t36e
  if difficulty == "Easy" then
    t40 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t40, "Have 5 or more ConVecs.")
    t32e = trigger.research{tech = 5201, player = 1, one_shot = true, on = AdvDone}
    mission.victory(t32e, "Completely research Advanced Combat Chassis.")
    t34e = trigger.research{tech = 5111, player = 1, one_shot = true, on = ITPSDone}
    mission.victory(t34e, "Completely research Independant Turret Power Systems.")
    t36e = trigger.research{tech = 5110, player = 1, one_shot = true, on = RareDone}
    mission.victory(t36e, "Completely research Rare Ore Processing.")
  elseif difficulty == "Normal" then
    t40 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t40, "Have 5 or more ConVecs.")
  end
  local t42 = trigger.research{tech = 5102, player = 1, one_shot = true}
  mission.victory(t42, "Completely research Robot-Assist Mechanic.")
  local t45 = trigger.resource{resource = "Scientists", compare = ">=", amount = 18, player = 1}
  mission.victory(t45, "Keep at least 18 scientists alive.")
  local t44 = trigger.resource{resource = "Workers", compare = ">=", amount = 32, player = 1}
  mission.victory(t44, "Keep at least 32 workers alive.")
  local t46 = trigger.resource{resource = "Kids", compare = ">=", amount = 45, player = 1}
  mission.victory(t46, "Keep at least 45 children alive.")
  local t58 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t58)
  if difficulty == "Normal" or difficulty == "Hard" then
    trigger.count{type = "Panther", compare = ">=", count = 4, player = 1, one_shot = true, on = Microbe}
  end
  trigger.time{min = 3600, max = 3900, on = Meteor1}  -- after 36 to 39 marks
  if difficulty == "Easy" then
    trigger.time{min = 16000, max = 16300, on = Meteor2}  -- after 160 to 163 marks
    trigger.time{min = 33000, max = 33300, on = Meteor3}  -- after 330 to 333 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 10000, on = MeteorMedStart}  -- after 100 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 3600, max = 6000, one_shot = false, on = MeteorOften}  -- after 36 to 60 marks
  end
  trigger.time{min = 12000, max = 12300, on = Quake1}  -- after 120 to 123 marks
  if difficulty == "Easy" then
    trigger.time{min = 36000, max = 38000, on = Lava}  -- after 360 to 380 marks
    trigger.time{min = 14000, max = 14300, one_shot = false, on = Lightning1}  -- after 140 to 143 marks
    trigger.time{time = 52000, on = Microbe}  -- after 520 marks
    trigger.time{time = 20000, on = ScoutArrive}  -- after 200 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 35000, on = Quake2}  -- after 350 marks
    trigger.time{min = 38000, max = 40000, on = Lava}  -- after 380 to 400 marks
    trigger.time{min = 7200, max = 7500, one_shot = false, on = Lightning1}  -- after 72 to 75 marks
    trigger.time{time = 48000, on = Microbe}  -- after 480 marks
    trigger.time{time = 18000, on = ScoutArrive}  -- after 180 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 30000, max = 32000, on = Lava}  -- after 300 to 320 marks
    trigger.time{min = 7200, max = 7500, one_shot = false, on = Lightning1}  -- after 72 to 75 marks
    trigger.time{time = 48000, on = Microbe}  -- after 480 marks
    trigger.time{time = 15000, on = ScoutArrive}  -- after 150 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

-- Not converted:
-- - AdvDone isn't converted: a count trigger on a cargo
-- - ITPSDone isn't converted: it calls CreateResearchTrigger
-- - RareDone isn't converted: a count trigger on a cargo
-- - ReleaseMorale isn't converted: it calls FreeMoraleLevel
