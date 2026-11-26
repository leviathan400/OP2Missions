-- p03Lua.lua  -  Plymouth Mission #3 (Lua)
-- Trigger functions finished by hand (CheckForFail, Teleoperations, VehFact, LSOR, MWP, ReleaseMorale), from the disassembly of p03.dll.
-- Converted by op2dll from p03.dll. With p03Lua.placement.lua (what every difficulty makes alike),
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
        workers = 14, scientists = 6, kids = 20, food = 2000, ore = 4000,
        research = { 3000 },
        tech_level = 2,
        kits = { [1] = { "Agridome" }, [2] = { "Residence" }, [3] = { "CommandCenter" }, [4] = { "StructureFactory" }, [5] = { "CommonOreSmelter" } },
        view = { 31, 69 },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 23, 63 } }, { "Tube", { 26, 63 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 31, 69 } },
      { type = "Agridome", player = 1, at = { 31, 72 } },
      { type = "StructureFactory", player = 1, at = { 27, 68 } },
      { type = "StandardLab", player = 1, at = { 31, 66 } },
      { type = "CommonOreSmelter", player = 1, at = { 36, 65 } },
      { type = "Tokamak", player = 1, at = { 31, 57 } },
      { type = "Residence", player = 1, at = { 31, 63 } },
      { type = "Tokamak", player = 1, at = { 36, 57 } },
      { type = "Agridome", player = 1, at = { 26, 65 } },
      { type = "Residence", player = 1, at = { 23, 65 } },
      { type = "University", player = 1, at = { 23, 61 } },
      { type = "Nursery", player = 1, at = { 26, 61 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 33, 73 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 33, 70 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 29, 70 } },
      { type = "ConVec", direction = "North", player = 1, at = { 33, 67 } },
      { type = "ConVec", direction = "South", player = 1, at = { 32, 58 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 39, 64 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 39, 65 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 34, 62 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 36, 62 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 38, 62 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 31, 75 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 30, 76 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 32, 76 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 26, 72 } },
      { type = "Earthworker", direction = "NorthWest", player = 1, at = { 38, 72 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 35, 69 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 35, 69 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 48, 39 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 48, 39 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 13, 79 }, beacon = true },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 14, scientists = 6, kids = 20, food = 1500, ore = 3000,
        research = { 3000 },
        tech_level = 2,
        kits = { [1] = { "CommandCenter" }, [2] = { "StructureFactory" } },
        view = { 31, 69 },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 23, 63 } }, { "Tube", { 26, 63 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 31, 69 } },
      { type = "Agridome", player = 1, at = { 31, 72 } },
      { type = "StructureFactory", player = 1, at = { 27, 68 } },
      { type = "StandardLab", player = 1, at = { 31, 66 } },
      { type = "CommonOreSmelter", player = 1, at = { 36, 65 } },
      { type = "Tokamak", player = 1, at = { 31, 57 } },
      { type = "Residence", player = 1, at = { 31, 63 } },
      { type = "Agridome", player = 1, at = { 26, 65 } },
      { type = "Residence", player = 1, at = { 23, 65 } },
      { type = "University", player = 1, at = { 23, 61 } },
      { type = "Nursery", player = 1, at = { 26, 61 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 33, 73 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 33, 70 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 29, 70 } },
      { type = "ConVec", direction = "North", player = 1, at = { 33, 67 } },
      { type = "ConVec", direction = "South", player = 1, at = { 32, 58 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 39, 64 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 39, 65 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 34, 62 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 36, 62 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 38, 62 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 31, 75 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 30, 76 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 32, 76 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 26, 72 } },
      { type = "Earthworker", direction = "NorthWest", player = 1, at = { 38, 72 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 35, 69 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 35, 69 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 48, 39 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 48, 39 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 9, 109 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 14, scientists = 6, kids = 20, food = 1500, ore = 2400,
        research = { 3000 },
        tech_level = 2,
        kits = { [1] = { "Agridome" }, [2] = { "Residence" }, [3] = { "Tokamak" } },
        view = { 31, 69 },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 31, 69 } },
      { type = "Agridome", player = 1, at = { 31, 72 } },
      { type = "StructureFactory", player = 1, at = { 27, 68 } },
      { type = "StandardLab", player = 1, at = { 31, 66 } },
      { type = "CommonOreSmelter", player = 1, at = { 36, 65 } },
      { type = "Tokamak", player = 1, at = { 31, 57 } },
      { type = "Residence", player = 1, at = { 31, 63 } },
      { type = "University", player = 1, at = { 35, 72 } },
      { type = "Nursery", player = 1, at = { 38, 72 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 33, 73 } },
      { type = "ConVec", direction = "NorthWest", player = 1, at = { 33, 70 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 29, 70 } },
      { type = "ConVec", direction = "North", player = 1, at = { 33, 67 } },
      { type = "ConVec", direction = "South", player = 1, at = { 32, 58 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 39, 64 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 39, 65 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 34, 62 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 36, 62 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 38, 62 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 31, 75 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 30, 76 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 32, 76 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 26, 72 } },
      { type = "Earthworker", direction = "NorthWest", player = 1, at = { 38, 72 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 35, 69 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 35, 69 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 48, 39 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 9, 109 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 9, 109 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 25, 64 } },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 1, 1, 12, 2 },
  { 46, 1, 64, 3 },
  { 1, 3, 11, 3 },
  { 1, 4, 12, 4 },
  { 45, 4, 64, 4 },
  { 1, 5, 6, 5 },
  { 12, 5, 13, 5 },
  { 44, 5, 51, 5 },
  { 54, 5, 58, 5 },
  { 1, 6, 5, 6 },
  { 13, 6, 14, 6 },
  { 43, 6, 51, 6 },
  { 55, 6, 58, 6 },
  { 1, 7, 4, 8 },
  { 13, 7, 15, 7 },
  { 24, 7, 26, 7 },
  { 42, 7, 48, 7 },
  { 50, 7, 50, 7 },
  { 56, 7, 58, 7 },
  { 13, 8, 16, 9 },
  { 23, 8, 26, 10 },
  { 43, 8, 44, 9 },
  { 56, 8, 57, 10 },
  { 1, 9, 3, 12 },
  { 12, 10, 18, 10 },
  { 42, 10, 45, 11 },
  { 12, 11, 19, 11 },
  { 23, 11, 25, 11 },
  { 39, 11, 40, 11 },
  { 9, 12, 9, 12 },
  { 12, 12, 24, 12 },
  { 39, 12, 45, 12 },
  { 1, 13, 4, 13 },
  { 8, 13, 23, 13 },
  { 34, 13, 36, 13 },
  { 38, 13, 47, 13 },
  { 1, 14, 21, 16 },
  { 34, 14, 48, 14 },
  { 34, 15, 49, 16 },
  { 51, 16, 53, 16 },
  { 1, 17, 8, 19 },
  { 10, 17, 13, 17 },
  { 15, 17, 21, 17 },
  { 33, 17, 56, 17 },
  { 17, 18, 23, 18 },
  { 32, 18, 60, 18 },
  { 64, 18, 64, 19 },
  { 18, 19, 25, 19 },
  { 31, 19, 61, 19 },
  { 1, 20, 2, 20 },
  { 6, 20, 8, 20 },
  { 18, 20, 26, 20 },
  { 30, 20, 64, 20 },
  { 1, 21, 1, 21 },
  { 21, 21, 34, 21 },
  { 37, 21, 64, 21 },
  { 22, 22, 28, 24 },
  { 31, 22, 31, 22 },
  { 39, 22, 47, 22 },
  { 52, 22, 64, 23 },
  { 39, 23, 46, 23 },
  { 39, 24, 42, 24 },
  { 59, 24, 64, 24 },
  { 21, 25, 28, 25 },
  { 38, 25, 42, 27 },
  { 60, 25, 64, 25 },
  { 19, 26, 28, 26 },
  { 18, 27, 27, 27 },
  { 16, 28, 26, 28 },
  { 37, 28, 42, 29 },
  { 15, 29, 25, 29 },
  { 14, 30, 23, 30 },
  { 37, 30, 43, 30 },
  { 13, 31, 21, 31 },
  { 36, 31, 46, 31 },
  { 11, 32, 20, 32 },
  { 36, 32, 36, 33 },
  { 38, 32, 46, 32 },
  { 50, 32, 50, 32 },
  { 10, 33, 20, 34 },
  { 38, 33, 51, 33 },
  { 63, 33, 64, 33 },
  { 38, 34, 52, 34 },
  { 62, 34, 64, 34 },
  { 1, 35, 2, 35 },
  { 10, 35, 18, 36 },
  { 39, 35, 64, 35 },
  { 1, 36, 3, 36 },
  { 38, 36, 64, 40 },
  { 1, 37, 7, 37 },
  { 10, 37, 16, 37 },
  { 18, 37, 18, 38 },
  { 1, 38, 16, 38 },
  { 1, 39, 18, 39 },
  { 36, 39, 36, 39 },
  { 1, 40, 17, 41 },
  { 40, 41, 64, 44 },
  { 1, 42, 16, 46 },
  { 28, 44, 32, 44 },
  { 26, 45, 33, 45 },
  { 39, 45, 64, 52 },
  { 25, 46, 35, 46 },
  { 1, 47, 17, 47 },
  { 20, 47, 21, 47 },
  { 24, 47, 35, 47 },
  { 1, 48, 36, 49 },
  { 1, 50, 37, 52 },
  { 1, 53, 64, 59 },
  { 2, 60, 64, 60 },
  { 4, 61, 64, 61 },
  { 5, 62, 64, 62 },
  { 8, 63, 64, 63 },
  { 9, 64, 64, 64 },
  { 11, 65, 64, 69 },
  { 12, 70, 64, 70 },
  { 13, 71, 64, 76 },
  { 15, 77, 64, 78 },
  { 16, 79, 64, 79 },
  { 15, 80, 64, 83 },
  { 15, 84, 56, 84 },
  { 60, 84, 64, 85 },
  { 14, 85, 55, 85 },
  { 13, 86, 52, 93 },
  { 61, 86, 64, 86 },
  { 14, 94, 52, 94 },
  { 14, 95, 50, 95 },
  { 52, 95, 52, 99 },
  { 15, 96, 50, 98 },
  { 15, 99, 16, 99 },
  { 18, 99, 50, 99 },
  { 18, 100, 49, 100 },
  { 19, 101, 47, 103 },
  { 16, 104, 16, 104 },
  { 18, 104, 47, 104 },
  { 16, 105, 46, 105 },
  { 16, 106, 45, 106 },
  { 16, 107, 43, 107 },
  { 16, 108, 40, 108 },
  { 17, 109, 39, 109 },
  { 17, 110, 37, 110 },
  { 17, 111, 36, 111 },
  { 18, 112, 35, 112 },
  { 19, 113, 33, 113 },
  { 19, 114, 32, 114 },
  { 21, 115, 31, 115 },
  { 25, 116, 31, 116 },
  { 26, 117, 30, 117 },
  { 27, 118, 29, 118 },
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


-- The triggers CheckForFail reads (0x1100896C to 0x11008994): the evacuation, ConVec and Robo-Surveyor counts and the
-- five kits from the setup, then the Scouts, Lynx and Robo-Miner counts the later objectives make (unset until then).
local t5, t23, t6, t9, t10, t11, t12, t13
local scouts_wanted, lynx_wanted, miner_wanted
local function new_objective() game.message_at("New Objective", 122, nil, -1, -1) end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local EruptLava, Quake1, Quake2, Quake3, Quake4, Quake5, Quake6, Quake7, Quake8, Quake9, QuakeHard, QuakeRepeater, Storm1, Storm2, StormRepeater, StormRepeaterStart

local EruptLava_done  -- EruptLava does nothing more once it has acted
function EruptLava(t)
  if EruptLava_done then return end
  game.create_eruption({ 13, 11 }, 200)
  EruptLava_done = true
end

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 26, 23 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 26, 23 }, 1)
  else
    game.create_earthquake({ 26, 23 }, 2)
  end
end

function Quake2(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 24, 110 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 24, 110 }, 1)
  else
    game.create_earthquake({ 20, 110 }, 2)
  end
end

function Quake3(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 43, 18 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 43, 18 }, 1)
  else
    game.create_earthquake({ 43, 18 }, 2)
  end
end

function Quake4(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 51, 22 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 51, 42 }, 1)
  else
    game.create_earthquake({ 51, 42 }, 2)
  end
end

function Quake5(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 41, 118 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 41, 118 }, 1)
  else
    game.create_earthquake({ 41, 118 }, 2)
  end
end

function Quake6(t)
  game.create_earthquake({ 14, 28 }, 2)
end

function Quake7(t)
  game.create_earthquake({ 15, 56 }, 2)
end

function Quake8(t)
  game.create_earthquake({ 24, 50 }, 1)
end

function Quake9(t)
  game.create_earthquake({ 20, 80 }, 3)
end

function QuakeHard(t)
  game.create_earthquake({ 23, 83 }, 2)
end

function QuakeRepeater(t)
  local r1 = game.rand(22)
  local r2 = game.rand(54)
  game.create_earthquake({ r2 + 6, r1 + 38 }, 1)
end

function Storm1(t)
  local r1 = game.rand(2)
  game.create_lightning({ -52 * r1 + 56, 116 * r1 + 10 }, { 55 * r1 + 4, 60 * r1 + 41 }, 20)
end

function Storm2(t)
  local r1 = game.rand(2)
  game.create_lightning({ -24 * r1 + 32, -r1 + 7 }, { 55 * r1 + 4, -25 * r1 + 126 }, 20)
end

function StormRepeater(t)
  if players[1].difficulty == "Easy" then
    local r1 = game.rand(64)
    local r2 = game.rand(10)
    local r3 = game.rand(64)
    game.create_lightning({ r3 + 1, 129 }, { r1 + 1, 2 }, r2 + 15)
  elseif players[1].difficulty == "Normal" then
    local r1 = game.rand(64)
    local r2 = game.rand(10)
    local r3 = game.rand(64)
    game.create_lightning({ r3 + 1, 2 }, { r1 + 1, 129 }, r2 + 15)
  else
    local r1 = game.rand(64)
    local r2 = game.rand(10)
    local r3 = game.rand(64)
    game.create_lightning({ r3 + 1, 129 }, { r1 + 1, 2 }, r2 + 15)
  end
end

function StormRepeaterStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 4000, max = 5000, one_shot = false, on = StormRepeater}  -- after 40 to 50 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 5000, max = 6000, one_shot = false, on = StormRepeater}  -- after 50 to 60 marks
  else
    trigger.time{min = 4000, max = 5000, one_shot = false, on = StormRepeater}  -- after 40 to 50 marks
  end
end

-- Every 40 ticks (0x11001100): the colony's checks. A count not yet made isn't checked.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 8 then fail = true end
  if p.scientists < 3 then fail = true end
  local ore = p.ore
  for _, u in ipairs(p:units("CargoTruck")) do
    if u.cargo == "CommonMetal" then ore = ore + 1000 end
  end
  if ore < 5000 and not p:can_accumulate_ore() then fail = true end
  local missing = false
  for _, k in pairs({ t5, t23, scouts_wanted, t6, miner_wanted, lynx_wanted }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_vehicle(1) then fail = true end
  missing = false
  for _, k in ipairs({ t9, t10, t11, t12, t13 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_building() then fail = true end
  if not p:has_tech(3603) and not p:can_do_research(3603) then fail = true end
  if not p:has_tech(3851) and not p:can_do_research(3851) then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- Cybernetic Teleoperations researched (0x11002480): on Easy, build a Vehicle Factory (then VehFact); on Normal, have
-- 4 Lynx, 2 Scouts and a Robo-Miner; on Hard nothing.
function Teleoperations(t)
  local d = players[1].difficulty
  if d == "Easy" then
    local f = trigger.operational{type = "VehicleFactory", compare = ">=", count = 1, player = 1, one_shot = true, on = VehFact}
    mission.victory(f, "Build a Vehicle Factory.", { one_shot = true })
    new_objective()
  elseif d == "Normal" then
    lynx_wanted = trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1}
    mission.victory(lynx_wanted, "Have 4 or more Lynx.")
    scouts_wanted = trigger.count{type = "Scout", compare = ">=", count = 2, player = 1}
    mission.victory(scouts_wanted, "Have 2 or more Scouts.")
    miner_wanted = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
    mission.victory(miner_wanted, "Have 1 or more Robo-Miner.")
    new_objective()
  end
end

-- Easy, a Vehicle Factory built (0x11002370): have 3 Scouts and a Robo-Miner, research Focused Microwave Projection
-- (then LSOR).
function VehFact(t)
  scouts_wanted = trigger.count{type = "Scout", compare = ">=", count = 3, player = 1}
  mission.victory(scouts_wanted, "Have 3 or more Scouts.")
  miner_wanted = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
  mission.victory(miner_wanted, "Have 1 or more Robo-Miners.")
  local r = trigger.research{tech = 3603, player = 1, one_shot = true, on = LSOR}
  mission.victory(r, "Completely research Focused Microwave Projection.", { one_shot = true })
  new_objective()
end

-- Easy, Focused Microwave Projection researched (0x11002300): research Mobile Weapons Platforms (then MWP).
function LSOR(t)
  local r = trigger.research{tech = 3851, player = 1, one_shot = true, on = MWP}
  mission.victory(r, "Completely research Mobile Weapons Platforms.", { one_shot = true })
  new_objective()
end

-- Easy, Mobile Weapons Platforms researched (0x11002280): have 4 Lynx.
function MWP(t)
  lynx_wanted = trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1}
  mission.victory(lynx_wanted, "Have 4 or more Lynx.")
  new_objective()
end

-- On Easy, 10 ticks in: the morale lock the setup set ends (FreeMoraleLevel(-1), 0x11002610).
function ReleaseMorale(t)
  game.free_morale()
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 9, 11 }, 1140)
  game.initial_set_tile({ 9, 12 }, 1150)
  game.initial_set_tile({ 11, 9 }, 1161)
  game.initial_set_tile({ 12, 9 }, 1172)
  game.initial_set_tile({ 11, 10 }, 1184)
  game.initial_set_tile({ 12, 10 }, 1195)
  game.set_daylight_everywhere(false)
  game.set_initial_light_level(62)
  if difficulty == "Easy" then game.morale_steady("Good") end
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end
  if difficulty == "Easy" then
    trigger.time{time = 10, on = ReleaseMorale}  -- after 0 marks
  end

  -- The win.
  if difficulty == "Easy" or difficulty == "Normal" then
    t9 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t9, "Have a Tokamak kit in storage.")
    t10 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t10, "Have a Structure Factory kit in storage.")
    t11 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t11, "Have a Smelter kit in storage.")
    t12 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t12, "Have a Command Center kit in storage.")
    t13 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t13, "Have an Agridome kit in storage.")
  elseif difficulty == "Hard" then
    t9 = trigger.count{type = "ConVec", cargo = "Tokamak", compare = ">=", count = 1, player = 1}
    mission.victory(t9, "Have a Tokamak kit in a ConVec.")
    t10 = trigger.count{type = "ConVec", cargo = "StructureFactory", compare = ">=", count = 1, player = 1}
    mission.victory(t10, "Have a Structure Factory kit in a ConVec.")
    t13 = trigger.count{type = "ConVec", cargo = "CommonOreSmelter", compare = ">=", count = 1, player = 1}
    mission.victory(t13, "Have a Smelter kit in a ConVec.")
    t11 = trigger.count{type = "ConVec", cargo = "CommandCenter", compare = ">=", count = 1, player = 1}
    mission.victory(t11, "Have a Command Center kit in a ConVec.")
    t12 = trigger.count{type = "ConVec", cargo = "Agridome", compare = ">=", count = 1, player = 1}
    mission.victory(t12, "Have an Agridome kit in a ConVec.")
  end
  local t8 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 2, player = 1}
  mission.victory(t8, "Have 2000 units of food in Cargo Trucks.")
  local t7 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 5, player = 1}
  mission.victory(t7, "Have 5000 units of Metals in Cargo Trucks.")
  local t21h
  if difficulty == "Hard" then
    t21h = trigger.count{type = "Lynx", compare = ">=", count = 5, player = 1}
    mission.victory(t21h, "Have 5 or more Lynx.")
    t23 = trigger.count{type = "Scout", compare = ">=", count = 3, player = 1}
    mission.victory(t23, "Have 3 or more Scouts.")
  end
  t6 = trigger.count{type = "RoboSurveyor", compare = ">=", count = 1, player = 1}
  mission.victory(t6, "Have 1 or more Robo-Surveyors.")
  local t26
  if difficulty == "Hard" then
    t26 = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
    mission.victory(t26, "Have 1 or more Robo-Miners.")
  end
  t5 = trigger.evac{player = 1}
  mission.victory(t5, "Have enough Evacuation Transports for your population.")
  local t25
  if difficulty == "Easy" or difficulty == "Normal" then
    t23 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t23, "Have 5 or more ConVecs.")
    t25 = trigger.research{tech = 3401, player = 1, one_shot = true, on = Teleoperations}
    mission.victory(t25, "Completely research Cybernetic Teleoperations.")
  end
  local t27 = trigger.research{tech = 3303, player = 1, one_shot = true}
  mission.victory(t27, "Completely research Health Maintenance.")
  local t29 = trigger.research{tech = 3301, player = 1, one_shot = true}
  mission.victory(t29, "Completely research Emergency Response Systems.")
  local t32 = trigger.resource{resource = "Scientists", compare = ">=", amount = 12, player = 1}
  mission.victory(t32, "Keep at least 12 scientists alive.")
  local t31, t33, t35
  if difficulty == "Easy" or difficulty == "Normal" then
    t31 = trigger.resource{resource = "Workers", compare = ">=", amount = 22, player = 1}
    mission.victory(t31, "Keep at least 22 workers alive.")
    t33 = trigger.resource{resource = "Kids", compare = ">=", amount = 32, player = 1}
    mission.victory(t33, "Keep at least 32 children alive.")
  elseif difficulty == "Hard" then
    t33 = trigger.resource{resource = "Workers", compare = ">=", amount = 20, player = 1}
    mission.victory(t33, "Keep at least 20 workers alive.")
    t35 = trigger.resource{resource = "Kids", compare = ">=", amount = 30, player = 1}
    mission.victory(t35, "Keep at least 30 children alive.")
  end
  local t48 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t48)
  trigger.time{min = 3600, max = 3800, on = Quake1}  -- after 36 to 38 marks
  trigger.time{min = 8400, max = 8600, on = Quake2}  -- after 84 to 86 marks
  trigger.time{min = 3600, max = 12000, on = Quake3}  -- after 36 to 120 marks
  trigger.time{min = 18000, max = 24000, on = Quake4}  -- after 180 to 240 marks
  trigger.time{min = 30000, max = 36000, on = Quake5}  -- after 300 to 360 marks
  trigger.count{type = "Lynx", compare = ">=", count = 4, player = 1, one_shot = true, on = Quake6}
  if difficulty == "Easy" then
    trigger.time{min = 7200, max = 21600, on = Storm1}  -- after 72 to 216 marks
    trigger.time{min = 12000, max = 24000, on = Storm2}  -- after 120 to 240 marks
    trigger.time{time = 35000, on = EruptLava}  -- after 350 marks
  elseif difficulty == "Normal" then
    trigger.time{min = 5500, max = 6500, one_shot = false, on = QuakeRepeater}  -- after 55 to 65 marks
    trigger.time{min = 22000, max = 24000, on = Quake7}  -- after 220 to 240 marks
    trigger.time{time = 35000, on = Quake8}  -- after 350 marks
    trigger.time{time = 9000, on = StormRepeaterStart}  -- after 90 marks
    trigger.time{time = 27000, on = EruptLava}  -- after 270 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 16000, on = Quake9}  -- after 160 marks
    trigger.time{time = 10800, on = QuakeHard}  -- after 108 marks
    trigger.time{time = 7000, on = StormRepeaterStart}  -- after 70 marks
    trigger.time{time = 34000, on = EruptLava}  -- after 340 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

