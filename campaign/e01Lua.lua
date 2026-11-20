-- e01Lua.lua  -  Eden Mission #1 (Lua)
-- Trigger functions finished by hand (Refresh, CheckVehicles, CheckKits, DisableSet1, DisableSet2, DisableSet3, DisableSet4, DisableSet5, DisableSet6, DisableSet7, DisableSet8, DisableSet9, DisableSet10), from the disassembly of e01.dll.
-- Converted by op2dll from e01.dll. With e01Lua.placement.lua (what every difficulty makes alike),
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
        workers = 23, scientists = 14, kids = 0, food = 5000, ore = 9000,
        research = {  },
        view = { 18, 14 },
        units = {
          { type = "Tokamak", at = { 22, 4 } },
          { type = "CargoTruck", direction = "SouthEast", cargo = "Food", amount = 1000, at = { 9, 23 } },
          { type = "CargoTruck", direction = "SouthEast", cargo = "Food", amount = 1000, at = { 15, 27 } },
          { type = "CargoTruck", direction = "East", cargo = "Food", amount = 1000, at = { 54, 47 } },
          { type = "CargoTruck", direction = "East", cargo = "Food", amount = 1000, at = { 54, 49 } },
          { type = "CargoTruck", direction = "SouthEast", cargo = "CommonMetal", amount = 1000, at = { 9, 14 } },
          { type = "CargoTruck", direction = "SouthEast", cargo = "CommonMetal", amount = 1000, at = { 15, 14 } },
          { type = "CargoTruck", direction = "East", cargo = "CommonMetal", amount = 1000, at = { 56, 48 } },
          { type = "CargoTruck", direction = "East", cargo = "CommonMetal", amount = 1000, at = { 56, 50 } },
          { type = "ConVec", weapon = "CommandCenter", direction = "SouthEast", at = { 45, 49 } },
          { type = "ConVec", weapon = "Agridome", direction = "SouthEast", at = { 43, 47 } },
          { type = "ConVec", weapon = "CommonOreSmelter", direction = "North", at = { 11, 19 } },
          { type = "ConVec", weapon = "Tokamak", direction = "East", at = { 18, 18 } },
          { type = "ConVec", weapon = "BasicLab", direction = "SouthEast", at = { 17, 22 } },
          { type = "ConVec", weapon = "StructureFactory", direction = "SouthWest", at = { 18, 21 } },
          { type = "EvacuationTransport", direction = "SouthEast", at = { 24, 25 } },
          { type = "EvacuationTransport", direction = "SouthEast", at = { 26, 25 } },
          { type = "EvacuationTransport", direction = "SouthEast", at = { 28, 25 } },
          { type = "RoboMiner", direction = "SouthEast", at = { 33, 37 } },
          { type = "RoboMiner", direction = "SouthEast", at = { 31, 35 } },
          { type = "RoboSurveyor", direction = "East", at = { 57, 51 } },
          { type = "RoboSurveyor", direction = "East", at = { 32, 39 } },
          { type = "Earthworker", direction = "East", at = { 30, 37 } },
        },
      },
    },
    walls = {
      { "Tube", { 4, 7 } }, { "Tube", { 4, 8 } }, { "Tube", { 4, 9 } }, { "Tube", { 8, 16 } },
      { "Tube", { 15, 8 } }, { "Tube", { 16, 8 } }, { "Tube", { 16, 23 } }, { "Tube", { 16, 24 } },
      { "Tube", { 16, 25 } }, { "Tube", { 17, 8 } }, { "Tube", { 18, 8 } }, { "Tube", { 18, 9 } },
    },
    beacons = {
    },
    late_beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 50 } },
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 23, scientists = 14, kids = 0, food = 3000, ore = 5500,
        research = {  },
        kits = { [1] = { "CommonOreSmelter" }, [2] = { "StructureFactory" }, [3] = { "BasicLab" } },
        view = { 18, 14 },
        units = {
          { type = "Tokamak", at = { 5, 33 } },
          { type = "DIRT", at = { 9, 4 } },
          { type = "BasicLab", at = { 4, 8 } },
          { type = "MedicalCenter", at = { 8, 8 } },
          { type = "CommonStorage", at = { 11, 15 } },
          { type = "CommonStorage", at = { 14, 14 } },
          { type = "University", at = { 14, 4 } },
          { type = "RecreationFacility", at = { 18, 4 } },
          { type = "Garage", at = { 18, 8 } },
          { type = "Garage", at = { 4, 18 } },
          { type = "Residence", at = { 4, 22 } },
          { type = "Residence", at = { 7, 22 } },
          { type = "Agridome", at = { 3, 26 } },
          { type = "CommonOreSmelter", at = { 11, 28 } },
          { type = "LightTower", at = { 17, 32 } },
          { type = "LightTower", at = { 24, 4 } },
          { type = "LightTower", at = { 2, 36 } },
          { type = "CargoTruck", direction = "North", at = { 9, 11 } },
          { type = "CargoTruck", direction = "SouthWest", at = { 14, 30 } },
          { type = "CargoTruck", direction = "West", cargo = "Food", amount = 1000, at = { 12, 24 } },
          { type = "CargoTruck", direction = "NorthWest", cargo = "Food", amount = 1000, at = { 5, 27 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 15, 15 } },
          { type = "CargoTruck", direction = "North", at = { 7, 16 } },
          { type = "CargoTruck", direction = "East", cargo = "CommonMetal", amount = 1000, at = { 12, 14 } },
          { type = "CargoTruck", direction = "East", at = { 19, 28 } },
          { type = "ConVec", weapon = "Agridome", direction = "South", at = { 14, 24 } },
          { type = "ConVec", direction = "West", at = { 10, 19 } },
          { type = "ConVec", direction = "North", at = { 11, 19 } },
          { type = "ConVec", direction = "East", at = { 19, 9 } },
          { type = "ConVec", weapon = "CommandCenter", direction = "SouthEast", at = { 17, 22 } },
          { type = "ConVec", weapon = "Tokamak", direction = "SouthWest", at = { 18, 21 } },
          { type = "EvacuationTransport", direction = "NorthWest", at = { 20, 15 } },
          { type = "EvacuationTransport", direction = "NorthEast", at = { 16, 12 } },
          { type = "EvacuationTransport", direction = "SouthWest", at = { 18, 17 } },
          { type = "RoboMiner", direction = "East", at = { 27, 23 } },
          { type = "RoboMiner", direction = "West", at = { 22, 19 } },
          { type = "RoboSurveyor", direction = "SouthWest", at = { 30, 25 } },
          { type = "RoboSurveyor", direction = "North", at = { 21, 23 } },
          { type = "Earthworker", direction = "South", at = { 28, 28 } },
        },
      },
    },
    walls = {
      { "Tube", { 1, 8 } }, { "Tube", { 1, 21 } }, { "Tube", { 2, 8 } }, { "Tube", { 2, 21 } },
      { "Tube", { 4, 16 } }, { "Tube", { 4, 20 } }, { "Tube", { 4, 24 } }, { "Tube", { 6, 8 } },
      { "Tube", { 6, 26 } }, { "Tube", { 7, 4 } }, { "Tube", { 7, 18 } }, { "Tube", { 9, 1 } },
      { "Tube", { 9, 2 } }, { "Tube", { 9, 6 } }, { "Tube", { 9, 7 } }, { "Tube", { 9, 22 } },
      { "Tube", { 10, 7 } }, { "Tube", { 10, 14 } }, { "Tube", { 11, 7 } }, { "Tube", { 11, 16 } },
      { "Tube", { 11, 17 } }, { "Tube", { 11, 26 } }, { "Tube", { 12, 4 } }, { "Tube", { 12, 15 } },
      { "Tube", { 13, 15 } }, { "Tube", { 14, 1 } }, { "Tube", { 14, 2 } }, { "Tube", { 14, 6 } },
      { "Tube", { 14, 7 } }, { "Tube", { 14, 15 } }, { "Tube", { 14, 28 } }, { "Tube", { 15, 7 } },
      { "Tube", { 15, 14 } }, { "Tube", { 15, 28 } }, { "Tube", { 16, 4 } }, { "Tube", { 16, 7 } },
      { "Tube", { 16, 14 } }, { "Tube", { 16, 28 } }, { "Tube", { 18, 6 } },
    },
    beacons = {
    },
    late_beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 50 } },
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 23, scientists = 14, kids = 0, food = 5000, ore = 2000,
        research = {  },
        kits = { [1] = { "CommandCenter" }, [2] = { "Agridome" }, [3] = { "CommonOreSmelter" }, [4] = { "Tokamak" }, [5] = { "StructureFactory" }, [6] = { "BasicLab" } },
        view = { 18, 14 },
        units = {
          { type = "DIRT", at = { 9, 4 } },
          { type = "BasicLab", at = { 4, 8 } },
          { type = "MedicalCenter", at = { 8, 8 } },
          { type = "CommonStorage", at = { 11, 15 } },
          { type = "CommonStorage", at = { 14, 14 } },
          { type = "University", at = { 14, 4 } },
          { type = "RecreationFacility", at = { 18, 4 } },
          { type = "Garage", at = { 18, 8 } },
          { type = "Garage", at = { 4, 18 } },
          { type = "Residence", at = { 4, 22 } },
          { type = "Residence", at = { 7, 22 } },
          { type = "Agridome", at = { 3, 26 } },
          { type = "CommonOreSmelter", at = { 11, 28 } },
          { type = "LightTower", at = { 17, 32 } },
          { type = "LightTower", at = { 24, 4 } },
          { type = "LightTower", at = { 2, 36 } },
          { type = "CargoTruck", direction = "North", garage = { bay = 1, at = { 5, 18 } }, at = { 4, 18 } },
          { type = "CargoTruck", direction = "SouthWest", at = { 14, 30 } },
          { type = "CargoTruck", direction = "West", at = { 2, 19 } },
          { type = "CargoTruck", direction = "NorthWest", at = { 4, 19 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonOre", amount = 1000, at = { 21, 6 } },
          { type = "CargoTruck", direction = "NorthEast", cargo = "CommonOre", amount = 1000, at = { 21, 8 } },
          { type = "CargoTruck", direction = "East", cargo = "CommonOre", amount = 1000, at = { 21, 10 } },
          { type = "CargoTruck", direction = "East", at = { 19, 28 } },
          { type = "ConVec", direction = "North", garage = { bay = 1, at = { 19, 8 } }, at = { 18, 8 } },
          { type = "ConVec", direction = "West", at = { 9, 19 } },
          { type = "ConVec", direction = "North", at = { 11, 19 } },
          { type = "ConVec", direction = "East", at = { 21, 13 } },
          { type = "ConVec", direction = "SouthEast", at = { 17, 22 } },
          { type = "ConVec", direction = "SouthWest", at = { 18, 21 } },
          { type = "EvacuationTransport", direction = "NorthWest", at = { 20, 15 } },
          { type = "EvacuationTransport", direction = "NorthEast", at = { 16, 12 } },
          { type = "EvacuationTransport", direction = "SouthWest", at = { 18, 30 } },
          { type = "RoboMiner", direction = "West", at = { 17, 9 } },
          { type = "RoboMiner", direction = "East", at = { 19, 9 } },
          { type = "RoboSurveyor", direction = "SouthWest", at = { 21, 18 } },
          { type = "RoboSurveyor", direction = "North", garage = { bay = 1, at = { 10, 18 } }, at = { 9, 18 } },
          { type = "Earthworker", direction = "South", at = { 23, 20 } },
        },
      },
    },
    walls = {
      { "Tube", { 1, 8 } }, { "Tube", { 1, 21 } }, { "Tube", { 2, 8 } }, { "Tube", { 2, 21 } },
      { "Tube", { 4, 16 } }, { "Tube", { 4, 20 } }, { "Tube", { 4, 24 } }, { "Tube", { 6, 8 } },
      { "Tube", { 6, 26 } }, { "Tube", { 7, 4 } }, { "Tube", { 7, 18 } }, { "Tube", { 9, 1 } },
      { "Tube", { 9, 2 } }, { "Tube", { 9, 6 } }, { "Tube", { 9, 7 } }, { "Tube", { 9, 22 } },
      { "Tube", { 10, 7 } }, { "Tube", { 10, 14 } }, { "Tube", { 11, 7 } }, { "Tube", { 11, 16 } },
      { "Tube", { 11, 17 } }, { "Tube", { 11, 26 } }, { "Tube", { 12, 4 } }, { "Tube", { 12, 15 } },
      { "Tube", { 13, 15 } }, { "Tube", { 14, 1 } }, { "Tube", { 14, 2 } }, { "Tube", { 14, 6 } },
      { "Tube", { 14, 7 } }, { "Tube", { 14, 15 } }, { "Tube", { 14, 28 } }, { "Tube", { 15, 7 } },
      { "Tube", { 15, 14 } }, { "Tube", { 15, 28 } }, { "Tube", { 16, 4 } }, { "Tube", { 16, 7 } },
      { "Tube", { 16, 14 } }, { "Tube", { 16, 28 } }, { "Tube", { 18, 6 } },
    },
    beacons = {
    },
    late_beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 50 } },
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


-- The setup's buildings by the DLL's slot for each (0x1100811C + the key), found where the setup made them: the
-- volcano infects them in turn. On Normal the Tokamak at 5,33 takes the slot of the one at 3,30.
local BUILDING_AT = {
  [0x1C] = { "AdvancedLab", 4, 4 }, [0x20] = { "DIRT", 9, 4 }, [0x24] = { "BasicLab", 4, 8 },
  [0x28] = { "MedicalCenter", 8, 8 }, [0x2C] = { "CommonOreSmelter", 4, 13 }, [0x30] = { "CommonStorage", 8, 14 },
  [0x34] = { "CommonStorage", 11, 15 }, [0x38] = { "CommonStorage", 14, 14 }, [0x3C] = { "University", 14, 4 },
  [0x40] = { "RecreationFacility", 18, 4 }, [0x44] = { "Garage", 18, 8 }, [0x48] = { "Residence", 13, 8 },
  [0x4C] = { "CommandCenter", 18, 14 }, [0x50] = { "Garage", 4, 18 }, [0x54] = { "Garage", 9, 18 },
  [0x58] = { "StructureFactory", 15, 19 }, [0x5C] = { "Residence", 4, 22 }, [0x60] = { "Residence", 7, 22 },
  [0x64] = { "Agridome", 11, 23 }, [0x68] = { "Agridome", 3, 26 }, [0x6C] = { "Residence", 7, 25 },
  [0x70] = { "Tokamak", 3, 30 }, [0x74] = { "CommonOreSmelter", 11, 28 }, [0x78] = { "Agridome", 17, 27 },
  [0x7C] = { "LightTower", 17, 32 }, [0x80] = { "LightTower", 24, 4 }, [0x84] = { "LightTower", 2, 36 },
}
local building = {}
local function find_building(kind, x, y)
  for r = 0, 2 do
    for _, u in ipairs(game.units_in_rect({ x - r, y - r, x + r, y + r })) do
      if u.type == kind then return u end
    end
  end
end
local function find_buildings()
  for k, b in pairs(BUILDING_AT) do building[k] = find_building(b[1], b[2], b[3]) end
  if players[1].difficulty == "Normal" then building[0x70] = find_building("Tokamak", 5, 33) end
end
local function infect(k)
  if building[k] then building[k]:infect() end
end
-- The volcano's stage (0x110081B8) and how far its line has come at each (0x11007088).
local stage = 0
local LINE = { 7, 11, 16, 20, 23, 25, 31, 34, 36, 38 }
-- The six kit triggers CheckKits reads (0x110081BC to 0x110081D0).
local kit_triggers = {}

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local EvacAgriKit, EvacCommandKit, EvacEWC, EvacFactKit, EvacFood, EvacLabKit, EvacMiners, EvacOre, EvacPeople, EvacSmelterKit, EvacSurveyors, EvacTokamakKit

local EvacAgriKit_done  -- EvacAgriKit does nothing more once it has acted
function EvacAgriKit(t)
  if EvacAgriKit_done then return end
  game.message_at("Agridome Kit evacuated successfully.", 0, 1, -1, -1)
  EvacAgriKit_done = true
end

local EvacCommandKit_done  -- EvacCommandKit does nothing more once it has acted
function EvacCommandKit(t)
  if EvacCommandKit_done then return end
  game.message_at("Command Center Kit evacuated successfully.", 0, 1, -1, -1)
  EvacCommandKit_done = true
end

local EvacEWC_done  -- EvacEWC does nothing more once it has acted
function EvacEWC(t)
  if EvacEWC_done then return end
  game.message_at("Earthworker evacuated successfully.", 0, 1, -1, -1)
  EvacEWC_done = true
end

local EvacFactKit_done  -- EvacFactKit does nothing more once it has acted
function EvacFactKit(t)
  if EvacFactKit_done then return end
  game.message_at("Structure Factory Kit evacuated successfully.", 0, 1, -1, -1)
  EvacFactKit_done = true
end

local EvacFood_done  -- EvacFood does nothing more once it has acted
function EvacFood(t)
  if EvacFood_done then return end
  game.message_at("Food evacuated successfully.", 0, 1, -1, -1)
  EvacFood_done = true
end

local EvacLabKit_done  -- EvacLabKit does nothing more once it has acted
function EvacLabKit(t)
  if EvacLabKit_done then return end
  game.message_at("Basic Lab Kit evacuated successfully.", 0, 1, -1, -1)
  EvacLabKit_done = true
end

local EvacMiners_done  -- EvacMiners does nothing more once it has acted
function EvacMiners(t)
  if EvacMiners_done then return end
  game.message_at("Robo-Miners evacuated successfully.", 0, 1, -1, -1)
  EvacMiners_done = true
end

local EvacOre_done  -- EvacOre does nothing more once it has acted
function EvacOre(t)
  if EvacOre_done then return end
  game.message_at("Metals evacuated successfully.", 0, 1, -1, -1)
  EvacOre_done = true
end

local EvacPeople_done  -- EvacPeople does nothing more once it has acted
function EvacPeople(t)
  if EvacPeople_done then return end
  game.message_at("Colonists evacuated successfully.", 0, 1, -1, -1)
  EvacPeople_done = true
end

local EvacSmelterKit_done  -- EvacSmelterKit does nothing more once it has acted
function EvacSmelterKit(t)
  if EvacSmelterKit_done then return end
  game.message_at("Smelter Kit evacuated successfully.", 0, 1, -1, -1)
  EvacSmelterKit_done = true
end

local EvacSurveyors_done  -- EvacSurveyors does nothing more once it has acted
function EvacSurveyors(t)
  if EvacSurveyors_done then return end
  game.message_at("Robo-Surveyors evacuated successfully.", 0, 1, -1, -1)
  EvacSurveyors_done = true
end

local EvacTokamakKit_done  -- EvacTokamakKit does nothing more once it has acted
function EvacTokamakKit(t)
  if EvacTokamakKit_done then return end
  game.message_at("Tokamak Kit evacuated successfully.", 0, 1, -1, -1)
  EvacTokamakKit_done = true
end

-- Every 120 ticks the DLL asks each of its buildings whether it's alive, and does nothing with the answer
-- (0x11001AC0).
function Refresh(t) end

-- Every 30 ticks once the volcano has begun: every vehicle in the corner it has reached, beyond the line x + y - 2 =
-- its distance, self-destructs (0x11001A10).
function CheckVehicles(t)
  if stage == 0 then return end
  local k = LINE[stage]
  for _, u in ipairs(game.units_in_rect({ 1, 1, k + 1, k + 1 })) do
    if u.is_vehicle and u.x + u.y - 2 < k then u:self_destruct() end
  end
end

-- Every 20 ticks: a kit gone (no ConVec carries one of the six) fails the mission (0x11001860).
function CheckKits(t)
  for _, k in ipairs(kit_triggers) do
    if not k:has_fired(1) then
      mission.failure(trigger.time{time = 1})
      return
    end
  end
end

function DisableSet1(t)
  stage = stage + 1
  infect(0x1C)
end

function DisableSet2(t)
  stage = stage + 1
  infect(0x24)
  infect(0x20)
end

function DisableSet3(t)
  stage = stage + 1
  infect(0x28)
  infect(0x2C)
  infect(0x3C)
end

function DisableSet4(t)
  stage = stage + 1
  infect(0x50)
  infect(0x30)
  infect(0x48)
  infect(0x40)
  if building[0x50] and building[0x50].occupied_bay then mission.failure(trigger.time{time = 1}) end
end

function DisableSet5(t)
  stage = stage + 1
  infect(0x5C)
  infect(0x54)
  infect(0x34)
  infect(0x44)
  if building[0x54] and building[0x54].occupied_bay then mission.failure(trigger.time{time = 1}) end
  if building[0x44] and building[0x44].occupied_bay then mission.failure(trigger.time{time = 1}) end
end

function DisableSet6(t)
  stage = stage + 1
  infect(0x68)
  infect(0x60)
  infect(0x38)
end

function DisableSet7(t)
  stage = stage + 1
  infect(0x70)
  infect(0x6C)
  infect(0x4C)
end

function DisableSet8(t)
  stage = stage + 1
  infect(0x64)
  infect(0x58)
  infect(0x74)
  if building[0x58] and building[0x58].occupied_bay then mission.failure(trigger.time{time = 1}) end
end

function DisableSet9(t)
  stage = stage + 1
  infect(0x78)
  infect(0x7C)
end

function DisableSet10(t)
  stage = stage + 1
  infect(0x80)
  infect(0x84)
  -- Fewer than 4 trucks of food or of Common Metals left fails it.
  mission.failure(trigger.count{type = "CargoTruck", cargo = 1, compare = "<", count = 4, player = 1, one_shot = true})
  mission.failure(trigger.count{type = "CargoTruck", cargo = 4, compare = "<", count = 4, player = 1, one_shot = true})
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
  game.set_daylight_everywhere(true)
  game.morale_steady("Terrible")
  find_buildings()
  trigger.time{time = 120, one_shot = false, on = Refresh}  -- after 1 marks
  trigger.time{time = 30, one_shot = false, on = CheckVehicles}  -- after 0 marks

  -- The win.
  local t7 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "CargoTruck", count = 4, cargo = 1, amount = 4000, player = 1, on = EvacFood}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t7, "Evacuate 4000 units of food.")
  end
  local t8 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "CargoTruck", count = 4, cargo = 4, amount = 4000, player = 1, on = EvacOre}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t8, "Evacuate 4000 units of Common Metals.")
  end
  local t9 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "EvacuationTransport", count = 3, player = 1, on = EvacPeople}
  local t12, t10
  if difficulty == "Easy" then
    t12 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "RoboMiner", count = 2, player = 1, on = EvacMiners}
  elseif difficulty == "Normal" then
    mission.victory(t9, "Evacuate the colonists in the 3 Evacuation Transports.")
    t10 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "RoboMiner", count = 2, player = 1, on = EvacMiners}
    mission.victory(t10, "Evacuate 2 Robo-Miners.")
  elseif difficulty == "Hard" then
    mission.victory(t9, "Evacuate the colonists in the 3 Evacuation Transports.")
    t12 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "RoboMiner", count = 2, player = 1, on = EvacMiners}
    mission.victory(t12, "Evacuate 2 Robo-Miners.")
  end
  local t11 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "RoboSurveyor", count = 2, player = 1, on = EvacSurveyors}
  local t12e, t29e, t12h
  if difficulty == "Easy" then
    t12e = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "Earthworker", count = 1, player = 1, on = EvacEWC}
    t29e = trigger.set{t7, t8, t9, t12, t11, t12e}
  elseif difficulty == "Normal" then
    mission.victory(t11, "Evacuate 2 Robo-Surveyors.")
    t12 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "Earthworker", count = 1, player = 1, on = EvacEWC}
    mission.victory(t12, "Evacuate the Earthworker.")
  elseif difficulty == "Hard" then
    mission.victory(t11, "Evacuate 2 Robo-Surveyors.")
    t12h = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "Earthworker", count = 1, player = 1, on = EvacEWC}
    mission.victory(t12h, "Evacuate the Earthworker.")
  end
  local t13 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "ConVec", count = 1, cargo = 28, amount = 1, player = 1, on = EvacCommandKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t13, "Evacuate a Command Center kit.")
  end
  local t14 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "ConVec", count = 1, cargo = 54, amount = 1, player = 1, on = EvacSmelterKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t14, "Evacuate a Smelter kit.")
  end
  local t15 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "ConVec", count = 1, cargo = 39, amount = 1, player = 1, on = EvacAgriKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t15, "Evacuate an Agridome kit.")
  end
  local t16 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "ConVec", count = 1, cargo = 58, amount = 1, player = 1, on = EvacTokamakKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t16, "Evacuate a Tokamak kit.")
  end
  local t17 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "ConVec", count = 1, cargo = 47, amount = 1, player = 1, on = EvacFactKit}
  if difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t17, "Evacuate a Structure Factory kit.")
  end
  local t18 = trigger.escape{at = { x = 81, y = 44, raw = true }, width = 15, height = 16, type = "ConVec", count = 1, cargo = 33, amount = 1, player = 1, on = EvacLabKit}
  local t30e, t31
  if difficulty == "Easy" then
    t30e = trigger.set{t13, t14, t15, t16, t17, t18}
    t31 = trigger.set{t29e, t30e}
    mission.victory(t31, "Move all units and their cargoes to the mining beacon southeast of our colony.")
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t18, "Evacuate a Basic Lab kit.")
  end
  local t41 = trigger.vehicle_count{compare = "<", count = 22, player = 1, one_shot = true}
  mission.failure(t41)
  -- The kits that must stay: one ConVec with each (0x110081BC to 0x110081D0), for CheckKits.
  for _, kind in ipairs({ "CommandCenter", "CommonOreSmelter", "Agridome", "Tokamak", "BasicLab", "StructureFactory" }) do
    kit_triggers[#kit_triggers + 1] = trigger.kit{type = kind, count = 1, player = 1}
  end
  if difficulty == "Easy" then
    trigger.time{time = 640, on = DisableSet1}  -- after 6 marks
    trigger.time{time = 1800, on = DisableSet2}  -- after 18 marks
    trigger.time{time = 3000, on = DisableSet3}  -- after 30 marks
    trigger.time{time = 4200, on = DisableSet4}  -- after 42 marks
    trigger.time{time = 5400, on = DisableSet5}  -- after 54 marks
    trigger.time{time = 6600, on = DisableSet6}  -- after 66 marks
    trigger.time{time = 7200, on = DisableSet7}  -- after 72 marks
    trigger.time{time = 7800, on = DisableSet8}  -- after 78 marks
    trigger.time{time = 8400, on = DisableSet9}  -- after 84 marks
    trigger.time{time = 9000, on = DisableSet10}  -- after 90 marks
  elseif difficulty == "Normal" or difficulty == "Hard" then
    trigger.time{time = 40, on = DisableSet1}  -- after 0 marks
    trigger.time{time = 1200, on = DisableSet2}  -- after 12 marks
    trigger.time{time = 2400, on = DisableSet3}  -- after 24 marks
    trigger.time{time = 3600, on = DisableSet4}  -- after 36 marks
    trigger.time{time = 4800, on = DisableSet5}  -- after 48 marks
    trigger.time{time = 6000, on = DisableSet6}  -- after 60 marks
    trigger.time{time = 6600, on = DisableSet7}  -- after 66 marks
    trigger.time{time = 7200, on = DisableSet8}  -- after 72 marks
    trigger.time{time = 7800, on = DisableSet9}  -- after 78 marks
    trigger.time{time = 8400, on = DisableSet10}  -- after 84 marks
  end
  trigger.time{time = 20, one_shot = false, on = CheckKits}  -- after 0 marks
end

