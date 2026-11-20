-- e07Lua.lua  -  Eden Mission #7 (Lua)
-- Trigger functions finished by hand (CheckForFail, RepeatWaves, RestorePeople), from the disassembly of e07.dll.
-- Converted by op2dll from e07.dll. With e07Lua.placement.lua (what every difficulty makes alike),
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
        workers = 31, scientists = 10, kids = 0, food = 2000, ore = 3000, rare_ore = 2000,
        research = { 7000 },
        tech_level = 6,
        view = { 66, 36 },
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
      { "Tube", { 51, 32 } }, { "Tube", { 51, 33 } }, { "Tube", { 51, 34 } }, { "Tube", { 51, 38 } },
      { "Tube", { 51, 39 } }, { "Tube", { 51, 40 } }, { "Tube", { 69, 44 } }, { "Tube", { 75, 32 } },
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 66, 36 } },
      { type = "Agridome", player = 1, at = { 66, 42 } },
      { type = "Tokamak", player = 1, at = { 72, 26 } },
      { type = "Tokamak", player = 1, at = { 90, 29 } },
      { type = "CommonOreSmelter", player = 1, at = { 59, 36 } },
      { type = "RareOreSmelter", player = 1, at = { 53, 36 } },
      { type = "RobotCommand", player = 1, at = { 72, 30 } },
      { type = "CommonStorage", player = 1, at = { 69, 42 } },
      { type = "RareStorage", player = 1, at = { 71, 42 } },
      { type = "VehicleFactory", player = 1, at = { 67, 30 } },
      { type = "Garage", player = 1, at = { 75, 30 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 49, 32 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 49, 40 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 62, 30 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 68, 45 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 76, 32 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "SouthWest", player = 1, at = { 80, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "West", player = 1, at = { 80, 35 } },
      { type = "RoboDozer", direction = "West", player = 1, at = { 59, 43 } },
      { type = "Earthworker", direction = "SouthWest", player = 1, at = { 69, 33 } },
      { type = "RepairVehicle", direction = "NorthEast", player = 1, at = { 85, 32 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 61, 31 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 61, 33 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 59, 31 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 59, 33 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 57, 33 } },
      { type = "RoboMiner", direction = "NorthEast", player = 1, at = { 70, 37 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 72, 37 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 70, 34 } },
      { type = "RoboMiner", direction = "NorthEast", player = 1, at = { 72, 34 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 73, 42 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthEast", player = 1, at = { 74, 40 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 76, 27 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 78, 29 } },
      { type = "Lynx", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 55, 42 } },
      { type = "Lynx", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 53, 40 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "SouthWest", player = 1, at = { 76, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "West", player = 1, at = { 78, 31 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "SouthWest", player = 1, at = { 78, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "West", player = 1, at = { 78, 35 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 14, 29 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 111, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 21, 45 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 21, 45 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 113, 24 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 38, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 78, 57 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 78, 57 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 46, 36 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 73, 44 }, beacon = true },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 31, scientists = 10, kids = 0, food = 2000, ore = 3000, rare_ore = 2000,
        research = { 7000 },
        tech_level = 6,
        view = { 66, 36 },
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
      { type = "CommandCenter", player = 1, at = { 66, 36 } },
      { type = "Agridome", player = 1, at = { 66, 42 } },
      { type = "Tokamak", player = 1, at = { 72, 26 } },
      { type = "Tokamak", player = 1, at = { 90, 29 } },
      { type = "CommonOreSmelter", player = 1, at = { 59, 36 } },
      { type = "RareOreSmelter", player = 1, at = { 53, 36 } },
      { type = "RobotCommand", player = 1, at = { 72, 30 } },
      { type = "CommonStorage", player = 1, at = { 69, 42 } },
      { type = "RareStorage", player = 1, at = { 71, 42 } },
      { type = "VehicleFactory", player = 1, at = { 67, 30 } },
      { type = "Garage", player = 1, at = { 75, 30 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 54, 32 } },
      { type = "GuardPost", weapon = "RailGun", player = 1, at = { 68, 45 } },
      { type = "GuardPost", weapon = "Laser", player = 1, at = { 77, 36 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "SouthWest", player = 1, at = { 80, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "West", player = 1, at = { 80, 35 } },
      { type = "Earthworker", direction = "SouthWest", player = 1, at = { 62, 39 } },
      { type = "RoboDozer", direction = "SouthWest", player = 1, at = { 73, 35 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 61, 31 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 61, 33 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 59, 31 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 59, 33 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 57, 33 } },
      { type = "RoboMiner", direction = "NorthEast", player = 1, at = { 70, 37 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 72, 37 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 70, 34 } },
      { type = "RoboMiner", direction = "NorthEast", player = 1, at = { 72, 34 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 73, 42 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthEast", player = 1, at = { 74, 40 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 76, 27 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 78, 29 } },
      { type = "Lynx", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 55, 42 } },
      { type = "Lynx", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 53, 40 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "SouthWest", player = 1, at = { 76, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "West", player = 1, at = { 78, 31 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "SouthWest", player = 1, at = { 78, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "West", player = 1, at = { 78, 35 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 22, 22 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 111, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 21, 45 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 21, 45 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 96, 36 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 78, 57 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 78, 57 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 46, 36 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 73, 44 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 31, scientists = 10, kids = 0, food = 2000, ore = 4000, rare_ore = 2000,
        research = { 7000 },
        tech_level = 6,
        view = { 66, 36 },
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
      { type = "CommandCenter", player = 1, at = { 66, 36 } },
      { type = "Agridome", player = 1, at = { 66, 42 } },
      { type = "Tokamak", player = 1, at = { 72, 26 } },
      { type = "CommonOreSmelter", player = 1, at = { 59, 36 } },
      { type = "RareOreSmelter", player = 1, at = { 53, 36 } },
      { type = "RobotCommand", player = 1, at = { 72, 30 } },
      { type = "CommonStorage", player = 1, at = { 69, 42 } },
      { type = "RareStorage", player = 1, at = { 71, 42 } },
      { type = "VehicleFactory", player = 1, at = { 67, 30 } },
      { type = "ConVec", weapon = "Garage", direction = "West", player = 1, at = { 76, 31 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "SouthWest", player = 1, at = { 80, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "West", player = 1, at = { 80, 35 } },
      { type = "Earthworker", direction = "SouthWest", player = 1, at = { 71, 36 } },
      { type = "Panther", weapon = "Laser", direction = "SouthWest", player = 1, at = { 47, 36 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 73, 37 } },
      { type = "Lynx", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 48, 44 } },
      { type = "Lynx", weapon = "RailGun", direction = "NorthWest", player = 1, at = { 51, 30 } },
      { type = "Lynx", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 63, 38 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 61, 31 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 61, 33 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 59, 31 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 59, 33 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 57, 33 } },
      { type = "RoboMiner", direction = "NorthEast", player = 1, at = { 70, 37 } },
      { type = "RoboMiner", direction = "East", player = 1, at = { 72, 37 } },
      { type = "RoboMiner", direction = "North", player = 1, at = { 70, 34 } },
      { type = "RoboMiner", direction = "NorthEast", player = 1, at = { 72, 34 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 73, 42 } },
      { type = "Lynx", weapon = "Laser", direction = "NorthEast", player = 1, at = { 74, 40 } },
      { type = "Panther", weapon = "RailGun", direction = "NorthEast", player = 1, at = { 76, 27 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 78, 29 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "SouthWest", player = 1, at = { 76, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "RailGun", direction = "West", player = 1, at = { 78, 31 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "SouthWest", player = 1, at = { 78, 33 } },
      { type = "ConVec", weapon = "GuardPost", topping = "Laser", direction = "West", player = 1, at = { 78, 35 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 59, 3 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 111, 5 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 21, 45 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 21, 45 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 98, 32 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 38, 54 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 38, 54 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 78, 57 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 46, 36 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 73, 44 }, beacon = true },
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

-- The human's workers, scientists and kids before the setup sets them (0x11009068 to 0x11009070), which
-- RestorePeople puts back.
local saved_people = {}

-- One player's start at the chosen difficulty.
function make_player(player, p)
  if p.tech_level then player:set_tech_level(p.tech_level) end
  for _, tech in ipairs(p.research) do player:mark_research(tech) end
  if p.workers then saved_people = { player.workers, player.scientists, player.kids } end
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
    { type = "Lynx", at = { 1, 11 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 14 }, weapon = "Microwave" },
    { type = "Panther", at = { 1, 17 }, weapon = "Microwave" },
  },
  [2] = {
    { type = "Lynx", at = { 128, 7 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 9 }, weapon = "Microwave" },
    { type = "Panther", at = { 128, 11 }, weapon = "Microwave" },
  },
  [3] = {
    { type = "Lynx", at = { 128, 7 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 9 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 9 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 11 }, weapon = "Microwave" },
    { type = "Panther", at = { 128, 11 }, weapon = "RPG" },
  },
  [4] = {
    { type = "Panther", at = { 52, 64 }, weapon = "Microwave" },
    { type = "Lynx", at = { 54, 64 }, weapon = "Microwave" },
    { type = "Lynx", at = { 56, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 58, 64 }, weapon = "EMP" },
    { type = "Panther", at = { 60, 64 }, weapon = "EMP" },
    { type = "Spider", at = { 60, 64 } },
    { type = "Spider", at = { 60, 64 } },
    { type = "Spider", at = { 60, 64 } },
  },
  [5] = {
    { type = "Panther", at = { 52, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 54, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 56, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 58, 64 }, weapon = "EMP" },
    { type = "Panther", at = { 60, 64 }, weapon = "EMP" },
    { type = "Spider", at = { 60, 64 } },
    { type = "Spider", at = { 60, 64 } },
    { type = "Spider", at = { 60, 64 } },
  },
  [6] = {
    { type = "Lynx", at = { 1, 9 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 11 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 14 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 17 }, weapon = "EMP" },
    { type = "Spider", at = { 1, 17 } },
    { type = "Spider", at = { 1, 17 } },
  },
  [7] = {
    { type = "Panther", at = { 1, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 4, 64 }, weapon = "Microwave" },
  },
  [8] = {
    { type = "Lynx", at = { 1, 9 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 11 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 14 }, weapon = "Microwave" },
    { type = "Lynx", at = { 1, 14 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 14 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 17 }, weapon = "EMP" },
    { type = "Spider", at = { 1, 17 } },
    { type = "Spider", at = { 1, 17 } },
    { type = "Spider", at = { 1, 17 } },
  },
  [9] = {
    { type = "Panther", at = { 128, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 119, 64 }, weapon = "Microwave" },
    { type = "Panther", at = { 124, 64 }, weapon = "EMP" },
    { type = "Spider", at = { 124, 64 } },
    { type = "Spider", at = { 124, 64 } },
  },
  [10] = {
    { type = "Lynx", at = { 128, 6 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 8 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 10 }, weapon = "Microwave" },
  },
  [11] = {
    { type = "Lynx", at = { 128, 6 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 8 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 10 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 10 }, weapon = "RPG" },
    { type = "Lynx", at = { 128, 10 }, weapon = "RPG" },
  },
  [12] = {
    { type = "Lynx", at = { 128, 7 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 7 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 9 }, weapon = "EMP" },
    { type = "Spider", at = { 128, 9 } },
    { type = "Spider", at = { 128, 9 } },
  },
  [13] = {
    { type = "Lynx", at = { 0, 64 }, weapon = "Microwave" },
    { type = "Lynx", at = { 2, 64 }, weapon = "Microwave" },
    { type = "Lynx", at = { 4, 64 }, weapon = "Microwave" },
  },
  [14] = {
    { type = "Lynx", at = { 4, 62 }, weapon = "Microwave" },
    { type = "Lynx", at = { 5, 62 }, weapon = "Microwave" },
    { type = "Lynx", at = { 4, 63 }, weapon = "Microwave" },
    { type = "Lynx", at = { 5, 63 }, weapon = "Microwave" },
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


-- RepeatWaves' two groups (0x11009074, 0x11009078), made at its first call: one attacks, the other guards it.
local repeat_attack, repeat_guard
-- Where a repeated wave comes from, by GetRand(5) (the jump table at 0x1100305C): x, y and its lights off Easy.
local REPEAT_FROM = { { 67, 63, true }, { 2, 22, true }, { 70, 2, true }, { 127, 11, true }, { 4, 63, false } }
-- The game's GetRand(0) still draws a number (and gives 0); game.rand(0) doesn't, so ask for GetRand(1).
local function draw(n) return game.rand(n > 0 and n or 1) end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Microbe, Quake1, Quake2, Quake3, Quake4, QuakeMed1, QuakeMed2, QuakeMed3, QuakeMed4, Storm1, Storm2, StormMedRepeater, StormMedStarter, Wave1Arrive, Wave2Arrive, Wave3AArrive, Wave3Arrive, Wave4Arrive, Wave5Arrive

function Microbe(t)
  game.create_blight({ 103, 64 })
  game.create_blight({ 103, 63 })
  game.create_blight({ 103, 62 })
  game.set_blight_speed(300)
  game.message_at("Microbe growth detected!", 152, 1, 4288, 2016)
end

function Quake1(t)
  game.create_earthquake({ 13, 16 }, 1)
end

function Quake2(t)
  game.create_earthquake({ 103, 6 }, 1)
end

function Quake3(t)
  game.create_earthquake({ 96, 23 }, 1)
end

function Quake4(t)
  game.create_earthquake({ 42, 34 }, 2)
end

function QuakeMed1(t)
  game.create_earthquake({ 45, 29 }, 1)
end

function QuakeMed2(t)
  game.create_earthquake({ 44, 38 }, 2)
end

function QuakeMed3(t)
  game.create_earthquake({ 23, 38 }, 2)
end

function QuakeMed4(t)
  game.create_earthquake({ 41, 44 }, 1)
end

function Storm1(t)
  local r1 = game.rand(15)
  local r2 = game.rand(5)
  local r3 = game.rand(20)
  game.create_lightning({ r3, r2 + 1 }, { 128, r1 + 51 }, 2)
end

function Storm2(t)
  local r1 = game.rand(15)
  local r2 = game.rand(5)
  local r3 = game.rand(10)
  game.create_lightning({ r3 + 119, r2 + 1 }, { 0, r1 + 51 }, 2)
end

function StormMedRepeater(t)
  local r1 = game.rand(63)
  local r2 = game.rand(25)
  game.create_lightning({ r2 + 103, r1 + 1 }, { 1, 32 }, 2)
end

function StormMedStarter(t)
  trigger.time{min = 3800, max = 4500, one_shot = false, on = StormMedRepeater}  -- after 38 to 45 marks
end

function Wave1Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:set_delete_when_empty(true)
    fight1:add_units(ai_block(13))
    fight1:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:set_delete_when_empty(true)
    fight1:add_units(ai_block(14))
    fight1:set_lights(false)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:set_delete_when_empty(true)
    fight1:add_units(ai_block(14))
    fight1:take_unit(game.create_unit{ type = "Lynx", player = ai_player, at = { 6, 62 }, weapon = "EMP", exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 1, 63 }, exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 2, 63 }, exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 3, 63 }, exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 3, 62 }, exact = true, lights = false }[1])
    fight1:set_lights(false)
  end
end

function Wave2Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(12))
    fight1:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 128, 9 }, exact = true, lights = false }[1])
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(12))
    fight1:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 128, 9 }, exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Lynx", player = ai_player, at = { 128, 9 }, weapon = "EMP", exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 128, 9 }, exact = true, lights = false }[1])
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(12))
    fight1:set_lights(true)
  end
end

function Wave3AArrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(10))
    fight1:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(11))
    fight1:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(11))
    fight1:set_lights(true)
  end
end

function Wave3Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(9))
    fight1:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 124, 64 }, exact = true, lights = false }[1])
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(9))
    fight1:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 124, 64 }, exact = true, lights = false }[1])
    fight1:take_unit(game.create_unit{ type = "Spider", player = ai_player, at = { 124, 64 }, exact = true, lights = false }[1])
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(9))
    fight1:set_lights(true)
  end
end

function Wave4Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(6))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_delete_when_empty(true)
    fight2:set_rect({ 59, 31, 79, 43 })
    fight2:add_units(ai_block(7))
    fight2:set_lights(true)
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(8))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_delete_when_empty(true)
    fight2:set_rect({ 59, 31, 79, 43 })
    fight2:add_units(ai_block(7))
    fight2:set_lights(true)
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(8))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_delete_when_empty(true)
    fight2:set_rect({ 59, 31, 79, 43 })
    fight2:add_units(ai_block(7))
    fight2:set_lights(true)
  end
end

function Wave5Arrive(t)
  if players[1].difficulty == "Easy" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(1))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_delete_when_empty(true)
    fight2:set_rect({ 59, 31, 79, 43 })
    fight2:add_units(ai_block(2))
    fight2:set_lights(true)
    trigger.time{min = 5400, max = 5900, one_shot = false, on = RepeatWaves}
  elseif players[1].difficulty == "Normal" then
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(3))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_delete_when_empty(true)
    fight2:set_rect({ 59, 31, 79, 43 })
    fight2:add_units(ai_block(4))
    fight2:set_lights(true)
    trigger.time{min = 6000, max = 6500, one_shot = false, on = RepeatWaves}
  else
    local fight1 = ai.fight_group(ai_player)
    fight1:do_attack_enemy()
    fight1:set_delete_when_empty(true)
    fight1:set_rect({ 59, 31, 79, 43 })
    fight1:add_units(ai_block(1))
    fight1:set_lights(true)
    local fight2 = ai.fight_group(ai_player)
    fight2:do_attack_enemy()
    fight2:set_delete_when_empty(true)
    fight2:set_rect({ 59, 31, 79, 43 })
    fight2:add_units(ai_block(3))
    fight2:set_lights(true)
    local fight3 = ai.fight_group(ai_player)
    fight3:do_attack_enemy()
    fight3:set_delete_when_empty(true)
    fight3:set_rect({ 59, 31, 79, 43 })
    fight3:add_units(ai_block(5))
    fight3:set_lights(true)
    trigger.time{min = 4800, max = 5300, one_shot = false, on = RepeatWaves}
  end
end

-- Every 40 ticks (0x11003070): no scientist, too few workers (10 on Easy, 11 otherwise), too little ore with no way to
-- mine more (Easy 10000 and 7500 rare; otherwise 12000, or no Common Storage, and 8000 rare) fails the colony.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = p.scientists < 1
  if p.difficulty == "Easy" then
    if p.workers < 10 then fail = true end
    if p.ore < 10000 and not p:can_accumulate_ore() then fail = true end
    if p.rare_ore < 7500 and not p:can_accumulate_rare_ore() then fail = true end
  else
    if p.workers < 11 then fail = true end
    if p.ore < 12000 then
      if not p:can_accumulate_ore() then fail = true end
      if #p:buildings("CommonStorage") == 0 then fail = true end
    end
    if p.rare_ore < 8000 and not p:can_accumulate_rare_ore() then fail = true end
  end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- A wave from one of five places drawn (0x11002D30): Panthers (Microwave) attacking the colony, and a guard of
-- Lynx (EMP) and Spider pairs, a Lynx (Microwave) and off Easy a Lynx and two Panthers (RPG) following them.
function RepeatWaves(t)
  if not repeat_attack then
    repeat_attack = ai.fight_group(ai_player)
    repeat_guard = ai.fight_group(ai_player)
  end
  repeat_attack:do_attack_enemy()
  repeat_attack:set_rect({ 59, 31, 79, 43 })
  repeat_guard:do_guard_group()
  repeat_guard:set_target_group(repeat_attack)
  repeat_guard:set_rect({ 59, 31, 79, 43 })
  local from = REPEAT_FROM[game.rand(5) + 1]
  local d = ({ Easy = 0, Normal = 1, Hard = 2 })[players[1].difficulty] or 1
  local panthers = draw(d * 2) + 2
  local escorts = draw(d * 2)
  if d == 1 then panthers = panthers - 1 end
  local function make(kind, weapon)
    return game.create_unit{ type = kind, player = ai_player, at = { from[1], from[2] }, weapon = weapon, exact = true, lights = false }[1]
  end
  for _ = 1, panthers do repeat_attack:take_unit(make("Panther", "Microwave")) end
  for _ = 1, escorts do
    repeat_guard:take_unit(make("Lynx", "EMP"))
    repeat_guard:take_unit(make("Spider"))
  end
  repeat_guard:take_unit(make("Lynx", "Microwave"))
  if d ~= 0 then
    repeat_guard:take_unit(make("Lynx", "RPG"))
    repeat_guard:take_unit(make("Panther", "RPG"))
    repeat_guard:take_unit(make("Panther", "RPG"))
  end
  local lights = d == 0 or from[3]
  repeat_attack:set_lights(lights)
  repeat_guard:set_lights(lights)
end

-- Both resource goals met: the human's colonists go back to what they were before the setup (0x11003490).
function RestorePeople(t)
  local p = players[1]
  p.workers, p.scientists, p.kids = saved_people[1], saved_people[2], saved_people[3]
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(false)
  if difficulty == "Easy" then game.morale_steady("Good") end
  if difficulty == "Normal" then game.morale_steady("Fair") end
  if difficulty == "Hard" then game.morale_steady("Fair") end

  -- The win.
  local t5, t7
  if difficulty == "Easy" then
    t5 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 10000}
    mission.victory(t5, "Have 10000 units of Common Metals in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 7500}
    mission.victory(t7, "Have 7500 units of Rare Metals in storage.")
  elseif difficulty == "Normal" or difficulty == "Hard" then
    t5 = trigger.resource{resource = "CommonOre", compare = ">=", amount = 12000}
    mission.victory(t5, "Have 12000 units of Common Metals in storage.")
    t7 = trigger.resource{resource = "RareOre", compare = ">=", amount = 8000}
    mission.victory(t7, "Have 8000 units of Rare Metals in storage.")
  trigger.set{t5, t7, needed = 2, one_shot = true, on = RestorePeople}
  end
  local t26 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t26)
  trigger.time{min = 14400, max = 16800, on = Quake1}  -- after 144 to 168 marks
  trigger.time{min = 16800, max = 19200, on = Quake2}  -- after 168 to 192 marks
  trigger.time{min = 30000, max = 32400, on = Quake3}  -- after 300 to 324 marks
  trigger.time{min = 46800, max = 49200, on = Quake4}  -- after 468 to 492 marks
  if difficulty == "Easy" then
    trigger.time{min = 7200, max = 9600, on = Storm1}  -- after 72 to 96 marks
    trigger.time{min = 67200, max = 69600, on = Storm2}  -- after 672 to 696 marks
  elseif difficulty == "Normal" or difficulty == "Hard" then
    trigger.time{min = 3000, max = 3800, on = QuakeMed1}  -- after 30 to 38 marks
    trigger.time{min = 7300, max = 7800, on = QuakeMed2}  -- after 73 to 78 marks
    trigger.time{min = 13000, max = 14000, on = QuakeMed3}  -- after 130 to 140 marks
    trigger.time{min = 17000, max = 17500, on = QuakeMed4}  -- after 170 to 175 marks
    trigger.time{min = 3400, max = 5800, on = StormMedStarter}  -- after 34 to 58 marks
  end
  trigger.time{time = 72000, on = Microbe}  -- after 720 marks
  if difficulty == "Easy" then
    trigger.time{min = 6000, max = 6500, on = Wave1Arrive}  -- after 60 to 65 marks
    trigger.time{min = 9000, max = 9500, on = Wave2Arrive}  -- after 90 to 95 marks
    trigger.time{min = 13000, max = 13500, on = Wave3Arrive}  -- after 130 to 135 marks
    trigger.time{min = 17000, max = 17500, on = Wave3AArrive}  -- after 170 to 175 marks
    trigger.time{min = 22000, max = 22500, on = Wave4Arrive}  -- after 220 to 225 marks
    trigger.time{min = 27000, max = 27500, on = Wave5Arrive}  -- after 270 to 275 marks
  elseif difficulty == "Normal" then
    trigger.time{min = 9000, max = 9500, on = Wave1Arrive}  -- after 90 to 95 marks
    trigger.time{min = 13800, max = 14300, on = Wave2Arrive}  -- after 138 to 143 marks
    trigger.time{min = 18600, max = 19100, on = Wave3Arrive}  -- after 186 to 191 marks
    trigger.time{min = 22000, max = 22500, on = Wave3AArrive}  -- after 220 to 225 marks
    trigger.time{min = 28400, max = 28900, on = Wave4Arrive}  -- after 284 to 289 marks
    trigger.time{min = 33200, max = 33700, on = Wave5Arrive}  -- after 332 to 337 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 6000, max = 6500, on = Wave1Arrive}  -- after 60 to 65 marks
    trigger.time{min = 11000, max = 11500, on = Wave2Arrive}  -- after 110 to 115 marks
    trigger.time{min = 16000, max = 16500, on = Wave3Arrive}  -- after 160 to 165 marks
    trigger.time{min = 21000, max = 21500, on = Wave3AArrive}  -- after 210 to 215 marks
    trigger.time{min = 25000, max = 25500, on = Wave4Arrive}  -- after 250 to 255 marks
    trigger.time{min = 30000, max = 30500, on = Wave5Arrive}  -- after 300 to 305 marks
  end
  players[2]:default_group():set_rect({ 0, 63, 4, 64 })
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
end

-- Not converted:
-- - trigger #9 calls RestorePeople, but isn't converted: its member trigger #5 isn't converted
