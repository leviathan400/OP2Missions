-- e03Lua.lua  -  Eden Mission #3 (Lua)
-- Trigger functions finished by hand (CheckForFail, StartMicrobe1), from the disassembly of e03.dll.
-- Converted by op2dll from e03.dll. With e03Lua.placement.lua (what every difficulty makes alike),
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
        workers = 14, scientists = 8, kids = 20, food = 3000, ore = 3300,
        research = { 3000 },
        tech_level = 2,
        kits = { [1] = { "Residence" }, [2] = { "Agridome" }, [3] = { "CommandCenter" }, [4] = { "StructureFactory" }, [5] = { "CommonOreSmelter" } },
        view = { 61, 29 },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 53, 26 } }, { "Tube", { 53, 27 } }, { "Tube", { 58, 36 } }, { "Tube", { 59, 36 } },
      { "Tube", { 70, 27 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 26, 17 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 61, 29 } },
      { type = "CommonOreSmelter", player = 1, at = { 53, 29 } },
      { type = "Agridome", player = 1, at = { 61, 36 } },
      { type = "Residence", player = 1, at = { 69, 36 } },
      { type = "Tokamak", player = 1, at = { 50, 41 } },
      { type = "University", player = 1, at = { 61, 22 } },
      { type = "Nursery", player = 1, at = { 61, 25 } },
      { type = "StructureFactory", player = 1, at = { 70, 29 } },
      { type = "Tokamak", player = 1, at = { 79, 36 } },
      { type = "Residence", player = 1, at = { 56, 36 } },
      { type = "Agridome", player = 1, at = { 53, 24 } },
      { type = "StandardLab", player = 1, at = { 70, 25 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 64, 26 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 66, 24 } },
      { type = "CommonOreMine", player = 1, at = { 26, 17 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 72, 31 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 70, 37 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 63, 37 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 55, 31 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 51, 42 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 51, 34 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 53, 34 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 59, 39 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 61, 39 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 77, 27 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 77, 29 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 77, 31 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 79, 27 } },
      { type = "CargoTruck", direction = "SouthWest", player = 1, at = { 81, 29 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 63, 39 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 14, scientists = 8, kids = 20, food = 1800, ore = 3500,
        research = { 3000 },
        tech_level = 2,
        kits = { [1] = { "Tokamak" }, [2] = { "CommandCenter" }, [3] = { "StructureFactory" } },
        view = { 61, 29 },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 53, 26 } }, { "Tube", { 53, 27 } }, { "Tube", { 58, 36 } }, { "Tube", { 59, 36 } },
      { "Tube", { 70, 27 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 29, 18 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 61, 29 } },
      { type = "CommonOreSmelter", player = 1, at = { 53, 29 } },
      { type = "Agridome", player = 1, at = { 61, 36 } },
      { type = "Residence", player = 1, at = { 69, 36 } },
      { type = "Tokamak", player = 1, at = { 50, 41 } },
      { type = "University", player = 1, at = { 61, 22 } },
      { type = "Nursery", player = 1, at = { 61, 25 } },
      { type = "StructureFactory", player = 1, at = { 70, 29 } },
      { type = "Residence", player = 1, at = { 56, 36 } },
      { type = "Agridome", player = 1, at = { 53, 24 } },
      { type = "StandardLab", player = 1, at = { 70, 25 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 64, 26 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 66, 24 } },
      { type = "CommonOreMine", player = 1, at = { 29, 18 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 72, 31 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 70, 37 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 63, 37 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 55, 31 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 51, 42 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 51, 34 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 53, 34 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 59, 39 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 61, 39 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 77, 27 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 77, 29 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 77, 31 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 79, 27 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 63, 39 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 14, scientists = 8, kids = 20, food = 1000, ore = 5000,
        research = { 3000 },
        tech_level = 2,
        kits = { [1] = { "Residence" } },
        view = { 61, 29 },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Mid", at = { 16, 21 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "High", at = { 95, 58 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "High", at = { 24, 52 }, beacon = true },
      { type = "CommandCenter", player = 1, at = { 61, 29 } },
      { type = "CommonOreSmelter", player = 1, at = { 53, 29 } },
      { type = "Agridome", player = 1, at = { 61, 36 } },
      { type = "Residence", player = 1, at = { 69, 36 } },
      { type = "Tokamak", player = 1, at = { 50, 41 } },
      { type = "University", player = 1, at = { 61, 22 } },
      { type = "Nursery", player = 1, at = { 61, 25 } },
      { type = "StructureFactory", player = 1, at = { 70, 29 } },
      { type = "StandardLab", player = 1, at = { 63, 32 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 64, 26 } },
      { type = "EvacuationTransport", direction = "SouthEast", player = 1, at = { 64, 26 } },
      { type = "RoboSurveyor", direction = "NorthEast", player = 1, at = { 66, 24 } },
      { type = "CommonOreMine", player = 1, at = { 16, 21 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 72, 31 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 70, 37 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 63, 37 } },
      { type = "ConVec", direction = "East", player = 1, at = { 72, 34 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 51, 42 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 51, 34 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 53, 34 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 59, 39 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 61, 39 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 77, 27 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 77, 29 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 77, 31 } },
      { type = "CargoTruck", direction = "NorthWest", player = 1, at = { 79, 27 } },
      { type = "Earthworker", direction = "East", player = 1, at = { 63, 39 } },
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

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function FreeMorale(t) end
function Teleop(t) end


-- The triggers CheckForFail reads (0x110071A0 to 0x110071C8): on Normal the Robo-Surveyor, evacuation and ConVec
-- counts, then the five kits.
local t19, t21, t23, t5, t6, t7, t8, t9
-- StartMicrobe1's flags (0x11007198, 0x1100719C).
local microbe_started, microbe_calls = false, 0

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Quake1, Quake2, Quake3, Quake4, Quake5, Quake6, QuakeRepeater, QuakeRepeater2, QuakeRepeater2Start

function Quake1(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 33, 61 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 33, 61 }, 1)
  else
    game.create_earthquake({ 33, 61 }, 2)
  end
end

function Quake2(t)
  game.create_earthquake({ 95, 57 }, 1)
end

function Quake3(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 118, 53 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 118, 53 }, 1)
  else
    game.create_earthquake({ 118, 53 }, 2)
  end
end

function Quake4(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 114, 43 }, 1)
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 114, 43 }, 1)
  else
    game.create_earthquake({ 114, 43 }, 2)
  end
end

function Quake5(t)
  local r1 = game.rand(7)
  local r2 = game.rand(7)
  game.create_earthquake({ r2 + 42, r1 + 30 }, 1)
end

function Quake6(t)
  local r1 = game.rand(7)
  local r2 = game.rand(7)
  game.create_earthquake({ r2 + 75, r1 + 35 }, 1)
end

function QuakeRepeater(t)
  local r1 = game.rand(60)
  local r2 = game.rand(44)
  game.create_earthquake({ r2 + 1, r1 + 2 }, 1)
end

function QuakeRepeater2(t)
  local r1 = game.rand(16)
  local r2 = game.rand(27)
  game.create_earthquake({ r2 + 48, r1 + 23 }, 1)
end

function QuakeRepeater2Start(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 7000, max = 8000, one_shot = false, on = QuakeRepeater2}  -- after 70 to 80 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 6000, max = 7000, one_shot = false, on = QuakeRepeater2}  -- after 60 to 70 marks
  else
    trigger.time{min = 7000, max = 8000, one_shot = false, on = QuakeRepeater2}  -- after 70 to 80 marks
  end
end

-- Every 40 ticks (0x11001830): the colony's checks.
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
  if ore < (players[1].difficulty == "Easy" and 5000 or 6000) and not p:can_accumulate_ore() then fail = true end
  local missing = false
  for _, k in pairs({ t21, t23, t19 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_vehicle(1) then fail = true end
  local missing = false
  for _, k in pairs({ t5, t6, t7, t8, t9 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing and not p:can_build_building() then fail = true end
  if not p:has_tech(3602) and not p:can_do_research(3602) then fail = true end
  if not p:has_tech(3851) and not p:can_do_research(3851) then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- The Blight on six tiles at 17,63 - 19,64, with a message, spreading by difficulty; on Easy only at its second call
-- (0x11001310).
function StartMicrobe1(t)
  if microbe_started then return end
  microbe_calls = microbe_calls + 1
  if microbe_calls < 2 and players[1].difficulty == "Easy" then return end
  microbe_started = true
  for _, y in ipairs({ 63, 64 }) do
    for x = 17, 19 do game.create_blight({ x, y }) end
  end
  game.message_at("Microbe growth detected!", 152, 1, 1536, 1984)
  game.set_blight_speed(({ Easy = 70, Normal = 110, Hard = 130 })[players[1].difficulty])
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
  if difficulty == "Easy" then
    trigger.time{time = 10, on = FreeMorale}  -- after 0 marks  -- FreeMorale isn't converted
  end

  -- The win.
  if difficulty == "Easy" or difficulty == "Normal" then
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
  end
  local t15 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 3, player = 1}
  mission.victory(t15, "Have 3000 units of food in Cargo Trucks.")
  local t18, t17, t21h
  if difficulty == "Easy" then
    t18 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 5, player = 1}
    mission.victory(t18, "Have 5000 units of Metals in Cargo Trucks.")
  elseif difficulty == "Normal" then
    t17 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 6, player = 1}
    mission.victory(t17, "Have 6000 units of Metals in Cargo Trucks.")
  elseif difficulty == "Hard" then
    t17 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 6, player = 1}
    mission.victory(t17, "Have 6000 units of Metals in Cargo Trucks.")
    t23 = trigger.count{type = "Lynx", compare = ">=", count = 5, player = 1}
    mission.victory(t23, "Have 5 or more Lynx.")
    t21h = trigger.count{type = "Scout", compare = ">=", count = 3, player = 1}
    mission.victory(t21h, "Have 3 or more Scouts.")
  end
  t19 = trigger.count{type = "RoboSurveyor", compare = ">=", count = 1, player = 1}
  mission.victory(t19, "Have 1 or more Robo-Surveyors.")
  local t25
  if difficulty == "Hard" then
    t25 = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
    mission.victory(t25, "Have 1 or more Robo-Miners.")
  end
  t21 = trigger.evac{player = 1}
  mission.victory(t21, "Have enough Evacuation Transports for your population.")
  if difficulty == "Easy" or difficulty == "Normal" then
    t23 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t23, "Have 5 or more ConVecs.")
    t25 = trigger.research{tech = 3401, player = 1, one_shot = true, on = Teleop}
    mission.victory(t25, "Completely research Cybernetic Teleoperations.")
  end
  local t27 = trigger.research{tech = 3303, player = 1, one_shot = true}
  mission.victory(t27, "Completely research Health Maintenance.")
  local t29 = trigger.research{tech = 3301, player = 1, one_shot = true}
  mission.victory(t29, "Completely research Emergency Response Systems.")
  local t33 = trigger.resource{resource = "Scientists", compare = ">=", amount = 15, player = 1}
  mission.victory(t33, "Have at least 15 scientists alive.")
  local t31, t32
  if difficulty == "Easy" or difficulty == "Normal" then
    t31 = trigger.resource{resource = "Workers", compare = ">=", amount = 22, player = 1}
    mission.victory(t31, "Have at least 22 workers alive.")
    t32 = trigger.resource{resource = "Kids", compare = ">=", amount = 28, player = 1}
    mission.victory(t32, "Have at least 28 children alive.")
  elseif difficulty == "Hard" then
    t31 = trigger.resource{resource = "Workers", compare = ">=", amount = 20, player = 1}
    mission.victory(t31, "Have at least 20 workers alive.")
    t32 = trigger.resource{resource = "Kids", compare = ">=", amount = 26, player = 1}
    mission.victory(t32, "Have at least 26 children alive.")
  end
  local t46 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t46)
  if difficulty == "Easy" then
    trigger.time{time = 22400, on = StartMicrobe1}  -- after 224 marks
    trigger.resource{resource = "Colonists", compare = ">=", amount = 90, player = 1, one_shot = true, on = StartMicrobe1}
  elseif difficulty == "Normal" then
    trigger.time{time = 23500, on = StartMicrobe1}  -- after 235 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 38000, on = StartMicrobe1}  -- after 380 marks
  end
  trigger.time{time = 1200, on = Quake1}  -- after 12 marks
  trigger.time{min = 14500, max = 16000, on = Quake2}  -- after 145 to 160 marks
  trigger.time{min = 22000, max = 24000, on = Quake3}  -- after 220 to 240 marks
  trigger.time{min = 32000, max = 34000, on = Quake4}  -- after 320 to 340 marks
  if difficulty == "Normal" then
    trigger.time{time = 6000, on = QuakeRepeater2Start}  -- after 60 marks
    trigger.time{min = 3000, max = 3700, one_shot = false, on = QuakeRepeater}  -- after 30 to 37 marks
    trigger.time{min = 18000, max = 19000, on = Quake5}  -- after 180 to 190 marks
    trigger.time{min = 23000, max = 26000, on = Quake6}  -- after 230 to 260 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 8000, on = QuakeRepeater2Start}  -- after 80 marks
    trigger.time{min = 3000, max = 3700, one_shot = false, on = QuakeRepeater}  -- after 30 to 37 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

-- Not converted:
-- - FreeMorale isn't converted: it calls FreeMoraleLevel
-- - Teleop isn't converted: it calls CreateOperationalTrigger
