-- e09Lua.lua  -  Eden Mission #9 (Lua)
-- Trigger functions finished by hand (CheckForEnd, ReinforceE, ReinforceP, Located, ToggleP, EnableAmbush, DoAmbush1, DoAmbush2, DoAmbush3, DoAmbush4), from the disassembly of e09.dll.
-- Converted by op2dll from e09.dll. With e09Lua.placement.lua (what every difficulty makes alike),
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
        research = { 9000 },
        tech_level = 8,
        view = { 11, 7 },
        units = {
        },
      },
      [2] = {
        workers = 25, scientists = 25, food = 8000,
        research = {  },
        tech_level = 9,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CargoTruck", direction = "South", player = 1, at = { 11, 5 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 13, 5 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 11, 7 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 13, 7 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 12, 6 } },
      { type = "Scout", direction = "SouthWest", player = 1, at = { 8, 13 } },
      { type = "Scout", direction = "SouthEast", player = 1, at = { 20, 13 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 4 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 6 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 8 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 16, 4 } },
      { type = "Lynx", weapon = "RailGun", direction = "South", player = 1, at = { 16, 6 } },
      { type = "Lynx", weapon = "RailGun", direction = "South", player = 1, at = { 16, 8 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 10, 10 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 14, 10 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 12, 10 } },
      { type = "Panther", weapon = "Laser", direction = "South", player = 1, at = { 11, 2 } },
      { type = "Panther", weapon = "Laser", direction = "SouthEast", player = 1, at = { 13, 2 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 14, 13 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 11, 13 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 5, 10 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 20, 10 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthEast", player = 1, at = { 22, 5 } },
      { type = "Lynx", weapon = "Laser", direction = "West", player = 1, at = { 22, 7 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 24, 5 } },
      { type = "Panther", weapon = "RailGun", direction = "West", player = 1, at = { 24, 7 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 26, 7 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        research = { 9000 },
        tech_level = 8,
        view = { 11, 7 },
        units = {
        },
      },
      [2] = {
        workers = 25, scientists = 25, food = 8000,
        research = {  },
        tech_level = 9,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CargoTruck", direction = "South", player = 1, at = { 11, 5 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 13, 5 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 11, 7 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 13, 7 } },
      { type = "Scout", direction = "SouthWest", player = 1, at = { 8, 13 } },
      { type = "Scout", direction = "SouthEast", player = 1, at = { 20, 13 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 4 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 6 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 8 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 16, 4 } },
      { type = "Lynx", weapon = "RailGun", direction = "South", player = 1, at = { 16, 6 } },
      { type = "Lynx", weapon = "RailGun", direction = "South", player = 1, at = { 16, 8 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 10, 10 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 14, 10 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 12, 10 } },
      { type = "Panther", weapon = "Laser", direction = "South", player = 1, at = { 11, 2 } },
      { type = "Panther", weapon = "Laser", direction = "SouthEast", player = 1, at = { 13, 2 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 14, 13 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 11, 13 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 5, 10 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 20, 10 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthEast", player = 1, at = { 22, 5 } },
      { type = "Lynx", weapon = "Laser", direction = "West", player = 1, at = { 22, 7 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 24, 5 } },
      { type = "Panther", weapon = "RailGun", direction = "West", player = 1, at = { 24, 7 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 26, 7 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        research = { 9000 },
        tech_level = 8,
        view = { 11, 7 },
        units = {
        },
      },
      [2] = {
        workers = 25, scientists = 25, food = 8000,
        research = {  },
        tech_level = 9,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CargoTruck", direction = "South", player = 1, at = { 11, 5 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 13, 5 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 11, 7 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 13, 7 } },
      { type = "Scout", direction = "SouthWest", player = 1, at = { 8, 13 } },
      { type = "Scout", direction = "SouthEast", player = 1, at = { 20, 13 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 4 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 6 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 8, 8 } },
      { type = "Lynx", weapon = "Laser", direction = "South", player = 1, at = { 16, 4 } },
      { type = "Lynx", weapon = "RailGun", direction = "South", player = 1, at = { 16, 6 } },
      { type = "Lynx", weapon = "RailGun", direction = "South", player = 1, at = { 16, 8 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 10, 10 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthEast", player = 1, at = { 14, 10 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 12, 10 } },
      { type = "Panther", weapon = "Laser", direction = "South", player = 1, at = { 11, 2 } },
      { type = "Panther", weapon = "Laser", direction = "SouthEast", player = 1, at = { 13, 2 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 14, 13 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 11, 13 } },
      { type = "Tiger", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 5, 10 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 20, 10 } },
      { type = "Lynx", weapon = "Laser", direction = "SouthEast", player = 1, at = { 22, 5 } },
      { type = "Lynx", weapon = "Laser", direction = "West", player = 1, at = { 22, 7 } },
      { type = "Panther", weapon = "RailGun", direction = "SouthWest", player = 1, at = { 24, 5 } },
      { type = "Panther", weapon = "RailGun", direction = "West", player = 1, at = { 24, 7 } },
      { type = "Tiger", weapon = "RailGun", direction = "South", player = 1, at = { 26, 7 } },
    },
    beacons = {
    },
  },
}

-- Where lava may flow (x1, y1, x2, y2).
local LAVA_POSSIBLE = {
  { 120, 28, 123, 28 },
  { 118, 29, 124, 29 },
  { 117, 30, 124, 30 },
  { 112, 31, 113, 31 },
  { 116, 31, 126, 31 },
  { 111, 32, 114, 32 },
  { 116, 32, 127, 32 },
  { 99, 33, 104, 33 },
  { 108, 33, 128, 33 },
  { 98, 34, 98, 34 },
  { 103, 34, 109, 34 },
  { 114, 34, 128, 34 },
  { 105, 35, 108, 35 },
  { 114, 35, 122, 36 },
  { 125, 35, 128, 35 },
  { 126, 36, 128, 39 },
  { 114, 37, 121, 37 },
  { 113, 38, 120, 38 },
  { 112, 39, 117, 39 },
  { 111, 40, 116, 40 },
  { 125, 40, 128, 41 },
  { 96, 41, 97, 41 },
  { 110, 41, 115, 41 },
  { 97, 42, 98, 42 },
  { 107, 42, 115, 42 },
  { 124, 42, 128, 42 },
  { 97, 43, 99, 43 },
  { 106, 43, 116, 43 },
  { 123, 43, 126, 43 },
  { 98, 44, 100, 44 },
  { 103, 44, 116, 44 },
  { 123, 44, 125, 44 },
  { 98, 45, 115, 45 },
  { 124, 45, 124, 45 },
  { 98, 46, 113, 46 },
  { 99, 47, 112, 47 },
  { 100, 48, 107, 48 },
  { 103, 49, 105, 49 },
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
    { type = "CommandCenter", at = { 60, 125 } },
    { type = "VehicleFactory", at = { 68, 125 } },
    { type = "AdvancedLab", at = { 53, 125 } },
    { type = "CommandCenter", at = { 114, 114 } },
    { type = "StandardLab", at = { 108, 115 } },
    { type = "CommandCenter", at = { 125, 79 } },
    { type = "AdvancedLab", at = { 126, 74 } },
    { type = "Tokamak", at = { 49, 125 } },
    { type = "GuardPost", at = { 60, 117 }, weapon = "RPG" },
    { type = "GuardPost", at = { 51, 117 }, weapon = "ESG" },
    { type = "GuardPost", at = { 67, 117 }, weapon = "RPG" },
    { type = "GuardPost", at = { 57, 84 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 121, 21 }, weapon = "ESG" },
    { type = "GuardPost", at = { 123, 86 }, weapon = "RPG" },
    { type = "GuardPost", at = { 118, 47 }, weapon = "RPG" },
    { type = "GuardPost", at = { 88, 42 }, weapon = "ESG" },
    { type = "GuardPost", at = { 95, 48 }, weapon = "EMP" },
    { type = "GuardPost", at = { 102, 112 }, weapon = "RPG" },
  },
  [2] = {
    { type = "Tokamak", at = { 127, 3 } },
  },
  [3] = {
    { type = "GuardPost", at = { 77, 98 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 117, 79 }, weapon = "Microwave" },
  },
  [4] = {
    { type = "Panther", at = { 119, 12 }, weapon = "RPG" },
  },
  [5] = {
    { type = "Panther", at = { 117, 11 }, weapon = "RPG" },
  },
  [6] = {
    { type = "Lynx", at = { 73, 122 }, weapon = "Microwave" },
    { type = "Lynx", at = { 74, 125 }, weapon = "Microwave" },
    { type = "Lynx", at = { 70, 122 }, weapon = "EMP" },
    { type = "Panther", at = { 68, 122 }, weapon = "RPG" },
    { type = "Tiger", at = { 72, 127 }, weapon = "RPG" },
  },
  [7] = {
    { type = "Lynx", at = { 122, 117 }, weapon = "EMP" },
    { type = "Lynx", at = { 121, 119 }, weapon = "Microwave" },
    { type = "Tiger", at = { 123, 81 }, weapon = "RPG" },
    { type = "Panther", at = { 118, 59 }, weapon = "Microwave" },
    { type = "Panther", at = { 121, 59 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 124, 95 }, weapon = "EMP" },
    { type = "Lynx", at = { 126, 95 }, weapon = "Stickyfoam" },
  },
  [8] = {
    { type = "Scout", at = { 121, 68 } },
    { type = "CargoTruck", at = { 116, 63 } },
    { type = "CargoTruck", at = { 116, 111 } },
    { type = "CargoTruck", at = { 63, 127 } },
  },
  [9] = {
    { type = "Lynx", at = { 119, 12 }, weapon = "RPG" },
  },
  [10] = {
    { type = "Lynx", at = { 117, 11 }, weapon = "RPG" },
  },
  [11] = {
    { type = "Lynx", at = { 121, 119 }, weapon = "Microwave" },
    { type = "Tiger", at = { 123, 81 }, weapon = "RPG" },
    { type = "Panther", at = { 118, 59 }, weapon = "Microwave" },
    { type = "Panther", at = { 121, 59 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 126, 95 }, weapon = "Stickyfoam" },
  },
  [12] = {
    { type = "GuardPost", at = { 77, 98 }, weapon = "ESG" },
    { type = "GuardPost", at = { 117, 79 }, weapon = "ESG" },
  },
  [13] = {
    { type = "Lynx", at = { 80, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 80, 122 }, weapon = "ESG" },
    { type = "Lynx", at = { 80, 122 }, weapon = "Microwave" },
    { type = "Lynx", at = { 80, 122 }, weapon = "Microwave" },
  },
  [14] = {
    { type = "Tiger", at = { 81, 55 }, weapon = "RPG" },
    { type = "Panther", at = { 81, 55 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 81, 55 }, weapon = "EMP" },
    { type = "Lynx", at = { 81, 55 }, weapon = "EMP" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_fight1, ai_fight2, ai_fight3, ai_fight4, ai_fight5, ai_fight6_hard, ai_fight7_hard

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_plymouth()
  ai_block(1):create_units(p, true)
  if difficulty == "Easy" then
    ai_block(3):create_units(p, true)
  elseif difficulty == "Normal" then
    ai_block(2):create_units(p, true)
    ai_block(3):create_units(p, true)
  elseif difficulty == "Hard" then
    ai_block(2):create_units(p, true)
    ai_block(12):create_units(p, true)
  end
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_patrol_only()
  ai_fight1:set_rect({ 117, 11, 124, 13 })
  ai_fight1:set_patrol({ { 120, 15 }, { 113, 7 } }, 1)
  if difficulty == "Easy" then
    ai_fight1:add_units(ai_block(9))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight1:add_units(ai_block(4))
  end
  ai_fight1:set_lights(true)
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_patrol_only()
  ai_fight2:set_rect({ 117, 11, 124, 13 })
  ai_fight2:set_patrol({ { 115, 18 }, { 112, 13 } }, 1)
  if difficulty == "Easy" then
    ai_fight2:add_units(ai_block(10))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight2:add_units(ai_block(5))
  end
  ai_fight2:set_lights(true)
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 68, 122, 74, 127 })
  ai_fight3:add_units(ai_block(6))
  ai_fight3:set_lights(true)
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 118, 59, 126, 119 })
  if difficulty == "Easy" then
    ai_fight4:add_units(ai_block(11))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight4:add_units(ai_block(7))
  end
  ai_fight4:set_lights(true)
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_patrol_only()
  ai_fight5:set_patrol({ { 19, 101 }, { 109, 26 }, { 44, 22 }, { 85, 81 } }, 2)
  ai_fight5:set_rect({ 118, 59, 126, 119 })
  ai_fight5:add_units(ai_block(8))
  ai_fight5:set_lights(true)
  if difficulty == "Hard" then
    ai_fight6_hard = ai.fight_group(p)
    ai_fight6_hard:do_patrol_only()
    ai_fight6_hard:set_patrol({ { 80, 122 }, { 116, 16 } }, 1)
    ai_fight6_hard:set_rect({ 68, 122, 74, 127 })
    ai_fight6_hard:add_units(ai_block(13))
    ai_fight6_hard:set_lights(true)
    ai_fight7_hard = ai.fight_group(p)
    ai_fight7_hard:do_guard_rect()
    ai_fight7_hard:set_rect({ 77, 53, 85, 57 })
    ai_fight7_hard:add_units(ai_block(14))
    ai_fight7_hard:set_lights(false)
  end
  p:set_tech_level(9)
  p.workers = 25
  p.scientists = 25
  p.food = 8000
end


-- The triggers the functions here turn on and off (0x1100B588 to 0x1100B5A4): ReinforceP's vehicle count and the
-- ToggleP timer, ReinforceE's vehicle count and parts count, and the four ambush rectangles.
local reinforce_p, toggle_p, reinforce_e1, reinforce_e2
local ambush = {}
-- What the setup reads of the player's research before it starts (0x110012D0): 8503 at
-- 0x1100B580 and 5508 at 0x1100B584; they choose the convoy's weapons.
local has_8503, has_5508
-- The Plymouth base the reinforcements guard and the ambushes attack from (0x1100B5A8).
local PLYMOUTH_RECT = { 50, 116, 70, 127 }
-- The unit blocks the reinforcements and ambushes add, by address, as the DLL ships them (`op2dll disasm --block
-- --shipped`).
local BLOCKS = {
  [0xA678] = {
    { type = "Lynx", at = { 73, 128 }, weapon = "EMP" },
    { type = "Lynx", at = { 75, 128 }, weapon = "Microwave" },
    { type = "Lynx", at = { 77, 128 }, weapon = "Microwave" },
    { type = "Lynx", at = { 79, 128 }, weapon = "EMP" },
    { type = "Tiger", at = { 81, 128 }, weapon = "ESG" } },
  [0xB2D0] = {
    { type = "Lynx", at = { 128, 52 }, weapon = "EMP" },
    { type = "Lynx", at = { 128, 54 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 56 }, weapon = "Microwave" } },
  [0xA5F0] = {
    { type = "Lynx", at = { 128, 52 }, weapon = "EMP" },
    { type = "Lynx", at = { 128, 54 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 56 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 58 }, weapon = "EMP" },
    { type = "Tiger", at = { 128, 60 }, weapon = "ESG" } },
  [0xAF08] = {
    { type = "Lynx", at = { 1, 51 }, weapon = "EMP" },
    { type = "Lynx", at = { 1, 52 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 53 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 54 }, weapon = "ESG" } },
  [0xA810] = {
    { type = "Lynx", at = { 1, 51 }, weapon = "EMP" },
    { type = "Lynx", at = { 1, 52 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 53 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 54 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 55 }, weapon = "RPG" },
    { type = "Panther", at = { 1, 56 }, weapon = "ESG" },
    { type = "Panther", at = { 1, 57 }, weapon = "ESG" } },
  [0xAC50] = {
    { type = "Lynx", at = { 1, 51 }, weapon = "EMP" },
    { type = "Lynx", at = { 1, 52 }, weapon = "RPG" },
    { type = "Lynx", at = { 1, 53 }, weapon = "RPG" },
    { type = "Panther", at = { 1, 54 }, weapon = "ESG" } },
  [0xA568] = {
    { type = "Lynx", at = { 73, 128 }, weapon = "Microwave" },
    { type = "Lynx", at = { 74, 128 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 75, 128 }, weapon = "RPG" },
    { type = "Panther", at = { 76, 128 }, weapon = "RPG" },
    { type = "Panther", at = { 77, 128 }, weapon = "ESG" } },
  [0xA108] = {
    { type = "Lynx", at = { 73, 128 }, weapon = "Microwave" },
    { type = "Lynx", at = { 74, 128 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 74, 128 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 75, 128 }, weapon = "RPG" },
    { type = "Panther", at = { 76, 128 }, weapon = "RPG" },
    { type = "Tiger", at = { 77, 128 }, weapon = "ESG" },
    { type = "Tiger", at = { 77, 128 }, weapon = "ESG" } },
  [0xABC8] = {
    { type = "Lynx", at = { 73, 128 }, weapon = "Microwave" },
    { type = "Lynx", at = { 74, 128 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 75, 128 }, weapon = "RPG" },
    { type = "Panther", at = { 76, 128 }, weapon = "RPG" },
    { type = "Tiger", at = { 77, 128 }, weapon = "ESG" } },
  [0xAE80] = {
    { type = "Lynx", at = { 124, 122 }, weapon = "EMP" },
    { type = "Lynx", at = { 125, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 126, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 127, 122 }, weapon = "ESG" } },
  [0xA898] = {
    { type = "Lynx", at = { 124, 122 }, weapon = "EMP" },
    { type = "Lynx", at = { 125, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 126, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 126, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 126, 122 }, weapon = "RPG" },
    { type = "Panther", at = { 127, 122 }, weapon = "ESG" },
    { type = "Panther", at = { 127, 122 }, weapon = "ESG" } },
  [0xAD60] = {
    { type = "Lynx", at = { 124, 122 }, weapon = "EMP" },
    { type = "Lynx", at = { 125, 122 }, weapon = "RPG" },
    { type = "Lynx", at = { 126, 122 }, weapon = "RPG" },
    { type = "Panther", at = { 127, 122 }, weapon = "ESG" } },
  [0xA3D0] = {
    { type = "Lynx", at = { 128, 16 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 17 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 128, 18 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 19 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 20 }, weapon = "ESG" } },
  [0xA2A0] = {
    { type = "Lynx", at = { 128, 16 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 17 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 128, 18 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 128, 19 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 20 }, weapon = "RPG" },
    { type = "Tiger", at = { 128, 21 }, weapon = "ESG" },
    { type = "Tiger", at = { 128, 22 }, weapon = "ESG" } },
  [0xACD8] = {
    { type = "Lynx", at = { 128, 16 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 17 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 128, 18 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 19 }, weapon = "RPG" },
    { type = "Tiger", at = { 128, 20 }, weapon = "ESG" } },
  [0xA788] = {
    { type = "Lynx", at = { 2, 77 }, weapon = "EMP" },
    { type = "Lynx", at = { 2, 78 }, weapon = "RPG" },
    { type = "Lynx", at = { 2, 79 }, weapon = "RPG" },
    { type = "Lynx", at = { 2, 80 }, weapon = "ESG" } },
  [0xA700] = {
    { type = "Lynx", at = { 2, 77 }, weapon = "EMP" },
    { type = "Lynx", at = { 2, 78 }, weapon = "RPG" },
    { type = "Lynx", at = { 2, 79 }, weapon = "RPG" },
    { type = "Lynx", at = { 2, 79 }, weapon = "RPG" },
    { type = "Lynx", at = { 2, 79 }, weapon = "RPG" },
    { type = "Panther", at = { 2, 80 }, weapon = "ESG" },
    { type = "Panther", at = { 2, 80 }, weapon = "ESG" } },
  [0xA9A8] = {
    { type = "Lynx", at = { 2, 77 }, weapon = "EMP" },
    { type = "Lynx", at = { 2, 78 }, weapon = "RPG" },
    { type = "Lynx", at = { 2, 79 }, weapon = "RPG" },
    { type = "Panther", at = { 2, 80 }, weapon = "ESG" } },
  [0xA080] = {
    { type = "Lynx", at = { 55, 127 }, weapon = "Microwave" },
    { type = "Lynx", at = { 56, 127 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 57, 127 }, weapon = "RPG" },
    { type = "Panther", at = { 58, 127 }, weapon = "RPG" },
    { type = "Panther", at = { 59, 127 }, weapon = "ESG" } },
  [0xB640] = {
    { type = "Lynx", at = { 55, 127 }, weapon = "Microwave" },
    { type = "Lynx", at = { 56, 127 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 57, 127 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 58, 127 }, weapon = "RPG" },
    { type = "Panther", at = { 59, 127 }, weapon = "RPG" },
    { type = "Tiger", at = { 60, 127 }, weapon = "ESG" },
    { type = "Tiger", at = { 61, 127 }, weapon = "ESG" } },
  [0xA920] = {
    { type = "Lynx", at = { 55, 127 }, weapon = "Microwave" },
    { type = "Lynx", at = { 56, 127 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 57, 127 }, weapon = "RPG" },
    { type = "Panther", at = { 58, 127 }, weapon = "RPG" },
    { type = "Tiger", at = { 59, 127 }, weapon = "ESG" } },
  [0xADE8] = {
    { type = "Lynx", at = { 3, 24 }, weapon = "EMP" },
    { type = "Lynx", at = { 3, 26 }, weapon = "RPG" },
    { type = "Lynx", at = { 3, 28 }, weapon = "RPG" },
    { type = "Lynx", at = { 3, 30 }, weapon = "ESG" } },
  [0xA190] = {
    { type = "Lynx", at = { 3, 24 }, weapon = "EMP" },
    { type = "Lynx", at = { 3, 26 }, weapon = "RPG" },
    { type = "Lynx", at = { 3, 28 }, weapon = "RPG" },
    { type = "Lynx", at = { 3, 28 }, weapon = "RPG" },
    { type = "Lynx", at = { 3, 28 }, weapon = "RPG" },
    { type = "Panther", at = { 3, 30 }, weapon = "ESG" },
    { type = "Panther", at = { 3, 30 }, weapon = "ESG" } },
  [0xAB40] = {
    { type = "Lynx", at = { 3, 24 }, weapon = "EMP" },
    { type = "Lynx", at = { 3, 26 }, weapon = "RPG" },
    { type = "Lynx", at = { 3, 28 }, weapon = "RPG" },
    { type = "Panther", at = { 3, 30 }, weapon = "ESG" } },
  [0xA218] = {
    { type = "Lynx", at = { 128, 16 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 17 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 128, 18 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 19 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 20 }, weapon = "ESG" } },
  [0xB3E8] = {
    { type = "Lynx", at = { 128, 16 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 17 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 128, 18 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 128, 19 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 20 }, weapon = "RPG" },
    { type = "Tiger", at = { 128, 21 }, weapon = "ESG" },
    { type = "Tiger", at = { 128, 22 }, weapon = "ESG" } },
  [0xAAB8] = {
    { type = "Lynx", at = { 128, 16 }, weapon = "Microwave" },
    { type = "Lynx", at = { 128, 17 }, weapon = "Stickyfoam" },
    { type = "Panther", at = { 128, 18 }, weapon = "RPG" },
    { type = "Panther", at = { 128, 19 }, weapon = "RPG" },
    { type = "Tiger", at = { 128, 20 }, weapon = "ESG" } },
}
local made_blocks = {}
local function block(addr)
  made_blocks[addr] = made_blocks[addr] or ai.unit_block(BLOCKS[addr])
  return made_blocks[addr]
end
-- The convoy's five (0x11001F80): by the two techs, each unit's type, weapon, x and facing, all on row y (the setup's
-- convoy uses rows 4 and 6, ReinforceE's row 0).
local CONVOYS = {
  both = { { "Lynx", "EMP", 22, "SouthEast" }, { "Lynx", "Laser", 22, "West" }, { "Panther", "RailGun", 24, "SouthWest" },
           { "Panther", "AcidCloud", 24, "West" }, { "Tiger", "RailGun", 26, "South" } },
  only_8503 = { { "Lynx", "Laser", 22, "SouthEast" }, { "Lynx", "Laser", 22, "West" }, { "Panther", "RailGun", 24, "SouthWest" },
                { "Panther", "RailGun", 24, "West" }, { "Tiger", "AcidCloud", 26, "South" } },
  only_5508 = { { "Lynx", "EMP", 22, "SouthEast" }, { "Lynx", "EMP", 22, "West" }, { "Panther", "Laser", 24, "SouthWest" },
                { "Panther", "RailGun", 24, "West" }, { "Tiger", "RailGun", 26, "South" } },
  none = { { "Lynx", "Laser", 22, "SouthEast" }, { "Lynx", "Laser", 22, "West" }, { "Panther", "RailGun", 24, "SouthWest" },
           { "Panther", "RailGun", 24, "West" }, { "Tiger", "RailGun", 26, "South" } },
}
local function convoy(y)
  local kind = has_8503 and (has_5508 and "both" or "only_8503") or (has_5508 and "only_5508" or "none")
  for _, u in ipairs(CONVOYS[kind]) do
    game.create_unit{type = u[1], weapon = u[2], player = 1, at = { u[3], y }, direction = u[4], exact = true}
  end
end
-- An ambush (0x11003260 and on): the four ambush triggers off, then two attacking groups, each with its block by
-- difficulty ({ Easy, Normal, Hard }).
local function do_ambush(first, second)
  for i = 1, 4 do ambush[i]:disable() end
  local k = ({ Easy = 1, Normal = 2, Hard = 3 })[players[1].difficulty] or 2
  for _, blocks in ipairs({ first, second }) do
    local g = ai.fight_group(ai_player)
    g:do_attack_enemy()
    g:set_rect(PLYMOUTH_RECT)
    g:add_units(block(blocks[k]))
    g:set_lights(true)
  end
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava, Quake1, Quake2, Quake3, Storm, Tornado, TornadoHard

function Lava(t)
  game.create_eruption({ 124, 31 }, 300)
end

function Quake1(t)
  game.create_earthquake({ 33, 47 }, 2)
end

function Quake2(t)
  game.create_earthquake({ 89, 11 }, 3)
end

function Quake3(t)
  if players[1].difficulty == "Easy" then
    game.create_earthquake({ 123, 23 }, 1)
    trigger.time{time = 5000, on = Lava}  -- after 50 marks
  elseif players[1].difficulty == "Normal" then
    game.create_earthquake({ 123, 23 }, 2)
    trigger.time{time = 3500, on = Lava}  -- after 35 marks
  else
    game.create_earthquake({ 123, 23 }, 3)
    trigger.time{time = 2000, on = Lava}  -- after 20 marks
  end
end

function Storm(t)
  local r1 = game.rand(36)
  local r2 = game.rand(128)
  local r3 = game.rand(5)
  local r4 = game.rand(128)
  game.create_lightning({ r4, r3 + 1 }, { r2, r1 + 91 }, 20)
end

function Tornado(t)
  local r1 = game.rand(128)
  local r2 = game.rand(36)
  local r3 = game.rand(128)
  game.create_tornado({ r3, r2 + 91 }, { r1, 1 }, 20)
end

function TornadoHard(t)
  local r1 = game.rand(64)
  local r2 = game.rand(36)
  local r3 = game.rand(64)
  game.create_tornado({ r3, r2 + 91 }, { r1, 1 }, 20)
end

-- Every 40 ticks (0x11002ED0): the parts left on the map and those in the player's Cargo Trucks; fewer than four, or
-- one still undiscovered with no Scout left to find it, and the mission fails.
function CheckForEnd(t)
  local parts, hidden = 0, false
  for _, w in ipairs(game.wreckage()) do
    parts = parts + 1
    if not w.is_discovered then hidden = true end
  end
  for _, u in ipairs(players[1]:units("CargoTruck")) do
    if u.cargo == "Wreckage" then parts = parts + 1 end
  end
  local scout = #players[1]:units("Scout") > 0
  if parts < 4 or (hidden and not scout) then mission.failure(trigger.time{time = 1}) end
end

-- Down to 7 vehicles, or all four parts loaded (0x11003860): both triggers off, a convoy at the top edge (row 0),
-- and the message.
function ReinforceE(t)
  reinforce_e1:disable()
  reinforce_e2:disable()
  convoy(1)
  game.message_at("Reinforcements have arrived!", 162, players[1], 1760, 192)
end

-- Plymouth down to 7 vehicles (0x110038C0): this trigger off and ToggleP's timer on.
function ReinforceP(t)
  reinforce_p:disable()
  toggle_p:enable()
end

-- Easy, tick 80 (0x11002EC0): the sound that the wrecks are found (151), for the human player.
function Located(t)
  game.sound(151, 0)
end

-- ReinforceP's timer later (0x110038F0): ReinforceP on again (not on Easy), the timer off, and a group guarding
-- the base: from the south edge when GetRand(2) isn't 0, else from the east edge (three units on Easy, five else).
function ToggleP(t)
  if players[1].difficulty ~= "Easy" then reinforce_p:enable() end
  toggle_p:disable()
  local g = ai.fight_group(ai_player)
  g:do_guard_rect()
  g:set_rect(PLYMOUTH_RECT)
  local addr
  if game.rand(2) ~= 0 then
    addr = 0xA678
  elseif players[1].difficulty == "Easy" then
    addr = 0xB2D0
  else
    addr = 0xA5F0
  end
  g:add_units(block(addr))
  g:set_lights(true)
end

-- All four parts loaded (0x11003200): the four ambush rectangles on.
function EnableAmbush(t)
  for i = 1, 4 do ambush[i]:enable() end
end

-- The player at 110,96 (0x11003260): an ambush from the west edge and the south edge.
function DoAmbush1(t) do_ambush({ 0xAF08, 0xAC50, 0xA810 }, { 0xA568, 0xABC8, 0xA108 }) end

-- The player at 147,78 (0x110033E0): an ambush from the south-east and the east edge.
function DoAmbush2(t) do_ambush({ 0xAE80, 0xAD60, 0xA898 }, { 0xA3D0, 0xACD8, 0xA2A0 }) end

-- The player at 41,94 (0x11003560): an ambush from the west edge and the south edge.
function DoAmbush3(t) do_ambush({ 0xA788, 0xA9A8, 0xA700 }, { 0xA080, 0xA920, 0xB640 }) end

-- The player at 112,16 (0x110036E0): an ambush from the west edge and the east edge.
function DoAmbush4(t) do_ambush({ 0xADE8, 0xAB40, 0xA190 }, { 0xA218, 0xAAB8, 0xB3E8 }) end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  has_5508, has_8503 = players[1]:has_tech(5508), players[1]:has_tech(8503)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.initial_set_tile({ 125, 29 }, 1095)
  game.initial_set_tile({ 126, 29 }, 1107)
  game.initial_set_tile({ 125, 30 }, 1118)
  game.initial_set_tile({ 126, 30 }, 1129)
  game.set_daylight_everywhere(difficulty == "Easy" or difficulty == "Normal")
  game.set_daylight_moves(false)
  for _, r in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(r) end

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  if players[1].difficulty == "Easy" then
    game.create_wreckage({ 124, 68 }, 8801, true)
    game.create_wreckage({ 115, 11 }, 8801, true)
    game.create_wreckage({ 78, 55 }, 8801, true)
    game.create_wreckage({ 104, 99 }, 8801, true)
  elseif players[1].difficulty == "Normal" then
    game.create_wreckage(({ { 22, 104 }, { 23, 111 }, { 28, 79 }, { 31, 38 }, { 28, 37 } })[game.rand(5) + 1], 8801)
    game.create_wreckage(({ { 115, 20 }, { 112, 16 }, { 114, 9 }, { 106, 9 }, { 89, 7 } })[game.rand(5) + 1], 8801)
    game.create_wreckage(({ { 86, 121 }, { 85, 110 }, { 86, 99 }, { 80, 81 }, { 78, 55 }, { 94, 73 }, { 96, 59 }, { 113, 37 }, { 125, 22 }, { 104, 99 }, { 59, 84 }, { 60, 65 }, { 71, 47 } })[game.rand(13) + 1], 8801)
    game.create_wreckage(({ { 115, 62 }, { 124, 68 }, { 127, 92 }, { 119, 86 }, { 122, 53 } })[game.rand(5) + 1], 8801)
  elseif players[1].difficulty == "Hard" then
    game.create_wreckage(({ { 22, 104 }, { 23, 111 }, { 28, 79 }, { 31, 38 }, { 28, 37 } })[game.rand(5) + 1], 8801)
    game.create_wreckage(({ { 115, 20 }, { 112, 16 }, { 114, 9 }, { 106, 9 }, { 89, 7 } })[game.rand(5) + 1], 8801)
    game.create_wreckage(({ { 86, 121 }, { 85, 110 }, { 86, 99 }, { 80, 81 }, { 78, 55 }, { 94, 73 }, { 96, 59 }, { 113, 37 }, { 125, 22 }, { 104, 99 }, { 59, 84 }, { 60, 65 }, { 71, 47 } })[game.rand(13) + 1], 8801)
    game.create_wreckage(({ { 115, 62 }, { 124, 68 }, { 127, 92 }, { 119, 86 }, { 122, 53 } })[game.rand(5) + 1], 8801)
  end
  game.create_marker({ 14, 8 })
  -- The tubes and walls the setup makes here, after the computer player's base.
  make_walls({
    { "Tube", { 56, 125 } }, { "Tube", { 57, 125 } }, { "Tube", { 58, 125 } }, { "Tube", { 60, 127 } }, { "Tube", { 63, 125 } }, { "Tube", { 64, 125 } },
    { "Tube", { 65, 125 } }, { "Tube", { 111, 115 } }, { "Tube", { 112, 114 } }, { "Tube", { 112, 115 } }, { "Tube", { 126, 77 } }, { "Tube", { 128, 79 } },
  })
  if difficulty == "Easy" then
    trigger.time{time = 80, on = Located}  -- after 0 marks
  end

  -- The win.
  local t10 = trigger.escape{at = { x = 40, y = 2, raw = true }, width = 10, height = 10, type = "CargoTruck", count = 4, cargo = 9, amount = -1, one_shot = true}
  if difficulty == "Easy" then
    mission.victory(t10, "Return spacecraft parts at (124,68), (115,11), (78,55), and (104,99) to the convoy starting location.", {one_shot = true})
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t10, "Return all 4 spacecraft parts to the convoy starting location.", {one_shot = true})
  end
  if difficulty == "Easy" or difficulty == "Normal" then
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Tornado}  -- after 120 to 180 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 5000, max = 6000, one_shot = false, on = TornadoHard}  -- after 50 to 60 marks
  end
  trigger.time{min = 5000, max = 11000, one_shot = false, on = Storm}  -- after 50 to 110 marks
  trigger.time{time = 8400, on = Quake1}  -- after 84 marks
  trigger.time{time = 24000, on = Quake2}  -- after 240 marks
  trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 3, player = 1, one_shot = true, on = Quake3}
  reinforce_e1 = trigger.vehicle_count{compare = "<", count = 8, player = 1, one_shot = true, on = ReinforceE}
  reinforce_e2 = trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 4, player = 1, one_shot = true, on = ReinforceE}
  if difficulty == "Easy" then
    toggle_p = trigger.time{time = 5000, one_shot = false, enabled = false, on = ToggleP}  -- after 50 marks
  elseif difficulty == "Normal" then
    toggle_p = trigger.time{time = 3000, one_shot = false, enabled = false, on = ToggleP}  -- after 30 marks
  elseif difficulty == "Hard" then
    toggle_p = trigger.time{time = 1200, one_shot = false, enabled = false, on = ToggleP}  -- after 12 marks
  end
  reinforce_p = trigger.vehicle_count{compare = "<", count = 8, player = ai_player, on = ReinforceP}
  trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 4, player = 1, one_shot = true, on = EnableAmbush}
  ambush[1] = trigger.rect{at = { x = 110, y = 96, raw = true }, width = 8, height = 9, player = 1, one_shot = true, enabled = false, on = DoAmbush1}
  ambush[2] = trigger.rect{at = { x = 147, y = 78, raw = true }, width = 3, height = 8, player = 1, one_shot = true, enabled = false, on = DoAmbush2}
  ambush[3] = trigger.rect{at = { x = 41, y = 94, raw = true }, width = 15, height = 19, player = 1, one_shot = true, enabled = false, on = DoAmbush3}
  ambush[4] = trigger.rect{at = { x = 112, y = 16, raw = true }, width = 3, height = 4, player = 1, one_shot = true, enabled = false, on = DoAmbush4}
  mission.failure(trigger.count{type = "CargoTruck", compare = "<", count = 4, player = 1})
  trigger.time{time = 40, one_shot = false, on = CheckForEnd}  -- after 0 marks
end

-- Not converted:
-- - Easy: units are made other ways than CreateUnit (63 on the map, 27 made)
-- - Normal: units are made other ways than CreateUnit (65 on the map, 26 made)
-- - Hard: units are made other ways than CreateUnit (73 on the map, 26 made)
-- - the setup's markers change with the difficulty (Normal's are made)
