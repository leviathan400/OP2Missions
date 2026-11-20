-- p02Lua.lua  -  Plymouth Mission #2 (Lua)
-- Trigger functions finished by hand (CheckForFail), from the disassembly of p02.dll.
-- Converted by op2dll from p02.dll. With p02Lua.placement.lua (what every difficulty makes alike),
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
        workers = 23, scientists = 11, kids = 41, food = 3900, ore = 3000,
        research = {  },
        tech_level = 1,
        kits = { [1] = { "CommandCenter" }, [2] = { "StructureFactory" }, [3] = { "Tokamak" }, [4] = { "CommonOreSmelter" } },
        view = { 36, 37 },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 36, 37 } },
      { type = "StructureFactory", player = 1, at = { 41, 40 } },
      { type = "ConVec", direction = "South", player = 1, at = { 38, 38 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 21, 38 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 21, 40 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 23, 38 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 23, 40 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 29, 43 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 31, 43 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 33, 43 } },
      { type = "CargoTruck", direction = "SouthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 32, 34 } },
      { type = "EvacuationTransport", direction = "North", player = 1, at = { 31, 36 } },
      { type = "EvacuationTransport", direction = "SouthWest", player = 1, at = { 29, 34 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 29, 36 } },
      { type = "Agridome", player = 1, at = { 36, 40 } },
      { type = "Agridome", player = 1, at = { 36, 34 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 38, 41 } },
      { type = "CommonOreSmelter", player = 1, at = { 32, 39 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 34, 41 } },
      { type = "Earthworker", direction = "SouthEast", player = 1, at = { 40, 33 } },
      { type = "Tokamak", player = 1, at = { 36, 48 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 37, 49 } },
      { type = "BasicLab", player = 1, at = { 41, 44 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 43, 42 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 44, 35 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 20, 42 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 46, 33 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 16, 42 }, beacon = true },
      { type = "CommonOreMine", player = 1, at = { 16, 42 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 23, scientists = 11, kids = 41, food = 3000,
        research = {  },
        tech_level = 1,
        view = { 36, 37 },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 36, 37 } },
      { type = "StructureFactory", player = 1, at = { 41, 37 } },
      { type = "ConVec", direction = "South", player = 1, at = { 38, 38 } },
      { type = "Tokamak", player = 1, at = { 40, 46 } },
      { type = "ConVec", direction = "South", player = 1, at = { 41, 47 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 35, 43 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 37, 43 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 39, 43 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 35, 45 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 26, 42 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 26, 46 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 26, 44 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 28, 44 } },
      { type = "EvacuationTransport", direction = "North", player = 1, at = { 36, 39 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 39, 40 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 34, 39 } },
      { type = "BasicLab", player = 1, at = { 40, 34 } },
      { type = "Agridome", player = 1, at = { 36, 34 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 38, 35 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 41, 35 } },
      { type = "Earthworker", direction = "SouthEast", player = 1, at = { 32, 39 } },
      { type = "ConVec", weapon = "CommonOreSmelter", direction = "West", player = 1, at = { 32, 36 } },
      { type = "ConVec", direction = "West", player = 1, at = { 43, 39 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 44, 35 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 17, 39 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 22, 42 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 46, 33 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 9, 40 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 23, scientists = 11, kids = 41, food = 2500,
        research = {  },
        tech_level = 1,
        view = { 36, 37 },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CommandCenter", player = 1, at = { 36, 37 } },
      { type = "ConVec", direction = "South", player = 1, at = { 38, 38 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 35, 43 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 37, 43 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 39, 43 } },
      { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, player = 1, at = { 35, 45 } },
      { type = "CargoTruck", direction = "NorthEast", player = 1, at = { 26, 42 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 26, 46 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 26, 44 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 28, 44 } },
      { type = "EvacuationTransport", direction = "North", player = 1, at = { 36, 39 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 40, 37 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 34, 39 } },
      { type = "BasicLab", player = 1, at = { 40, 34 } },
      { type = "Agridome", player = 1, at = { 36, 34 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 38, 35 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 41, 35 } },
      { type = "Earthworker", direction = "SouthEast", player = 1, at = { 32, 39 } },
      { type = "ConVec", weapon = "Tokamak", direction = "West", player = 1, at = { 44, 40 } },
      { type = "ConVec", weapon = "CommonOreSmelter", direction = "West", player = 1, at = { 32, 36 } },
      { type = "ConVec", weapon = "StructureFactory", direction = "West", player = 1, at = { 46, 40 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 44, 35 } },
      { type = "RoboMiner", direction = "SouthWest", player = 1, at = { 33, 33 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 30, 30 } },
      { type = "RoboSurveyor", direction = "SouthWest", player = 1, at = { 46, 33 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 7, 27 }, beacon = true },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 48, 1, 52, 1 },
  { 59, 1, 64, 1 },
  { 48, 2, 51, 2 },
  { 60, 2, 64, 2 },
  { 47, 3, 50, 5 },
  { 61, 3, 64, 8 },
  { 46, 6, 49, 6 },
  { 51, 6, 51, 6 },
  { 46, 7, 52, 8 },
  { 43, 9, 52, 10 },
  { 60, 9, 64, 9 },
  { 58, 10, 64, 10 },
  { 45, 11, 55, 11 },
  { 57, 11, 64, 11 },
  { 45, 12, 60, 12 },
  { 64, 12, 64, 12 },
  { 45, 13, 59, 13 },
  { 13, 14, 20, 14 },
  { 45, 14, 58, 14 },
  { 1, 15, 3, 15 },
  { 9, 15, 21, 15 },
  { 44, 15, 58, 15 },
  { 1, 16, 4, 16 },
  { 7, 16, 21, 16 },
  { 42, 16, 58, 16 },
  { 1, 17, 22, 17 },
  { 39, 17, 45, 17 },
  { 47, 17, 54, 17 },
  { 56, 17, 57, 17 },
  { 1, 18, 21, 18 },
  { 23, 18, 29, 18 },
  { 37, 18, 43, 18 },
  { 47, 18, 55, 18 },
  { 58, 18, 58, 21 },
  { 1, 19, 30, 19 },
  { 34, 19, 43, 19 },
  { 47, 19, 53, 19 },
  { 64, 19, 64, 19 },
  { 1, 20, 42, 22 },
  { 47, 20, 51, 20 },
  { 46, 21, 50, 21 },
  { 44, 22, 50, 22 },
  { 57, 22, 57, 24 },
  { 1, 23, 50, 24 },
  { 53, 24, 53, 24 },
  { 1, 25, 57, 25 },
  { 1, 26, 55, 26 },
  { 1, 27, 54, 27 },
  { 1, 28, 53, 28 },
  { 1, 29, 52, 31 },
  { 1, 32, 51, 41 },
  { 53, 36, 53, 41 },
  { 2, 42, 51, 42 },
  { 3, 43, 51, 43 },
  { 9, 44, 51, 44 },
  { 12, 45, 12, 45 },
  { 17, 45, 51, 45 },
  { 20, 46, 51, 46 },
  { 21, 47, 51, 47 },
  { 54, 47, 54, 48 },
  { 23, 48, 51, 50 },
  { 24, 51, 51, 51 },
  { 26, 52, 51, 54 },
  { 27, 55, 51, 55 },
  { 28, 56, 51, 57 },
  { 29, 58, 51, 58 },
  { 32, 59, 50, 59 },
  { 33, 60, 50, 64 },
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


-- The triggers CheckForFail reads (0x11008758 to 0x11008780): the Earthworker, Robo-Surveyor, evacuation, ConVec,
-- Robo-Miner and eight-Cargo-Truck counts, then the five kits.
local t24, t26, t23, t43, t25, t10, t27, t28, t29, t30, t31

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local EruptLava, Lava2, MinorQuake1, MinorQuake2, MinorQuake3, MinorQuake4, ModerateQuake1, ModerateQuake2, ModerateQuake2Med, ModerateQuake3Hard

function EruptLava(t)
  if players[1].difficulty == "Easy" then
    game.set_tile({ 52, 6 }, 1104)
    game.set_tile({ 53, 6 }, 1115)
    game.set_tile({ 52, 7 }, 1126)
    game.set_tile({ 53, 7 }, 1137)
    game.create_eruption({ 52, 7 }, 80)
  elseif players[1].difficulty == "Normal" then
    game.set_tile({ 52, 6 }, 1104)
    game.set_tile({ 53, 6 }, 1115)
    game.set_tile({ 52, 7 }, 1126)
    game.set_tile({ 53, 7 }, 1137)
    game.create_eruption({ 52, 7 }, 100)
  else
    game.set_tile({ 52, 6 }, 1104)
    game.set_tile({ 53, 6 }, 1115)
    game.set_tile({ 52, 7 }, 1126)
    game.set_tile({ 53, 7 }, 1137)
    game.create_eruption({ 52, 7 }, 80)
    trigger.time{time = 300, on = Lava2}  -- after 3 marks
  end
end

function Lava2(t)
  game.set_tile({ 53, 23 }, 1147)
  game.set_tile({ 53, 24 }, 1158)
  game.create_eruption({ 53, 24 }, 80)
end

function MinorQuake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 46, 19 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 46, 19 }, 1)
  else
    game.create_earthquake({ 46, 19 }, 2)
  end
end

function MinorQuake2(t)
  game.create_earthquake({ 54, 24 }, 1)
end

function MinorQuake3(t)
  game.create_earthquake({ 19, 20 }, 1)
end

function MinorQuake4(t)
  game.create_earthquake({ 52, 8 }, 1)
end

function ModerateQuake1(t)
  game.create_earthquake({ 42, 53 }, 1)
end

function ModerateQuake2(t)
  game.create_earthquake({ 41, 27 }, 1)
end

function ModerateQuake2Med(t)
  game.create_earthquake({ 46, 24 }, 2)
end

function ModerateQuake3Hard(t)
  game.create_earthquake({ 20, 18 }, 2)
end

-- Every 40 ticks (0x110013A0): the colony's checks.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 14 then fail = true end
  if p.scientists < 6 then fail = true end
  if p.kids < 20 then fail = true end
  local ore, rare = p.ore, p.rare_ore
  for _, u in ipairs(p:units("CargoTruck")) do
    if u.cargo == "CommonMetal" then ore = ore + 1000 end
    if u.cargo == "RareMetal" then rare = rare + 1000 end
  end
  if ore < 6000 and not p:can_accumulate_ore() then fail = true end
  local missing = false
  for _, k in pairs({ t24, t26, t23, t43, t25, t10 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing then fail = true end
  local missing = false
  for _, k in pairs({ t27, t28, t29, t30, t31 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_building() then fail = true end
  if not p:has_tech(2701) and not p:can_do_research(2701) then fail = true end
  if not p:has_tech(2702) and not p:can_do_research(2702) then fail = true end
  if not p:has_tech(2703) and not p:can_do_research(2703) then fail = true end
  if not p:has_tech(2704) and not p:can_do_research(2704) then fail = true end
  if not p:has_tech(2705) and not p:can_do_research(2705) then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 52, 6 }, 1095)
  game.initial_set_tile({ 53, 6 }, 1107)
  game.initial_set_tile({ 52, 7 }, 1118)
  game.initial_set_tile({ 53, 7 }, 1129)
  game.initial_set_tile({ 53, 23 }, 1140)
  game.initial_set_tile({ 53, 24 }, 1150)
  game.set_daylight_everywhere(true)
  if difficulty == "Easy" then game.morale_steady("Good") end
  if difficulty == "Normal" then game.morale_steady("Good") end
  if difficulty == "Hard" then game.morale_steady("Fair") end
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end

  -- The win.
  t10 = trigger.count{type = "CargoTruck", compare = ">=", count = 8, player = 1}
  if difficulty == "Easy" or difficulty == "Normal" then
    t27 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t27, "Have a Tokamak kit in storage.")
    t28 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t28, "Have a Structure Factory kit in storage.")
    t29 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t29, "Have a Smelter kit in storage.")
    t30 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t30, "Have a Command Center kit in storage.")
    t31 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t31, "Have an Agridome kit in storage.")
  elseif difficulty == "Hard" then
    t27 = trigger.count{type = "ConVec", cargo = "Tokamak", compare = ">=", count = 1, player = 1}
    mission.victory(t27, "Have a Tokamak kit in a ConVec.")
    t28 = trigger.count{type = "ConVec", cargo = "StructureFactory", compare = ">=", count = 1, player = 1}
    mission.victory(t28, "Have a Structure Factory kit in a ConVec.")
    t31 = trigger.count{type = "ConVec", cargo = "CommonOreSmelter", compare = ">=", count = 1, player = 1}
    mission.victory(t31, "Have a Smelter kit in a ConVec.")
    t29 = trigger.count{type = "ConVec", cargo = "CommandCenter", compare = ">=", count = 1, player = 1}
    mission.victory(t29, "Have a Command Center kit in a ConVec.")
    t30 = trigger.count{type = "ConVec", cargo = "Agridome", compare = ">=", count = 1, player = 1}
    mission.victory(t30, "Have an Agridome kit in a ConVec.")
  end
  local t12 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 2, player = 1}
  mission.victory(t12, "Have 2000 units of food in Cargo Trucks.")
  local t11 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 6, player = 1}
  mission.victory(t11, "Have 6000 units of Metals in Cargo Trucks.")
  t23 = trigger.evac{player = 1}
  mission.victory(t23, "Have enough Evacuation Transports for your population.")
  t26 = trigger.count{type = "RoboSurveyor", compare = ">=", count = 1, player = 1}
  mission.victory(t26, "Have 1 or more Robo-Surveyors.")
  t25 = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
  mission.victory(t25, "Have 1 or more Robo-Miners.")
  t24 = trigger.count{type = "Earthworker", compare = ">=", count = 1, player = 1}
  mission.victory(t24, "Have 1 or more Earthworkers.")
  if difficulty == "Easy" or difficulty == "Normal" then
    t43 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t43, "Have 5 or more ConVecs.")
  end
  local t9 = trigger.research{tech = 2705, player = 1, one_shot = true}
  mission.victory(t9, "Reconstruct Social Sciences database.")
  local t8 = trigger.research{tech = 2704, player = 1, one_shot = true}
  mission.victory(t8, "Reconstruct Planetary Sciences database.")
  local t7 = trigger.research{tech = 2703, player = 1, one_shot = true}
  mission.victory(t7, "Reconstruct Chemistry database.")
  local t6 = trigger.research{tech = 2702, player = 1, one_shot = true}
  mission.victory(t6, "Reconstruct Boptronics database.")
  local t5 = trigger.research{tech = 2701, player = 1, one_shot = true}
  mission.victory(t5, "Reconstruct Astronomy database.")
  local t15 = trigger.resource{resource = "Scientists", compare = ">=", amount = 6, player = 1}
  mission.victory(t15, "Keep at least 6 scientists alive.")
  local t14 = trigger.resource{resource = "Workers", compare = ">=", amount = 14, player = 1}
  mission.victory(t14, "Keep at least 14 workers alive.")
  local t13 = trigger.resource{resource = "Kids", compare = ">=", amount = 20, player = 1}
  mission.victory(t13, "Keep at least 20 children alive.")
  local t53 = trigger.building_count{compare = "==", count = 0, player = 1, one_shot = true}
  mission.failure(t53)
  trigger.time{time = 200, on = MinorQuake1}  -- after 2 marks
  trigger.time{time = 500, on = MinorQuake2}  -- after 5 marks
  trigger.time{time = 4000, on = MinorQuake3}  -- after 40 marks
  trigger.time{time = 8000, on = MinorQuake4}  -- after 80 marks
  trigger.time{time = 11050, on = ModerateQuake1}  -- after 110 marks
  if difficulty == "Easy" then
    trigger.time{time = 15000, on = ModerateQuake2}  -- after 150 marks
    trigger.time{time = 17400, on = EruptLava}  -- after 174 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 15000, on = ModerateQuake2Med}  -- after 150 marks
    trigger.time{min = 15000, max = 15500, on = EruptLava}  -- after 150 to 155 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 15000, on = ModerateQuake2}  -- after 150 marks
    trigger.time{time = 11000, on = ModerateQuake3Hard}  -- after 110 marks
    trigger.time{time = 17200, on = EruptLava}  -- after 172 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

