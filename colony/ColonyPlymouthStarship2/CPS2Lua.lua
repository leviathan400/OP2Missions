-- CPS2Lua.lua  -  Colony Builder II - Plymouth, Starship (Lua)
-- Trigger functions finished by hand (CheckForFail, DoMeteor, DoQuake, DoLightning, DoTornado, GiveAIOre, Microbe, Base1RareCheck, Base1BSmelterCheck, Base3SmelterCheck, Base3RareSmelterCheck, Base3Finish, BasePlaced), from the disassembly of CPS2.dll.
-- Converted by op2dll from CPS2.dll. With CPS2Lua.placement.lua (what every difficulty makes alike),
-- this makes the colony's start: what changes with the difficulty, and the beacons the setup rolls.
-- Games run: Easy 505, Normal 610, Hard 542.
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
        workers = 28, scientists = 13, kids = 15, food = 6000, ore = 5000,
        research = { 3304, 3305, 3401 },
        view = { 0, 0 },
        units = {
        },
        start_area = { 107, 6, 197, 6 },  -- 91 of its 91 tiles seen
        kit = {
          { type = "RoboSurveyor", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "CommandCenter", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "Tokamak", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "CommonOreSmelter", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "StructureFactory", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "Agridome", direction = "North", at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "Food", amount = 1000, at = { 0, 0 } },
          { type = "RoboMiner", direction = "North", at = { 0, 0 } },
          { type = "Earthworker", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "StandardLab", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "VehicleFactory", direction = "North", at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
        },
      },
      [2] = {
        ore = 10000,
        research = {  },
        tech_level = 3,
        units = {
        },
      },
    },
    walls = {
    },
    beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 53, 25 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 31, 58 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 63, 10 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 155, 35 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 123, 77 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 12, 71 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 118, 29 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 133, 17 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 84, 119 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 251, 102 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 170, 121 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 190, 6 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 171, 68 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 84, 102 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 58 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 65, 13 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 56, 125 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 12, 92 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 216, 4 } },
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 26, scientists = 13, kids = 15, food = 6000, ore = 4000,
        research = {  },
        view = { 0, 0 },
        units = {
        },
        start_area = { 107, 6, 197, 6 },  -- 90 of its 91 tiles seen
        kit = {
          { type = "RoboSurveyor", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "CommandCenter", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "Tokamak", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "CommonOreSmelter", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "StructureFactory", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "Agridome", direction = "North", at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "Food", amount = 1000, at = { 0, 0 } },
          { type = "RoboMiner", direction = "North", at = { 0, 0 } },
          { type = "Earthworker", direction = "North", at = { 0, 0 } },
        },
      },
      [2] = {
        ore = 10000,
        research = {  },
        tech_level = 3,
        units = {
        },
      },
    },
    walls = {
    },
    beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 53, 25 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 31, 58 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 63, 10 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 155, 35 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 123, 77 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 12, 71 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 118, 29 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 84, 119 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 251, 102 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 170, 121 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 190, 6 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 171, 68 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 84, 102 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 58 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 65, 13 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 56, 125 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 12, 92 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 216, 4 } },
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 26, scientists = 13, kids = 15, food = 6000, ore = 3000,
        research = {  },
        view = { 0, 0 },
        units = {
        },
        start_area = { 107, 6, 197, 6 },  -- 89 of its 91 tiles seen
        kit = {
          { type = "RoboSurveyor", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "CommandCenter", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "Tokamak", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "CommonOreSmelter", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "StructureFactory", direction = "North", at = { 0, 0 } },
          { type = "ConVec", weapon = "Agridome", direction = "North", at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "CommonMetal", amount = 1000, at = { 0, 0 } },
          { type = "CargoTruck", direction = "North", cargo = "Food", amount = 1000, at = { 0, 0 } },
          { type = "RoboMiner", direction = "North", at = { 0, 0 } },
          { type = "Earthworker", direction = "North", at = { 0, 0 } },
        },
      },
      [2] = {
        ore = 10000,
        research = {  },
        tech_level = 3,
        units = {
        },
      },
    },
    walls = {
    },
    beacons = {
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 53, 25 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 31, 58 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 63, 10 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 155, 35 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 123, 77 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 12, 71 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 84, 119 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 251, 102 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 170, 121 } },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 190, 6 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 171, 68 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 84, 102 } },
      { type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 65, 58 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 65, 13 } },
      { type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 56, 125 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 12, 92 } },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 216, 4 } },
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
    { type = "CommandCenter", at = { 238, 52 } },
    { type = "Tokamak", at = { 242, 40 } },
    { type = "CommonOreSmelter", at = { 230, 51 } },
    { type = "Agridome", at = { 242, 52 } },
    { type = "StructureFactory", at = { 243, 48 } },
    { type = "CommonOreMine", at = { 225, 52 } },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_base1, ai_base2, ai_mining1, ai_base3, ai_fight1, ai_fight2, ai_fight3, ai_fight4
local TimeUpgrades_step = 0

local function setup_ai(p)
  ai_player = p
  p:go_eden()
  p.ore = 10000
  p:set_tech_level(3)
  ai_base1 = ai.building_group(p)
  ai_base1:set_rect({ 234, 46, 255, 55 })
  ai_base1:add_units(ai_block(1))
  ai_base1:record_unit_block(ai_block(1), ai_base1)
  ai_base1:record_veh_reinforce_group(ai_base1, 1000)
  ai_base1:set_targ_count("ConVec", nil, 2)
  ai_base1:set_targ_count("Earthworker", nil, 1)
  ai_base1:record_tubes_touching({ 238, 52 })
  ai_base1:take_unit(game.create_unit{ type = "ConVec", player = p, at = { 238, 52 }, exact = true, lights = false }[1])
  ai_base2 = ai.building_group(p)
  ai_base2:set_rect({ 206, 33, 213, 49 })
  ai_base2:set_targ_count("Earthworker", nil, 1)
  ai_base1:record_veh_reinforce_group(ai_base2, 1)
  ai_base1:record_building({ 246, 52 }, "StandardLab")
  ai_base1:record_building({ 251, 51 }, "VehicleFactory", nil, ai_base1)
  ai_base1:record_building({ 247, 49 }, "Residence")
  ai_base1:record_building({ 238, 55 }, "Nursery")
  ai_base1:record_building({ 246, 55 }, "RobotCommand")
  ai_base1:record_building({ 242, 55 }, "University")
  ai_base1:record_building({ 246, 40 }, "Tokamak")
  ai_base1:record_building({ 233, 39 }, "AdvancedLab")
  ai_base1:record_building({ 235, 49 }, "DIRT")
  ai_base1:record_building({ 235, 55 }, "MedicalCenter")
  ai_base1:record_building({ 218, 48 }, "GuardPost", "RailGun")
  ai_base1:record_building({ 248, 66 }, "GuardPost", "Laser")
  ai_base1:record_building({ 250, 40 }, "Tokamak")
  ai_base1:record_building({ 249, 55 }, "Residence")
  ai_base1:record_tube({ 233, 50 })
  ai_base1:record_tube({ 233, 49 })
  ai_base1:record_tube({ 233, 48 })
  ai_base1:record_tube({ 233, 47 })
  ai_base1:record_tube({ 233, 46 })
  ai_base1:record_tube({ 233, 45 })
  ai_base1:record_tube({ 233, 44 })
  ai_base1:record_tube({ 233, 43 })
  ai_base1:record_tube({ 233, 42 })
  ai_base1:record_wall({ 230, 36 })
  ai_base1:record_wall({ 230, 37 })
  ai_base1:record_wall({ 230, 38 })
  ai_base1:record_wall({ 230, 39 })
  ai_base1:record_wall({ 230, 40 })
  ai_base1:record_wall({ 230, 41 })
  ai_base1:record_wall({ 230, 42 })
  ai_base1:record_wall({ 231, 36 })
  ai_base1:record_wall({ 231, 42 })
  ai_base1:record_wall({ 232, 36 })
  ai_base1:record_wall({ 232, 42 })
  ai_base1:record_wall({ 233, 36 })
  ai_base1:record_wall({ 234, 36 })
  ai_base1:record_wall({ 235, 36 })
  ai_base1:record_wall({ 235, 42 })
  ai_base1:record_wall({ 236, 36 })
  ai_base1:record_wall({ 236, 37 })
  ai_base1:record_wall({ 236, 38 })
  ai_base1:record_wall({ 236, 39 })
  ai_base1:record_wall({ 236, 40 })
  ai_base1:record_wall({ 236, 41 })
  ai_base1:record_wall({ 236, 42 })
  ai_base1:record_wall({ 239, 37 })
  ai_base1:record_wall({ 239, 38 })
  ai_base1:record_wall({ 239, 39 })
  ai_base1:record_wall({ 239, 40 })
  ai_base1:record_wall({ 239, 41 })
  ai_base1:record_wall({ 239, 42 })
  ai_base1:record_wall({ 240, 37 })
  ai_base1:record_wall({ 240, 42 })
  ai_base1:record_wall({ 241, 37 })
  ai_base1:record_wall({ 241, 42 })
  ai_base1:record_wall({ 242, 37 })
  ai_base1:record_wall({ 242, 42 })
  ai_base1:record_wall({ 243, 37 })
  ai_base1:record_wall({ 243, 42 })
  ai_base1:record_wall({ 244, 37 })
  ai_base1:record_wall({ 244, 42 })
  ai_base1:record_wall({ 245, 37 })
  ai_base1:record_wall({ 246, 37 })
  ai_base1:record_wall({ 246, 42 })
  ai_base1:record_wall({ 247, 37 })
  ai_base1:record_wall({ 247, 42 })
  ai_base1:record_wall({ 248, 37 })
  ai_base1:record_wall({ 249, 37 })
  ai_base1:record_wall({ 249, 42 })
  ai_base1:record_wall({ 250, 37 })
  ai_base1:record_wall({ 250, 42 })
  ai_base1:record_wall({ 251, 37 })
  ai_base1:record_wall({ 251, 42 })
  ai_base1:record_wall({ 252, 37 })
  ai_base1:record_wall({ 252, 38 })
  ai_base1:record_wall({ 252, 39 })
  ai_base1:record_wall({ 252, 40 })
  ai_base1:record_wall({ 252, 41 })
  ai_base1:record_wall({ 252, 42 })
  ai_base2:record_tube({ 232, 44 })
  ai_base2:record_tube({ 231, 44 })
  ai_base2:record_tube({ 230, 44 })
  ai_base2:record_tube({ 229, 44 })
  ai_base2:record_tube({ 228, 44 })
  ai_base2:record_tube({ 227, 44 })
  ai_base2:record_tube({ 226, 44 })
  ai_base2:record_tube({ 225, 44 })
  ai_base2:record_tube({ 224, 44 })
  ai_base2:record_tube({ 223, 44 })
  ai_base2:record_tube({ 222, 44 })
  ai_base2:record_tube({ 221, 44 })
  ai_base2:record_tube({ 220, 44 })
  ai_base2:record_tube({ 220, 45 })
  ai_base2:record_tube({ 220, 46 })
  ai_base2:record_tube({ 220, 47 })
  ai_base2:record_tube({ 220, 48 })
  ai_mining1 = ai.mining_group(p)
  ai_mining1:setup({ 224, 52 }, { 231, 52 }, "CommonOreMine", "CommonOreSmelter", { 226, 47, 232, 54 })
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 231, 52 }, exact = true, lights = false }[1])
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { x = 1262, y = 51, raw = true }, exact = true, lights = false }[1])
  ai_mining1:set_targ_count("CargoTruck", nil, 3)
  ai_base1:record_veh_reinforce_group(ai_mining1, 100)
  ai_base3 = ai.building_group(p)
  ai_base3:set_rect({ 40, 94, 50, 101 })
  ai_base3:record_veh_reinforce_group(ai_base3, 1000)
  ai_base3:set_targ_count("ConVec", nil, 2)
  ai_base3:set_targ_count("Earthworker", nil, 1)
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 231, 37, 256, 55 })
  ai_fight1:clear_guarded_rects()
  ai_fight1:add_guarded_rect({ 224, 2, 256, 61 })
  ai_fight1:add_guarded_rect({ 245, 63, 251, 68 })
  ai_fight1:set_targ_count("Lynx", "Laser", 5)
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 231, 37, 256, 55 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 231, 37, 256, 55 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 231, 37, 256, 55 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 231, 37, 256, 55 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 184, 58, 191, 62 })
  ai_fight2:clear_guarded_rects()
  ai_fight2:add_guarded_rect({ 187, 35, 221, 67 })
  ai_fight2:add_guarded_rect({ 201, 23, 215, 34 })
  ai_fight2:set_targ_count("Lynx", "Laser", 4)
  ai_fight2:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 192, 44, 210, 64 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight2:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 192, 44, 210, 64 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 61, 96, 70, 103 })
  ai_fight3:clear_guarded_rects()
  ai_fight3:add_guarded_rect({ 20, 88, 61, 127 })
  ai_fight3:add_guarded_rect({ 62, 95, 74, 104 })
  ai_fight3:set_targ_count("Lynx", "Laser", 4)
  ai_fight3:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 44, 91, 59, 114 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_fight3:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 44, 91, 59, 114 }), weapon = "Laser", exact = true, lights = false }[1])
  ai_base1:record_veh_reinforce_group(ai_fight1, 10)
  ai_base1:record_veh_reinforce_group(ai_fight2, 2)
  ai_base1:record_veh_reinforce_group(ai_fight3, 2)
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_patrol_only()
  ai_fight4:set_patrol({ { 63, 10 }, { 155, 35 }, { 123, 77 }, { 12, 71 }, { 84, 119 }, { 251, 102 }, { 170, 121 } }, 6)
  ai_fight4:set_rect({ 184, 58, 191, 62 })
  ai_fight4:take_unit(game.create_unit{ type = "Scout", player = p, at = game.rand_point({ 231, 37, 256, 55 }), exact = true, lights = false }[1])
  ai_fight4:take_unit(game.create_unit{ type = "Scout", player = p, at = game.rand_point({ 192, 44, 210, 64 }), exact = true, lights = false }[1])
  ai_fight4:take_unit(game.create_unit{ type = "Scout", player = p, at = game.rand_point({ 44, 91, 59, 114 }), exact = true, lights = false }[1])
end

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function TraceOre(t) end


-- The win's Common Metals and Rare Metals evacuations (the setup's triggers 9 and 11, kept at 0x1100CDDC and
-- 0x1100CDE0), for CheckForFail.
local t9, t11
-- Whether BasePlaced has acted (0x1100CE0C), and the trigger of the computer's first move (0x1100CDE4).
local base_placed, attack_trigger = false, nil
-- The mining groups made once smelters stand: base 1's rare ore (0x1100CD98), base 1B's two (0x1100CD90, the second
-- on Hard, 0x1100CD94) and base 3's two (0x1100CD9C, 0x1100CDA0).
local ai_base1_rare_mining, ai_base1b_mining, ai_base1b_mining2, ai_base3_mining, ai_base3_rare_mining
-- Where CPS2's disasters don't strike (game tiles, 0x1100CBA0, 0x1100CBB0).
local CALM = { { 256, 31, 287, 58 }, { 68, 89, 93, 109 } }
-- What GiveAIOre gives player 2 by difficulty (0x1100A000, 0x1100A010).
local AI_ORE = { Easy = 1000, Normal = 2000, Hard = 3000 }
local AI_RARE_ORE = { Easy = 100, Normal = 300, Hard = 500 }

local function in_rect(x, y, r) return x >= r[1] and x <= r[3] and y >= r[2] and y <= r[4] end
-- A tile drawn anywhere (x 32 to 287, y 0 to 127, game tiles), again while it falls in a calm area or, before tick
-- 20000, while a unit of player 1 stands within 5 tiles (0x11007C30); as the status bar has it.
local function wild_tile()
  local x, y
  repeat
    x, y = game.rand(256) + 32, game.rand(128)
    local calm = in_rect(x, y, CALM[1]) or in_rect(x, y, CALM[2])
    if not calm and game.tick() < 20000 then
      for _, u in ipairs(game.units_in_range({ x - 31, y + 1 }, 5)) do
        if u.owner == 0 then calm = true break end
      end
    end
  until not calm
  return { x - 31, y + 1 }
end

-- The computer's attack waves and its leaving, not converted yet (SpawnAttack, ExitMapMultiple).
function SpawnAttack(t) end
function ExitMapMultiple(t) end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local AddDirts, Base1RareCheck, Base3SmelterCheck, ExpandBase1A, ExpandBase1B, ExpandBase1C, ExpandBase1D, Lava_Flow, Lava_Vent, Microbe, SetupBase3, TimeUpgrades

function AddDirts(t)
  ai_base1:record_building({ 247, 23 }, "DIRT")
  ai_base1:record_building({ 243, 23 }, "DIRT")
  ai_base1:record_building({ 243, 27 }, "DIRT")
  ai_base3:record_building({ 39, 105 }, "DIRT")
  ai_base3:record_building({ 47, 112 }, "DIRT")
  ai_base3:record_building({ 27, 113 }, "DIRT")
end

function Base1RareCheck(t)
end

function Base3SmelterCheck(t)
end

function ExpandBase1A(t)
  t:destroy()
  trigger.time{time = 107, one_shot = false, on = Base1RareCheck}
  ai_base1:record_building({ 246, 52 }, "StandardLab")
  ai_base1:record_building({ 239, 33 }, "Agridome")
  ai_base1:record_building({ 243, 33 }, "Residence")
  ai_base1:record_building({ 245, 30 }, "CommonStorage")
  ai_base1:record_building({ 245, 18 }, "RareOreSmelter", nil, ai_base1)
  ai_base1:record_building({ 246, 33 }, "Residence")
  ai_base1:record_building({ 249, 33 }, "RecreationFacility")
  ai_base1:record_building({ 252, 33 }, "MedicalCenter")
  ai_base1:record_building({ 239, 30 }, "DIRT")
  ai_base1:record_building({ 243, 30 }, "CommonStorage")
  ai_base1:record_building({ 249, 30 }, "RareStorage")
  ai_base1:record_building({ 247, 30 }, "RareStorage")
  ai_base1:record_tube({ 234, 44 })
  ai_base1:record_tube({ 235, 44 })
  ai_base1:record_tube({ 236, 44 })
  ai_base1:record_tube({ 237, 44 })
  ai_base1:record_tube({ 238, 44 })
  ai_base1:record_tube({ 238, 44 })
  ai_base1:record_tube({ 238, 43 })
  ai_base1:record_tube({ 238, 42 })
  ai_base1:record_tube({ 238, 41 })
  ai_base1:record_tube({ 238, 40 })
  ai_base1:record_tube({ 238, 39 })
  ai_base1:record_tube({ 238, 38 })
  ai_base1:record_tube({ 238, 37 })
  ai_base1:record_tube({ 238, 36 })
  ai_base1:record_tube({ 238, 35 })
  ai_base1:record_tube({ 238, 34 })
  ai_base1:record_tube({ 245, 28 })
  ai_base1:record_tube({ 245, 27 })
  ai_base1:record_tube({ 245, 26 })
  ai_base1:record_tube({ 245, 25 })
  ai_base1:record_tube({ 245, 24 })
  ai_base1:record_tube({ 245, 23 })
  ai_base1:record_tube({ 245, 22 })
  ai_base1:record_tube({ 245, 21 })
  ai_base1:record_tube({ 249, 57 })
  ai_base1:record_tube({ 249, 58 })
  ai_base1:record_tube({ 249, 59 })
  ai_base1:record_tube({ 249, 60 })
  ai_base1:record_tube({ 249, 61 })
  ai_base1:record_tube({ 249, 62 })
  ai_base1:record_tube({ 249, 63 })
  ai_base1:record_tube({ 249, 64 })
  ai_base1:record_tube({ 249, 65 })
end

function ExpandBase1B(t)
  t:destroy()
  trigger.time{time = 107, one_shot = false, on = Base1BSmelterCheck}
  ai_base1:set_targ_count("ConVec", nil, 3)
  ai_base1:record_building({ 209, 37 }, "CommonOreSmelter", nil, ai_base1)
  ai_base1:record_building({ 207, 46 }, "CommandCenter")
  ai_base1:record_building({ 203, 45 }, "StructureFactory", nil, ai_base1)
  ai_base1:record_building({ 203, 49 }, "VehicleFactory", nil, ai_base1)
  ai_base1:record_building({ 191, 58 }, "GuardPost", "EMP")
  ai_base2:record_tube({ 219, 47 })
  ai_base2:record_tube({ 218, 47 })
  ai_base2:record_tube({ 217, 47 })
  ai_base2:record_tube({ 216, 47 })
  ai_base2:record_tube({ 215, 47 })
  ai_base2:record_tube({ 214, 47 })
  ai_base2:record_tube({ 213, 47 })
  ai_base2:record_tube({ 212, 47 })
  ai_base2:record_tube({ 211, 47 })
  ai_base2:record_tube({ 210, 47 })
  ai_base2:record_tube({ 209, 47 })
  ai_base2:record_tube({ 209, 46 })
  ai_base2:record_tube({ 209, 45 })
  ai_base2:record_tube({ 209, 44 })
  ai_base2:record_tube({ 209, 43 })
  ai_base2:record_tube({ 209, 42 })
  ai_base2:record_tube({ 209, 41 })
  ai_base2:record_tube({ 209, 40 })
end

function ExpandBase1C(t)
  t:destroy()
  ai_base1:record_building({ 248, 62 }, "GuardPost", "RailGun")
  ai_base1:record_building({ 194, 58 }, "GuardPost", "EMP")
  ai_base1:record_building({ 194, 53 }, "GuardPost", "AcidCloud")
  ai_base1:record_building({ 203, 53 }, "Agridome")
  ai_base1:record_building({ 203, 56 }, "AdvancedResidence")
  ai_base1:record_building({ 199, 56 }, "AdvancedResidence")
  ai_base1:record_building({ 200, 53 }, "MedicalCenter")
  ai_base1:record_building({ 207, 49 }, "Observatory")
  ai_base1:record_building({ 213, 55 }, "Spaceport")
  ai_base1:record_building({ 199, 60 }, "MeteorDefense")
  ai_base1:record_building({ 213, 62 }, "GeothermalPlant")
  ai_base1:record_building({ 252, 55 }, "RecreationFacility")
  ai_base1:record_tube({ 198, 57 })
  ai_base1:record_tube({ 197, 57 })
  ai_base1:record_tube({ 196, 57 })
  ai_base1:record_tube({ 195, 57 })
  ai_base1:record_tube({ 194, 57 })
  ai_base1:record_tube({ 193, 57 })
  ai_base1:record_tube({ 192, 57 })
  ai_base2:record_tube({ 213, 48 })
  ai_base2:record_tube({ 213, 49 })
  ai_base2:record_tube({ 213, 50 })
  ai_base2:record_tube({ 213, 51 })
  ai_base2:record_tube({ 213, 52 })
  ai_base2:record_tube({ 205, 44 })
  ai_base2:record_tube({ 206, 44 })
  ai_base2:record_tube({ 207, 44 })
  ai_base2:record_tube({ 208, 44 })
end

function ExpandBase1D(t)
  if players[1].difficulty == "Easy" then
    t:destroy()
    ai_base1:record_building({ 191, 64 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 189, 53 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 194, 55 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 194, 60 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 199, 62 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 206, 43 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 213, 46 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 233, 52 }, "GuardPost", "EMP")
    ai_base1:record_building({ 246, 57 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 248, 57 }, "GuardPost", "EMP")
    ai_base1:record_building({ 252, 57 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 254, 55 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 242, 57 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 198, 49 }, "Agridome")
    ai_base1:record_building({ 198, 45 }, "ConsumerFactory")
    ai_base1:record_building({ 202, 60 }, "GORF")
    ai_base1:record_building({ 249, 48 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 205, 37 }, "RareStorage")
    ai_base1:record_building({ 206, 52 }, "RareStorage")
    ai_base1:record_building({ 198, 41 }, "AdvancedResidence")
    ai_base1:record_building({ 202, 41 }, "AdvancedResidence")
    ai_base1:record_building({ 206, 55 }, "RareStorage")
    ai_base1:record_building({ 223, 43 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 235, 52 }, "GuardPost", "ThorsHammer")
    ai_base1:record_wall({ 189, 62 })
    ai_base1:record_wall({ 189, 63 })
    ai_base1:record_wall({ 190, 56 })
    ai_base1:record_wall({ 190, 62 })
    ai_base1:record_wall({ 191, 51 })
    ai_base1:record_wall({ 191, 56 })
    ai_base1:record_wall({ 191, 62 })
    ai_base1:record_wall({ 192, 51 })
    ai_base1:record_wall({ 192, 54 })
    ai_base1:record_wall({ 192, 55 })
    ai_base1:record_wall({ 192, 56 })
    ai_base1:record_wall({ 192, 60 })
    ai_base1:record_wall({ 192, 61 })
    ai_base1:record_wall({ 192, 62 })
    ai_base1:record_wall({ 193, 51 })
    ai_base1:record_wall({ 194, 51 })
    ai_base1:record_wall({ 195, 38 })
    ai_base1:record_wall({ 195, 39 })
    ai_base1:record_wall({ 195, 40 })
    ai_base1:record_wall({ 195, 41 })
    ai_base1:record_wall({ 195, 42 })
    ai_base1:record_wall({ 195, 43 })
    ai_base1:record_wall({ 195, 44 })
    ai_base1:record_wall({ 195, 45 })
    ai_base1:record_wall({ 195, 46 })
    ai_base1:record_wall({ 195, 47 })
    ai_base1:record_wall({ 195, 48 })
    ai_base1:record_wall({ 195, 49 })
    ai_base1:record_wall({ 195, 50 })
    ai_base1:record_wall({ 195, 51 })
    ai_base1:record_wall({ 196, 38 })
    ai_base1:record_wall({ 196, 51 })
    ai_base1:record_wall({ 197, 38 })
    ai_base1:record_wall({ 197, 51 })
    ai_base1:record_wall({ 198, 38 })
    ai_base1:record_wall({ 199, 38 })
    ai_base1:record_wall({ 200, 38 })
    ai_base1:record_wall({ 201, 38 })
    ai_base1:record_wall({ 201, 62 })
    ai_base1:record_wall({ 202, 38 })
    ai_base1:record_wall({ 202, 62 })
    ai_base1:record_wall({ 203, 38 })
    ai_base1:record_wall({ 203, 62 })
    ai_base1:record_wall({ 204, 62 })
    ai_base1:record_wall({ 205, 62 })
    ai_base1:record_wall({ 206, 62 })
    ai_base1:record_wall({ 207, 57 })
    ai_base1:record_wall({ 207, 58 })
    ai_base1:record_wall({ 207, 59 })
    ai_base1:record_wall({ 207, 60 })
    ai_base1:record_wall({ 207, 61 })
    ai_base1:record_wall({ 207, 62 })
    ai_base1:record_wall({ 209, 51 })
    ai_base1:record_wall({ 209, 52 })
    ai_base1:record_wall({ 209, 53 })
    ai_base1:record_wall({ 209, 54 })
    ai_base1:record_wall({ 209, 55 })
    ai_base1:record_wall({ 209, 56 })
    ai_base1:record_wall({ 209, 57 })
    ai_base1:record_wall({ 209, 58 })
    ai_base1:record_wall({ 210, 51 })
    ai_base1:record_wall({ 210, 58 })
    ai_base1:record_wall({ 211, 51 })
    ai_base1:record_wall({ 211, 58 })
    ai_base1:record_wall({ 212, 51 })
    ai_base1:record_wall({ 212, 58 })
    ai_base1:record_wall({ 213, 58 })
    ai_base1:record_wall({ 214, 51 })
    ai_base1:record_wall({ 214, 58 })
    ai_base1:record_wall({ 215, 51 })
    ai_base1:record_wall({ 215, 58 })
    ai_base1:record_wall({ 216, 51 })
    ai_base1:record_wall({ 216, 58 })
    ai_base1:record_wall({ 217, 51 })
    ai_base1:record_wall({ 217, 52 })
    ai_base1:record_wall({ 217, 53 })
    ai_base1:record_wall({ 217, 54 })
    ai_base1:record_wall({ 217, 55 })
    ai_base1:record_wall({ 217, 56 })
    ai_base1:record_wall({ 217, 57 })
    ai_base1:record_wall({ 217, 58 })
    ai_base1:record_wall({ 240, 57 })
    ai_base1:record_wall({ 240, 58 })
    ai_base1:record_wall({ 240, 59 })
    ai_base1:record_wall({ 241, 59 })
    ai_base1:record_wall({ 242, 59 })
    ai_base1:record_wall({ 243, 59 })
    ai_base1:record_wall({ 244, 59 })
    ai_base1:record_wall({ 245, 59 })
    ai_base1:record_wall({ 246, 59 })
    ai_base1:record_wall({ 251, 59 })
    ai_base1:record_wall({ 252, 59 })
    ai_base1:record_wall({ 253, 59 })
    ai_base1:record_wall({ 254, 59 })
    ai_base1:record_wall({ 255, 57 })
    ai_base1:record_wall({ 255, 58 })
    ai_base1:record_wall({ 255, 59 })
  elseif players[1].difficulty == "Normal" then
    t:destroy()
    ai_base1:record_building({ 191, 64 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 189, 53 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 194, 55 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 194, 60 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 199, 62 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 206, 43 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 213, 46 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 233, 52 }, "GuardPost", "EMP")
    ai_base1:record_building({ 246, 57 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 248, 57 }, "GuardPost", "EMP")
    ai_base1:record_building({ 252, 57 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 254, 55 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 242, 57 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 198, 49 }, "Agridome")
    ai_base1:record_building({ 198, 45 }, "ConsumerFactory")
    ai_base1:record_building({ 202, 60 }, "GORF")
    ai_base1:record_building({ 249, 48 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 205, 37 }, "RareStorage")
    ai_base1:record_building({ 206, 52 }, "RareStorage")
    ai_base1:record_building({ 198, 41 }, "AdvancedResidence")
    ai_base1:record_building({ 202, 41 }, "AdvancedResidence")
    ai_base1:record_building({ 206, 55 }, "RareStorage")
    ai_base1:record_building({ 223, 43 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 235, 52 }, "GuardPost", "ThorsHammer")
    ai_base1:record_wall({ 189, 62 })
    ai_base1:record_wall({ 189, 63 })
    ai_base1:record_wall({ 190, 56 })
    ai_base1:record_wall({ 190, 62 })
    ai_base1:record_wall({ 191, 51 })
    ai_base1:record_wall({ 191, 56 })
    ai_base1:record_wall({ 191, 62 })
    ai_base1:record_wall({ 192, 51 })
    ai_base1:record_wall({ 192, 54 })
    ai_base1:record_wall({ 192, 55 })
    ai_base1:record_wall({ 192, 56 })
    ai_base1:record_wall({ 192, 60 })
    ai_base1:record_wall({ 192, 61 })
    ai_base1:record_wall({ 192, 62 })
    ai_base1:record_wall({ 193, 51 })
    ai_base1:record_wall({ 194, 51 })
    ai_base1:record_wall({ 195, 38 })
    ai_base1:record_wall({ 195, 39 })
    ai_base1:record_wall({ 195, 40 })
    ai_base1:record_wall({ 195, 41 })
    ai_base1:record_wall({ 195, 42 })
    ai_base1:record_wall({ 195, 43 })
    ai_base1:record_wall({ 195, 44 })
    ai_base1:record_wall({ 195, 45 })
    ai_base1:record_wall({ 195, 46 })
    ai_base1:record_wall({ 195, 47 })
    ai_base1:record_wall({ 195, 48 })
    ai_base1:record_wall({ 195, 49 })
    ai_base1:record_wall({ 195, 50 })
    ai_base1:record_wall({ 195, 51 })
    ai_base1:record_wall({ 196, 38 })
    ai_base1:record_wall({ 196, 51 })
    ai_base1:record_wall({ 197, 38 })
    ai_base1:record_wall({ 197, 51 })
    ai_base1:record_wall({ 198, 38 })
    ai_base1:record_wall({ 199, 38 })
    ai_base1:record_wall({ 200, 38 })
    ai_base1:record_wall({ 201, 38 })
    ai_base1:record_wall({ 201, 62 })
    ai_base1:record_wall({ 202, 38 })
    ai_base1:record_wall({ 202, 62 })
    ai_base1:record_wall({ 203, 38 })
    ai_base1:record_wall({ 203, 62 })
    ai_base1:record_wall({ 204, 62 })
    ai_base1:record_wall({ 205, 62 })
    ai_base1:record_wall({ 206, 62 })
    ai_base1:record_wall({ 207, 57 })
    ai_base1:record_wall({ 207, 58 })
    ai_base1:record_wall({ 207, 59 })
    ai_base1:record_wall({ 207, 60 })
    ai_base1:record_wall({ 207, 61 })
    ai_base1:record_wall({ 207, 62 })
    ai_base1:record_wall({ 209, 51 })
    ai_base1:record_wall({ 209, 52 })
    ai_base1:record_wall({ 209, 53 })
    ai_base1:record_wall({ 209, 54 })
    ai_base1:record_wall({ 209, 55 })
    ai_base1:record_wall({ 209, 56 })
    ai_base1:record_wall({ 209, 57 })
    ai_base1:record_wall({ 209, 58 })
    ai_base1:record_wall({ 210, 51 })
    ai_base1:record_wall({ 210, 58 })
    ai_base1:record_wall({ 211, 51 })
    ai_base1:record_wall({ 211, 58 })
    ai_base1:record_wall({ 212, 51 })
    ai_base1:record_wall({ 212, 58 })
    ai_base1:record_wall({ 213, 58 })
    ai_base1:record_wall({ 214, 51 })
    ai_base1:record_wall({ 214, 58 })
    ai_base1:record_wall({ 215, 51 })
    ai_base1:record_wall({ 215, 58 })
    ai_base1:record_wall({ 216, 51 })
    ai_base1:record_wall({ 216, 58 })
    ai_base1:record_wall({ 217, 51 })
    ai_base1:record_wall({ 217, 52 })
    ai_base1:record_wall({ 217, 53 })
    ai_base1:record_wall({ 217, 54 })
    ai_base1:record_wall({ 217, 55 })
    ai_base1:record_wall({ 217, 56 })
    ai_base1:record_wall({ 217, 57 })
    ai_base1:record_wall({ 217, 58 })
    ai_base1:record_wall({ 240, 57 })
    ai_base1:record_wall({ 240, 58 })
    ai_base1:record_wall({ 240, 59 })
    ai_base1:record_wall({ 241, 59 })
    ai_base1:record_wall({ 242, 59 })
    ai_base1:record_wall({ 243, 59 })
    ai_base1:record_wall({ 244, 59 })
    ai_base1:record_wall({ 245, 59 })
    ai_base1:record_wall({ 246, 59 })
    ai_base1:record_wall({ 251, 59 })
    ai_base1:record_wall({ 252, 59 })
    ai_base1:record_wall({ 253, 59 })
    ai_base1:record_wall({ 254, 59 })
    ai_base1:record_wall({ 255, 57 })
    ai_base1:record_wall({ 255, 58 })
    ai_base1:record_wall({ 255, 59 })
  else
    t:destroy()
    ai_base1:record_building({ 191, 64 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 189, 53 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 194, 55 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 194, 60 }, "GuardPost", "ThorsHammer")
    ai_base1:record_tube({ 191, 53 })
    ai_base1:record_tube({ 192, 53 })
    ai_base1:record_tube({ 193, 53 })
    ai_base1:record_tube({ 193, 54 })
    ai_base1:record_tube({ 193, 55 })
    ai_base1:record_tube({ 193, 56 })
    ai_base1:record_tube({ 193, 58 })
    ai_base1:record_tube({ 193, 59 })
    ai_base1:record_tube({ 193, 60 })
    ai_base1:record_tube({ 193, 61 })
    ai_base1:record_tube({ 193, 62 })
    ai_base1:record_tube({ 193, 63 })
    ai_base1:record_tube({ 193, 64 })
    ai_base1:record_building({ 199, 62 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 206, 43 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 213, 46 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 233, 52 }, "GuardPost", "EMP")
    ai_base1:record_building({ 246, 57 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 248, 57 }, "GuardPost", "EMP")
    ai_base1:record_building({ 252, 57 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 254, 55 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 242, 57 }, "GuardPost", "AcidCloud")
    ai_base1:record_building({ 198, 49 }, "Agridome")
    ai_base1:record_building({ 198, 45 }, "ConsumerFactory")
    ai_base1:record_building({ 202, 60 }, "GORF")
    ai_base1:record_building({ 249, 48 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 205, 37 }, "RareStorage")
    ai_base1:record_building({ 206, 52 }, "RareStorage")
    ai_base1:record_building({ 198, 41 }, "AdvancedResidence")
    ai_base1:record_building({ 202, 41 }, "AdvancedResidence")
    ai_base1:record_building({ 206, 55 }, "RareStorage")
    ai_base1:record_building({ 223, 43 }, "GuardPost", "ThorsHammer")
    ai_base1:record_building({ 235, 52 }, "GuardPost", "ThorsHammer")
    ai_base1:record_wall({ 189, 62 })
    ai_base1:record_wall({ 189, 63 })
    ai_base1:record_wall({ 190, 56 })
    ai_base1:record_wall({ 190, 62 })
    ai_base1:record_wall({ 191, 51 })
    ai_base1:record_wall({ 191, 56 })
    ai_base1:record_wall({ 191, 62 })
    ai_base1:record_wall({ 192, 51 })
    ai_base1:record_wall({ 192, 54 })
    ai_base1:record_wall({ 192, 55 })
    ai_base1:record_wall({ 192, 56 })
    ai_base1:record_wall({ 192, 60 })
    ai_base1:record_wall({ 192, 61 })
    ai_base1:record_wall({ 192, 62 })
    ai_base1:record_wall({ 193, 51 })
    ai_base1:record_wall({ 194, 51 })
    ai_base1:record_wall({ 195, 38 })
    ai_base1:record_wall({ 195, 39 })
    ai_base1:record_wall({ 195, 40 })
    ai_base1:record_wall({ 195, 41 })
    ai_base1:record_wall({ 195, 42 })
    ai_base1:record_wall({ 195, 43 })
    ai_base1:record_wall({ 195, 44 })
    ai_base1:record_wall({ 195, 45 })
    ai_base1:record_wall({ 195, 46 })
    ai_base1:record_wall({ 195, 47 })
    ai_base1:record_wall({ 195, 48 })
    ai_base1:record_wall({ 195, 49 })
    ai_base1:record_wall({ 195, 50 })
    ai_base1:record_wall({ 195, 51 })
    ai_base1:record_wall({ 196, 38 })
    ai_base1:record_wall({ 196, 51 })
    ai_base1:record_wall({ 197, 38 })
    ai_base1:record_wall({ 197, 51 })
    ai_base1:record_wall({ 198, 38 })
    ai_base1:record_wall({ 199, 38 })
    ai_base1:record_wall({ 200, 38 })
    ai_base1:record_wall({ 201, 38 })
    ai_base1:record_wall({ 201, 62 })
    ai_base1:record_wall({ 202, 38 })
    ai_base1:record_wall({ 202, 62 })
    ai_base1:record_wall({ 203, 38 })
    ai_base1:record_wall({ 203, 62 })
    ai_base1:record_wall({ 204, 62 })
    ai_base1:record_wall({ 205, 62 })
    ai_base1:record_wall({ 206, 62 })
    ai_base1:record_wall({ 207, 57 })
    ai_base1:record_wall({ 207, 58 })
    ai_base1:record_wall({ 207, 59 })
    ai_base1:record_wall({ 207, 60 })
    ai_base1:record_wall({ 207, 61 })
    ai_base1:record_wall({ 207, 62 })
    ai_base1:record_wall({ 209, 51 })
    ai_base1:record_wall({ 209, 52 })
    ai_base1:record_wall({ 209, 53 })
    ai_base1:record_wall({ 209, 54 })
    ai_base1:record_wall({ 209, 55 })
    ai_base1:record_wall({ 209, 56 })
    ai_base1:record_wall({ 209, 57 })
    ai_base1:record_wall({ 209, 58 })
    ai_base1:record_wall({ 210, 51 })
    ai_base1:record_wall({ 210, 58 })
    ai_base1:record_wall({ 211, 51 })
    ai_base1:record_wall({ 211, 58 })
    ai_base1:record_wall({ 212, 51 })
    ai_base1:record_wall({ 212, 58 })
    ai_base1:record_wall({ 213, 58 })
    ai_base1:record_wall({ 214, 51 })
    ai_base1:record_wall({ 214, 58 })
    ai_base1:record_wall({ 215, 51 })
    ai_base1:record_wall({ 215, 58 })
    ai_base1:record_wall({ 216, 51 })
    ai_base1:record_wall({ 216, 58 })
    ai_base1:record_wall({ 217, 51 })
    ai_base1:record_wall({ 217, 52 })
    ai_base1:record_wall({ 217, 53 })
    ai_base1:record_wall({ 217, 54 })
    ai_base1:record_wall({ 217, 55 })
    ai_base1:record_wall({ 217, 56 })
    ai_base1:record_wall({ 217, 57 })
    ai_base1:record_wall({ 217, 58 })
    ai_base1:record_wall({ 240, 57 })
    ai_base1:record_wall({ 240, 58 })
    ai_base1:record_wall({ 240, 59 })
    ai_base1:record_wall({ 241, 59 })
    ai_base1:record_wall({ 242, 59 })
    ai_base1:record_wall({ 243, 59 })
    ai_base1:record_wall({ 244, 59 })
    ai_base1:record_wall({ 245, 59 })
    ai_base1:record_wall({ 246, 59 })
    ai_base1:record_wall({ 251, 59 })
    ai_base1:record_wall({ 252, 59 })
    ai_base1:record_wall({ 253, 59 })
    ai_base1:record_wall({ 254, 59 })
    ai_base1:record_wall({ 255, 57 })
    ai_base1:record_wall({ 255, 58 })
    ai_base1:record_wall({ 255, 59 })
  end
end

function Lava_Flow(t)
  game.set_tile({ 20, 21 }, 1147)
  game.set_tile({ 20, 22 }, 1158)
  for _, r in ipairs({
    { 0, 1, 62, 1 }, { 0, 2, 61, 2 }, { 0, 3, 59, 4 }, { 0, 5, 57, 9 }, { 0, 10, 58, 13 }, { -1, 14, 59, 14 },
    { -1, 15, 61, 15 }, { -1, 16, 19, 16 }, { 26, 16, 64, 16 }, { -1, 17, 18, 18 }, { 27, 17, 65, 19 }, { -1, 19, 17, 19 },
    { 1, 20, 17, 20 }, { 28, 20, 68, 20 }, { 82, 20, 83, 20 }, { 87, 20, 89, 20 }, { -1, 21, 17, 23 }, { 28, 21, 71, 21 },
    { 81, 21, 91, 21 }, { 28, 22, 73, 22 }, { 75, 22, 92, 22 }, { 19, 23, 20, 23 }, { 28, 23, 72, 23 }, { 74, 23, 93, 23 },
    { -1, 24, 20, 25 }, { 27, 24, 29, 24 }, { 32, 24, 94, 24 }, { 24, 25, 28, 25 }, { 33, 25, 95, 25 }, { -1, 26, 27, 26 },
    { 34, 26, 95, 26 }, { -1, 27, 28, 28 }, { 33, 27, 96, 27 }, { 33, 28, 73, 28 }, { 81, 28, 83, 28 }, { 88, 28, 90, 28 },
    { 92, 28, 96, 28 }, { -1, 29, 29, 29 }, { 32, 29, 69, 29 }, { 94, 29, 95, 29 }, { -1, 30, 67, 30 }, { -1, 31, 66, 31 },
    { -2, 32, 62, 33 }, { -2, 34, 61, 34 }, { -1, 35, 52, 36 }, { -1, 37, 50, 38 }, { -1, 39, 48, 39 }, { -1, 40, 47, 40 },
    { -1, 41, 46, 41 }, { 0, 42, 43, 42 }, { 1, 43, 43, 44 }, { 1, 45, 42, 45 }, { 0, 46, 43, 46 }, { -1, 47, 43, 47 },
    { -1, 48, 42, 48 }, { -1, 49, 43, 51 }, { -1, 52, 47, 52 }, { -1, 53, 18, 53 }, { 21, 53, 48, 53 }, { 0, 54, 7, 54 },
    { 9, 54, 9, 54 }, { 13, 54, 17, 54 }, { 22, 54, 50, 54 }, { 1, 55, 3, 55 }, { 23, 55, 51, 55 }, { 23, 56, 52, 56 },
    { 22, 57, 52, 57 }, { 21, 58, 52, 58 }, { 21, 59, 51, 59 }, { 21, 60, 50, 60 }, { 21, 61, 49, 61 }, { 22, 62, 48, 62 },
    { 23, 63, 48, 63 }, { 24, 64, 48, 64 }, { 25, 65, 49, 65 }, { 26, 66, 49, 66 }, { 28, 67, 48, 68 }, { 29, 69, 48, 69 },
    { 29, 70, 47, 70 }, { 30, 71, 46, 71 }, { 31, 72, 43, 72 }, { 32, 73, 34, 73 },
  }) do game.set_lava_possible(r) end
  game.create_eruption({ 20, 23 }, 10)
  t:destroy()
end

function Lava_Vent(t)
  game.set_tile({ 20, 21 }, 1140)
  game.set_tile({ 20, 22 }, 1150)
  t:destroy()
  trigger.time{time = 1500, on = Lava_Flow}  -- after 15 marks
end

function Microbe(t)
  game.create_blight({ 109, 1 })
  game.create_blight({ 110, 1 })
  game.set_blight_speed(40)
  game.message_at("Microbe growth detected!", 152, 1, 4480, 32)
end

function SetupBase3(t)
  t:destroy()
  trigger.time{time = 121, one_shot = false, on = Base3SmelterCheck}
  ai_base3:take_unit(game.create_unit{ type = "ConVec", player = ai_player, at = { 2, 127 }, weapon = "CommandCenter", exact = true, lights = false }[1])
  ai_base3:take_unit(game.create_unit{ type = "ConVec", player = ai_player, at = { 2, 127 }, weapon = "StructureFactory", exact = true, lights = false }[1])
  ai_base3:record_building({ 48, 100 }, "CommandCenter")
  ai_base3:record_building({ 44, 99 }, "StructureFactory", nil, ai_base3)
  ai_base3:record_building({ 48, 103 }, "VehicleFactory", nil, ai_base3)
  ai_base3:record_building({ 52, 100 }, "Agridome")
  ai_base3:record_building({ 49, 106 }, "GuardPost", "EMP")
  ai_base3:record_building({ 33, 106 }, "CommonOreSmelter", nil, ai_base3)
  ai_base3:record_building({ 48, 97 }, "StandardLab")
  ai_base3:record_building({ 45, 96 }, "CommonStorage")
  ai_base3:record_building({ 43, 96 }, "CommonStorage")
  ai_base3:record_building({ 41, 96 }, "RareStorage")
  ai_base3:record_building({ 39, 96 }, "RareStorage")
  ai_base3:record_building({ 52, 114 }, "RareOreSmelter", nil, ai_base3)
  ai_base3:record_building({ 65, 100 }, "GuardPost", "EMP")
  ai_base3:record_tube({ 48, 106 })
  ai_base3:record_tube({ 48, 107 })
  ai_base3:record_tube({ 47, 107 })
  ai_base3:record_tube({ 46, 107 })
  ai_base3:record_tube({ 45, 107 })
  ai_base3:record_tube({ 44, 107 })
  ai_base3:record_tube({ 43, 107 })
  ai_base3:record_tube({ 42, 107 })
  ai_base3:record_tube({ 41, 107 })
  ai_base3:record_tube({ 40, 107 })
  ai_base3:record_tube({ 39, 107 })
  ai_base3:record_tube({ 38, 107 })
  ai_base3:record_tube({ 37, 107 })
  ai_base3:record_tube({ 36, 107 })
  ai_base3:record_tube({ 35, 107 })
  ai_base3:record_tube({ 49, 107 })
  ai_base3:record_tube({ 49, 108 })
  ai_base3:record_tube({ 49, 109 })
  ai_base3:record_tube({ 49, 110 })
  ai_base3:record_tube({ 49, 111 })
  ai_base3:record_tube({ 49, 112 })
  ai_base3:record_tube({ 49, 113 })
  ai_base3:record_tube({ 54, 101 })
  ai_base3:record_tube({ 55, 101 })
  ai_base3:record_tube({ 56, 101 })
  ai_base3:record_tube({ 57, 101 })
  ai_base3:record_tube({ 58, 101 })
  ai_base3:record_tube({ 59, 101 })
  ai_base3:record_tube({ 60, 101 })
  ai_base3:record_tube({ 61, 101 })
  ai_base3:record_tube({ 62, 101 })
  ai_base3:record_tube({ 63, 101 })
  ai_base3:record_tube({ 64, 101 })
  ai_base3:record_tube({ 65, 101 })
  ai_base3:record_tube({ 66, 101 })
  ai_base3:record_tube({ 67, 101 })
  ai_base3:record_tube({ 68, 101 })
end

function TimeUpgrades(t)
  TimeUpgrades_step = TimeUpgrades_step + 1
  if TimeUpgrades_step == 1 then
  elseif TimeUpgrades_step == 2 then
  elseif TimeUpgrades_step == 3 then
    ai_player:set_tech_level(4)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "Laser", 4)
    ai_fight2:set_targ_count("Lynx", "Laser", 4)
    ai_fight3:set_targ_count("Lynx", "Laser", 4)
    ai_fight1:set_targ_count("Lynx", "EMP", 1)
    ai_fight2:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight1:set_targ_count("Lynx", "RailGun", 1)
    ai_fight2:set_targ_count("Lynx", "RailGun", 1)
    ai_fight3:set_targ_count("Lynx", "RailGun", 1)
    ai_fight1:set_targ_count("Lynx", "Starflare", 1)
    ai_fight2:set_targ_count("Lynx", "Starflare", 1)
    ai_fight3:set_targ_count("Lynx", "Starflare", 1)
  elseif TimeUpgrades_step == 4 then
    ai_player:set_tech_level(5)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "Laser", 6)
    ai_fight2:set_targ_count("Lynx", "Laser", 6)
    ai_fight3:set_targ_count("Lynx", "Laser", 6)
    ai_fight1:set_targ_count("Lynx", "EMP", 2)
    ai_fight2:set_targ_count("Lynx", "EMP", 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 2)
    ai_fight1:set_targ_count("Lynx", "RailGun", 3)
    ai_fight2:set_targ_count("Lynx", "RailGun", 3)
    ai_fight3:set_targ_count("Lynx", "RailGun", 3)
    ai_fight1:set_targ_count("Lynx", "Starflare", 2)
    ai_fight2:set_targ_count("Lynx", "Starflare", 2)
    ai_fight3:set_targ_count("Lynx", "Starflare", 2)
    ai_fight1:set_targ_count("Panther", "Laser", 1)
    ai_fight2:set_targ_count("Panther", "Laser", 1)
    ai_fight3:set_targ_count("Panther", "Laser", 1)
  elseif TimeUpgrades_step == 5 then
    ai_player:set_tech_level(6)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "Laser", 3)
    ai_fight2:set_targ_count("Lynx", "Laser", 3)
    ai_fight3:set_targ_count("Lynx", "Laser", 3)
    ai_fight1:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight2:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight3:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight1:set_targ_count("Lynx", "EMP", 3)
    ai_fight2:set_targ_count("Lynx", "EMP", 3)
    ai_fight3:set_targ_count("Lynx", "EMP", 3)
    ai_fight1:set_targ_count("Lynx", "RailGun", 4)
    ai_fight2:set_targ_count("Lynx", "RailGun", 4)
    ai_fight3:set_targ_count("Lynx", "RailGun", 4)
    ai_fight1:set_targ_count("Lynx", "Starflare", 2)
    ai_fight2:set_targ_count("Lynx", "Starflare", 2)
    ai_fight3:set_targ_count("Lynx", "Starflare", 2)
    ai_fight1:set_targ_count("Panther", "Laser", 3)
    ai_fight2:set_targ_count("Panther", "Laser", 3)
    ai_fight3:set_targ_count("Panther", "Laser", 3)
    ai_fight1:set_targ_count("Panther", "EMP", 2)
    ai_fight2:set_targ_count("Panther", "EMP", 2)
    ai_fight3:set_targ_count("Panther", "EMP", 2)
    ai_fight1:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight2:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight3:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight1:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight2:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight3:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight1:set_targ_count("Lynx", "RailGun", 1)
    ai_fight2:set_targ_count("Lynx", "RailGun", 1)
    ai_fight3:set_targ_count("Lynx", "RailGun", 1)
    ai_fight1:set_targ_count("Lynx", "EMP", 1)
    ai_fight2:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight1:set_targ_count("Panther", "Laser", 4)
    ai_fight2:set_targ_count("Panther", "Laser", 4)
    ai_fight3:set_targ_count("Panther", "Laser", 4)
    ai_fight1:set_targ_count("Panther", "EMP", 4)
    ai_fight2:set_targ_count("Panther", "EMP", 4)
    ai_fight3:set_targ_count("Panther", "EMP", 4)
    ai_fight1:set_targ_count("Panther", "AcidCloud", 4)
    ai_fight2:set_targ_count("Panther", "AcidCloud", 4)
    ai_fight3:set_targ_count("Panther", "AcidCloud", 4)
    ai_fight1:set_targ_count("Panther", "RailGun", 4)
    ai_fight2:set_targ_count("Panther", "RailGun", 4)
    ai_fight3:set_targ_count("Panther", "RailGun", 4)
  elseif TimeUpgrades_step == 6 then
    ai_player:set_tech_level(7)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight2:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight3:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight1:set_targ_count("Lynx", "RailGun", 1)
    ai_fight2:set_targ_count("Lynx", "RailGun", 1)
    ai_fight3:set_targ_count("Lynx", "RailGun", 1)
    ai_fight1:set_targ_count("Lynx", "EMP", 1)
    ai_fight2:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight1:set_targ_count("Panther", "Laser", 4)
    ai_fight2:set_targ_count("Panther", "Laser", 4)
    ai_fight3:set_targ_count("Panther", "Laser", 4)
    ai_fight1:set_targ_count("Panther", "EMP", 4)
    ai_fight2:set_targ_count("Panther", "EMP", 4)
    ai_fight3:set_targ_count("Panther", "EMP", 4)
    ai_fight1:set_targ_count("Panther", "AcidCloud", 4)
    ai_fight2:set_targ_count("Panther", "AcidCloud", 4)
    ai_fight3:set_targ_count("Panther", "AcidCloud", 4)
    ai_fight1:set_targ_count("Panther", "RailGun", 4)
    ai_fight2:set_targ_count("Panther", "RailGun", 4)
    ai_fight3:set_targ_count("Panther", "RailGun", 4)
  elseif TimeUpgrades_step == 7 then
    ai_player:set_tech_level(8)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "Laser", 3)
    ai_fight2:set_targ_count("Panther", "Laser", 3)
    ai_fight3:set_targ_count("Panther", "Laser", 3)
    ai_fight1:set_targ_count("Panther", "EMP", 3)
    ai_fight2:set_targ_count("Panther", "EMP", 3)
    ai_fight3:set_targ_count("Panther", "EMP", 3)
    ai_fight1:set_targ_count("Panther", "AcidCloud", 3)
    ai_fight2:set_targ_count("Panther", "AcidCloud", 3)
    ai_fight3:set_targ_count("Panther", "AcidCloud", 3)
    ai_fight1:set_targ_count("Panther", "RailGun", 3)
    ai_fight2:set_targ_count("Panther", "RailGun", 3)
    ai_fight3:set_targ_count("Panther", "RailGun", 3)
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 3)
    ai_fight2:set_targ_count("Tiger", "RailGun", 3)
    ai_fight3:set_targ_count("Tiger", "RailGun", 3)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 3)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 3)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 3)
    ai_fight1:set_targ_count("Tiger", "EMP", 3)
    ai_fight2:set_targ_count("Tiger", "EMP", 3)
    ai_fight3:set_targ_count("Tiger", "EMP", 3)
    ai_fight1:set_targ_count("Panther", "Laser", 2)
    ai_fight2:set_targ_count("Panther", "Laser", 2)
    ai_fight3:set_targ_count("Panther", "Laser", 2)
    ai_fight1:set_targ_count("Panther", "EMP", 2)
    ai_fight2:set_targ_count("Panther", "EMP", 2)
    ai_fight3:set_targ_count("Panther", "EMP", 2)
    ai_fight1:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight2:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight3:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight1:set_targ_count("Panther", "RailGun", 2)
    ai_fight2:set_targ_count("Panther", "RailGun", 2)
    ai_fight3:set_targ_count("Panther", "RailGun", 2)
    ai_fight1:set_targ_count("Panther", "ThorsHammer", 1)
    ai_fight2:set_targ_count("Panther", "ThorsHammer", 1)
    ai_fight3:set_targ_count("Panther", "ThorsHammer", 1)
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 5)
    ai_fight2:set_targ_count("Tiger", "RailGun", 5)
    ai_fight3:set_targ_count("Tiger", "RailGun", 5)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 5)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 5)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 5)
    ai_fight1:set_targ_count("Tiger", "EMP", 5)
    ai_fight2:set_targ_count("Tiger", "EMP", 5)
    ai_fight3:set_targ_count("Tiger", "EMP", 5)
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 8)
    ai_fight2:set_targ_count("Tiger", "RailGun", 8)
    ai_fight3:set_targ_count("Tiger", "RailGun", 8)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight1:set_targ_count("Tiger", "EMP", 8)
    ai_fight2:set_targ_count("Tiger", "EMP", 8)
    ai_fight3:set_targ_count("Tiger", "EMP", 8)
    ai_fight1:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_fight2:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_fight3:set_targ_count("Tiger", "ThorsHammer", 2)
  elseif TimeUpgrades_step == 8 then
    ai_player:set_tech_level(9)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "Laser", 2)
    ai_fight2:set_targ_count("Panther", "Laser", 2)
    ai_fight3:set_targ_count("Panther", "Laser", 2)
    ai_fight1:set_targ_count("Panther", "EMP", 2)
    ai_fight2:set_targ_count("Panther", "EMP", 2)
    ai_fight3:set_targ_count("Panther", "EMP", 2)
    ai_fight1:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight2:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight3:set_targ_count("Panther", "AcidCloud", 2)
    ai_fight1:set_targ_count("Panther", "RailGun", 2)
    ai_fight2:set_targ_count("Panther", "RailGun", 2)
    ai_fight3:set_targ_count("Panther", "RailGun", 2)
    ai_fight1:set_targ_count("Panther", "ThorsHammer", 1)
    ai_fight2:set_targ_count("Panther", "ThorsHammer", 1)
    ai_fight3:set_targ_count("Panther", "ThorsHammer", 1)
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 5)
    ai_fight2:set_targ_count("Tiger", "RailGun", 5)
    ai_fight3:set_targ_count("Tiger", "RailGun", 5)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 5)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 5)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 5)
    ai_fight1:set_targ_count("Tiger", "EMP", 5)
    ai_fight2:set_targ_count("Tiger", "EMP", 5)
    ai_fight3:set_targ_count("Tiger", "EMP", 5)
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 8)
    ai_fight2:set_targ_count("Tiger", "RailGun", 8)
    ai_fight3:set_targ_count("Tiger", "RailGun", 8)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight1:set_targ_count("Tiger", "EMP", 8)
    ai_fight2:set_targ_count("Tiger", "EMP", 8)
    ai_fight3:set_targ_count("Tiger", "EMP", 8)
    ai_fight1:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_fight2:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_fight3:set_targ_count("Tiger", "ThorsHammer", 2)
  elseif TimeUpgrades_step == 9 then
    ai_player:set_tech_level(10)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 8)
    ai_fight2:set_targ_count("Tiger", "RailGun", 8)
    ai_fight3:set_targ_count("Tiger", "RailGun", 8)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight1:set_targ_count("Tiger", "EMP", 8)
    ai_fight2:set_targ_count("Tiger", "EMP", 8)
    ai_fight3:set_targ_count("Tiger", "EMP", 8)
    ai_fight1:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_fight2:set_targ_count("Tiger", "ThorsHammer", 2)
    ai_fight3:set_targ_count("Tiger", "ThorsHammer", 2)
  elseif TimeUpgrades_step == 10 then
    ai_player:set_tech_level(11)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight2:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight3:set_targ_count("Lynx", "AcidCloud", 1)
    ai_fight1:set_targ_count("Lynx", "RailGun", 1)
    ai_fight2:set_targ_count("Lynx", "RailGun", 1)
    ai_fight3:set_targ_count("Lynx", "RailGun", 1)
    ai_fight1:set_targ_count("Tiger", "Laser", 1)
    ai_fight2:set_targ_count("Tiger", "Laser", 1)
    ai_fight3:set_targ_count("Tiger", "Laser", 1)
    ai_fight1:set_targ_count("Tiger", "RailGun", 8)
    ai_fight2:set_targ_count("Tiger", "RailGun", 8)
    ai_fight3:set_targ_count("Tiger", "RailGun", 8)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight1:set_targ_count("Tiger", "EMP", 8)
    ai_fight2:set_targ_count("Tiger", "EMP", 8)
    ai_fight3:set_targ_count("Tiger", "EMP", 8)
    ai_fight1:set_targ_count("Tiger", "ThorsHammer", 4)
    ai_fight2:set_targ_count("Tiger", "ThorsHammer", 4)
    ai_fight3:set_targ_count("Tiger", "ThorsHammer", 4)
  elseif TimeUpgrades_step == 11 then
    ai_player:set_tech_level(12)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight1:set_targ_count("Tiger", "Laser", 2)
    ai_fight2:set_targ_count("Tiger", "Laser", 2)
    ai_fight3:set_targ_count("Tiger", "Laser", 2)
    ai_fight1:set_targ_count("Tiger", "RailGun", 2)
    ai_fight2:set_targ_count("Tiger", "RailGun", 2)
    ai_fight3:set_targ_count("Tiger", "RailGun", 2)
    ai_fight1:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight2:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight3:set_targ_count("Tiger", "AcidCloud", 8)
    ai_fight1:set_targ_count("Tiger", "EMP", 8)
    ai_fight2:set_targ_count("Tiger", "EMP", 8)
    ai_fight3:set_targ_count("Tiger", "EMP", 8)
    ai_fight1:set_targ_count("Tiger", "ThorsHammer", 12)
    ai_fight2:set_targ_count("Tiger", "ThorsHammer", 12)
    ai_fight3:set_targ_count("Tiger", "ThorsHammer", 12)
  else
    ai_fight4:set_delete_when_empty(true)
    t:destroy()
  end
end

-- Every 40 ticks: the colony fails at once with fewer than 8 workers or 3 scientists, with nothing that can build
-- for space, or with no income of an ore whose evacuation isn't met yet (0x11007550).
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = p.workers < 8 or p.scientists < 3
  if not p:can_build_space() then fail = true end
  if not t9:has_fired(1) and not p:can_accumulate_ore() then fail = true end
  if not t11:has_fired(1) and not p:can_accumulate_rare_ore() then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- A meteor of size 1 on a wild tile (0x11007E00); the next in 1 to 40 marks.
function DoMeteor(t)
  game.create_meteor(wild_tile(), 1)
  t:destroy()
  trigger.time{min = 100, max = 4000, one_shot = false, on = DoMeteor}
end

-- An earthquake of magnitude 1 on a wild tile (0x11007BD0); the next in 80 to 400 marks.
function DoQuake(t)
  game.create_earthquake(wild_tile(), 1)
  t:destroy()
  trigger.time{min = 8000, max = 40000, one_shot = false, on = DoQuake}
end

-- A storm of 10 ticks from one wild tile to another (0x11007D00); the next in 90 to 400 marks.
function DoLightning(t)
  local from = wild_tile()
  game.create_lightning(from, wild_tile(), 10)
  t:destroy()
  trigger.time{min = 9000, max = 40000, one_shot = false, on = DoLightning}
end

-- A vortex of 10 ticks from one wild tile to another (0x11007D80); the next in 90 to 400 marks.
function DoTornado(t)
  local from = wild_tile()
  game.create_tornado(from, wild_tile(), 10)
  t:destroy()
  trigger.time{min = 9000, max = 40000, one_shot = false, on = DoTornado}
end

-- Every 50 marks: player 2 gets ore and rare ore by player 1's difficulty, and 2000 more ore before tick 30000
-- (0x11006E90).
function GiveAIOre(t)
  local early = game.tick() < 30000 and 2000 or 0
  local level = players[1].difficulty
  players[2].ore = (AI_ORE[level] or 2000) + players[2].ore + early
  players[2].rare_ore = (AI_RARE_ORE[level] or 300) + players[2].rare_ore
end

-- At tick 350000: the Blight starts at 109,1 and 110,1, spreading at 40, and player 1 is told (0x11007E60).
function Microbe(t)
  game.create_blight({ 109, 1 })
  game.create_blight({ 110, 1 })
  game.set_blight_speed(40)
  game.message_at("Microbe growth detected!", 152, 1, 4480, 32)
end

-- Every 107 ticks once base 1 expands: when it has a Rare Ore Smelter, it gets a rare ore mining group with up to 3
-- Cargo Trucks, a mine and a Geothermal Plant to build (0x11004350).
function Base1RareCheck(t)
  if not ai_base1:first_of_type("RareOreSmelter", "None") then return end
  t:destroy()
  ai_base1_rare_mining = ai.mining_group(ai_player)
  ai_base1_rare_mining:setup({ 249, 18 }, { 246, 19 }, "RareOreMine", "RareOreSmelter", { 242, 16, 251, 20 })
  ai_base1_rare_mining:set_targ_count("CargoTruck", nil, 3)
  ai_base1:record_veh_reinforce_group(ai_base1_rare_mining, 100)
  ai_base1:record_building({ 250, 18 }, "RareOreMine")
  ai_base1:record_building({ 224, 17 }, "GeothermalPlant")
end

-- Every 107 ticks once base 1B is planned: when a Common Ore Smelter (anyone's) stands on 208,36 - 209,37, base 1
-- gets a mining group with up to 5 Cargo Trucks, a mine and a Geothermal Plant; on Hard a second smelter, a mining
-- group of 2 for it, tubes and a Thor's Hammer guard post too; and base 1B's guards a new waiting area
-- (0x11004740).
function Base1BSmelterCheck(t)
  local found = false
  for _, u in ipairs(game.units_in_rect({ 208, 36, 209, 37 })) do
    if u.type == "CommonOreSmelter" then found = true break end
  end
  if not found then return end
  t:destroy()
  ai_base1b_mining = ai.mining_group(ai_player)
  ai_base1b_mining:setup({ 212, 25 }, { 210, 38 }, "CommonOreMine", "CommonOreSmelter", { 206, 33, 213, 49 })
  ai_base1b_mining:set_targ_count("CargoTruck", nil, 5)
  ai_base1:record_veh_reinforce_group(ai_base1b_mining, 100)
  ai_base1:record_building({ 213, 25 }, "CommonOreMine")
  ai_base1:record_building({ 188, 40 }, "GeothermalPlant")
  if players[1].difficulty == "Hard" then
    ai_base1:record_building({ 207, 26 }, "CommonOreSmelter")
    ai_base1b_mining2 = ai.mining_group(ai_player)
    ai_base1b_mining2:setup({ 212, 25 }, { 208, 27 }, "CommonOreMine", "CommonOreSmelter", { 204, 29, 208, 33 })
    ai_base1b_mining2:set_targ_count("CargoTruck", nil, 2)
    ai_base1:record_veh_reinforce_group(ai_base1b_mining2, 25)
    for y = 29, 35 do ai_base2:record_tube({ 207, y }) end
    ai_base1:record_building({ 203, 25 }, "GuardPost", "ThorsHammer")
  end
  ai_fight2:set_rect({ 192, 44, 210, 64 })
  ai_fight2:clear_guarded_rects()
  ai_fight2:add_guarded_rect({ 187, 35, 221, 67 })
  ai_fight2:add_guarded_rect({ 201, 23, 215, 34 })
end

-- Every 121 ticks once base 3 is set up: when it has a Common Ore Smelter, it gets a mining group with up to 4
-- Cargo Trucks, a mine and a Geothermal Plant to build, and its guards a new waiting area; then it waits for a Rare
-- Ore Smelter (0x11006210).
function Base3SmelterCheck(t)
  if not ai_base3:first_of_type("CommonOreSmelter", "None") then return end
  t:destroy()
  trigger.time{time = 121, one_shot = false, on = Base3RareSmelterCheck}
  ai_base3_mining = ai.mining_group(ai_player)
  ai_base3_mining:setup({ 26, 97 }, { 34, 107 }, "CommonOreMine", "CommonOreSmelter", { 24, 95, 31, 99 })
  ai_base3_mining:set_targ_count("CargoTruck", nil, 4)
  ai_base3:record_veh_reinforce_group(ai_base3_mining, 100)
  ai_base3:record_building({ 27, 97 }, "CommonOreMine")
  ai_base3:record_building({ 6, 121 }, "GeothermalPlant")
  ai_fight3:set_rect({ 44, 91, 59, 114 })
  ai_fight3:clear_guarded_rects()
  ai_fight3:add_guarded_rect({ 20, 88, 61, 127 })
  ai_fight3:add_guarded_rect({ 62, 95, 74, 104 })
end

-- Every 121 ticks: when base 3 has a Rare Ore Smelter, it gets a rare ore mining group with up to 3 Cargo Trucks,
-- a mine, a Geothermal Plant and a Rail Gun guard post to build, and builds for its guards instead of base 1; base 3
-- is finished 300 marks later (0x11006390).
function Base3RareSmelterCheck(t)
  if not ai_base3:first_of_type("RareOreSmelter", "None") then return end
  t:destroy()
  trigger.time{time = 30000, on = Base3Finish}
  ai_base3_rare_mining = ai.mining_group(ai_player)
  ai_base3_rare_mining:setup({ 53, 120 }, { 53, 115 }, "RareOreMine", "RareOreSmelter", { 49, 116, 56, 121 })
  ai_base3_rare_mining:set_targ_count("CargoTruck", nil, 3)
  ai_base3:record_veh_reinforce_group(ai_base3_rare_mining, 100)
  ai_base3:record_building({ 54, 120 }, "RareOreMine")
  ai_base3:record_building({ 39, 86 }, "GeothermalPlant")
  ai_base3:record_building({ 69, 100 }, "GuardPost", "RailGun")
  ai_base3:record_veh_reinforce_group(ai_fight3, 10)
  ai_base1:unrecord_veh_group(ai_fight3)
end

-- Base 3's last buildings, tubes and walls; on Hard a Meteor Defense too (0x11006510; the list from `op2dll calls
-- --call Base3Finish` at each difficulty).
function Base3Finish(t)
  t:destroy()
  ai_base3:record_building({ 67, 100 }, "GuardPost", "AcidCloud")
  ai_base3:record_building({ 52, 97 }, "Residence")
  ai_base3:record_building({ 28, 106 }, "AdvancedResidence")
  ai_base3:record_building({ 24, 106 }, "AdvancedResidence")
  ai_base3:record_building({ 28, 110 }, "RecreationFacility")
  ai_base3:record_building({ 48, 94 }, "GuardPost", "ThorsHammer")
  if players[1].difficulty == "Hard" then ai_base3:record_building({ 52, 103 }, "MeteorDefense") end
  ai_base3:record_building({ 25, 110 }, "MedicalCenter")
  ai_base3:record_building({ 21, 106 }, "Observatory")
  ai_base3:record_building({ 24, 103 }, "Agridome")
  ai_base3:record_building({ 52, 106 }, "Nursery")
  ai_base3:record_building({ 52, 109 }, "University")
  ai_base3:record_building({ 60, 95 }, "GuardPost", "AcidCloud")
  ai_base3:record_building({ 62, 106 }, "GuardPost", "ThorsHammer")
  ai_base3:record_building({ 60, 98 }, "GuardPost", "EMP")
  ai_base3:record_building({ 60, 100 }, "GuardPost", "ThorsHammer")
  ai_base3:record_building({ 60, 102 }, "GuardPost", "AcidCloud")
  ai_base3:record_tube({ 61, 96 })
  ai_base3:record_tube({ 61, 97 })
  ai_base3:record_tube({ 61, 99 })
  ai_base3:record_tube({ 61, 101 })
  ai_base3:record_tube({ 61, 103 })
  ai_base3:record_tube({ 61, 104 })
  ai_base3:record_tube({ 61, 105 })
  ai_base3:record_tube({ 61, 106 })
  ai_base3:record_wall({ 36, 103 })
  ai_base3:record_wall({ 36, 104 })
  ai_base3:record_wall({ 36, 105 })
  ai_base3:record_wall({ 36, 106 })
  ai_base3:record_wall({ 36, 108 })
  ai_base3:record_wall({ 37, 108 })
  ai_base3:record_wall({ 38, 108 })
  ai_base3:record_wall({ 39, 108 })
  ai_base3:record_wall({ 40, 108 })
  ai_base3:record_wall({ 41, 108 })
  ai_base3:record_wall({ 42, 108 })
  ai_base3:record_wall({ 43, 108 })
  ai_base3:record_wall({ 44, 108 })
  ai_base3:record_wall({ 47, 92 })
  ai_base3:record_wall({ 48, 92 })
  ai_base3:record_wall({ 49, 92 })
  ai_base3:record_wall({ 50, 92 })
  ai_base3:record_wall({ 51, 92 })
  ai_base3:record_wall({ 52, 92 })
  ai_base3:record_wall({ 53, 92 })
  ai_base3:record_wall({ 54, 92 })
  ai_base3:record_wall({ 54, 93 })
  ai_base3:record_wall({ 54, 94 })
  ai_base3:record_wall({ 54, 95 })
  ai_base3:record_wall({ 54, 96 })
  ai_base3:record_wall({ 54, 97 })
  ai_base3:record_wall({ 55, 97 })
  ai_base3:record_wall({ 55, 98 })
  ai_base3:record_wall({ 55, 99 })
  ai_base3:record_wall({ 55, 104 })
  ai_base3:record_wall({ 55, 105 })
  ai_base3:record_wall({ 55, 106 })
  ai_base3:record_wall({ 55, 107 })
  ai_base3:record_wall({ 55, 108 })
  ai_base3:record_wall({ 55, 109 })
  ai_base3:record_wall({ 55, 110 })
  ai_base3:record_wall({ 55, 111 })
  ai_base3:record_wall({ 55, 112 })
  ai_base3:record_wall({ 55, 113 })
  ai_base3:record_wall({ 55, 114 })
  ai_base3:record_wall({ 55, 115 })
  ai_base3:record_wall({ 55, 116 })
  ai_base3:record_wall({ 62, 94 })
  ai_base3:record_wall({ 62, 95 })
  ai_base3:record_wall({ 62, 96 })
  ai_base3:record_wall({ 62, 97 })
  ai_base3:record_wall({ 62, 98 })
  ai_base3:record_wall({ 62, 99 })
  ai_base3:record_wall({ 62, 104 })
  ai_base3:record_wall({ 63, 96 })
  ai_base3:record_wall({ 63, 104 })
  ai_base3:record_wall({ 64, 104 })
  ai_base3:record_wall({ 65, 104 })

end

-- Once player 1 has a Command Center up (or few colonists, or one vehicle): from then on the colony fails without a
-- Command Center, CheckForFail runs every 40 ticks and morale is free; the computer's first move is drawn 280 to
-- 315 marks out (Normal: 5/4 of that), on Easy its leaving instead (0x110078C0).
function BasePlaced(t)
  if base_placed then return end
  base_placed = true
  mission.failure(trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1})
  trigger.time{time = 40, one_shot = false, on = CheckForFail}
  game.free_morale(1)
  if players[1].difficulty ~= "Easy" then
    local wait = game.rand(3500) + 28000
    if players[1].difficulty == "Normal" then wait = wait * 5 // 4 end
    attack_trigger = trigger.time{time = wait, one_shot = false, on = SpawnAttack}
  else
    attack_trigger = trigger.time{time = game.rand(3500) + 28000, one_shot = false, on = ExitMapMultiple}
  end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  roll_beacons(BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(false)
  game.set_daylight_moves(true)
  game.morale_steady("Good")

  -- The win.
  local t5 = trigger.count{type = "EvacuationModule", compare = ">=", count = 1, one_shot = true}
  mission.victory(t5, "Evacuate 200 colonists to spacecraft", {one_shot = true})
  local t7 = trigger.count{type = "FoodCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t7, "Evacuate 10000 units of food to spacecraft", {one_shot = true})
  t9 = trigger.count{type = "CommonMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t9, "Evacuate 10000 units of Common Metals to spacecraft", {one_shot = true})
  t11 = trigger.count{type = "RareMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t11, "Evacuate 10000 units of Rare Metals to spacecraft", {one_shot = true})
  trigger.operational{type = "CommandCenter", compare = ">=", count = 1, player = 1, on = BasePlaced}
  trigger.resource{resource = "Colonists", compare = "<", amount = 5, player = 1, one_shot = true, on = BasePlaced}
  trigger.vehicle_count{compare = "<", count = 1, player = 1, one_shot = true, on = BasePlaced}
  trigger.time{min = 1, max = 10, on = Lava_Vent}  -- after 0 to 0 marks
  trigger.time{min = 10000, max = 20000, one_shot = false, on = DoQuake}  -- after 100 to 200 marks
  trigger.time{min = 20000, max = 25000, one_shot = false, on = DoLightning}  -- after 200 to 250 marks
  trigger.time{min = 25000, max = 30000, one_shot = false, on = DoTornado}  -- after 250 to 300 marks
  trigger.time{min = 2000, max = 15000, one_shot = false, on = DoMeteor}  -- after 20 to 150 marks
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 224, 52 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 223, 17 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 188, 40 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 213, 62 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 250, 18 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 213, 25 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 39, 86 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 6, 121 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 26, 97 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 54, 120 } }
  trigger.time{time = 5000, one_shot = false, on = GiveAIOre}  -- after 50 marks
  trigger.time{min = 10, max = 50, on = ExpandBase1A}  -- after 0 to 0 marks
  trigger.time{min = 51, max = 90, on = ExpandBase1B}  -- after 0 to 0 marks
  trigger.time{min = 200, max = 300, on = ExpandBase1C}  -- after 2 to 3 marks
  trigger.time{min = 60000, max = 70000, on = ExpandBase1D}  -- after 600 to 700 marks
  trigger.time{min = 100000, max = 120000, on = AddDirts}  -- after 1000 to 1200 marks
  trigger.time{min = 400, max = 500, on = SetupBase3}  -- after 4 to 5 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  if difficulty == "Easy" then
    trigger.time{time = 20000, one_shot = false, on = TimeUpgrades}  -- after 200 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 15000, one_shot = false, on = TimeUpgrades}  -- after 150 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 13500, one_shot = false, on = TimeUpgrades}  -- after 135 marks
  end
  trigger.time{time = 1000, one_shot = false, on = TraceOre}  -- after 10 marks  -- TraceOre isn't converted
  trigger.time{time = 350000, on = Microbe}  -- after 3500 marks
end

-- Not converted:
-- - TraceOre isn't converted: it calls nothing
