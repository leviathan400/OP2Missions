-- e06Lua.lua  -  Eden Mission #6 (Lua)
-- Trigger functions finished by hand (Located, Toggle1Active, Toggle2Active, Toggle3Active, CheckForEnd), from the disassembly of e06.dll.
-- Converted by op2dll from e06.dll. With e06Lua.placement.lua (what every difficulty makes alike),
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
        workers = 24, scientists = 16, kids = 7, food = 3000, ore = 3000,
        research = { 6000 },
        tech_level = 5,
        view = { 9, 57 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 6,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 116, 55 } },
    },
    made = {
      { type = "CargoTruck", direction = "East", player = 1, at = { 4, 59 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 5, 60 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 4, 61 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 5, 62 } },
      { type = "Scout", direction = "East", player = 1, at = { 7, 52 } },
      { type = "Scout", direction = "East", player = 1, at = { 15, 62 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 7, 57 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 8, 58 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 9, 59 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 8, 62 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 7, 63 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 12, 61 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 14, 59 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 3, 63 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 24, scientists = 16, kids = 7, food = 3000, ore = 3000,
        research = { 6000 },
        tech_level = 5,
        view = { 9, 57 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 6,
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "CargoTruck", direction = "East", player = 1, at = { 4, 59 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 5, 60 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 4, 61 } },
      { type = "Scout", direction = "East", player = 1, at = { 7, 52 } },
      { type = "Scout", direction = "East", player = 1, at = { 15, 62 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 7, 57 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 8, 58 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 9, 59 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 10, 60 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 9, 61 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 8, 62 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 7, 63 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 8, 62 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 7, 63 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 12, 61 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 12, 58 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 14, 59 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 24, scientists = 16, kids = 7, food = 3000, ore = 3000,
        research = { 6000 },
        tech_level = 5,
        view = { 9, 57 },
        units = {
        },
      },
      [2] = {
        research = {  },
        tech_level = 6,
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 111, 42 } }, { "Tube", { 111, 43 } }, { "Tube", { 111, 44 } }, { "Tube", { 111, 45 } },
      { "Tube", { 111, 46 } }, { "Tube", { 113, 40 } }, { "Tube", { 114, 40 } }, { "Tube", { 115, 40 } },
      { "Tube", { 116, 40 } }, { "Tube", { 117, 40 } },
    },
    made = {
      { type = "CargoTruck", direction = "East", player = 1, at = { 4, 59 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 5, 60 } },
      { type = "CargoTruck", direction = "East", player = 1, at = { 4, 61 } },
      { type = "Scout", direction = "East", player = 1, at = { 7, 52 } },
      { type = "Scout", direction = "East", player = 1, at = { 15, 62 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 7, 57 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 8, 58 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 9, 59 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 10, 60 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 9, 61 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 8, 62 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 7, 63 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 15, 58 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 12, 58 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 14, 59 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 12, 60 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 12, 62 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 15, 60 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 16, 59 } },
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
    { type = "CommandCenter", at = { 123, 53 } },
    { type = "StandardLab", at = { 118, 56 } },
    { type = "StandardLab", at = { 118, 39 } },
    { type = "MHDGenerator", at = { 119, 61 } },
    { type = "GuardPost", at = { 111, 40 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 105, 32 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 106, 21 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 117, 15 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 120, 29 }, weapon = "RPG" },
    { type = "GuardPost", at = { 111, 47 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 121, 50 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 125, 58 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 114, 55 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 101, 26 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 106, 5 }, weapon = "RPG" },
    { type = "GuardPost", at = { 88, 27 }, weapon = "RPG" },
    { type = "GuardPost", at = { 77, 14 }, weapon = "RPG" },
    { type = "GuardPost", at = { 89, 37 }, weapon = "EMP" },
    { type = "GuardPost", at = { 77, 36 }, weapon = "EMP" },
  },
  [2] = {
    { type = "Lynx", at = { 70, 10 }, weapon = "RPG" },
    { type = "Lynx", at = { 72, 12 }, weapon = "Microwave" },
    { type = "Lynx", at = { 70, 8 }, weapon = "Microwave" },
  },
  [3] = {
    { type = "Panther", at = { 77, 37 }, weapon = "Microwave" },
    { type = "Panther", at = { 80, 37 }, weapon = "Microwave" },
    { type = "Lynx", at = { 81, 35 }, weapon = "RPG" },
    { type = "Lynx", at = { 78, 34 }, weapon = "Microwave" },
    { type = "Lynx", at = { 77, 32 }, weapon = "RPG" },
  },
  [4] = {
    { type = "Lynx", at = { 88, 58 }, weapon = "Microwave" },
    { type = "Lynx", at = { 88, 58 }, weapon = "RPG" },
    { type = "Lynx", at = { 88, 58 }, weapon = "RPG" },
    { type = "Panther", at = { 88, 54 }, weapon = "Microwave" },
    { type = "Panther", at = { 90, 56 }, weapon = "Microwave" },
  },
  [5] = {
    { type = "Lynx", at = { 88, 21 }, weapon = "Microwave" },
    { type = "Lynx", at = { 90, 20 }, weapon = "RPG" },
    { type = "Lynx", at = { 88, 18 }, weapon = "Microwave" },
  },
  [6] = {
    { type = "Lynx", at = { 100, 2 }, weapon = "Microwave" },
    { type = "Lynx", at = { 99, 4 }, weapon = "Microwave" },
    { type = "Lynx", at = { 97, 2 }, weapon = "Microwave" },
  },
  [7] = {
    { type = "Lynx", at = { 110, 29 }, weapon = "Microwave" },
    { type = "Panther", at = { 116, 28 }, weapon = "Microwave" },
    { type = "Panther", at = { 117, 31 }, weapon = "Microwave" },
  },
  [8] = {
    { type = "Lynx", at = { 125, 61 }, weapon = "Microwave" },
    { type = "Lynx", at = { 121, 63 }, weapon = "Microwave" },
    { type = "Lynx", at = { 110, 45 }, weapon = "RPG" },
    { type = "Lynx", at = { 113, 44 }, weapon = "RPG" },
    { type = "Panther", at = { 113, 55 }, weapon = "Microwave" },
  },
  [9] = {
    { type = "Lynx", at = { 91, 5 }, weapon = "RPG" },
  },
  [10] = {
    { type = "CommandCenter", at = { 123, 53 } },
    { type = "StandardLab", at = { 118, 56 } },
    { type = "StandardLab", at = { 118, 39 } },
    { type = "Tokamak", at = { 119, 61 } },
    { type = "GuardPost", at = { 111, 40 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 105, 32 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 106, 21 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 117, 15 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 120, 29 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 111, 47 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 121, 50 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 125, 58 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 114, 55 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 101, 26 }, weapon = "Microwave" },
  },
  [11] = {
    { type = "Lynx", at = { 70, 10 }, weapon = "Microwave" },
    { type = "Lynx", at = { 72, 12 }, weapon = "Microwave" },
    { type = "Lynx", at = { 70, 8 }, weapon = "Microwave" },
  },
  [12] = {
    { type = "Panther", at = { 78, 39 }, weapon = "Microwave" },
    { type = "Lynx", at = { 78, 34 }, weapon = "Microwave" },
    { type = "Lynx", at = { 77, 32 }, weapon = "Microwave" },
  },
  [13] = {
    { type = "Lynx", at = { 88, 58 }, weapon = "Microwave" },
    { type = "Lynx", at = { 87, 56 }, weapon = "Microwave" },
    { type = "Panther", at = { 88, 54 }, weapon = "Microwave" },
  },
  [14] = {
    { type = "Lynx", at = { 88, 21 }, weapon = "Microwave" },
    { type = "Lynx", at = { 88, 18 }, weapon = "Microwave" },
  },
  [15] = {
    { type = "Lynx", at = { 100, 2 }, weapon = "Microwave" },
    { type = "Lynx", at = { 99, 4 }, weapon = "Microwave" },
  },
  [16] = {
    { type = "Lynx", at = { 110, 29 }, weapon = "Microwave" },
    { type = "Lynx", at = { 109, 27 }, weapon = "Microwave" },
  },
  [17] = {
    { type = "Lynx", at = { 125, 61 }, weapon = "Microwave" },
    { type = "Lynx", at = { 121, 63 }, weapon = "Microwave" },
    { type = "Lynx", at = { 113, 44 }, weapon = "Microwave" },
  },
  [18] = {
    { type = "CommandCenter", at = { 123, 53 } },
    { type = "StandardLab", at = { 118, 56 } },
    { type = "StandardLab", at = { 118, 39 } },
    { type = "MHDGenerator", at = { 119, 61 } },
    { type = "GuardPost", at = { 111, 40 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 111, 47 }, weapon = "RPG" },
    { type = "GuardPost", at = { 121, 50 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 101, 26 }, weapon = "RPG" },
    { type = "GuardPost", at = { 105, 32 }, weapon = "RPG" },
    { type = "GuardPost", at = { 114, 55 }, weapon = "RPG" },
    { type = "GuardPost", at = { 106, 21 }, weapon = "RPG" },
    { type = "GuardPost", at = { 117, 15 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 120, 29 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 125, 58 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 89, 37 }, weapon = "EMP" },
    { type = "GuardPost", at = { 77, 36 }, weapon = "EMP" },
    { type = "GuardPost", at = { 105, 6 }, weapon = "RPG" },
    { type = "GuardPost", at = { 89, 53 }, weapon = "EMP" },
  },
  [19] = {
    { type = "Panther", at = { 70, 10 }, weapon = "RPG" },
    { type = "Panther", at = { 72, 12 }, weapon = "Microwave" },
    { type = "Lynx", at = { 73, 9 }, weapon = "RPG" },
    { type = "Lynx", at = { 70, 8 }, weapon = "Microwave" },
  },
  [20] = {
    { type = "Panther", at = { 78, 39 }, weapon = "RPG" },
    { type = "Panther", at = { 77, 37 }, weapon = "Microwave" },
    { type = "Panther", at = { 80, 37 }, weapon = "RPG" },
    { type = "Lynx", at = { 81, 35 }, weapon = "Microwave" },
    { type = "Lynx", at = { 78, 34 }, weapon = "RPG" },
    { type = "Lynx", at = { 77, 32 }, weapon = "Microwave" },
  },
  [21] = {
    { type = "Lynx", at = { 88, 58 }, weapon = "Microwave" },
    { type = "Lynx", at = { 87, 56 }, weapon = "RPG" },
    { type = "Panther", at = { 88, 54 }, weapon = "RPG" },
    { type = "Panther", at = { 90, 56 }, weapon = "Microwave" },
    { type = "Lynx", at = { 89, 57 }, weapon = "EMP" },
  },
  [22] = {
    { type = "Panther", at = { 88, 21 }, weapon = "Microwave" },
    { type = "Lynx", at = { 90, 20 }, weapon = "RPG" },
    { type = "Panther", at = { 88, 18 }, weapon = "RPG" },
    { type = "Lynx", at = { 89, 19 }, weapon = "EMP" },
  },
  [23] = {
    { type = "Lynx", at = { 100, 2 }, weapon = "Microwave" },
    { type = "Panther", at = { 99, 4 }, weapon = "RPG" },
    { type = "Panther", at = { 97, 2 }, weapon = "Microwave" },
    { type = "Lynx", at = { 98, 3 }, weapon = "EMP" },
  },
  [24] = {
    { type = "Lynx", at = { 110, 29 }, weapon = "Microwave" },
    { type = "Lynx", at = { 109, 27 }, weapon = "RPG" },
    { type = "Panther", at = { 116, 28 }, weapon = "RPG" },
    { type = "Panther", at = { 117, 31 }, weapon = "Microwave" },
  },
  [25] = {
    { type = "Lynx", at = { 125, 61 }, weapon = "Microwave" },
    { type = "Lynx", at = { 121, 63 }, weapon = "RPG" },
    { type = "Panther", at = { 110, 45 }, weapon = "Microwave" },
    { type = "Lynx", at = { 113, 44 }, weapon = "RPG" },
    { type = "Panther", at = { 122, 45 }, weapon = "Microwave" },
    { type = "Panther", at = { 113, 55 }, weapon = "RPG" },
    { type = "Lynx", at = { 117, 47 }, weapon = "EMP" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_fight1, ai_fight2, ai_fight3, ai_fight4, ai_fight5, ai_fight6, ai_fight7, ai_fight8

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_plymouth()
  if difficulty == "Easy" then
    ai_block(10):create_units(p, false)
  elseif difficulty == "Normal" then
    ai_block(1):create_units(p, false)
  elseif difficulty == "Hard" then
    ai_block(18):create_units(p, false)
  end
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 60, 30, 63, 37 })
  if difficulty == "Easy" then
    ai_fight1:add_units(ai_block(11))
  elseif difficulty == "Normal" then
    ai_fight1:add_units(ai_block(2))
  elseif difficulty == "Hard" then
    ai_fight1:add_units(ai_block(19))
  end
  ai_fight1:set_lights(true)
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 77, 32, 81, 39 })
  if difficulty == "Easy" then
    ai_fight2:add_units(ai_block(12))
  elseif difficulty == "Normal" then
    ai_fight2:add_units(ai_block(3))
  elseif difficulty == "Hard" then
    ai_fight2:add_units(ai_block(20))
  end
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_patrol_only()
  ai_fight3:set_rect({ 87, 54, 90, 58 })
  ai_fight3:set_patrol({ { 69, 56 }, { 84, 56 }, { 90, 51 }, { 99, 59 } }, 2)
  if difficulty == "Easy" then
    ai_fight3:add_units(ai_block(13))
  elseif difficulty == "Normal" then
    ai_fight3:add_units(ai_block(4))
  elseif difficulty == "Hard" then
    ai_fight3:add_units(ai_block(21))
  end
  ai_fight3:set_lights(true)
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 88, 18, 90, 21 })
  if difficulty == "Easy" then
    ai_fight4:add_units(ai_block(14))
  elseif difficulty == "Normal" then
    ai_fight4:add_units(ai_block(5))
  elseif difficulty == "Hard" then
    ai_fight4:add_units(ai_block(22))
  end
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_rect()
  ai_fight5:set_rect({ 53, 46, 57, 49 })
  if difficulty == "Easy" then
    ai_fight5:add_units(ai_block(15))
  elseif difficulty == "Normal" then
    ai_fight5:add_units(ai_block(6))
  elseif difficulty == "Hard" then
    ai_fight5:add_units(ai_block(23))
  end
  ai_fight5:set_lights(true)
  ai_fight6 = ai.fight_group(p)
  ai_fight6:do_guard_rect()
  ai_fight6:set_rect({ 109, 27, 117, 31 })
  if difficulty == "Easy" then
    ai_fight6:add_units(ai_block(16))
  elseif difficulty == "Normal" then
    ai_fight6:add_units(ai_block(7))
  elseif difficulty == "Hard" then
    ai_fight6:add_units(ai_block(24))
  end
  ai_fight7 = ai.fight_group(p)
  ai_fight7:do_guard_rect()
  ai_fight7:set_rect({ 110, 44, 125, 63 })
  if difficulty == "Easy" then
    ai_fight7:add_units(ai_block(17))
  elseif difficulty == "Normal" then
    ai_fight7:add_units(ai_block(8))
  elseif difficulty == "Hard" then
    ai_fight7:add_units(ai_block(25))
  end
  ai_fight8 = ai.fight_group(p)
  ai_fight8:do_patrol_only()
  ai_fight8:set_rect({ 91, 5, 92, 6 })
  ai_fight8:set_patrol({ { 84, 3 }, { 96, 14 } }, 1)
  ai_fight8:add_units(ai_block(9))
  ai_fight8:set_lights(true)
  local d = players[1].difficulty
  local WRECKS = {
    { { 31, 2 }, { 90, 9 }, { 116, 52 } },
    { { 7, 7 }, { 90, 30 }, { 114, 35 } },
    { { 41, 11 }, { 67, 58 }, { 119, 24 } },
  }
  local set = d == "Easy" and 1 or d == "Normal" and 2 or game.rand(3) + 1
  for _, at in ipairs(WRECKS[set]) do game.create_wreckage(at, 8801, d == "Easy") end
  if d == "Easy" then trigger.time{time = 80, on = Located} end
  p:set_tech_level(6)
end


-- The round's time triggers (0x11008F10, 0x11008F14, 0x11008F18): each turns itself off and the next on.
local toggle1, toggle2, toggle3

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Group4Active, Tornado1, Tornado2, Tornado3, Tornado4, TornadoHardRepeater, TornadoHardRepeaterStart, TornadoRepeater, TornadoRepeaterEasy

function Group4Active(t)
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 83, 2, 96, 12 })
  ai_fight4:set_lights(true)
end

function Tornado1(t)
  if players[1].difficulty == "Easy" then
    game.create_tornado({ 76, 21 }, { -2, 12 }, 14)
    trigger.time{min = 3000, max = 3500, one_shot = false, on = TornadoRepeaterEasy}  -- after 30 to 35 marks
  elseif players[1].difficulty == "Normal" then
    game.create_tornado({ 76, 21 }, { -2, 12 }, 14)
    trigger.time{min = 2500, max = 3000, one_shot = false, on = TornadoRepeaterEasy}  -- after 25 to 30 marks
  else
    game.create_tornado({ 76, 21 }, { -2, 12 }, 14)
    trigger.time{min = 2500, max = 3000, one_shot = false, on = TornadoRepeaterEasy}  -- after 25 to 30 marks
  end
end

function Tornado2(t)
  game.create_tornado({ 75, 46 }, { 10, 45 }, 15)
end

function Tornado3(t)
  game.create_tornado({ 8, 56 }, { 1, 62 }, 15)
end

function Tornado4(t)
  game.create_tornado({ 10, 3 }, { 3, 15 }, 15)
end

function TornadoHardRepeater(t)
  local r1 = game.rand(56)
  local r2 = game.rand(79)
  local r3 = game.rand(56)
  local r4 = game.rand(79)
  game.create_tornado({ r4 + 5, r3 + 5 }, { r2 + 5, r1 + 5 }, 16)
end

function TornadoHardRepeaterStart(t)
  trigger.time{min = 2000, max = 2500, one_shot = false, on = TornadoHardRepeater}  -- after 20 to 25 marks
end

function TornadoRepeater(t)
  local r1 = game.rand(63)
  local r2 = game.rand(79)
  local r3 = game.rand(63)
  local r4 = game.rand(79)
  game.create_tornado({ r4, r3 + 1 }, { r2, r1 + 1 }, 16)
end

function TornadoRepeaterEasy(t)
  local r1 = game.rand(26)
  local r2 = game.rand(79)
  local r3 = game.rand(26)
  local r4 = game.rand(79)
  game.create_tornado({ r4 + 5, r3 + 5 }, { r2 + 5, r1 + 5 }, 16)
end

-- Easy, tick 80 (0x11001A80): the sound that the wrecks are found (151), for the human player.
function Located(t)
  game.sound(151, 0)
end

-- Every 14 to 17 marks while on (0x110025E0): the first guard group moves to guard 83,2 - 96,12; Toggle2Active next.
function Toggle1Active(t)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 83, 2, 96, 12 })
  toggle1:disable()
  toggle2:enable()
end

-- Every 20 to 23 marks while on (0x11002620): to 70,8 - 73,12; Toggle3Active next.
function Toggle2Active(t)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 70, 8, 73, 12 })
  toggle2:disable()
  toggle3:enable()
end

-- Every 10 to 13 marks while on (0x11002660): back to 60,30 - 63,37; Toggle1Active next.
function Toggle3Active(t)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 60, 30, 63, 37 })
  toggle3:disable()
  toggle1:enable()
end

-- Every 40 ticks (0x110026A0): the spacecraft parts left, wrecks on the ground and Cargo Trucks carrying one; none
-- count while a wreck is undiscovered and the colony has no Scout to find it. Fewer than three fails the mission.
function CheckForEnd(t)
  local parts, hidden, scout = 0, false, false
  for _, w in ipairs(game.wreckage()) do
    parts = parts + 1
    if not w.is_discovered then hidden = true end
  end
  for _, u in ipairs(players[1]:units()) do
    if u.type == "CargoTruck" then
      if u.cargo == "Wreckage" then parts = parts + 1 end
    elseif u.type == "Scout" then
      scout = true
    end
  end
  if hidden and not scout then parts = 0 end
  if parts < 3 then mission.failure(trigger.time{time = 1}) end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(true)
  game.set_daylight_moves(false)

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  game.create_marker({ 8, 57 })
  -- The tubes and walls the setup makes here, after the computer player's base.
  make_walls({
    { "Tube", { 118, 41 } }, { "Tube", { 118, 42 } }, { "Tube", { 118, 43 } }, { "Tube", { 118, 44 } }, { "Tube", { 118, 45 } }, { "Tube", { 118, 46 } },
    { "Tube", { 119, 46 } }, { "Tube", { 119, 47 } }, { "Tube", { 119, 48 } }, { "Tube", { 119, 49 } }, { "Tube", { 119, 50 } }, { "Tube", { 119, 51 } },
    { "Tube", { 119, 52 } }, { "Tube", { 120, 52 } }, { "Tube", { 121, 52 } }, { "Tube", { 121, 56 } }, { "Tube", { 122, 56 } }, { "Tube", { 123, 55 } },
    { "Tube", { 123, 56 } },
  })
  if difficulty == "Easy" then
    trigger.time{time = 80, on = Located}  -- after 0 marks
  end

  -- The win.
  local t13 = trigger.escape{at = { x = 34, y = 51, raw = true }, width = 10, height = 10, type = "CargoTruck", count = 3, cargo = 9, amount = -1, one_shot = true}
  if difficulty == "Easy" then
    mission.victory(t13, "Return spacecraft parts at (31,2), (90,9), and (116,52) to the convoy starting location.", {one_shot = true})
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t13, "Return all three spacecraft parts to the convoy starting location.", {one_shot = true})
  end
  if difficulty == "Easy" then
    trigger.time{time = 9000, on = Tornado1}  -- after 90 marks
    trigger.time{time = 18000, on = Tornado2}  -- after 180 marks
  elseif difficulty == "Normal" then
    trigger.time{time = 9000, on = Tornado1}  -- after 90 marks
    trigger.time{min = 1800, max = 2200, one_shot = false, on = TornadoRepeater}  -- after 18 to 22 marks
  elseif difficulty == "Hard" then
    trigger.time{time = 10, on = TornadoHardRepeaterStart}  -- after 0 marks
    trigger.time{time = 3200, on = Tornado3}  -- after 32 marks
    trigger.time{time = 7000, on = Tornado4}  -- after 70 marks
  end
  trigger.rect{at = { x = 114, y = 1, raw = true }, width = 13, height = 10, player = 1, one_shot = true, on = Group4Active}
  toggle1 = trigger.time{min = 1400, max = 1700, one_shot = false, on = Toggle1Active}  -- after 14 to 17 marks
  toggle2 = trigger.time{min = 2000, max = 2300, one_shot = false, enabled = false, on = Toggle2Active}  -- after 20 to 23 marks
  toggle3 = trigger.time{min = 1000, max = 1300, one_shot = false, enabled = false, on = Toggle3Active}  -- after 10 to 13 marks
  mission.failure(trigger.count{type = "CargoTruck", compare = "<", count = 3, player = 1})
  trigger.time{time = 40, one_shot = false, on = CheckForEnd}  -- after 0 marks
end

-- Not converted:
-- - Easy: units are made other ways than CreateUnit (47 on the map, 14 made)
-- - Normal: units are made other ways than CreateUnit (64 on the map, 17 made)
-- - Hard: units are made other ways than CreateUnit (72 on the map, 19 made)
-- - the setup's wreckage isn't converted: wreck 2 moves with no draw before it
-- - the setup's markers change with the difficulty (Normal's are made)
