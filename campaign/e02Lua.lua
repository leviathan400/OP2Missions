-- e02Lua.lua  -  Eden Mission #2 (Lua)
-- Trigger functions finished by hand (CheckForFail), from the disassembly of e02.dll.
-- Converted by op2dll from e02.dll. With e02Lua.placement.lua (what every difficulty makes alike),
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
        workers = 24, scientists = 15, kids = 36, food = 3900, ore = 3000,
        research = {  },
        tech_level = 1,
        kits = { [1] = { "CommandCenter" }, [2] = { "StructureFactory" }, [3] = { "CommonOreSmelter" }, [4] = { "Tokamak" } },
        view = { 56, 28 },
        units = {
          { type = "CargoTruck", direction = "NorthEast", at = { 84, 26 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 83, 24 } },
          { type = "CargoTruck", direction = "North", at = { 81, 25 } },
          { type = "CargoTruck", direction = "SouthWest", at = { 81, 27 } },
          { type = "RoboMiner", direction = "NorthEast", at = { 66, 36 } },
          { type = "Earthworker", direction = "NorthEast", at = { 61, 35 } },
          { type = "ConVec", direction = "NorthEast", at = { 60, 23 } },
          { type = "Tokamak", at = { 53, 36 } },
          { type = "ConVec", direction = "SouthWest", at = { 54, 37 } },
          { type = "CommonOreSmelter", at = { 59, 27 } },
          { type = "BasicLab", at = { 57, 22 } },
          { type = "StructureFactory", at = { 52, 24 } },
          { type = "ConVec", weapon = "Agridome", direction = "West", at = { 53, 20 } },
          { type = "Agridome", at = { 56, 25 } },
          { type = "ConVec", direction = "NorthEast", at = { 62, 23 } },
          { type = "RoboSurveyor", direction = "NorthEast", at = { 88, 26 } },
          { type = "RoboSurveyor", direction = "NorthEast", at = { 58, 34 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 64, 26 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 64, 27 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 64, 30 } },
          { type = "CargoTruck", direction = "NorthEast", cargo = "CommonMetal", amount = 1000, at = { 60, 30 } },
          { type = "CommonOreMine", at = { 92, 26 } },
        },
      },
    },
    walls = {
    },
    beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 92, 26 } },
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 24, scientists = 15, kids = 36, food = 3200,
        research = {  },
        tech_level = 1,
        view = { 56, 28 },
        units = {
          { type = "StructureFactory", at = { 56, 24 } },
          { type = "Tokamak", at = { 54, 36 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 84, 25 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 88, 23 } },
          { type = "CargoTruck", direction = "North", at = { 83, 20 } },
          { type = "CargoTruck", direction = "SouthWest", at = { 80, 21 } },
          { type = "RoboMiner", direction = "NorthEast", at = { 63, 24 } },
          { type = "RoboMiner", direction = "NorthEast", at = { 87, 28 } },
          { type = "Earthworker", direction = "NorthEast", at = { 58, 22 } },
          { type = "ConVec", weapon = "BasicLab", direction = "NorthEast", at = { 58, 31 } },
          { type = "ConVec", direction = "NorthEast", at = { 54, 37 } },
          { type = "ConVec", direction = "NorthEast", at = { 59, 25 } },
          { type = "ConVec", weapon = "Agridome", direction = "NorthEast", at = { 51, 27 } },
          { type = "ConVec", weapon = "CommonOreSmelter", direction = "NorthEast", at = { 57, 33 } },
          { type = "RoboSurveyor", direction = "NorthEast", at = { 87, 30 } },
          { type = "RoboSurveyor", direction = "NorthEast", at = { 65, 22 } },
          { type = "CargoTruck", direction = "SouthWest", cargo = "CommonMetal", amount = 1000, at = { 50, 26 } },
          { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, at = { 45, 24 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 44, 27 } },
          { type = "CargoTruck", direction = "SouthEast", cargo = "CommonMetal", amount = 1000, at = { 49, 24 } },
        },
      },
    },
    walls = {
    },
    beacons = {
    },
    late_beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Mid", at = { 92, 26 } },
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 24, scientists = 15, kids = 36, food = 3500,
        research = {  },
        tech_level = 1,
        view = { 56, 28 },
        units = {
          { type = "CargoTruck", direction = "NorthEast", at = { 55, 25 } },
          { type = "CargoTruck", direction = "NorthEast", at = { 57, 25 } },
          { type = "CargoTruck", direction = "North", at = { 58, 26 } },
          { type = "CargoTruck", direction = "SouthWest", at = { 59, 25 } },
          { type = "RoboMiner", direction = "NorthEast", at = { 6, 60 } },
          { type = "RoboMiner", direction = "NorthEast", at = { 7, 60 } },
          { type = "Earthworker", direction = "NorthEast", at = { 7, 58 } },
          { type = "ConVec", weapon = "BasicLab", direction = "NorthEast", at = { 13, 54 } },
          { type = "ConVec", weapon = "Tokamak", direction = "NorthEast", at = { 12, 53 } },
          { type = "ConVec", weapon = "StructureFactory", direction = "NorthEast", at = { 10, 51 } },
          { type = "ConVec", weapon = "Agridome", direction = "NorthEast", at = { 14, 55 } },
          { type = "ConVec", weapon = "CommonOreSmelter", direction = "NorthEast", at = { 11, 52 } },
          { type = "RoboSurveyor", direction = "NorthEast", at = { 5, 60 } },
          { type = "RoboSurveyor", direction = "NorthEast", at = { 6, 61 } },
          { type = "CargoTruck", direction = "SouthWest", cargo = "CommonMetal", amount = 1000, at = { 15, 52 } },
          { type = "CargoTruck", direction = "NorthWest", cargo = "CommonMetal", amount = 1000, at = { 8, 55 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 9, 55 } },
          { type = "CargoTruck", direction = "SouthEast", cargo = "CommonMetal", amount = 1000, at = { 12, 56 } },
        },
      },
    },
    walls = {
    },
    beacons = {
    },
    late_beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Mid", at = { 92, 26 } },
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


-- The triggers CheckForFail reads (0x11006FE8 to 0x11007010): six that must hold (the evacuation, ConVec,
-- Earthworker, Robo-Surveyor, Robo-Miner and Cargo Truck counts) and the five kits.
local t10, t17, t18, t19, t20, t37, t21, t22, t23, t24, t25

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local StartMicrobe

function StartMicrobe(t)
  if players[1].difficulty == "Easy" then
    game.create_blight({ 2, 64 })
    game.create_blight({ 2, 63 })
    game.create_blight({ 3, 64 })
    game.create_blight({ 3, 63 })
    game.create_blight({ 2, 64 })
    game.create_blight({ 2, 62 })
    game.create_blight({ 3, 62 })
    game.set_blight_speed(170)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 2016)
  elseif players[1].difficulty == "Normal" then
    game.create_blight({ 2, 64 })
    game.create_blight({ 2, 63 })
    game.create_blight({ 3, 64 })
    game.create_blight({ 3, 63 })
    game.create_blight({ 2, 64 })
    game.create_blight({ 2, 62 })
    game.create_blight({ 3, 62 })
    game.set_blight_speed(220)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 2016)
  else
    game.create_blight({ 2, 64 })
    game.create_blight({ 2, 63 })
    game.create_blight({ 3, 64 })
    game.create_blight({ 3, 63 })
    game.create_blight({ 2, 64 })
    game.create_blight({ 2, 62 })
    game.create_blight({ 3, 62 })
    game.set_blight_speed(160)
    game.message_at("Microbe growth detected!", 152, 1, 1056, 2016)
  end
end

-- Every 40 ticks (0x11001250): the colony's checks.
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = false
  if p.workers < 14 then fail = true end
  if p.scientists < 8 then fail = true end
  if p.kids < 20 then fail = true end
  local ore, rare = p.ore, p.rare_ore
  for _, u in ipairs(p:units("CargoTruck")) do
    if u.cargo == "CommonMetal" then ore = ore + 1000 end
    if u.cargo == "RareMetal" then rare = rare + 1000 end
  end
  if ore < 6000 and not p:can_accumulate_ore() then fail = true end
  local missing = false
  for _, k in pairs({ t17, t37, t18, t20, t19, t10 }) do
    if not k:has_fired(1) then missing = true end
  end
  if missing then fail = true end
  local missing = false
  for _, k in pairs({ t21, t22, t23, t24, t25 }) do
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
  roll_beacons(BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The beacons the original makes after all its units, so that the units keep its ids.
  for _, b in ipairs(d.late_beacons or {}) do game.create_beacon(b) end
  game.set_daylight_everywhere(true)
  if difficulty == "Easy" then game.morale_steady("Good") end
  if difficulty == "Normal" then game.morale_steady("Good") end
  if difficulty == "Hard" then game.morale_steady("Fair") end

  -- The win.
  t10 = trigger.count{type = "CargoTruck", compare = ">=", count = 8, player = 1}
  if difficulty == "Easy" or difficulty == "Normal" then
    t21 = trigger.kit{type = "Tokamak", count = 1, player = 1}
    mission.victory(t21, "Have a Tokamak kit in storage.")
    t22 = trigger.kit{type = "StructureFactory", count = 1, player = 1}
    mission.victory(t22, "Have a Structure Factory kit in storage.")
    t23 = trigger.kit{type = "CommonOreSmelter", count = 1, player = 1}
    mission.victory(t23, "Have a Smelter kit in storage.")
    t24 = trigger.kit{type = "CommandCenter", count = 1, player = 1}
    mission.victory(t24, "Have a Command Center kit in storage.")
    t25 = trigger.kit{type = "Agridome", count = 1, player = 1}
    mission.victory(t25, "Have an Agridome kit in storage.")
  elseif difficulty == "Hard" then
    t21 = trigger.count{type = "ConVec", cargo = "Tokamak", compare = ">=", count = 1, player = 1}
    mission.victory(t21, "Have a Tokamak kit in a ConVec.")
    t22 = trigger.count{type = "ConVec", cargo = "StructureFactory", compare = ">=", count = 1, player = 1}
    mission.victory(t22, "Have a Structure Factory kit in a ConVec.")
    t25 = trigger.count{type = "ConVec", cargo = "CommonOreSmelter", compare = ">=", count = 1, player = 1}
    mission.victory(t25, "Have a Smelter kit in a ConVec.")
    t23 = trigger.count{type = "ConVec", cargo = "CommandCenter", compare = ">=", count = 1, player = 1}
    mission.victory(t23, "Have a Command Center kit in a ConVec.")
    t24 = trigger.count{type = "ConVec", cargo = "Agridome", compare = ">=", count = 1, player = 1}
    mission.victory(t24, "Have an Agridome kit in a ConVec.")
  end
  local t12 = trigger.count{type = "CargoTruck", cargo = 1, compare = ">=", count = 2, player = 1}
  mission.victory(t12, "Have 2000 units of food in Cargo Trucks.")
  local t11 = trigger.count{type = "CargoTruck", cargo = 4, compare = ">=", count = 6, player = 1}
  mission.victory(t11, "Have 6000 units of Metals in Cargo Trucks.")
  t17 = trigger.evac{player = 1}
  mission.victory(t17, "Have enough Evacuation Transports for your population.")
  t20 = trigger.count{type = "RoboSurveyor", compare = ">=", count = 1, player = 1}
  mission.victory(t20, "Have 1 or more Robo-Surveyors.")
  t19 = trigger.count{type = "RoboMiner", compare = ">=", count = 1, player = 1}
  mission.victory(t19, "Have 1 or more Robo-Miners.")
  t18 = trigger.count{type = "Earthworker", compare = ">=", count = 1, player = 1}
  mission.victory(t18, "Have 1 or more Earthworkers.")
  if difficulty == "Easy" or difficulty == "Normal" then
    t37 = trigger.count{type = "ConVec", compare = ">=", count = 5, player = 1}
    mission.victory(t37, "Have 5 or more ConVecs.")
  end
  local t9 = trigger.research{tech = 2705, player = 1, one_shot = true}
  mission.victory(t9, "Reconstruct Social Sciences database.", {one_shot = true})
  local t8 = trigger.research{tech = 2704, player = 1, one_shot = true}
  mission.victory(t8, "Reconstruct Planetary Sciences database.", {one_shot = true})
  local t7 = trigger.research{tech = 2703, player = 1, one_shot = true}
  mission.victory(t7, "Reconstruct Chemistry database.", {one_shot = true})
  local t6 = trigger.research{tech = 2702, player = 1, one_shot = true}
  mission.victory(t6, "Reconstruct Boptronics database.", {one_shot = true})
  local t5 = trigger.research{tech = 2701, player = 1, one_shot = true}
  mission.victory(t5, "Reconstruct Astronomy database.", {one_shot = true})
  local t15 = trigger.resource{resource = "Scientists", compare = ">=", amount = 8, player = 1}
  mission.victory(t15, "Keep at least 8 scientists alive.")
  local t14 = trigger.resource{resource = "Workers", compare = ">=", amount = 14, player = 1}
  mission.victory(t14, "Keep at least 14 workers alive.")
  local t13 = trigger.resource{resource = "Kids", compare = ">=", amount = 20, player = 1}
  mission.victory(t13, "Keep at least 20 children alive.")
  local t47 = trigger.building_count{compare = "==", count = 0, player = 1, one_shot = true}
  mission.failure(t47)
  if difficulty == "Easy" then
    trigger.time{time = 13200, on = StartMicrobe}  -- after 132 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 15000, on = StartMicrobe}  -- after 150 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 19000, on = StartMicrobe}  -- after 190 marks
  end
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

