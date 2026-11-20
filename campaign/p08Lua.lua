-- p08Lua.lua  -  Plymouth Mission #8 (Lua)
-- Trigger functions finished by hand (CheckForFail, DualDone, EnemyArrive1Q, LaterWave), from the disassembly of p08.dll.
-- Converted by op2dll from p08.dll. With p08Lua.placement.lua (what every difficulty makes alike),
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
        workers = 32, scientists = 15, kids = 45, food = 1000, ore = 5000, rare_ore = 2000,
        research = { 8000 },
        tech_level = 7,
        kits = { [1] = { "Residence" }, [2] = { "Agridome" }, [3] = { "Tokamak" }, [4] = { "CommandCenter" }, [5] = { "Spaceport" }, [6] = { "ArachnidFactory" } },
        view = { 104, 32 },
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
      { "Tube", { 113, 26 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 91, 62 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 28, 58 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 63, 39 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 68, 8 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 104, 4 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 104, 4 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 121, 46 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 121, 46 } },
      { type = "CommandCenter", player = 1, at = { 104, 32 } },
      { type = "Agridome", player = 1, at = { 98, 25 } },
      { type = "CommonOreSmelter", player = 1, at = { 112, 20 } },
      { type = "Residence", player = 1, at = { 107, 39 } },
      { type = "Agridome", player = 1, at = { 109, 25 } },
      { type = "Nursery", player = 1, at = { 96, 30 } },
      { type = "RareOreSmelter", player = 1, at = { 97, 41 } },
      { type = "Tokamak", player = 1, at = { 95, 14 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 88, 46 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 84, 27 } },
      { type = "StructureFactory", player = 1, at = { 113, 38 } },
      { type = "RobotCommand", player = 1, at = { 115, 26 } },
      { type = "University", player = 1, at = { 115, 31 } },
      { type = "Agridome", player = 1, at = { 95, 38 } },
      { type = "Residence", player = 1, at = { 118, 26 } },
      { type = "Residence", player = 1, at = { 107, 43 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 84, 17 } },
      { type = "Garage", player = 1, at = { 109, 35 } },
      { type = "VehicleFactory", player = 1, at = { 97, 44 } },
      { type = "AdvancedLab", player = 1, at = { 117, 31 } },
      { type = "StandardLab", player = 1, at = { 101, 25 } },
      { type = "MedicalCenter", player = 1, at = { 118, 23 } },
      { type = "MedicalCenter", player = 1, at = { 97, 32 } },
      { type = "DIRT", player = 1, at = { 94, 25 } },
      { type = "Tokamak", player = 1, at = { 89, 14 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 118, 20 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 118, 22 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 99, 44 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 101, 40 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 105, 36 } },
      { type = "RoboDozer", direction = "NorthWest", player = 1, at = { 98, 49 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 89, 23 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 116, 20 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 116, 22 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 96, 22 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 115, 40 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 96, 15 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 100, 26 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 87, 24 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 89, 26 } },
      { type = "Panther", weapon = "Microwave", direction = "South", player = 1, at = { 99, 34 } },
      { type = "Panther", weapon = "Microwave", direction = "SouthEast", player = 1, at = { 101, 36 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 106, 19 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 106, 21 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 110, 29 } },
      { type = "Earthworker", direction = "South", player = 1, at = { 110, 31 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 105, 28 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 32, scientists = 15, kids = 45, food = 1000, ore = 4000, rare_ore = 2000,
        research = { 8000 },
        tech_level = 7,
        kits = { [1] = { "Residence" }, [2] = { "Agridome" }, [3] = { "Tokamak" }, [4] = { "CommandCenter" }, [5] = { "ArachnidFactory" } },
        view = { 104, 32 },
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
      { "Tube", { 113, 26 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 87, 42 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 39, 34 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 68, 8 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 4 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 104, 4 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 63, 39 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 115, 51 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 115, 51 } },
      { type = "CommandCenter", player = 1, at = { 104, 32 } },
      { type = "Agridome", player = 1, at = { 98, 25 } },
      { type = "CommonOreSmelter", player = 1, at = { 112, 20 } },
      { type = "Residence", player = 1, at = { 107, 39 } },
      { type = "Agridome", player = 1, at = { 109, 25 } },
      { type = "Nursery", player = 1, at = { 96, 30 } },
      { type = "RareOreSmelter", player = 1, at = { 97, 41 } },
      { type = "Tokamak", player = 1, at = { 95, 14 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 88, 46 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 84, 27 } },
      { type = "StructureFactory", player = 1, at = { 113, 38 } },
      { type = "RobotCommand", player = 1, at = { 115, 26 } },
      { type = "University", player = 1, at = { 115, 31 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 84, 17 } },
      { type = "Garage", player = 1, at = { 109, 35 } },
      { type = "VehicleFactory", player = 1, at = { 103, 25 } },
      { type = "AdvancedLab", player = 1, at = { 118, 31 } },
      { type = "StandardLab", player = 1, at = { 111, 17 } },
      { type = "Residence", player = 1, at = { 96, 33 } },
      { type = "Residence", player = 1, at = { 103, 22 } },
      { type = "MedicalCenter", player = 1, at = { 93, 30 } },
      { type = "DIRT", player = 1, at = { 103, 42 } },
      { type = "Tokamak", player = 1, at = { 89, 14 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 104, 19 } },
      { type = "Panther", weapon = "RPG", direction = "South", player = 1, at = { 91, 51 } },
      { type = "Lynx", weapon = "RPG", direction = "West", player = 1, at = { 89, 23 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 90, 18 } },
      { type = "Panther", weapon = "EMP", direction = "West", player = 1, at = { 102, 50 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 99, 44 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 101, 40 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 116, 20 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 116, 22 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 96, 22 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 115, 40 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 96, 15 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 100, 26 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 87, 24 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 89, 26 } },
      { type = "Panther", weapon = "Microwave", direction = "South", player = 1, at = { 99, 34 } },
      { type = "Panther", weapon = "Microwave", direction = "SouthEast", player = 1, at = { 101, 36 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 106, 19 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 106, 21 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 110, 29 } },
      { type = "Earthworker", direction = "South", player = 1, at = { 110, 31 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 105, 28 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 32, scientists = 15, kids = 45, food = 1000, ore = 5000, rare_ore = 3000,
        research = { 8000 },
        tech_level = 7,
        kits = { [1] = { "Residence" }, [2] = { "ArachnidFactory" }, [3] = { "Agridome" }, [4] = { "AdvancedLab" }, [5] = { "DIRT" } },
        view = { 104, 32 },
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
      { "Tube", { 104, 25 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 91, 62 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 91, 62 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 121, 43 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 121, 43 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 27, 43 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 32, 56 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 75, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 63, 39 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 105, 6 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 104, 32 } },
      { type = "Agridome", player = 1, at = { 98, 25 } },
      { type = "CommonOreSmelter", player = 1, at = { 112, 20 } },
      { type = "Residence", player = 1, at = { 107, 39 } },
      { type = "Agridome", player = 1, at = { 109, 25 } },
      { type = "Nursery", player = 1, at = { 96, 30 } },
      { type = "RareOreSmelter", player = 1, at = { 97, 41 } },
      { type = "Tokamak", player = 1, at = { 95, 14 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 88, 46 } },
      { type = "GuardPost", weapon = "Microwave", player = 1, at = { 84, 27 } },
      { type = "StructureFactory", player = 1, at = { 113, 38 } },
      { type = "StandardLab", player = 1, at = { 112, 35 } },
      { type = "Residence", player = 1, at = { 100, 31 } },
      { type = "RobotCommand", player = 1, at = { 106, 25 } },
      { type = "Tokamak", player = 1, at = { 119, 25 } },
      { type = "MedicalCenter", player = 1, at = { 102, 25 } },
      { type = "University", player = 1, at = { 115, 31 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 117, 33 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 114, 24 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 116, 24 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 89, 23 } },
      { type = "Panther", weapon = "EMP", direction = "West", player = 1, at = { 91, 49 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 89, 21 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 89, 28 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 116, 20 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 116, 22 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 96, 22 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 115, 40 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 96, 15 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 100, 26 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 87, 24 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 89, 26 } },
      { type = "Panther", weapon = "Microwave", direction = "South", player = 1, at = { 99, 34 } },
      { type = "Panther", weapon = "Microwave", direction = "SouthEast", player = 1, at = { 101, 36 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 106, 19 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 106, 21 } },
      { type = "RoboDozer", direction = "East", player = 1, at = { 110, 29 } },
      { type = "Earthworker", direction = "South", player = 1, at = { 110, 31 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "South", player = 1, at = { 105, 28 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 105, 28 } },
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
-- Its unit tables, as the mission's UnitRecord arrays list them (ai.unit_block).
local AI_UNITS = {
  [1] = {
    { type = "Lynx", at = { 48, 2 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 49, 2 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 50, 2 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 51, 2 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 52, 2 }, direction = "West", weapon = "Laser" },
    { type = "Lynx", at = { 53, 2 }, direction = "West", weapon = "Laser" },
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
function FactDone(t) end
function SpaceDone(t) end


-- The triggers CheckForFail reads (0x1100AB94 to 0x1100ABB4): on Normal the Panther, RPG Panther, Lynx, Stickyfoam
-- Lynx and evacuation counts, then the Ion Drive, Fusion Drive or Fueling Systems, and Skydock in orbit.
local t19, t20, t23, t24, t27, t11, t15, t17
-- DualDone's Tigers wanted (0x1100AB90), which CheckForFail reads once it's set.
local tiger_trigger
-- Where the waves go (0x1100ABB8), and the two map edges they come in on (0x1100AA60, a column; 0x1100AA70, a row):
-- the first unit at the given tile and each next one tile further along.
local WAVE_RECT = { 97, 21, 113, 38 }
local WAVE_EDGES = { { 2, 2, false }, { 69, 2, true } }
-- The waves' units by the size drawn (0 to 9), the blocks' types and weapons in the order
-- the DLL walks their records (the array each block's +0x84 points to): Easy's
-- (0x1100AB08, A3F8, AA80, A2E8, A9D0, A260, A140, ABC8, A370, A1D8) and the others' (0x1100A508, A480, A7B0, A728,
-- A6A0, A618, A590, A948, A8C0, A838).
local WAVES_EASY = {
  { { "Lynx", "Laser" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" } },
  { { "Lynx", "Laser" }, { "Panther", "RailGun" }, { "Lynx", "Laser" }, { "Lynx", "EMP" } },
  { { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" }, { "Lynx", "EMP" } },
  { { "Lynx", "Laser" }, { "Lynx", "Laser" }, { "Panther", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" }, { "Lynx", "EMP" } },
  { { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "EMP" }, { "Lynx", "EMP" }, { "Lynx", "EMP" } },
  { { "Panther", "AcidCloud" }, { "Lynx", "RailGun" }, { "Panther", "RailGun" }, { "Lynx", "EMP" } },
  { { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" }, { "Lynx", "EMP" } },
  { { "Lynx", "RailGun" }, { "Lynx", "AcidCloud" }, { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "EMP" } },
  { { "Panther", "RailGun" }, { "Panther", "AcidCloud" }, { "Lynx", "RailGun" }, { "Panther", "Laser" }, { "Lynx", "EMP" } },
  { { "Panther", "Laser" }, { "Panther", "AcidCloud" }, { "Panther", "RailGun" }, { "Lynx", "RailGun" }, { "Panther", "Laser" }, { "Lynx", "EMP" } },
}
local WAVES = {
  { { "Lynx", "Laser" }, { "Panther", "RailGun" }, { "Lynx", "Laser" } },
  { { "Tiger", "AcidCloud" }, { "Panther", "RailGun" }, { "Panther", "RailGun" }, { "Lynx", "Laser" }, { "Lynx", "EMP" } },
  { { "Lynx", "Laser" }, { "Lynx", "RailGun" }, { "Lynx", "Laser" } },
  { { "Lynx", "Laser" }, { "Lynx", "Laser" }, { "Panther", "RailGun" }, { "Panther", "AcidCloud" }, { "Lynx", "Laser" } },
  { { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "RailGun" }, { "Lynx", "EMP" }, { "Lynx", "EMP" } },
  { { "Panther", "AcidCloud" }, { "Panther", "AcidCloud" }, { "Panther", "RailGun" } },
  { { "Tiger", "RailGun" }, { "Tiger", "Laser" } },
  { { "Lynx", "RailGun" }, { "Lynx", "AcidCloud" }, { "Lynx", "AcidCloud" }, { "Lynx", "RailGun" } },
  { { "Panther", "Laser" }, { "Panther", "AcidCloud" }, { "Panther", "RailGun" }, { "Panther", "Laser" } },
  { { "Tiger", "Laser" }, { "Tiger", "AcidCloud" }, { "Tiger", "AcidCloud" }, { "Tiger", "Laser" } },
}
-- A wave (0x11002A50): a group that attacks the Spaceport, or the Advanced Lab while there's none; its size drawn from
-- lo to hi, its edge drawn of two; its units made one by one along the edge.
local function enemy_wave(lo, hi)
  local g = ai.fight_group(ai_player)
  g:do_attack_enemy()
  g:set_attack_type(#players[1]:buildings("Spaceport") > 0 and "Spaceport" or "AdvancedLab")
  g:set_rect(WAVE_RECT)
  local k = lo + game.rand(hi - lo + 1)
  local units = (players[1].difficulty == "Easy" and WAVES_EASY or WAVES)[k + 1] or WAVES[1]
  local edge = WAVE_EDGES[game.rand(2) + 1]
  for i, u in ipairs(units) do
    local at = edge[3] and { edge[1] + i - 1, edge[2] } or { edge[1], edge[2] + i - 1 }
    local made = game.create_unit{type = u[1], weapon = u[2], player = ai_player, at = at, exact = true}
    if made[1] then g:take_unit(made[1]) end
  end
  g:set_lights(true)
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Blockade, Meteor1, Microbe, MoreMeteors, Quake1, Quake2, Quake3, Quake4, Quake5, Storm1, Storm2, StormOften, Tornado1, Tornado2

function Blockade(t)
  local fight1 = ai.fight_group(ai_player)
  fight1:do_guard_rect()
  fight1:set_rect({ 62, 22, 72, 32 })
  fight1:add_units(ai_block(1))
end

function Meteor1(t)
  if players[1].difficulty == "Easy" then
    game.create_meteor({ 103, 31 }, 0)
    trigger.time{min = 7000, max = 7500, one_shot = false, on = MoreMeteors}  -- after 70 to 75 marks
  elseif players[1].difficulty == "Normal" then
    game.create_meteor({ 103, 31 }, 0)
    trigger.time{min = 8000, max = 8500, one_shot = false, on = MoreMeteors}  -- after 80 to 85 marks
  else
    game.create_meteor({ 103, 31 }, 0)
    trigger.time{min = 7000, max = 7500, one_shot = false, on = MoreMeteors}  -- after 70 to 75 marks
  end
end

function Microbe(t)
  game.create_blight({ 51, 64 })
  game.create_blight({ 50, 64 })
  game.create_blight({ 52, 64 })
  game.set_blight_speed(180)
  game.message_at("Microbe growth detected!", 152, 1, 2624, 2016)
end

function MoreMeteors(t)
  local r1 = game.rand(45)
  local r2 = game.rand(45)
  game.create_meteor({ r2 + 80, r1 + 6 }, 0)
end

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 44, 48 }, 2)
    trigger.time{min = 6000, max = 8400, on = Quake2}  -- after 60 to 84 marks
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 96, 2 }, 2)
    trigger.time{min = 6000, max = 8400, on = Quake2}  -- after 60 to 84 marks
  else
    game.create_earthquake({ 96, 2 }, 2)
    trigger.time{min = 6000, max = 8400, on = Quake2}  -- after 60 to 84 marks
  end
end

function Quake2(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 64, 17 }, 2)
    trigger.time{min = 6000, max = 8400, on = Quake3}  -- after 60 to 84 marks
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 76, 24 }, 2)
    trigger.time{min = 6000, max = 8400, on = Quake3}  -- after 60 to 84 marks
  else
    game.create_earthquake({ 76, 24 }, 2)
    trigger.time{min = 6000, max = 8400, on = Quake3}  -- after 60 to 84 marks
  end
end

function Quake3(t)
  game.create_earthquake({ 49, 12 }, 2)
  trigger.time{min = 6000, max = 8400, on = Quake4}  -- after 60 to 84 marks
end

function Quake4(t)
  game.create_earthquake({ 9, 8 }, 2)
  trigger.time{min = 6000, max = 8400, on = Quake5}  -- after 60 to 84 marks
end

function Quake5(t)
  game.create_earthquake({ 25, 24 }, 2)
end

function Storm1(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(64)
    game.create_lightning({ 2, 31 }, { 128, r1 + 1 }, 14)
    trigger.time{min = 8000, max = 10000, one_shot = false, on = StormOften}  -- after 80 to 100 marks
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(64)
    game.create_lightning({ 2, 31 }, { 128, r1 + 1 }, 14)
    trigger.time{min = 6500, max = 8000, one_shot = false, on = StormOften}  -- after 65 to 80 marks
  else
    local r1 = game.rand(64)
    game.create_lightning({ 2, 31 }, { 128, r1 + 1 }, 14)
    trigger.time{min = 3000, max = 5000, one_shot = false, on = StormOften}  -- after 30 to 50 marks
  end
end

function Storm2(t)
  local r1 = game.rand(128)
  game.create_lightning({ 50, 64 }, { r1, 2 }, 20)
end

function StormOften(t)
  local r1 = game.rand(17)
  local r2 = game.rand(7)
  local r3 = game.rand(120)
  game.create_lightning({ r3 + 1, 61 }, { r1 + 110, 1 }, r2 + 14)
end

function Tornado1(t)
  if players[1].difficulty == "Easy" then
    game.create_tornado({ 126, 36 }, { 67, 14 }, 14)
    trigger.time{min = 7500, max = 8000, one_shot = false, on = Tornado2}  -- after 75 to 80 marks
  elseif players[1].difficulty == "Normal" then
    game.create_tornado({ 126, 56 }, { 1, 46 }, 40)
    trigger.time{min = 7500, max = 8000, one_shot = false, on = Tornado2}  -- after 75 to 80 marks
  else
    game.create_tornado({ 126, 36 }, { 67, 14 }, 14)
    trigger.time{min = 7500, max = 8000, one_shot = false, on = Tornado2}  -- after 75 to 80 marks
  end
end

function Tornado2(t)
  local r1 = game.rand(55)
  local r2 = game.rand(24)
  local r3 = game.rand(55)
  local r4 = game.rand(24)
  game.create_tornado({ r4 + 59, r3 + 2 }, { r2 + 59, r1 + 2 }, 20)
end

-- Every 40 ticks (0x11002CB0): the colony's checks. Too few workers or scientists; less Common or Rare Metals in
-- storage than the difficulty's (Cargo Trucks don't count) and no way to mine more; a vehicle objective missing
-- (DualDone's Tigers too, once set) and no way to build vehicles; a space objective missing and no Spaceport to build
-- one; or technology 3901 or 7102 (Explosive Charges) out of reach: the colony fails.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  local need = ({ Easy = { 8000, 4000 }, Normal = { 10000, 7500 }, Hard = { 10000, 8000 } })[p.difficulty]
  if p.ore < need[1] and not p:can_accumulate_ore() then fail = true end
  if p.rare_ore < need[2] and not p:can_accumulate_rare_ore() then fail = true end
  local missing = tiger_trigger ~= nil and not tiger_trigger:has_fired(1)
  for _, k in ipairs({ t19, t20, t23, t24, t27 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_vehicle(1) then fail = true end
  missing = false
  for _, k in ipairs({ t11, t15, t17 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_space() then fail = true end
  for _, tech in ipairs({ 3901, 7102 }) do
    if not p:has_tech(tech) and not p:can_do_research(tech) then fail = true end
  end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Dual-Turret Weapons Systems researched: a new objective, three Tigers on Easy and five otherwise (0x11003720).
function DualDone(t)
  local n = players[1].difficulty == "Easy" and 3 or 5
  tiger_trigger = trigger.count{type = "Tiger", cargo = -1, compare = ">=", count = n, player = 1}
  mission.victory(tiger_trigger, "Have " .. n .. " or more Tigers.")
  game.message_at("New Objective", 122, nil, -1, -1)
end

-- The first wave (size 0 or 1), then the later ones every 45 to 55 marks on Easy, 50 to 60 on Normal and 20 to 40 on
-- Hard (0x11003030).
function EnemyArrive1Q(t)
  enemy_wave(0, 1)
  local d = players[1].difficulty
  if d == "Easy" then
    trigger.time{min = 4500, max = 5500, one_shot = false, on = LaterWave}
  elseif d == "Normal" then
    trigger.time{min = 5000, max = 6000, one_shot = false, on = LaterWave}
  else
    trigger.time{min = 2000, max = 4000, one_shot = false, on = LaterWave}
  end
end

-- A later wave, larger with time (TethysGame::Time, a quarter of the tick): before tick 14000 size 0 or 1, before
-- 28000 size 2 or 3, before 42000 two of those, then size 4 to 9 (0x110030F0).
function LaterWave(t)
  local now = math.floor(game.tick() / 4) * 4
  if now < 14000 then
    enemy_wave(0, 1)
  elseif now < 28000 then
    enemy_wave(2, 3)
  elseif now < 42000 then
    enemy_wave(2, 3)
    enemy_wave(2, 3)
  else
    enemy_wave(4, 9)
  end
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
  local t5, t7, t9, t13, t14, t19h
  if difficulty == "Easy" then
    t5 = trigger.resource{resource = "Food", compare = ">=", amount = 3000, player = 1}
    mission.victory(t5, "Have 3000 units of food in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 4000}
    mission.victory(t7, "Have 4000 units of Rare Metals in storage.")
    t9 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 8000, player = 1}
    mission.victory(t9, "Have 8000 units of Common Metals in storage.")
    t11 = trigger.operational{type = "Spaceport", compare = ">=", count = 1, player = 1, on = SpaceDone}
    mission.victory(t11, "Build a Spaceport.")
    t19 = trigger.count{type = "Panther", compare = ">=", count = 3, player = 1}
    mission.victory(t19, "Have 3 or more Panthers.")
    t23 = trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1}
    mission.victory(t23, "Have 4 or more Lynx.")
  elseif difficulty == "Normal" then
    t5 = trigger.resource{resource = "Food", compare = ">=", amount = 4000, player = 1}
    mission.victory(t5, "Have 4000 units of food in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 7500}
    mission.victory(t7, "Have 7500 units of Rare Metals in storage.")
    t9 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t9, "Have 10000 units of Common Metals in storage.")
    t11 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t11, "Place the Ion Drive Module in orbit.")
    t13 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t15 = trigger.set{t13, t14, needed = 1}
    mission.victory(t15, "Place the Fusion Drive Module OR the Fueling Systems in orbit.")
    t17 = trigger.count{type = "Skydock", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t17, "Place the Skydock in orbit.")
    t19 = trigger.count{type = "Panther", compare = ">=", count = 5, player = 1}
    mission.victory(t19, "Have 5 or more total Panthers.")
    t20 = trigger.count{type = "Panther", cargo = "RPG", compare = ">=", count = 1, player = 1}
    mission.victory(t20, "Have 1 or more RPG Panthers.")
    t23 = trigger.count{type = "Lynx", compare = ">=", count = 6, player = 1}
    mission.victory(t23, "Have 6 or more total Lynx.")
    t24 = trigger.count{type = "Lynx", cargo = "Stickyfoam", compare = ">=", count = 1, player = 1}
    mission.victory(t24, "Have 1 or more Stickyfoam Lynx.")
  elseif difficulty == "Hard" then
    t5 = trigger.resource{resource = "Food", compare = ">=", amount = 4000, player = 1}
    mission.victory(t5, "Have 4000 units of food in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 8000}
    mission.victory(t7, "Have 8000 units of Rare Metals in storage.")
    t9 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000, player = 1}
    mission.victory(t9, "Have 10000 units of Common Metals in storage.")
    t11 = trigger.count{type = "IonDriveModule", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t11, "Place the Ion Drive Module in orbit.")
    t13 = trigger.count{type = "FusionDriveModule", compare = ">=", count = 1, player = 1}
    t14 = trigger.count{type = "FuelingSystems", compare = ">=", count = 1, player = 1}
    t15 = trigger.set{t13, t14, needed = 1}
    mission.victory(t15, "Place the Fusion Drive Module OR the Fueling Systems in orbit.")
    t17 = trigger.count{type = "Skydock", compare = ">=", count = 1, player = 1, one_shot = true}
    mission.victory(t17, "Place the Skydock in orbit.")
    t19h = trigger.count{type = "Tiger", compare = ">=", count = 6, player = 1}
    mission.victory(t19h, "Have 6 or more Tigers.")
    t19 = trigger.count{type = "Panther", compare = ">=", count = 6, player = 1}
    mission.victory(t19, "Have 6 or more total Panthers.")
    t20 = trigger.count{type = "Panther", cargo = "RPG", compare = ">=", count = 1, player = 1}
    mission.victory(t20, "Have 1 or more RPG Panthers.")
    t23 = trigger.count{type = "Lynx", compare = ">=", count = 8, player = 1}
    mission.victory(t23, "Have 8 or more total Lynx.")
    t24 = trigger.count{type = "Lynx", cargo = "Stickyfoam", compare = ">=", count = 1, player = 1}
    mission.victory(t24, "Have 1 or more Stickyfoam Lynx.")
  end
  t27 = trigger.evac{player = 1}
  mission.victory(t27, "Have enough Evacuation Transports for your population.")
  local t29 = trigger.research{tech = 7102, player = 1, one_shot = true}
  mission.victory(t29, "Completely research Explosive Charges.")
  local t23e, t31
  if difficulty == "Easy" then
    t24 = trigger.count{type = "Lynx", cargo = "EMP", compare = ">=", count = 4, player = 1}
    mission.victory(t24, "Have 4 or more EMP Lynx.")
    t23e = trigger.operational{type = "ArachnidFactory", compare = ">=", count = 1, player = 1, on = FactDone}
    mission.victory(t23e, "Build an Arachnid Factory.")
    t31 = trigger.research{tech = 8201, player = 1, one_shot = true, on = DualDone}
    mission.victory(t31, "Completely research Dual-Turret Weapons Systems.")
  elseif difficulty == "Normal" then
    t31 = trigger.research{tech = 8201, player = 1, one_shot = true, on = DualDone}
    mission.victory(t31, "Completely research Dual-Turret Weapons Systems.")
  end
  local t34 = trigger.resource{resource = "Scientists", compare = ">=", amount = 23, player = 1}
  mission.victory(t34, "Keep at least 23 scientists alive.")
  local t33 = trigger.resource{resource = "Workers", compare = ">=", amount = 42, player = 1}
  mission.victory(t33, "Keep at least 42 workers alive.")
  local t35 = trigger.resource{resource = "Kids", compare = ">=", amount = 60, player = 1}
  mission.victory(t35, "Keep at least 60 children alive.")
  local t45 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t45)
  trigger.time{time = 12000, on = Quake1}  -- after 120 marks
  trigger.time{min = 20000, max = 22000, on = Meteor1}  -- after 200 to 220 marks
  trigger.time{min = 4000, max = 5000, on = Storm1}  -- after 40 to 50 marks
  if difficulty == "Easy" then
    trigger.time{min = 18000, max = 19000, on = Storm2}  -- after 180 to 190 marks
  end
  trigger.time{min = 4000, max = 8000, on = Tornado1}  -- after 40 to 80 marks
  trigger.time{time = 54000, on = Microbe}  -- after 540 marks
  if difficulty == "Hard" then
    trigger.time{time = 9600, on = Blockade}  -- after 96 marks
  end
  trigger.time{min = 8000, max = 9000, on = EnemyArrive1Q}  -- after 80 to 90 marks
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

-- Not converted:
-- - FactDone isn't converted: a count trigger on a cargo
-- - SpaceDone isn't converted: a count trigger on a cargo
