-- p04Lua.lua  -  Plymouth Mission #4 (Lua)
-- Trigger functions finished by hand (Refresh, CheckForFail, Tower1Active, Tower2Active, Tower3Active, Tower4Active, Tower5Active, Tower6Active, Tower7Active, Tower8Active, Tower9Active, Tower10Active, Tower11Active, Tank1Trans, Tank2Trans, Tank3Trans, Tank4Trans, Tank5Trans, Tank6Trans, Tank7Trans, Tank8Trans, Tank9Trans, Tank10Trans, Tank11Trans, Tank12Trans, Scout1Trans, Scout2Trans, Scout3Trans, Scout4Trans), from the disassembly of p04.dll.
-- Converted by op2dll from p04.dll. With p04Lua.placement.lua (what every difficulty makes alike),
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
        research = { 4000 },
        tech_level = 3,
        view = { 57, 6 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 4,
        units = {
        },
      },
      [3] = {
        research = {  },
        tech_level = 4,
        units = {
        },
      },
    },
    walls = {
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        research = { 4000 },
        tech_level = 3,
        view = { 57, 6 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 4,
        units = {
        },
      },
      [3] = {
        research = {  },
        tech_level = 4,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 34, 25 } }, { "Tube", { 39, 45 } }, { "Tube", { 41, 15 } }, { "Tube", { 41, 16 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        research = { 4000 },
        tech_level = 3,
        view = { 57, 6 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 4,
        units = {
        },
      },
      [3] = {
        research = {  },
        tech_level = 4,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 15, 55 } }, { "Tube", { 18, 26 } }, { "Tube", { 18, 27 } }, { "Tube", { 18, 28 } },
      { "Tube", { 18, 29 } }, { "Tube", { 23, 32 } }, { "Tube", { 27, 19 } }, { "Tube", { 27, 20 } },
      { "Tube", { 27, 21 } }, { "Tube", { 27, 22 } }, { "Tube", { 27, 23 } }, { "Tube", { 38, 57 } },
      { "Tube", { 39, 45 } }, { "Tube", { 39, 57 } }, { "Tube", { 41, 15 } }, { "Tube", { 41, 16 } },
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
    { type = "Lynx", at = { 47, 40 }, weapon = "Laser" },
  },
  [2] = {
    { type = "Lynx", at = { 22, 21 }, weapon = "Laser" },
    { type = "Lynx", at = { 22, 24 }, weapon = "Laser" },
  },
  [3] = {
    { type = "Lynx", at = { 20, 50 }, weapon = "Laser" },
    { type = "Lynx", at = { 23, 52 }, weapon = "Laser" },
  },
  [4] = {
    { type = "Lynx", at = { 13, 40 }, weapon = "Laser" },
    { type = "Lynx", at = { 11, 40 }, weapon = "Laser" },
  },
  [5] = {
    { type = "Lynx", at = { 40, 62 }, weapon = "Laser" },
    { type = "Lynx", at = { 55, 25 }, weapon = "Laser" },
    { type = "Lynx", at = { 35, 42 }, weapon = "Laser" },
  },
  [6] = {
    { type = "Lynx", at = { 33, 40 }, weapon = "Laser" },
    { type = "Lynx", at = { 34, 41 }, weapon = "Laser" },
    { type = "Lynx", at = { 33, 41 }, weapon = "Laser" },
  },
  [7] = {
    { type = "Lynx", at = { 48, 31 }, weapon = "Laser" },
  },
  [8] = {
    { type = "Lynx", at = { 29, 22 }, weapon = "Laser" },
  },
  [9] = {
    { type = "Lynx", at = { 25, 54 }, weapon = "Laser" },
  },
  [10] = {
    { type = "Lynx", at = { 47, 40 }, weapon = "Laser" },
    { type = "Lynx", at = { 50, 40 }, weapon = "Laser" },
    { type = "Lynx", at = { 52, 41 }, weapon = "Laser" },
  },
  [11] = {
    { type = "Lynx", at = { 22, 21 }, weapon = "Laser" },
    { type = "Lynx", at = { 32, 28 }, weapon = "Laser" },
    { type = "Lynx", at = { 25, 20 }, weapon = "Laser" },
  },
  [12] = {
    { type = "Lynx", at = { 23, 52 }, weapon = "Laser" },
    { type = "Lynx", at = { 24, 57 }, weapon = "Laser" },
    { type = "Lynx", at = { 14, 60 }, weapon = "Laser" },
  },
  [13] = {
    { type = "Lynx", at = { 13, 40 }, weapon = "Laser" },
    { type = "Lynx", at = { 15, 40 }, weapon = "Laser" },
    { type = "Lynx", at = { 11, 40 }, weapon = "Laser" },
  },
  [14] = {
    { type = "Lynx", at = { 40, 62 }, weapon = "Laser" },
    { type = "Lynx", at = { 55, 25 }, weapon = "Laser" },
    { type = "Lynx", at = { 35, 42 }, weapon = "Laser" },
    { type = "Lynx", at = { 35, 6 }, weapon = "Laser" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_fight1, ai_fight2, ai_fight3, ai_fight4, ai_fight5, ai_fight6, ai_fight7, ai_fight8, ai_fight9

-- The computer player's eleven idle Guard Posts (0x11009AB4 to 0x11009ADC), woken by the rect triggers.
local tower = {}

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_eden()
  p:ally_with(players[2])
  p:set_tech_level(4)
  local u61 = game.create_unit{ type = "Tokamak", player = p, at = { 45, 60 }, exact = true, lights = false }[1]
  u61:set_damage(0)
  local u62 = game.create_unit{ type = "Tokamak", player = p, at = { 3, 60 }, exact = true, lights = false }[1]
  u62:set_damage(0)
  local u63 = game.create_unit{ type = "GuardPost", player = p, at = { 40, 57 }, weapon = "Laser", exact = true, lights = false }[1]
  u63:set_damage(0)
  local u64 = game.create_unit{ type = "GuardPost", player = p, at = { 41, 13 }, weapon = "Laser", exact = true, lights = false }[1]
  u64:set_damage(0)
  local u65 = game.create_unit{ type = "GuardPost", player = p, at = { 27, 17 }, weapon = "Laser", exact = true, lights = false }[1]
  u65:idle()
  tower[1] = u65
  local u66 = game.create_unit{ type = "GuardPost", player = p, at = { 35, 25 }, weapon = "Laser", exact = true, lights = false }[1]
  u66:idle()
  tower[2] = u66
  local u67 = game.create_unit{ type = "GuardPost", player = p, at = { 18, 24 }, weapon = "Laser", exact = true, lights = false }[1]
  u67:idle()
  tower[3] = u67
  local u68 = game.create_unit{ type = "GuardPost", player = p, at = { 23, 33 }, weapon = "Laser", exact = true, lights = false }[1]
  u68:idle()
  tower[4] = u68
  local u69, u70
  if difficulty == "Normal" or difficulty == "Hard" then
    u69 = game.create_unit{ type = "GuardPost", player = p, at = { 20, 46 }, weapon = "Laser", exact = true, lights = false }[1]
    u69:idle()
  tower[5] = u69
    u70 = game.create_unit{ type = "GuardPost", player = p, at = { 30, 55 }, weapon = "Laser", exact = true, lights = false }[1]
    u70:idle()
  tower[6] = u70
  end
  local u71 = game.create_unit{ type = "GuardPost", player = p, at = { 20, 62 }, weapon = "Laser", exact = true, lights = false }[1]
  u71:idle()
  tower[7] = u71
  local u72 = game.create_unit{ type = "GuardPost", player = p, at = { 13, 55 }, weapon = "Laser", exact = true, lights = false }[1]
  u72:idle()
  tower[8] = u72
  local u73
  if difficulty == "Normal" or difficulty == "Hard" then
    u73 = game.create_unit{ type = "GuardPost", player = p, at = { 46, 28 }, weapon = "Laser", exact = true, lights = false }[1]
    u73:idle()
  tower[9] = u73
  end
  local u74 = game.create_unit{ type = "GuardPost", player = p, at = { 40, 34 }, weapon = "Laser", exact = true, lights = false }[1]
  u74:idle()
  tower[10] = u74
  local u75 = game.create_unit{ type = "GuardPost", player = p, at = { 40, 45 }, weapon = "Laser", exact = true, lights = false }[1]
  u75:idle()
  tower[11] = u75
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 41, 29, 52, 40 })
  if difficulty == "Easy" then
    ai_fight1:add_units(ai_block(1))
    ai_fight1:set_lights(true)
  elseif difficulty == "Normal" then
    ai_fight1:add_units(ai_block(1))
    ai_fight1:set_lights(false)
  elseif difficulty == "Hard" then
    ai_fight1:add_units(ai_block(10))
    ai_fight1:set_lights(false)
  end
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 21, 20, 32, 31 })
  if difficulty == "Easy" then
    ai_fight2:add_units(ai_block(2))
    ai_fight2:set_lights(true)
  elseif difficulty == "Normal" then
    ai_fight2:add_units(ai_block(2))
    ai_fight2:set_lights(false)
  elseif difficulty == "Hard" then
    ai_fight2:add_units(ai_block(11))
    ai_fight2:set_lights(false)
  end
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 14, 51, 25, 61 })
  if difficulty == "Easy" then
    ai_fight3:add_units(ai_block(3))
    ai_fight3:set_lights(true)
  elseif difficulty == "Normal" then
    ai_fight3:add_units(ai_block(3))
    ai_fight3:set_lights(false)
  elseif difficulty == "Hard" then
    ai_fight3:add_units(ai_block(12))
    ai_fight3:set_lights(false)
  end
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_patrol_only()
  ai_fight4:set_rect({ 11, 40, 15, 42 })
  ai_fight4:set_patrol({ { 31, 14 }, { 55, 20 }, { 41, 37 }, { 35, 56 }, { 21, 49 } }, 3)
  ai_fight4:set_combine_fire()
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_fight4:add_units(ai_block(4))
  elseif difficulty == "Hard" then
    ai_fight4:add_units(ai_block(13))
  end
  ai_fight4:set_lights(true)
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_rect()
  ai_fight5:set_rect({ 35, 6, 55, 62 })
  ai_fight5:set_combine_fire(false)
  if difficulty == "Easy" then
    ai_fight5:add_units(ai_block(5))
    ai_fight5:set_lights(true)
  elseif difficulty == "Normal" then
    ai_fight5:add_units(ai_block(5))
    ai_fight5:set_lights(false)
  elseif difficulty == "Hard" then
    ai_fight5:add_units(ai_block(14))
    ai_fight5:set_lights(false)
  end
  players[2]:set_default_group(ai_fight5)
  if difficulty == "Normal" or difficulty == "Hard" then
    ai_fight6 = ai.fight_group(p)
    ai_fight6:do_guard_rect()
    ai_fight6:set_rect({ 33, 40, 34, 42 })
    ai_fight6:set_combine_fire(false)
    ai_fight6:add_units(ai_block(6))
    ai_fight6:set_lights(false)
    ai_fight7 = ai.fight_group(p)
    ai_fight7:do_guard_rect()
    ai_fight7:set_rect({ 41, 29, 52, 40 })
    ai_fight7:add_units(ai_block(7))
    ai_fight7:set_lights(false)
    ai_fight8 = ai.fight_group(p)
    ai_fight8:do_guard_rect()
    ai_fight8:set_rect({ 21, 20, 32, 31 })
    ai_fight8:add_units(ai_block(8))
    ai_fight8:set_lights(false)
    ai_fight9 = ai.fight_group(p)
    ai_fight9:do_guard_rect()
    ai_fight9:set_rect({ 14, 51, 25, 61 })
    ai_fight9:add_units(ai_block(9))
    ai_fight9:set_lights(false)
  end
end


-- The setup's units the trigger functions read (the DLL keeps each in a slot), found where it made them: the three
-- Advanced Labs to visit (0x11009AA8), Tank1 to Tank12 (0x11009AE0) and Scout1 to Scout4 (0x11009B10).
local LAB_AT = { { 46, 34 }, { 26, 25 }, { 20, 55 } }
local TANK_AT = { { 52, 2 }, { 53, 4 }, { 54, 6 }, { 56, 7 }, { 58, 7 }, { 60, 7 }, { 62, 5 }, { 63, 3 }, { 51, 9 }, { 53, 9 }, { 53, 11 }, { 51, 11 } }
local SCOUT_AT = { { 57, 3 }, { 59, 3 }, { 59, 5 }, { 57, 5 } }
local lab, tank, scout = {}, {}, {}
-- Which labs a Scout has visited (0x11009B20 to 0x11009B28).
local visited = { false, false, false }
-- The allied colony's buildings as the setup leaves them (0x110018C0): type, tile, damage, idle.
local ALLY_BUILDINGS = {
  { "LightTower", 59, 62, 0 }, { "Agridome", 59, 57, 800, true }, { "Agridome", 53, 53, 400, true },
  { "Agridome", 45, 56, 800, true }, { "Agridome", 40, 52, 400, true }, { "Agridome", 34, 52, 800, true },
  { "Agridome", 34, 46, 400, true }, { "CommonOreSmelter", 53, 58, 1000, true },
  { "CommonOreSmelter", 46, 43, 1000, true }, { "CommonOreSmelter", 35, 16, 1000, true },
  { "Residence", 49, 55, 400, true }, { "Residence", 46, 52, 600, true }, { "Residence", 49, 52, 400, true },
  { "Residence", 55, 38, 600, true }, { "Residence", 52, 28, 400, true }, { "Residence", 58, 28, 600, true },
  { "Residence", 58, 22, 400, true }, { "Residence", 52, 22, 600, true }, { "StructureFactory", 57, 49, 800, true },
  { "Garage", 46, 48, 550, true }, { "Garage", 51, 48, 1400, true }, { "Garage", 60, 38, 550, true },
  { "Garage", 34, 60, 1400, true }, { "Garage", 29, 62, 550, true }, { "Garage", 36, 30, 1400, true },
  { "Garage", 38, 40, 550, true }, { "Garage", 15, 43, 1400, true }, { "CommonStorage", 50, 44, 400, true },
  { "CommonStorage", 53, 45, 400, true }, { "CommonStorage", 56, 44, 400, true },
  { "CommonStorage", 32, 11, 400, true }, { "CommonStorage", 35, 11, 400, true },
  { "CommonStorage", 38, 11, 400, true }, { "CommonStorage", 35, 20, 400, true },
  { "CommonStorage", 33, 20, 400, true }, { "CommonStorage", 12, 47, 400, true },
  { "CommonStorage", 15, 47, 400, true }, { "CommandCenter", 60, 44, 800, true },
  { "CommandCenter", 40, 20, 800, true }, { "BasicLab", 46, 38, 800, true }, { "BasicLab", 46, 24, 800, true },
  { "MedicalCenter", 50, 38, 700, true }, { "MedicalCenter", 52, 16, 700, true },
  { "AdvancedLab", 46, 34, 500, true }, { "AdvancedLab", 26, 25, 500, true }, { "AdvancedLab", 20, 55, 500, true },
  { "DIRT", 51, 34, 1000, true }, { "DIRT", 18, 31, 1000, true }, { "University", 56, 34, 600, true },
  { "University", 41, 26, 600, true }, { "RecreationFacility", 60, 34, 400, true }, { "Nursery", 58, 16, 600, true },
  { "StandardLab", 46, 20, 800, true }, { "Tokamak", 20, 16, 0 }, { "VehicleFactory", 27, 48, 1500, true },
  { "VehicleFactory", 19, 38, 1500, true }, { "LightTower", 61, 9, 0 }, { "LightTower", 47, 10, 0 },
  { "LightTower", 24, 11, 0 }, { "LightTower", 12, 32, 0 },
}
local function find_unit(kind, at)
  for r = 0, 2 do
    for _, u in ipairs(game.units_in_rect({ at[1] - r, at[2] - r, at[1] + r, at[2] + r })) do
      if u.type == kind then return u end
    end
  end
end
local function find_units()
  for _, b in ipairs(ALLY_BUILDINGS) do
    local u = find_unit(b[1], { b[2], b[3] })
    if u then
      u:set_damage(b[4])
      if b[5] then u:idle() end
    end
  end
  for i, at in ipairs(LAB_AT) do lab[i] = find_unit("AdvancedLab", at) end
  for i, at in ipairs(TANK_AT) do tank[i] = find_unit("Lynx", at) end
  for i, at in ipairs(SCOUT_AT) do scout[i] = find_unit("Scout", at) end
end
-- A vehicle of the human's, while it lives, goes over to the hostile computer player with "Vehicle Infected" (sound
-- 166) pointing at it (Unit::DoTransfer(2), then TethysGame::AddMessage(Unit, ...)).
local function infect_vehicle(u)
  if u and u.alive then
    u:do_transfer(players[3])
    game.message_at("Vehicle Infected", 166, 1, (u.x + 31) * 32 + 16, (u.y - 1) * 32 + 16)
  end
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lab1Visit, Lab2Visit, Lab3Visit, StartHarass

function Lab1Visit(t)
  visited[1] = true
  game.message_at("Data Transmitted from Lab 1!", 160, 1, 2464, 1056)
end

function Lab2Visit(t)
  visited[2] = true
  game.message_at("Data Transmitted from Lab 2!", 160, 1, 1824, 768)
end

function Lab3Visit(t)
  visited[3] = true
  game.message_at("Data Transmitted from Lab 3!", 160, 1, 1632, 1728)
end

function StartHarass(t)
  ai_fight6:set_lights(true)
  ai_fight6:do_attack_enemy()
  ai_fight6:set_attack_type("Scout")
  ai_fight6:set_rect({ 59, 45, 63, 64 })
end

-- Every 120 ticks the DLL asks each of its tanks, Scouts and Guard Posts whether it's alive, and does nothing
-- with the answer (0x110033F0).
function Refresh(t) end

-- Every 40 ticks (0x110034D0): a lab destroyed before a Scout has visited it fails the
-- mission (one failure for each).
function CheckForFail(t)
  for i = 1, 3 do
    if not visited[i] and not (lab[i] and lab[i].alive) then mission.failure(trigger.time{time = 1}) end
  end
end

-- A unit of the human's in the 8 by 8 tiles at 55,13 (the game's): the Guard Post at 27,17 wakes (0x11002E90).
function Tower1Active(t)
  if tower[1] and tower[1].alive then tower[1]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 63,21 (the game's): the Guard Post at 35,25 wakes (0x11002EB0).
function Tower2Active(t)
  if tower[2] and tower[2].alive then tower[2]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 45,20 (the game's): the Guard Post at 18,24 wakes (0x11002ED0).
function Tower3Active(t)
  if tower[3] and tower[3].alive then tower[3]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 51,29 (the game's): the Guard Post at 23,33 wakes (0x11002EF0).
function Tower4Active(t)
  if tower[4] and tower[4].alive then tower[4]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 48,42 (the game's): the Guard Post at 20,46 wakes (0x11002F10).
function Tower5Active(t)
  if tower[5] and tower[5].alive then tower[5]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 58,51 (the game's): the Guard Post at 30,55 wakes (0x11002F30).
function Tower6Active(t)
  if tower[6] and tower[6].alive then tower[6]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 48,59 (the game's): the Guard Post at 20,62 wakes (0x11002F50).
function Tower7Active(t)
  if tower[7] and tower[7].alive then tower[7]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 41,51 (the game's): the Guard Post at 13,55 wakes (0x11002F70).
function Tower8Active(t)
  if tower[8] and tower[8].alive then tower[8]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 74,24 (the game's): the Guard Post at 46,28 wakes (0x11002F90).
function Tower9Active(t)
  if tower[9] and tower[9].alive then tower[9]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 68,30 (the game's): the Guard Post at 40,34 wakes (0x11002FB0).
function Tower10Active(t)
  if tower[10] and tower[10].alive then tower[10]:unidle() end
end

-- A unit of the human's in the 8 by 8 tiles at 68,41 (the game's): the Guard Post at 40,45 wakes (0x11002FD0).
function Tower11Active(t)
  if tower[11] and tower[11].alive then tower[11]:unidle() end
end

-- After 130 to 190 marks (0x11002FF0): Tank 1 goes over to the hostile player.
function Tank1Trans(t)
  infect_vehicle(tank[1])
end

-- After 130 to 190 marks (0x11003030): Tank 2 goes over to the hostile player.
function Tank2Trans(t)
  infect_vehicle(tank[2])
end

-- After 130 to 190 marks (0x11003070): Tank 3 goes over to the hostile player.
function Tank3Trans(t)
  infect_vehicle(tank[3])
end

-- After 130 to 190 marks (0x110030B0): Tank 4 goes over to the hostile player.
function Tank4Trans(t)
  infect_vehicle(tank[4])
end

-- After 130 to 190 marks (0x110030F0): Tank 5 goes over to the hostile player.
function Tank5Trans(t)
  infect_vehicle(tank[5])
end

-- After 130 to 190 marks (0x11003130): Tank 6 goes over to the hostile player.
function Tank6Trans(t)
  infect_vehicle(tank[6])
end

-- After 130 to 190 marks (0x11003170): Tank 7 goes over to the hostile player.
function Tank7Trans(t)
  infect_vehicle(tank[7])
end

-- After 130 to 190 marks (0x110031B0): Tank 8 goes over to the hostile player.
function Tank8Trans(t)
  infect_vehicle(tank[8])
end

-- After 130 to 190 marks (0x110031F0): Tank 9 goes over to the hostile player.
function Tank9Trans(t)
  infect_vehicle(tank[9])
end

-- After 130 to 190 marks (0x11003230): Tank 10 goes over to the hostile player.
function Tank10Trans(t)
  infect_vehicle(tank[10])
end

-- After 130 to 190 marks (0x11003270): Tank 11 goes over to the hostile player.
function Tank11Trans(t)
  infect_vehicle(tank[11])
end

-- After 130 to 190 marks (0x110032B0): Tank 12 goes over to the hostile player.
function Tank12Trans(t)
  infect_vehicle(tank[12])
end

-- After 130 to 190 marks (0x110032F0): Scout 1 goes over to the hostile player.
function Scout1Trans(t)
  infect_vehicle(scout[1])
end

-- After 130 to 190 marks (0x11003330): Scout 2 goes over to the hostile player.
function Scout2Trans(t)
  infect_vehicle(scout[2])
end

-- After 130 to 190 marks (0x11003370): Scout 3 goes over to the hostile player.
function Scout3Trans(t)
  infect_vehicle(scout[3])
end

-- After 130 to 190 marks (0x110033B0): Scout 4 goes over to the hostile player.
function Scout4Trans(t)
  infect_vehicle(scout[4])
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  roll_beacons(BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(false)
  game.set_daylight_moves(false)

  -- The computer player's base, where the setup makes it.
  setup_ai(players[3])
  -- The units the setup makes after it, alike at every difficulty.
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 52, 2 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 53, 4 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 54, 6 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 56, 7 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 58, 7 }, nil, true)
  make_unit(players[1], { type = "Scout", direction = "East" }, { 57, 3 }, nil, true)
  make_unit(players[1], { type = "Scout", direction = "East" }, { 59, 3 }, nil, true)
  make_unit(players[1], { type = "Scout", direction = "East" }, { 59, 5 }, nil, true)
  make_unit(players[1], { type = "Scout", direction = "East" }, { 57, 5 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 60, 7 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 62, 5 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 63, 3 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 51, 9 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 53, 9 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 53, 11 }, nil, true)
  make_unit(players[1], { type = "Lynx", weapon = "Microwave", direction = "East" }, { 51, 11 }, nil, true)
  find_units()
  if difficulty == "Normal" then
    trigger.time{time = 7500, on = StartHarass}  -- after 75 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 4500, on = StartHarass}  -- after 45 marks
  end
  local visit = {}
  for i, fn in ipairs({ Lab1Visit, Lab2Visit, Lab3Visit }) do
    visit[i] = trigger.special_target{target = lab[i], type = "Scout", on = fn}
  end
  for _, v in ipairs({ { 3, "20,55" }, { 2, "26,25" }, { 1, "46,34" } }) do
    mission.victory(visit[v[1]], "Transmit data from Lab " .. v[1] .. " at " .. v[2] .. ".", { one_shot = true })
  end
  trigger.time{time = 120, one_shot = false, on = Refresh}  -- after 1 marks
  trigger.rect{at = { x = 55, y = 13, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower1Active}
  trigger.rect{at = { x = 63, y = 21, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower2Active}
  trigger.rect{at = { x = 45, y = 20, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower3Active}
  trigger.rect{at = { x = 51, y = 29, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower4Active}
  trigger.rect{at = { x = 48, y = 42, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower5Active}
  trigger.rect{at = { x = 58, y = 51, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower6Active}
  trigger.rect{at = { x = 48, y = 59, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower7Active}
  trigger.rect{at = { x = 41, y = 51, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower8Active}
  trigger.rect{at = { x = 74, y = 24, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower9Active}
  trigger.rect{at = { x = 68, y = 30, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower10Active}
  trigger.rect{at = { x = 68, y = 41, raw = true }, width = 8, height = 8, player = 1, one_shot = true, on = Tower11Active}
  if difficulty == "Easy" then
    trigger.time{min = 15000, max = 21000, on = Tank1Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank2Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank3Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank4Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank5Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank6Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank7Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank8Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank9Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank10Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank11Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Tank12Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Scout1Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Scout2Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Scout3Trans}  -- after 150 to 210 marks
    trigger.time{min = 15000, max = 21000, on = Scout4Trans}  -- after 150 to 210 marks
  elseif difficulty == "Normal" then
    trigger.time{min = 13000, max = 19000, on = Tank1Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank2Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank3Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank4Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank5Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank6Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank7Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank8Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank9Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank10Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank11Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Tank12Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Scout1Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Scout2Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Scout3Trans}  -- after 130 to 190 marks
    trigger.time{min = 13000, max = 19000, on = Scout4Trans}  -- after 130 to 190 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 10000, max = 16000, on = Tank1Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank2Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank3Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank4Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank5Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank6Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank7Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank8Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank9Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank10Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank11Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Tank12Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Scout1Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Scout2Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Scout3Trans}  -- after 100 to 160 marks
    trigger.time{min = 10000, max = 16000, on = Scout4Trans}  -- after 100 to 160 marks
  end

  -- The win.
  local t49 = trigger.count{type = "Scout", compare = "<", count = 1, player = 1}
  mission.failure(t49)
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
end

-- Not converted:
-- - the tubes and walls the setup makes late change with the difficulty (made first)
-- - Easy: units are made other ways than CreateUnit (98 on the map, 76 made)
-- - Normal: units are made other ways than CreateUnit (107 on the map, 76 made)
-- - Hard: units are made other ways than CreateUnit (113 on the map, 76 made)
-- - condition #18's trigger #17: SpecialTarget isn't converted
-- - condition #19's trigger #16: SpecialTarget isn't converted
-- - condition #20's trigger #15: SpecialTarget isn't converted
-- - trigger #15 calls Lab1Visit, but isn't converted: SpecialTarget isn't converted
-- - trigger #16 calls Lab2Visit, but isn't converted: SpecialTarget isn't converted
-- - trigger #17 calls Lab3Visit, but isn't converted: SpecialTarget isn't converted
