-- p10Lua.lua  -  Plymouth Mission #10 (Lua)
-- Trigger functions finished by hand (PartsGrabbed, PeopleGrabbed1, PeopleGrabbed2, CheckForLoss, MineGuardToHuntTrucks, MineGuardToHuntEvacs, ReinforceFromGarage, ReinforceP, MoreReinforce, GiveOre, GoBanzia, CheckForFail, Lab1DeadCheck, Lab2DeadCheck, Lab3DeadCheck, RestoreOre), from the disassembly of p10.dll.
-- Converted by op2dll from p10.dll. With p10Lua.placement.lua (what every difficulty makes alike),
-- this makes the colony's start: what changes with the difficulty, and the beacons the setup rolls.
-- Games run: Easy 213, Normal 321, Hard 459.
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
        ore = 0,
        research = { 10000 },
        tech_level = 9,
        view = { 7, 81 },
        units = {
        },
      },
      [2] = {
        workers = 55, scientists = 55, food = 16000, ore = 30000, rare_ore = 4000,
        research = {  },
        tech_level = 10,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 106, 16 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 16, 17 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 65, 100 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 24, 125 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 15 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 12, 61 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 56, 76 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 18, 27 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 7, 79 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 7, 81 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 9, 79 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 9, 81 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 6, 83 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 8, 83 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 8, 77 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 10, 77 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 6, 77 } },
      { type = "Panther", weapon = "Stickyfoam", direction = "East", player = 1, at = { 13, 79 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 5, 72 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 7, 72 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 9, 72 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 5, 74 } },
      { type = "Lynx", weapon = "Starflare", direction = "East", player = 1, at = { 7, 74 } },
      { type = "Lynx", weapon = "Starflare", direction = "East", player = 1, at = { 9, 74 } },
      { type = "Lynx", weapon = "Supernova", direction = "East", player = 1, at = { 10, 83 } },
      { type = "Tiger", weapon = "ESG", direction = "East", player = 1, at = { 2, 79 } },
      { type = "Lynx", weapon = "ESG", direction = "East", player = 1, at = { 3, 77 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 13, 81 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 17, 80 } },
      { type = "Tiger", weapon = "EMP", direction = "East", player = 1, at = { 4, 79 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "East", player = 1, at = { 4, 88 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Spider", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Spider", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Panther", weapon = "ESG", direction = "East", player = 1, at = { 15, 79 } },
      { type = "Panther", weapon = "Supernova", direction = "East", player = 1, at = { 15, 81 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 4, 81 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 4, 90 } },
      { type = "Lynx", weapon = "ESG", direction = "East", player = 1, at = { 6, 87 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        ore = 0,
        research = { 10000 },
        tech_level = 9,
        view = { 7, 81 },
        units = {
        },
      },
      [2] = {
        workers = 55, scientists = 55, food = 16000, ore = 30000, rare_ore = 4000,
        research = {  },
        tech_level = 10,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 106, 16 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 16, 17 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 65, 100 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 24, 125 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 15 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 12, 61 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 56, 76 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 18, 27 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 7, 79 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 7, 81 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 9, 79 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 9, 81 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 6, 83 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 8, 83 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 8, 77 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 10, 77 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 6, 77 } },
      { type = "Panther", weapon = "Stickyfoam", direction = "East", player = 1, at = { 13, 79 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Lynx", weapon = "Supernova", direction = "East", player = 1, at = { 10, 83 } },
      { type = "Tiger", weapon = "ESG", direction = "East", player = 1, at = { 2, 79 } },
      { type = "Lynx", weapon = "ESG", direction = "East", player = 1, at = { 3, 77 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 13, 81 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 17, 80 } },
      { type = "Tiger", weapon = "EMP", direction = "East", player = 1, at = { 4, 79 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "East", player = 1, at = { 4, 88 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Spider", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Spider", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Panther", weapon = "ESG", direction = "East", player = 1, at = { 15, 79 } },
      { type = "Panther", weapon = "Supernova", direction = "East", player = 1, at = { 15, 81 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 4, 81 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 4, 90 } },
      { type = "Lynx", weapon = "ESG", direction = "East", player = 1, at = { 6, 87 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        ore = 0,
        research = { 10000 },
        tech_level = 9,
        view = { 7, 81 },
        units = {
        },
      },
      [2] = {
        workers = 55, scientists = 55, food = 16000, ore = 30000, rare_ore = 4000,
        research = {  },
        tech_level = 10,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 72, 52 } }, { "Tube", { 91, 53 } }, { "Tube", { 92, 53 } }, { "Tube", { 112, 81 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 106, 16 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 16, 17 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 65, 100 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 24, 125 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 52, 15 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 12, 61 }, beacon = true },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 28, 4 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 56, 76 }, beacon = true },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 18, 27 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 7, 79 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 7, 81 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 9, 79 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 9, 81 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 6, 83 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 8, 83 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 8, 77 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 10, 77 } },
      { type = "Lynx", weapon = "RPG", direction = "East", player = 1, at = { 6, 77 } },
      { type = "Panther", weapon = "Stickyfoam", direction = "East", player = 1, at = { 13, 79 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Spider", direction = "East", player = 1, at = { 2, 81 } },
      { type = "Lynx", weapon = "Supernova", direction = "East", player = 1, at = { 10, 83 } },
      { type = "Tiger", weapon = "ESG", direction = "East", player = 1, at = { 2, 79 } },
      { type = "Lynx", weapon = "ESG", direction = "East", player = 1, at = { 3, 77 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 13, 81 } },
      { type = "Panther", weapon = "RPG", direction = "East", player = 1, at = { 17, 80 } },
      { type = "Tiger", weapon = "EMP", direction = "East", player = 1, at = { 4, 79 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "East", player = 1, at = { 4, 88 } },
      { type = "Lynx", weapon = "EMP", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Spider", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Spider", direction = "East", player = 1, at = { 5, 89 } },
      { type = "Panther", weapon = "ESG", direction = "East", player = 1, at = { 15, 79 } },
      { type = "Panther", weapon = "Supernova", direction = "East", player = 1, at = { 15, 81 } },
      { type = "Tiger", weapon = "RPG", direction = "East", player = 1, at = { 4, 81 } },
      { type = "Lynx", weapon = "Microwave", direction = "East", player = 1, at = { 4, 90 } },
      { type = "Lynx", weapon = "ESG", direction = "East", player = 1, at = { 6, 87 } },
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
    { type = "CommandCenter", at = { 98, 53 } },
    { type = "StructureFactory", at = { 93, 40 } },
    { type = "VehicleFactory", at = { 93, 47 } },
    { type = "VehicleFactory", at = { 80, 69 } },
    { type = "StructureFactory", at = { 117, 72 } },
    { type = "Earthworker", at = { 91, 85 } },
    { type = "ConVec", at = { 119, 75 } },
    { type = "ConVec", at = { 121, 75 } },
    { type = "ConVec", at = { 91, 43 } },
    { type = "CommandCenter", at = { 80, 58 } },
  },
  [2] = {
    { type = "Garage", at = { 112, 79 } },
    { type = "Garage", at = { 82, 41 } },
    { type = "Garage", at = { 78, 76 } },
    { type = "Garage", at = { 85, 76 } },
  },
  [3] = {
    { type = "Agridome", at = { 103, 46 } },
    { type = "Agridome", at = { 103, 40 } },
    { type = "Nursery", at = { 111, 46 } },
    { type = "Residence", at = { 111, 52 } },
    { type = "Residence", at = { 111, 40 } },
    { type = "CommonStorage", at = { 112, 60 } },
    { type = "RareStorage", at = { 88, 60 } },
    { type = "Tokamak", at = { 84, 37 } },
    { type = "MedicalCenter", at = { 117, 46 } },
    { type = "Observatory", at = { 73, 36 } },
    { type = "GeothermalPlant", at = { 80, 62 } },
    { type = "GORF", at = { 122, 50 } },
    { type = "RecreationFacility", at = { 119, 60 } },
    { type = "RecreationFacility", at = { 125, 60 } },
    { type = "University", at = { 119, 55 } },
    { type = "RobotCommand", at = { 111, 35 } },
    { type = "StandardLab", at = { 88, 82 } },
    { type = "DIRT", at = { 107, 68 } },
    { type = "DIRT", at = { 76, 41 } },
    { type = "MedicalCenter", at = { 106, 82 } },
    { type = "University", at = { 94, 82 } },
    { type = "RareStorage", at = { 99, 60 } },
    { type = "CommonStorage", at = { 112, 56 } },
    { type = "ConsumerFactory", at = { 125, 66 } },
    { type = "Tokamak", at = { 126, 82 } },
    { type = "Agridome", at = { 125, 73 } },
    { type = "Agridome", at = { 125, 77 } },
    { type = "CommonStorage", at = { 109, 55 } },
    { type = "RecreationFacility", at = { 97, 69 } },
    { type = "RareStorage", at = { 72, 47 } },
    { type = "RareStorage", at = { 72, 50 } },
    { type = "CommonStorage", at = { 87, 47 } },
    { type = "CommonStorage", at = { 87, 50 } },
    { type = "RoboDozer", at = { 95, 43 } },
    { type = "EvacuationTransport", at = { 100, 54 } },
    { type = "EvacuationTransport", at = { 81, 60 } },
    { type = "Scout", at = { 76, 76 } },
    { type = "RoboSurveyor", at = { 82, 70 } },
    { type = "Earthworker", at = { 95, 48 } },
  },
  [4] = {
    { type = "GuardPost", at = { 89, 53 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 100, 65 }, weapon = "EMP" },
    { type = "GuardPost", at = { 86, 43 }, weapon = "Laser" },
    { type = "GuardPost", at = { 105, 51 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 125, 43 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 117, 40 }, weapon = "EMP" },
    { type = "GuardPost", at = { 115, 34 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 117, 66 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 88, 66 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 73, 43 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 72, 53 }, weapon = "Laser" },
    { type = "GuardPost", at = { 66, 63 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 71, 29 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 66, 71 }, weapon = "EMP" },
    { type = "GuardPost", at = { 100, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 91, 75 }, weapon = "EMP" },
    { type = "GuardPost", at = { 109, 75 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 78, 84 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 84, 84 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 119, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 98, 37 }, weapon = "AcidCloud" },
  },
  [5] = {
    { type = "GuardPost", at = { 84, 54 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 80, 45 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 100, 71 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 100, 79 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 124, 30 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 123, 38 }, weapon = "RailGun" },
  },
  [6] = {
    { type = "GuardPost", at = { 89, 53 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 100, 65 }, weapon = "EMP" },
    { type = "GuardPost", at = { 86, 43 }, weapon = "Laser" },
    { type = "GuardPost", at = { 105, 51 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 125, 43 }, weapon = "EMP" },
    { type = "GuardPost", at = { 117, 40 }, weapon = "EMP" },
    { type = "GuardPost", at = { 115, 34 }, weapon = "EMP" },
    { type = "GuardPost", at = { 117, 66 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 88, 66 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 73, 43 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 72, 53 }, weapon = "Laser" },
    { type = "GuardPost", at = { 66, 63 }, weapon = "EMP" },
    { type = "GuardPost", at = { 71, 29 }, weapon = "EMP" },
    { type = "GuardPost", at = { 66, 71 }, weapon = "EMP" },
    { type = "GuardPost", at = { 100, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 91, 75 }, weapon = "EMP" },
    { type = "GuardPost", at = { 109, 75 }, weapon = "EMP" },
    { type = "GuardPost", at = { 78, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 119, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 98, 37 }, weapon = "RailGun" },
  },
  [7] = {
    { type = "GeothermalPlant", at = { 119, 3 } },
    { type = "GeothermalPlant", at = { 121, 68 } },
  },
  [8] = {
    { type = "GuardPost", at = { 89, 53 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 100, 65 }, weapon = "EMP" },
    { type = "GuardPost", at = { 86, 43 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 105, 51 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 125, 43 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 117, 40 }, weapon = "EMP" },
    { type = "GuardPost", at = { 115, 34 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 117, 66 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 88, 66 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 73, 43 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 72, 53 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 66, 63 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 71, 29 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 66, 71 }, weapon = "EMP" },
    { type = "GuardPost", at = { 100, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 91, 75 }, weapon = "EMP" },
    { type = "GuardPost", at = { 109, 75 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 78, 84 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 84, 84 }, weapon = "ThorsHammer" },
    { type = "GuardPost", at = { 119, 84 }, weapon = "EMP" },
    { type = "GuardPost", at = { 98, 37 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 112, 82 }, weapon = "ThorsHammer" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
-- A unit of a type on a tile (one the setup made, which a group's call names).
local function unit_at(kind, at)
  for _, u in ipairs(game.units_in_rect({ at[1], at[2], at[1], at[2] })) do
    if u.type == kind then return u end
  end
end
local ai_player, ai_base1, ai_fight1, ai_fight2, ai_fight3, ai_mining1, ai_fight4, ai_mining2, ai_fight5, ai_mining3, ai_fight6, ai_mining4, ai_fight7, ai_fight8, ai_fight9

-- The Spaceport and the two Advanced Labs (0x1100BE58, 0x1100BE50, 0x1100BE54).
local u54, u55, u56
-- Each mine's escort (0x11004EE0): its targets by difficulty (0x11008000, 0x11008010, 0x11008020), then on the
-- smelter's tile a draw of up to twice the target of Acid Cloud and of EMP Panthers, and 1 to twice the target of
-- Rail Gun Panthers (one fewer on Normal).
local ESCORT = { Easy = { 0, 1, 1 }, Normal = { 0, 1, 2 }, Hard = { 1, 2, 2 } }
local function escort_units(g, at)
  local n = ESCORT[players[1].difficulty] or ESCORT.Normal
  g:set_targ_count("Panther", "AcidCloud", n[1])
  g:set_targ_count("Panther", "EMP", n[2])
  g:set_targ_count("Panther", "RailGun", n[3])
  local function panthers(weapon, k)
    for _ = 1, k do
      g:take_unit(game.create_unit{type = "Panther", weapon = weapon, player = ai_player, at = at, exact = true, lights = false}[1])
    end
  end
  panthers("AcidCloud", game.rand(2 * n[1] + 1))
  panthers("EMP", game.rand(2 * n[2] + 1))
  local rail = game.rand(2 * n[3]) + 1
  if players[1].difficulty == "Normal" then rail = rail - 1 end
  panthers("RailGun", rail)
end

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_eden()
  p.workers = 55
  p.scientists = 55
  p.food = 16000
  p.ore = 30000
  p.rare_ore = 4000
  p:set_tech_level(10)
  ai_base1 = ai.building_group(p)
  ai_base1:set_rect({ 73, 39, 126, 78 })
  ai_base1:add_units(ai_block(1))
  ai_base1:record_unit_block(ai_block(1), ai_base1)
  ai_base1:record_veh_reinforce_group(ai_base1, 1000)
  ai_base1:set_targ_counts(ai_block(1))
  ai_fight1 = ai.fight_group(p)
  ai_fight1:set_rect({ 70, 41, 90, 59 })
  u54 = game.create_unit{ type = "Spaceport", player = p, at = { 80, 50 }, exact = true, lights = false }[1]
  ai_fight1:take_unit(u54)
  ai_fight2 = ai.fight_group(p)
  ai_fight2:set_rect({ 117, 29, 127, 39 })
  u55 = game.create_unit{ type = "AdvancedLab", player = p, at = { 123, 34 }, exact = true, lights = false }[1]
  ai_fight2:take_unit(u55)
  ai_fight3 = ai.fight_group(p)
  u56 = game.create_unit{ type = "AdvancedLab", player = p, at = { 100, 75 }, exact = true, lights = false }[1]
  ai_fight3:take_unit(u56)
  ai_fight3:set_rect({ 95, 70, 107, 80 })
  u55:set_opp_fired_upon(false)
  u56:set_opp_fired_upon(false)
  u54:set_opp_fired_upon(false)
  ai_block(2):create_units(p, true)
  if difficulty == "Hard" then
    ai_block(7):create_units(p, true)
  end
  ai_block(3):create_units(p, true)
  ai_base1:record_unit_block(ai_block(3))
  if difficulty == "Easy" then
    ai_block(6):create_units(p, true)
    ai_base1:record_unit_block(ai_block(6))
  elseif difficulty == "Normal" then
    ai_block(4):create_units(p, true)
    ai_base1:record_unit_block(ai_block(4))
  elseif difficulty == "Hard" then
    ai_block(8):create_units(p, true)
    ai_base1:record_unit_block(ai_block(8))
  end
  ai_base1:record_unit_block(ai_block(5))
  game.create_unit{ type = "CommonOreSmelter", player = p, at = { 107, 60 }, exact = true, lights = false }
  game.create_unit{ type = "RareOreSmelter", player = p, at = { 94, 60 }, exact = true, lights = false }
  ai_mining1 = ai.mining_group(p)
  ai_mining1:take_unit(game.create_unit{ type = "CommonOreMine", player = p, at = { 106, 16 }, exact = true, lights = false }[1])
  ai_base1:record_building({ 106, 16 }, "CommonOreMine")
  ai_mining1:setup(unit_at("CommonOreMine", { 106, 16 }), unit_at("CommonOreSmelter", { 107, 60 }), { 113, 54, 117, 59 })
  ai_mining1:set_targ_count("CargoTruck", nil, 2)
  ai_base1:record_veh_reinforce_group(ai_mining1, 10)
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 106, 16 }, exact = true, lights = false }[1])
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 96, 26 }, exact = true, lights = false }[1])
  ai_mining1:set_lights(true)
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_guard_group()
  ai_fight4:set_target_group(ai_mining1)
  ai_fight4:set_follow_mode(0)
  ai_fight4:set_patrol({ { 108, 13 }, { 83, 25 }, { 106, 25 } }, 2)
  ai_fight4:set_rect({ 101, 11, 111, 21 })
  escort_units(ai_fight4, { 107, 60 })
  ai_base1:record_veh_reinforce_group(ai_fight4, 1)
  ai_fight4:set_lights(true)
  ai_mining2 = ai.mining_group(p)
  ai_mining2:take_unit(game.create_unit{ type = "CommonOreMine", player = p, at = { 16, 17 }, exact = true, lights = false }[1])
  ai_base1:record_building({ 16, 17 }, "CommonOreMine")
  ai_mining2:setup(unit_at("CommonOreMine", { 16, 17 }), unit_at("CommonOreSmelter", { 107, 60 }), { 113, 54, 117, 59 })
  ai_mining2:set_targ_count("CargoTruck", nil, 2)
  ai_base1:record_veh_reinforce_group(ai_mining2, 10)
  ai_mining2:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 16, 17 }, exact = true, lights = false }[1])
  ai_mining2:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 26, 27 }, exact = true, lights = false }[1])
  ai_mining2:set_lights(true)
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_group()
  ai_fight5:set_target_group(ai_mining2)
  ai_fight5:set_follow_mode(0)
  ai_fight5:set_patrol({ { 14, 16 }, { 32, 18 }, { 19, 32 }, { 6, 24 } }, 3)
  ai_fight5:set_rect({ 11, 12, 21, 22 })
  escort_units(ai_fight5, { 107, 60 })
  ai_base1:record_veh_reinforce_group(ai_fight5, 1)
  ai_fight5:set_lights(true)
  ai_mining3 = ai.mining_group(p)
  ai_mining3:take_unit(game.create_unit{ type = "CommonOreMine", player = p, at = { 65, 100 }, exact = true, lights = false }[1])
  ai_base1:record_building({ 65, 100 }, "CommonOreMine")
  ai_mining3:setup(unit_at("CommonOreMine", { 65, 100 }), unit_at("CommonOreSmelter", { 107, 60 }), { 113, 54, 117, 59 })
  ai_mining3:set_targ_count("CargoTruck", nil, 2)
  ai_base1:record_veh_reinforce_group(ai_mining3, 10)
  ai_mining3:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 65, 90 }, exact = true, lights = false }[1])
  ai_mining3:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 65, 100 }, exact = true, lights = false }[1])
  ai_mining3:set_lights(true)
  ai_fight6 = ai.fight_group(p)
  ai_fight6:do_guard_group()
  ai_fight6:set_target_group(ai_mining3)
  ai_fight6:set_follow_mode(0)
  ai_fight6:set_patrol({ { 66, 101 }, { 53, 104 }, { 82, 85 } }, 2)
  ai_fight6:set_rect({ 60, 95, 70, 105 })
  escort_units(ai_fight6, { 107, 60 })
  ai_base1:record_veh_reinforce_group(ai_fight6, 1)
  ai_fight6:set_lights(true)
  ai_mining4 = ai.mining_group(p)
  ai_mining4:take_unit(game.create_unit{ type = "CommonOreMine", player = p, at = { 24, 125 }, exact = true, lights = false }[1])
  ai_base1:record_building({ 24, 125 }, "CommonOreMine")
  ai_mining4:setup(unit_at("RareOreMine", { 24, 125 }), unit_at("RareOreSmelter", { 94, 60 }), { 91, 57, 97, 65 })
  ai_mining4:set_targ_count("CargoTruck", nil, 2)
  ai_base1:record_veh_reinforce_group(ai_mining4, 10)
  ai_mining4:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 14, 135 }, exact = true, lights = false }[1])
  ai_mining4:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 34, 115 }, exact = true, lights = false }[1])
  ai_mining4:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 24, 125 }, exact = true, lights = false }[1])
  ai_mining4:set_lights(true)
  ai_fight7 = ai.fight_group(p)
  ai_fight7:do_guard_group()
  ai_fight7:set_target_group(ai_mining4)
  ai_fight7:set_follow_mode(0)
  ai_fight7:set_patrol({ { 21, 128 }, { 40, 109 }, { 20, 115 }, { 32, 125 } }, 3)
  ai_fight7:set_rect({ 9, 120, 19, 128 })
  escort_units(ai_fight7, { 94, 60 })
  ai_base1:record_veh_reinforce_group(ai_fight7, 1)
  ai_fight7:set_lights(true)
  ai_fight8 = ai.fight_group(p)
  ai_fight8:do_guard_rect()
  ai_fight8:set_rect({ 71, 34, 127, 82 })
  if difficulty == "Easy" then
    ai_fight8:set_targ_count("Tiger", "RailGun", 3)
    ai_fight8:set_targ_count("Lynx", "RailGun", 4)
    ai_fight8:set_targ_count("Panther", "Laser", 4)
  elseif difficulty == "Normal" then
    ai_fight8:set_targ_count("Tiger", "RailGun", 8)
    ai_fight8:set_targ_count("Panther", "RailGun", 8)
    ai_fight8:set_targ_count("Panther", "Laser", 8)
  elseif difficulty == "Hard" then
    ai_fight8:set_targ_count("Tiger", "RailGun", 8)
    ai_fight8:set_targ_count("Panther", "RailGun", 8)
    ai_fight8:set_targ_count("Panther", "Laser", 6)
    ai_fight8:set_targ_count("Panther", "AcidCloud", 6)
  end
  ai_base1:record_veh_reinforce_group(ai_fight8, 4)
  ai_fight9 = ai.fight_group(p)
  ai_fight9:do_guard_group()
  ai_fight9:set_rect({ 71, 34, 127, 82 })
  ai_fight9:set_target_group(ai_fight8)
  ai_fight9:set_follow_mode(0)
  if difficulty == "Easy" then
    ai_fight9:set_targ_count("Lynx", "EMP", 4)
    ai_fight9:set_targ_count("Panther", "EMP", 3)
    ai_fight9:set_targ_count("Lynx", "RailGun", 4)
  elseif difficulty == "Normal" then
    ai_fight9:set_targ_count("Lynx", "EMP", 8)
    ai_fight9:set_targ_count("Panther", "EMP", 8)
    ai_fight9:set_targ_count("Lynx", "RailGun", 8)
  elseif difficulty == "Hard" then
    ai_fight9:set_targ_count("Lynx", "EMP", 8)
    ai_fight9:set_targ_count("Panther", "EMP", 8)
    ai_fight9:set_targ_count("Lynx", "RailGun", 8)
    ai_fight8:set_targ_count("Panther", "AcidCloud", 8)
  end
  ai_base1:record_veh_reinforce_group(ai_fight9, 3)
end


-- The escape triggers RestoreOre reads (0x1100BE8C, 0x1100BE90).
local t19, t22
-- The player's ore when the setup starts (0x1100BE94; RestoreOre gives it back) and the research that chooses the
-- convoys' weapons (0x1100BE10: 8203, 0x1100BE14: 7103).
local saved_ore, has_8203, has_7103
-- The player's two Evacuation Transports (0x1100BE5C, 0x1100BE60).
local evacs = {}
-- Starship parts loaded (0x1100BE18), groups of scientists taken (0x1100BE1C), ReinforceFromGarage's waves
-- (0x1100BE20).
local parts, people, garage_waves = 0, 0, 0
-- The special targets (0x1100BE6C: the Spaceport, 0x1100BE64 and 0x1100BE68: the labs), MoreReinforce's three
-- triggers (0x1100BE74 to 0x1100BE7C), the lab checks (0x1100BE80 to 0x1100BE88) and ReinforceFromGarage's timer
-- (0x1100BE70).
local parts_target, people_target1, people_target2, garage_reinforce
local more_triggers, lab_checks = {}, {}
-- Where the mine guards hunt (0x11004A70) and where the all-attack aims (0x1100BE00).
local HUNT_RECT = { 63, 62, 73, 71 }
local BASE_RECT = { 71, 34, 127, 82 }
-- ReinforceFromGarage's draws (0x1100A8D8 to 0x1100A924): a weapon, then a type.
local GARAGE_UNITS = {
  Easy = { weapons = { "Laser", "Laser", "Laser", "EMP", "RailGun", "AcidCloud" },
           types = { "Lynx", "Lynx", "Lynx", "Panther", "Panther", "Tiger" } },
  other = { weapons = { "EMP", "RailGun", "AcidCloud" }, types = { "Lynx", "Panther", "Tiger" } },
}
-- The reinforcement convoy (0x11001BA0): seven always, then five whose weapons the research picks; each with its
-- type, weapon and tile (the convoy's start).
local CONVOY = {
  { "Panther", "RPG", 13, 81 }, { "Panther", "RPG", 17, 80 }, { "Tiger", "EMP", 4, 79 }, { "Lynx", "Stickyfoam", 4, 88 },
  { "Lynx", "EMP", 5, 89 }, { "Spider", nil, 5, 89 }, { "Spider", nil, 5, 89 },
}
local CONVOY_AT = { { "Panther", 15, 79 }, { "Panther", 15, 81 }, { "Tiger", 4, 81 }, { "Lynx", 4, 90 }, { "Lynx", 6, 87 } }
local CONVOY_WEAPONS = {
  both = { "ESG", "Supernova", "RPG", "Microwave", "ESG" },
  only_8203 = { "RPG", "Supernova", "RPG", "Microwave", "Supernova" },
  only_7103 = { "ESG", "Stickyfoam", "RPG", "ESG", "Microwave" },
  none = { "RPG", "Stickyfoam", "RPG", "Microwave", "Microwave" },
}
local function convoy()
  for _, u in ipairs(CONVOY) do
    game.create_unit{type = u[1], weapon = u[2], player = 1, at = { u[3], u[4] }, exact = true}
  end
  local kind = has_8203 and (has_7103 and "both" or "only_8203") or (has_7103 and "only_7103" or "none")
  for i, u in ipairs(CONVOY_AT) do
    game.create_unit{type = u[1], weapon = CONVOY_WEAPONS[kind][i], player = 1, at = { u[2], u[3] }, exact = true}
  end
  game.message_at("Reinforcements have arrived!", 162, players[1], 1408, 2560)
end
-- Every group of the base attacks (0x11006110), and the Garages' reinforcements start (once).
local function all_attack()
  local groups = { ai_fight8, ai_fight9, ai_fight2, ai_fight3, ai_fight1 }
  for _, g in ipairs(groups) do g:do_attack_enemy() end
  for _, g in ipairs(groups) do g:set_rect(BASE_RECT) end
  if not garage_reinforce then
    garage_reinforce = trigger.time{min = 100, max = 200, one_shot = false, on = ReinforceFromGarage}
  end
end
-- The mine guards hunt one kind of vehicle by the base (0x11004A70, 0x11004B20).
local function hunt(kind)
  for _, g in ipairs({ ai_fight4, ai_fight5, ai_fight6, ai_fight7 }) do
    g:do_attack_enemy()
    g:set_attack_type(kind)
    g:set_rect(HUNT_RECT)
  end
end
-- A unit of the player's on a tile (or the nearest within two), as the setup made it.
local function find_unit(kind, x, y)
  for r = 0, 2 do
    for _, u in ipairs(game.units_in_rect({ x - r, y - r, x + r, y + r })) do
      if u.type == kind and u.owner == 0 then return u end
    end
  end
end

-- A Cargo Truck at the Spaceport (0x11004930), up to twice: it loads a starship part; after the first, CheckForLoss
-- every 40 ticks; after the second the Spaceport is no longer a target or checked, may be fired upon, and with both
-- groups of scientists taken the base attacks, else the mine guards hunt trucks 1200 to 2400 ticks later.
function PartsGrabbed(t)
  if parts >= 2 then return end
  game.message_at("Wreckage loaded.", 176, nil, -1, -1)
  parts_target:special_target_unit():set_cargo("Wreckage", 8801)
  parts = parts + 1
  if parts == 1 then trigger.time{time = 40, one_shot = false, on = CheckForLoss} end
  if parts ~= 2 then return end
  if parts_target.valid then parts_target:disable() end
  if u54.alive then u54:clear_special_target() end
  lab_checks[3]:disable()
  u54:set_opp_fired_upon(true)
  if people == 2 then
    all_attack()
  else
    trigger.time{min = 1200, max = 2400, on = MineGuardToHuntTrucks}
  end
end

-- An Evacuation Transport at the lab at 123,34 (0x11004D10): it takes the scientists, the lab is no longer checked
-- and may be fired upon; with both groups taken the base attacks if both parts are loaded, else the mine guards hunt
-- transports 1200 to 2400 ticks later.
function PeopleGrabbed1(t)
  game.message_at("Scientists Captured!", 0, nil, -1, -1)
  people_target1:special_target_unit():set_kit("Agridome")
  lab_checks[1]:disable()
  u55:set_opp_fired_upon(true)
  people = people + 1
  if people ~= 2 then return end
  if parts == 2 then
    all_attack()
  else
    trigger.time{min = 1200, max = 2400, on = MineGuardToHuntEvacs}
  end
end

-- The same at the lab at 100,75 (0x11004DC0).
function PeopleGrabbed2(t)
  game.message_at("Scientists Captured!", 0, nil, -1, -1)
  people_target2:special_target_unit():set_kit("Agridome")
  lab_checks[2]:disable()
  u56:set_opp_fired_upon(true)
  people = people + 1
  if people ~= 2 then return end
  if parts == 2 then
    all_attack()
  else
    trigger.time{min = 1200, max = 2400, on = MineGuardToHuntEvacs}
  end
end

-- Every 40 ticks once a part is loaded (0x11004750): fewer Cargo Trucks with a part than parts loaded fails it.
function CheckForLoss(t)
  local loaded = 0
  for _, u in ipairs(players[1]:units("CargoTruck")) do
    if u.cargo == "Wreckage" then loaded = loaded + 1 end
  end
  if parts > loaded then mission.failure(trigger.time{time = 1}) end
end

-- The mine guards attack Cargo Trucks by the base (0x11004A70).
function MineGuardToHuntTrucks(t) hunt("CargoTruck") end

-- The mine guards attack Evacuation Transports by the base (0x11004B20).
function MineGuardToHuntEvacs(t) hunt("EvacuationTransport") end

-- Every 100 to 200 ticks after the all-attack (0x11004BD0): while the base guard has 24 units or fewer, a drawn tank at
-- each Garage joins it; after 6 waves (5 on Normal) the timer stops.
function ReinforceFromGarage(t)
  if ai_fight8:unit_count() > 24 then return end
  local draw = GARAGE_UNITS[players[1].difficulty == "Easy" and "Easy" or "other"]
  for _, garage in ipairs(ai_player:buildings("Garage")) do
    local weapon = draw.weapons[game.rand(#draw.weapons) + 1]
    local kind = draw.types[game.rand(#draw.types) + 1]
    ai_fight8:take_unit(game.create_unit{type = kind, weapon = weapon, player = ai_player, at = { garage.x, garage.y },
                                         exact = true, lights = false}[1])
  end
  garage_waves = garage_waves + 1
  if garage_waves == (players[1].difficulty == "Normal" and 5 or 6) then garage_reinforce:disable() end
end

-- The player down to 14 vehicles (0x110046B0): the reinforcement convoy.
function ReinforceP(t) convoy() end

-- Both parts and both groups of scientists loaded (0x110046E0): the set's triggers off and another convoy.
function MoreReinforce(t)
  for _, k in ipairs(more_triggers) do
    if k.valid then k:disable() end
  end
  convoy()
end

-- Every 2400 ticks (0x11004E70): Eden gets 2000 ore and 250 rare ore.
function GiveOre(t)
  ai_player.ore = ai_player.ore + 2000
  ai_player.rare_ore = ai_player.rare_ore + 250
end

-- 400 marks in (0x11004EC0): with neither both parts nor both groups taken the mine guards hunt trucks; the base
-- attacks.
function GoBanzia(t)
  if people ~= 2 and parts ~= 2 then hunt("CargoTruck") end
  all_attack()
end

-- Every 40 ticks (0x11005D50): either Evacuation Transport destroyed fails the mission.
function CheckForFail(t)
  if not (evacs[1] and evacs[1].alive) or not (evacs[2] and evacs[2].alive) then
    mission.failure(trigger.time{time = 1})
  end
end

-- Every 40 ticks until its scientists are taken (0x11004810): the lab at 123,34 destroyed fails the mission.
function Lab1DeadCheck(t)
  if not u55.alive then mission.failure(trigger.time{time = 1}) end
end

-- The same for the lab at 100,75 (0x11004870).
function Lab2DeadCheck(t)
  if not u56.alive then mission.failure(trigger.time{time = 1}) end
end

-- The same for the Spaceport until both parts are loaded (0x110048D0).
function Lab3DeadCheck(t)
  if not u54.alive then mission.failure(trigger.time{time = 1}) end
end

-- Either escape (0x11005D10): with both done, the ore the player came with back.
function RestoreOre(t)
  if t19:has_fired(1) and t22:has_fired(1) then players[1].ore = saved_ore end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  saved_ore = players[1].ore
  has_8203, has_7103 = players[1]:has_tech(8203), players[1]:has_tech(7103)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  evacs = { find_unit("EvacuationTransport", 9, 79), find_unit("EvacuationTransport", 9, 81) }
  game.set_daylight_everywhere(difficulty == "Easy")
  game.set_daylight_moves(false)

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  game.create_beacon{type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 79, 62 }}
  if players[1].difficulty == "Hard" then
    game.create_beacon{type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 119, 3 }}
    game.create_beacon{type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 121, 68 }}
  end
  game.create_marker({ 7, 79 })
  -- The tubes and walls the setup makes here, after the computer player's base.
  make_walls({
    { "Wall", { 65, 62 } }, { "Wall", { 65, 63 } }, { "Wall", { 65, 64 } }, { "Wall", { 65, 70 } }, { "Wall", { 65, 71 } }, { "Wall", { 65, 72 } },
    { "Wall", { 66, 62 } }, { "Wall", { 66, 64 } }, { "Wall", { 66, 70 } }, { "Wall", { 66, 72 } }, { "Wall", { 67, 62 } }, { "Wall", { 67, 63 } },
    { "Wall", { 67, 71 } }, { "Wall", { 67, 72 } }, { "Wall", { 68, 63 } }, { "Wall", { 68, 71 } }, { "Wall", { 69, 63 } }, { "Wall", { 69, 71 } },
    { "Wall", { 70, 33 } }, { "Wall", { 70, 34 } }, { "Wall", { 70, 35 } }, { "Wall", { 70, 36 } }, { "Wall", { 70, 37 } }, { "Wall", { 70, 38 } },
    { "Wall", { 70, 39 } }, { "Wall", { 70, 40 } }, { "Wall", { 70, 41 } }, { "Wall", { 70, 42 } }, { "Wall", { 70, 43 } }, { "Wall", { 70, 44 } },
    { "Wall", { 70, 45 } }, { "Wall", { 70, 46 } }, { "Wall", { 70, 47 } }, { "Wall", { 70, 48 } }, { "Wall", { 70, 49 } }, { "Wall", { 70, 50 } },
    { "Wall", { 70, 51 } }, { "Wall", { 70, 52 } }, { "Wall", { 70, 53 } }, { "Wall", { 70, 54 } }, { "Wall", { 70, 55 } }, { "Wall", { 70, 56 } },
    { "Wall", { 70, 57 } }, { "Wall", { 70, 63 } }, { "Wall", { 70, 71 } }, { "Wall", { 70, 32 } }, { "Wall", { 70, 31 } }, { "Wall", { 70, 30 } },
    { "Wall", { 70, 29 } }, { "Wall", { 70, 28 } }, { "Wall", { 71, 28 } }, { "Wall", { 72, 28 } }, { "Wall", { 72, 29 } }, { "Wall", { 71, 30 } },
    { "Wall", { 71, 57 } }, { "Wall", { 71, 63 } }, { "Wall", { 71, 71 } }, { "Wall", { 72, 57 } }, { "Wall", { 72, 63 } }, { "Wall", { 72, 71 } },
    { "Wall", { 73, 57 } }, { "Wall", { 73, 58 } }, { "Wall", { 73, 59 } }, { "Wall", { 73, 60 } }, { "Wall", { 73, 61 } }, { "Wall", { 73, 62 } },
    { "Wall", { 73, 63 } }, { "Wall", { 73, 71 } }, { "Wall", { 73, 72 } }, { "Wall", { 73, 73 } }, { "Wall", { 73, 74 } }, { "Wall", { 73, 75 } },
    { "Wall", { 73, 76 } }, { "Wall", { 73, 77 } }, { "Wall", { 73, 78 } }, { "Wall", { 73, 79 } }, { "Wall", { 73, 80 } }, { "Wall", { 73, 81 } },
    { "Wall", { 73, 82 } }, { "Wall", { 73, 83 } }, { "Wall", { 73, 84 } }, { "Wall", { 74, 84 } }, { "Wall", { 75, 84 } }, { "Wall", { 76, 84 } },
    { "Wall", { 77, 84 } }, { "Wall", { 77, 85 } }, { "Wall", { 78, 83 } }, { "Wall", { 78, 85 } }, { "Wall", { 79, 83 } }, { "Wall", { 79, 84 } },
    { "Wall", { 79, 85 } }, { "Wall", { 85, 84 } }, { "Wall", { 86, 57 } }, { "Wall", { 86, 58 } }, { "Wall", { 86, 59 } }, { "Wall", { 86, 60 } },
    { "Wall", { 86, 61 } }, { "Wall", { 86, 62 } }, { "Wall", { 86, 63 } }, { "Wall", { 86, 84 } }, { "Wall", { 87, 57 } }, { "Wall", { 87, 63 } },
    { "Wall", { 87, 84 } }, { "Wall", { 88, 57 } }, { "Wall", { 88, 63 } }, { "Wall", { 88, 84 } }, { "Wall", { 89, 33 } }, { "Wall", { 89, 34 } },
    { "Wall", { 89, 35 } }, { "Wall", { 89, 39 } }, { "Wall", { 89, 40 } }, { "Wall", { 89, 41 } }, { "Wall", { 89, 42 } }, { "Wall", { 89, 43 } },
    { "Wall", { 89, 44 } }, { "Wall", { 89, 45 } }, { "Wall", { 89, 46 } }, { "Wall", { 89, 49 } }, { "Wall", { 89, 50 } }, { "Wall", { 89, 51 } },
    { "Wall", { 89, 52 } }, { "Wall", { 89, 54 } }, { "Wall", { 89, 55 } }, { "Wall", { 89, 56 } }, { "Wall", { 89, 57 } }, { "Wall", { 89, 63 } },
    { "Wall", { 89, 84 } }, { "Wall", { 90, 63 } }, { "Wall", { 90, 64 } }, { "Wall", { 90, 65 } }, { "Wall", { 90, 66 } }, { "Wall", { 90, 67 } },
    { "Wall", { 90, 74 } }, { "Wall", { 90, 75 } }, { "Wall", { 90, 76 } }, { "Wall", { 90, 84 } }, { "Wall", { 91, 76 } }, { "Wall", { 91, 77 } },
    { "Wall", { 91, 78 } }, { "Wall", { 91, 79 } }, { "Wall", { 91, 80 } }, { "Wall", { 91, 81 } }, { "Wall", { 91, 82 } }, { "Wall", { 91, 83 } },
    { "Wall", { 91, 84 } }, { "Wall", { 92, 74 } }, { "Wall", { 92, 75 } }, { "Wall", { 92, 76 } }, { "Wall", { 92, 84 } }, { "Wall", { 93, 84 } },
    { "Wall", { 94, 84 } }, { "Wall", { 95, 84 } }, { "Wall", { 96, 84 } }, { "Wall", { 97, 84 } }, { "Wall", { 98, 63 } }, { "Wall", { 98, 64 } },
    { "Wall", { 98, 65 } }, { "Wall", { 98, 84 } }, { "Wall", { 99, 63 } }, { "Wall", { 99, 84 } }, { "Wall", { 99, 85 } }, { "Wall", { 100, 63 } },
    { "Wall", { 100, 85 } }, { "Wall", { 101, 63 } }, { "Wall", { 101, 84 } }, { "Wall", { 101, 85 } }, { "Wall", { 102, 63 } }, { "Wall", { 102, 64 } },
    { "Wall", { 102, 65 } }, { "Wall", { 102, 84 } }, { "Wall", { 103, 84 } }, { "Wall", { 104, 84 } }, { "Wall", { 105, 84 } }, { "Wall", { 106, 84 } },
    { "Wall", { 107, 84 } }, { "Wall", { 108, 74 } }, { "Wall", { 108, 75 } }, { "Wall", { 108, 76 } }, { "Wall", { 108, 84 } }, { "Wall", { 109, 76 } },
    { "Wall", { 109, 77 } }, { "Wall", { 109, 78 } }, { "Wall", { 109, 79 } }, { "Wall", { 109, 80 } }, { "Wall", { 109, 81 } }, { "Wall", { 109, 82 } },
    { "Wall", { 109, 83 } }, { "Wall", { 109, 84 } }, { "Wall", { 110, 74 } }, { "Wall", { 110, 75 } }, { "Wall", { 110, 76 } }, { "Wall", { 110, 84 } },
    { "Wall", { 111, 84 } }, { "Wall", { 112, 84 } }, { "Wall", { 115, 63 } }, { "Wall", { 115, 64 } }, { "Wall", { 115, 65 } }, { "Wall", { 115, 66 } },
    { "Wall", { 115, 67 } }, { "Wall", { 116, 63 } }, { "Wall", { 117, 63 } }, { "Wall", { 118, 63 } }, { "Wall", { 118, 83 } }, { "Wall", { 118, 84 } },
    { "Wall", { 118, 85 } }, { "Wall", { 119, 63 } }, { "Wall", { 119, 83 } }, { "Wall", { 119, 85 } }, { "Wall", { 120, 63 } }, { "Wall", { 120, 84 } },
    { "Wall", { 120, 85 } }, { "Wall", { 121, 63 } }, { "Wall", { 121, 84 } }, { "Wall", { 122, 63 } }, { "Wall", { 122, 84 } }, { "Wall", { 123, 63 } },
    { "Wall", { 123, 84 } }, { "Wall", { 125, 84 } }, { "Wall", { 124, 63 } }, { "Wall", { 124, 84 } }, { "Wall", { 125, 63 } }, { "Wall", { 126, 63 } },
    { "Wall", { 126, 84 } }, { "Wall", { 127, 63 } }, { "Wall", { 127, 84 } }, { "Wall", { 128, 63 } }, { "Wall", { 128, 84 } }, { "Wall", { 114, 33 } },
    { "Wall", { 114, 34 } }, { "Wall", { 114, 35 } }, { "Wall", { 115, 33 } }, { "Wall", { 115, 35 } }, { "Wall", { 116, 34 } }, { "Wall", { 116, 35 } },
    { "Wall", { 116, 39 } }, { "Wall", { 116, 40 } }, { "Wall", { 116, 41 } }, { "Wall", { 117, 39 } }, { "Wall", { 117, 41 } }, { "Wall", { 118, 40 } },
    { "Wall", { 118, 41 } }, { "Wall", { 124, 42 } }, { "Wall", { 124, 43 } }, { "Wall", { 124, 44 } }, { "Wall", { 125, 42 } }, { "Wall", { 125, 44 } },
    { "Wall", { 126, 42 } }, { "Wall", { 126, 43 } },
  })

  -- The win.
  t19 = trigger.escape{at = { x = 33, y = 73, raw = true }, width = 10, height = 10, type = "CargoTruck", count = 2, cargo = 9, amount = -1, on = RestoreOre}
  mission.victory(t19, "Return both starship parts to the convoy starting location.")
  parts_target = trigger.special_target{target = u54, type = "CargoTruck", one_shot = false, on = PartsGrabbed}
  t22 = trigger.escape{at = { x = 33, y = 73, raw = true }, width = 10, height = 10, type = "EvacuationTransport", count = 2, cargo = 39, amount = -1, on = RestoreOre}
  mission.victory(t22, "Return both groups of scientists to the convoy starting location.")
  people_target2 = trigger.special_target{target = u56, type = "EvacuationTransport", one_shot = true, on = PeopleGrabbed2}
  people_target1 = trigger.special_target{target = u55, type = "EvacuationTransport", one_shot = true, on = PeopleGrabbed1}
  trigger.vehicle_count{compare = "<", count = 15, player = 1, one_shot = true, on = ReinforceP}
  more_triggers[1] = trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 2, player = 1}
  more_triggers[2] = trigger.count{type = "EvacuationTransport", cargo = 39, compare = ">=", count = 2, player = 1}
  more_triggers[3] = trigger.research{tech = 10000, one_shot = true}
  trigger.set{more_triggers[1], more_triggers[2], more_triggers[3], needed = 3, one_shot = true, on = MoreReinforce}
  trigger.time{min = 2400, max = 2400, one_shot = false, on = GiveOre}  -- after 24 to 24 marks
  trigger.time{min = 40000, max = 40000, on = GoBanzia}  -- after 400 to 400 marks
  mission.failure(trigger.count{type = "CargoTruck", compare = "<", count = 2, player = 1})
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
  lab_checks[1] = trigger.time{time = 40, one_shot = false, on = Lab1DeadCheck}  -- after 0 marks
  lab_checks[2] = trigger.time{time = 40, one_shot = false, on = Lab2DeadCheck}  -- after 0 marks
  lab_checks[3] = trigger.time{time = 40, one_shot = false, on = Lab3DeadCheck}  -- after 0 marks
end

-- Not converted:
-- - Easy: units are made other ways than CreateUnit (135 on the map, 40 made)
-- - Normal: units are made other ways than CreateUnit (126 on the map, 34 made)
-- - Hard: units are made other ways than CreateUnit (137 on the map, 34 made)
