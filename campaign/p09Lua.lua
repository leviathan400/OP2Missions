-- p09Lua.lua  -  Plymouth Mission #9 (Lua)
-- Trigger functions finished by hand (Located, CheckForEnd, CheckForTrucks, RestoreOre, Wreck1Touch, Wreck2Touch, Wreck3Touch, Wreck4Touch, ReissueMove, EdenGotWreck, on_tick, ReinforceP, ReinforceE, ToggleE, EnableAmbush, DoAmbush1, DoAmbush2, DoAmbush3, DoAmbush4), from the disassembly of p09.dll.
-- Converted by op2dll from p09.dll. With p09Lua.placement.lua (what every difficulty makes alike),
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
        ore = 0,
        research = { 9000 },
        tech_level = 8,
        view = { 118, 116 },
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
      { type = "CargoTruck", direction = "North", player = 1, at = { 121, 121 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 123, 121 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 121, 123 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 123, 123 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 122, 122 } },
      { type = "Spider", direction = "North", player = 1, at = { 125, 125 } },
      { type = "Spider", direction = "North", player = 1, at = { 123, 125 } },
      { type = "Scout", direction = "North", player = 1, at = { 118, 116 } },
      { type = "Scout", direction = "East", player = 1, at = { 116, 118 } },
      { type = "Lynx", weapon = "EMP", direction = "NorthEast", player = 1, at = { 125, 123 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "NorthWest", player = 1, at = { 125, 121 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 125 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 123 } },
      { type = "Panther", weapon = "RPG", direction = "North", player = 1, at = { 120, 119 } },
      { type = "Panther", weapon = "RPG", direction = "NorthWest", player = 1, at = { 122, 119 } },
      { type = "Lynx", weapon = "EMP", direction = "North", player = 1, at = { 128, 125 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Lynx", weapon = "EMP", direction = "NorthEast", player = 1, at = { 125, 123 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 125 } },
      { type = "Panther", weapon = "RPG", direction = "NorthWest", player = 1, at = { 122, 119 } },
      { type = "Panther", weapon = "EMP", direction = "North", player = 1, at = { 124, 119 } },
      { type = "Panther", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 121, 117 } },
      { type = "Tiger", weapon = "Stickyfoam", direction = "West", player = 1, at = { 116, 125 } },
      { type = "Tiger", weapon = "RPG", direction = "North", player = 1, at = { 128, 125 } },
      { type = "Lynx", weapon = "EMP", direction = "North", player = 1, at = { 117, 110 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 118, 112 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 116, 112 } },
      { type = "Tiger", weapon = "RPG", direction = "North", player = 1, at = { 125, 111 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 127, 111 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        ore = 0,
        research = { 9000 },
        tech_level = 8,
        view = { 118, 116 },
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
      { type = "CargoTruck", direction = "North", player = 1, at = { 121, 121 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 123, 121 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 121, 123 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 123, 123 } },
      { type = "Scout", direction = "North", player = 1, at = { 118, 116 } },
      { type = "Scout", direction = "East", player = 1, at = { 116, 118 } },
      { type = "Lynx", weapon = "EMP", direction = "NorthEast", player = 1, at = { 125, 123 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "NorthWest", player = 1, at = { 125, 121 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 125 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 123 } },
      { type = "Panther", weapon = "RPG", direction = "North", player = 1, at = { 120, 119 } },
      { type = "Panther", weapon = "RPG", direction = "NorthWest", player = 1, at = { 122, 119 } },
      { type = "Lynx", weapon = "EMP", direction = "North", player = 1, at = { 128, 125 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Lynx", weapon = "EMP", direction = "NorthEast", player = 1, at = { 125, 123 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 125 } },
      { type = "Panther", weapon = "RPG", direction = "NorthWest", player = 1, at = { 122, 119 } },
      { type = "Panther", weapon = "EMP", direction = "North", player = 1, at = { 124, 119 } },
      { type = "Panther", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 121, 117 } },
      { type = "Tiger", weapon = "Stickyfoam", direction = "West", player = 1, at = { 116, 125 } },
      { type = "Tiger", weapon = "RPG", direction = "North", player = 1, at = { 128, 125 } },
      { type = "Lynx", weapon = "EMP", direction = "North", player = 1, at = { 117, 110 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 118, 112 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 116, 112 } },
      { type = "Tiger", weapon = "RPG", direction = "North", player = 1, at = { 125, 111 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 127, 111 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        ore = 0,
        research = { 9000 },
        tech_level = 8,
        view = { 118, 116 },
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
      { type = "CargoTruck", direction = "North", player = 1, at = { 121, 121 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 123, 121 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 121, 123 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 123, 123 } },
      { type = "Panther", weapon = "EMP", direction = "North", player = 1, at = { 125, 114 } },
      { type = "Spider", direction = "North", player = 1, at = { 126, 116 } },
      { type = "Spider", direction = "North", player = 1, at = { 123, 116 } },
      { type = "Spider", direction = "North", player = 1, at = { 123, 113 } },
      { type = "Scout", direction = "North", player = 1, at = { 118, 116 } },
      { type = "Scout", direction = "East", player = 1, at = { 116, 118 } },
      { type = "Lynx", weapon = "EMP", direction = "NorthEast", player = 1, at = { 125, 123 } },
      { type = "Lynx", weapon = "Stickyfoam", direction = "NorthWest", player = 1, at = { 125, 121 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 125 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 123 } },
      { type = "Panther", weapon = "RPG", direction = "North", player = 1, at = { 120, 119 } },
      { type = "Panther", weapon = "RPG", direction = "NorthWest", player = 1, at = { 122, 119 } },
      { type = "Lynx", weapon = "EMP", direction = "North", player = 1, at = { 128, 125 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Spider", direction = "North", player = 1, at = { 117, 117 } },
      { type = "Lynx", weapon = "EMP", direction = "NorthEast", player = 1, at = { 125, 123 } },
      { type = "Lynx", weapon = "Microwave", direction = "North", player = 1, at = { 119, 125 } },
      { type = "Panther", weapon = "RPG", direction = "NorthWest", player = 1, at = { 122, 119 } },
      { type = "Panther", weapon = "EMP", direction = "North", player = 1, at = { 124, 119 } },
      { type = "Panther", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 121, 117 } },
      { type = "Tiger", weapon = "Stickyfoam", direction = "West", player = 1, at = { 116, 125 } },
      { type = "Tiger", weapon = "RPG", direction = "North", player = 1, at = { 128, 125 } },
      { type = "Lynx", weapon = "EMP", direction = "North", player = 1, at = { 117, 110 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 118, 112 } },
      { type = "Lynx", weapon = "Microwave", direction = "NorthWest", player = 1, at = { 116, 112 } },
      { type = "Tiger", weapon = "RPG", direction = "North", player = 1, at = { 125, 111 } },
      { type = "Tiger", weapon = "RPG", direction = "NorthEast", player = 1, at = { 127, 111 } },
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
    { type = "CommandCenter", at = { 3, 121 } },
    { type = "Tokamak", at = { 3, 115 } },
    { type = "AdvancedLab", at = { 10, 121 } },
    { type = "VehicleFactory", at = { 10, 115 } },
    { type = "StructureFactory", at = { 4, 125 } },
    { type = "GuardPost", at = { 10, 102 }, weapon = "EMP" },
    { type = "GuardPost", at = { 25, 100 }, weapon = "Laser" },
    { type = "GuardPost", at = { 15, 90 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 24, 90 }, weapon = "EMP" },
    { type = "GuardPost", at = { 18, 116 }, weapon = "AcidCloud" },
    { type = "CommandCenter", at = { 21, 10 } },
    { type = "AdvancedLab", at = { 14, 10 } },
    { type = "GuardPost", at = { 27, 5 }, weapon = "Laser" },
    { type = "GuardPost", at = { 30, 14 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 21, 16 }, weapon = "EMP" },
    { type = "GuardPost", at = { 18, 26 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 31, 38 }, weapon = "Laser" },
    { type = "GuardPost", at = { 50, 56 }, weapon = "Laser" },
    { type = "GuardPost", at = { 33, 56 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 8, 3 }, weapon = "Laser" },
    { type = "GuardPost", at = { 18, 126 }, weapon = "Laser" },
    { type = "GuardPost", at = { 18, 36 }, weapon = "EMP" },
    { type = "GuardPost", at = { 27, 64 }, weapon = "AcidCloud" },
    { type = "GuardPost", at = { 47, 35 }, weapon = "Laser" },
  },
  [2] = {
    { type = "Lynx", at = { 67, 7 }, weapon = "EMP" },
    { type = "Lynx", at = { 69, 8 }, weapon = "Laser" },
    { type = "Lynx", at = { 70, 6 }, weapon = "RailGun" },
  },
  [3] = {
    { type = "Lynx", at = { 72, 88 }, weapon = "EMP" },
    { type = "Lynx", at = { 73, 86 }, weapon = "Laser" },
    { type = "Tiger", at = { 75, 88 }, weapon = "AcidCloud" },
  },
  [4] = {
    { type = "Panther", at = { 24, 38 }, weapon = "EMP" },
    { type = "Panther", at = { 22, 35 }, weapon = "AcidCloud" },
    { type = "Panther", at = { 27, 35 }, weapon = "Laser" },
    { type = "Lynx", at = { 4, 45 }, weapon = "EMP" },
    { type = "Lynx", at = { 4, 47 }, weapon = "Laser" },
  },
  [5] = {
    { type = "Panther", at = { 45, 117 }, weapon = "EMP" },
    { type = "Tiger", at = { 47, 119 }, weapon = "RailGun" },
    { type = "Tiger", at = { 47, 121 }, weapon = "RailGun" },
  },
  [6] = {
    { type = "Panther", at = { 66, 46 }, weapon = "RailGun" },
    { type = "Panther", at = { 67, 44 }, weapon = "RailGun" },
    { type = "Lynx", at = { 89, 37 }, weapon = "Laser" },
  },
  [7] = {
    { type = "Tiger", at = { 22, 103 }, weapon = "AcidCloud" },
    { type = "Tiger", at = { 20, 103 }, weapon = "Laser" },
  },
  [8] = {
    { type = "Lynx", at = { 121, 11 }, weapon = "Laser" },
    { type = "Lynx", at = { 119, 12 }, weapon = "Laser" },
  },
  [9] = {
    { type = "Lynx", at = { 28, 10 }, weapon = "Laser" },
    { type = "Lynx", at = { 27, 12 }, weapon = "RailGun" },
    { type = "Lynx", at = { 26, 9 }, weapon = "Laser" },
    { type = "Panther", at = { 17, 5 }, weapon = "EMP" },
    { type = "Tiger", at = { 14, 6 }, weapon = "RailGun" },
  },
  [10] = {
    { type = "Lynx", at = { 21, 122 }, weapon = "EMP" },
    { type = "Lynx", at = { 23, 122 }, weapon = "AcidCloud" },
    { type = "Lynx", at = { 25, 122 }, weapon = "Laser" },
    { type = "Panther", at = { 21, 124 }, weapon = "RailGun" },
    { type = "Panther", at = { 23, 124 }, weapon = "EMP" },
    { type = "Tiger", at = { 25, 124 }, weapon = "RailGun" },
    { type = "Panther", at = { 13, 98 }, weapon = "EMP" },
    { type = "Panther", at = { 15, 98 }, weapon = "RailGun" },
    { type = "Panther", at = { 17, 98 }, weapon = "RailGun" },
  },
  [11] = {
    { type = "CargoTruck", at = { 10, 8 } },
    { type = "CargoTruck", at = { 11, 110 } },
    { type = "CargoTruck", at = { 11, 112 } },
    { type = "CargoTruck", at = { 17, 41 } },
  },
  [12] = {
    { type = "CommandCenter", at = { 3, 121 } },
    { type = "Tokamak", at = { 3, 115 } },
    { type = "AdvancedLab", at = { 10, 121 } },
    { type = "VehicleFactory", at = { 10, 115 } },
    { type = "StructureFactory", at = { 4, 125 } },
    { type = "CommandCenter", at = { 21, 10 } },
    { type = "AdvancedLab", at = { 14, 10 } },
    { type = "GuardPost", at = { 10, 102 }, weapon = "EMP" },
    { type = "GuardPost", at = { 25, 100 }, weapon = "Laser" },
    { type = "GuardPost", at = { 15, 90 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 27, 5 }, weapon = "Laser" },
    { type = "GuardPost", at = { 30, 14 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 21, 16 }, weapon = "EMP" },
    { type = "GuardPost", at = { 18, 26 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 31, 38 }, weapon = "Laser" },
    { type = "GuardPost", at = { 50, 56 }, weapon = "Laser" },
    { type = "GuardPost", at = { 33, 56 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 8, 3 }, weapon = "Laser" },
    { type = "GuardPost", at = { 18, 126 }, weapon = "Laser" },
    { type = "GuardPost", at = { 18, 36 }, weapon = "EMP" },
    { type = "GuardPost", at = { 27, 64 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 47, 35 }, weapon = "RailGun" },
  },
  [13] = {
    { type = "Lynx", at = { 72, 88 }, weapon = "EMP" },
    { type = "Lynx", at = { 73, 86 }, weapon = "Laser" },
  },
  [14] = {
    { type = "Panther", at = { 22, 35 }, weapon = "Laser" },
    { type = "Panther", at = { 27, 35 }, weapon = "Laser" },
    { type = "Lynx", at = { 4, 45 }, weapon = "EMP" },
  },
  [15] = {
    { type = "Panther", at = { 45, 117 }, weapon = "EMP" },
    { type = "Tiger", at = { 47, 119 }, weapon = "RailGun" },
  },
  [16] = {
    { type = "Panther", at = { 66, 46 }, weapon = "RailGun" },
    { type = "Lynx", at = { 89, 37 }, weapon = "Laser" },
  },
  [17] = {
    { type = "Tiger", at = { 22, 103 }, weapon = "Laser" },
  },
  [18] = {
    { type = "Lynx", at = { 23, 122 }, weapon = "Laser" },
    { type = "Lynx", at = { 25, 122 }, weapon = "Laser" },
    { type = "Panther", at = { 21, 124 }, weapon = "RailGun" },
    { type = "Tiger", at = { 25, 124 }, weapon = "RailGun" },
    { type = "Panther", at = { 13, 98 }, weapon = "EMP" },
    { type = "Panther", at = { 17, 98 }, weapon = "RailGun" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_fight1, ai_fight2, ai_fight3, ai_fight4, ai_fight5, ai_fight6, ai_fight7, ai_fight8, ai_fight9, ai_fight10

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_eden()
  if difficulty == "Easy" then
    ai_block(12):create_units(p, true)
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_block(1):create_units(p, true)
  end
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 67, 7, 70, 9 })
  ai_fight1:add_units(ai_block(2))
  ai_fight1:set_lights(true)
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 72, 86, 75, 88 })
  if difficulty == "Easy" then
    ai_fight2:add_units(ai_block(13))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight2:add_units(ai_block(3))
  end
  ai_fight2:set_lights(true)
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 7, 35, 25, 47 })
  if difficulty == "Easy" then
    ai_fight3:add_units(ai_block(14))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight3:add_units(ai_block(4))
  end
  ai_fight3:set_lights(true)
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 45, 117, 47, 121 })
  if difficulty == "Easy" then
    ai_fight4:add_units(ai_block(15))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight4:add_units(ai_block(5))
  end
  ai_fight4:set_lights(true)
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_rect()
  ai_fight5:set_rect({ 66, 37, 79, 46 })
  if difficulty == "Easy" then
    ai_fight5:add_units(ai_block(16))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight5:add_units(ai_block(6))
  end
  ai_fight5:set_lights(true)
  ai_fight6 = ai.fight_group(p)
  ai_fight6:do_guard_rect()
  ai_fight6:set_rect({ 20, 103, 24, 105 })
  if difficulty == "Easy" then
    ai_fight6:add_units(ai_block(17))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight6:add_units(ai_block(7))
  end
  ai_fight6:set_lights(true)
  ai_fight7 = ai.fight_group(p)
  ai_fight7:do_guard_rect()
  ai_fight7:set_rect({ 117, 11, 124, 13 })
  ai_fight7:add_units(ai_block(8))
  ai_fight7:set_lights(true)
  ai_fight8 = ai.fight_group(p)
  ai_fight8:do_guard_rect()
  ai_fight8:set_rect({ 6, 5, 19, 16 })
  ai_fight8:add_units(ai_block(9))
  ai_fight8:set_lights(true)
  ai_fight9 = ai.fight_group(p)
  ai_fight9:do_guard_rect()
  ai_fight9:set_rect({ 0, 111, 20, 125 })
  if difficulty == "Easy" then
    ai_fight9:add_units(ai_block(18))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight9:add_units(ai_block(10))
  end
  ai_fight9:set_lights(true)
  ai_fight10 = ai.fight_group(p)
  ai_fight10:do_patrol_only()
  ai_fight10:set_patrol({ { 48, 121 }, { 14, 117 }, { 24, 35 }, { 18, 8 } }, 2)
  ai_fight10:set_rect({ 0, 111, 20, 125 })
  ai_fight10:add_units(ai_block(11))
  ai_fight10:set_lights(true)
  p:set_tech_level(9)
  p.workers = 25
  p.scientists = 25
  p.food = 8000
end


-- The triggers the functions here turn on and off (0x1100C198 to 0x1100C1B4): ReinforceE's vehicle count, the
-- ToggleE timer, ReinforceP's vehicle count and parts count, and the four ambush rectangles.
local reinforce_e, toggle_e, reinforce_p1, reinforce_p2
local ambush = {}
-- The wrecks' spots as the setup rolls them (0x1100C1F0, 0x1100C200), their point triggers (0x1100C224) and whether
-- the player has loaded each (0x1100C210).
local wreck_spots, wreck_triggers, wreck_loaded = {}, {}, { false, false, false, false }
local function wreck_at(at, tech, discovered)
  wreck_spots[#wreck_spots + 1] = at
  game.create_wreckage(at, tech, discovered)
end
-- What the setup reads before it starts: the player's ore (0x1100C234, given back at the end by RestoreOre), and
-- research 8203 (0x1100C194) and 7103 (0x1100C190), which choose the convoy's weapons.
local saved_ore, has_8203, has_7103
-- Eden's truck for the last part (0x1100C1E8), its escort (0x1100C1C8), the wreck it drives to (0x1100C220), its
-- ReissueMove trigger (0x1100C1EC), and ReinforceE's last group (0x1100C1E4).
local eden_truck, escort, last_wreck, reissue, reinforce_e_group
-- Where the truck starts and its escort waits (0x1100C180); Eden's corner it takes the part to (0x1100AF60) and the
-- edge it leaves by (0x1100BEA0); the Eden base the reinforcements guard and the ambushes attack from (0x1100B108).
local TRUCK_RECT = { 1, 42, 2, 48 }
local EDEN_CORNER = { 1, 118, 5, 123 }
local EDEN_EXIT = { 1, 118, 1, 119 }
local EDEN_RECT = { 67, 7, 70, 9 }
-- The unit blocks the escort, the reinforcements and the ambushes add, by address, as the DLL ships them (`op2dll disasm
-- --block --shipped`).
local BLOCKS = {
  [0xBC80] = {
    { type = "Lynx", at = { 45, 127 }, weapon = "EMP" },
    { type = "Lynx", at = { 46, 127 }, weapon = "Laser" },
    { type = "Lynx", at = { 47, 127 }, weapon = "EMP" },
    { type = "Lynx", at = { 48, 127 }, weapon = "Laser" },
    { type = "Lynx", at = { 49, 127 }, weapon = "Laser" },
    { type = "Panther", at = { 50, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 51, 127 }, weapon = "EMP" },
    { type = "Tiger", at = { 52, 127 }, weapon = "RailGun" } },
  [0xB8A8] = {
    { type = "Lynx", at = { 45, 127 }, weapon = "EMP" },
    { type = "Lynx", at = { 46, 127 }, weapon = "Laser" },
    { type = "Lynx", at = { 47, 127 }, weapon = "EMP" },
    { type = "Lynx", at = { 48, 127 }, weapon = "AcidCloud" },
    { type = "Lynx", at = { 49, 127 }, weapon = "Laser" },
    { type = "Panther", at = { 50, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 51, 127 }, weapon = "EMP" },
    { type = "Tiger", at = { 52, 127 }, weapon = "RailGun" } },
  [0xB238] = {
    { type = "Tiger", at = { 20, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 21, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 22, 2 }, weapon = "RailGun" },
    { type = "Lynx", at = { 23, 2 }, weapon = "Laser" },
    { type = "Lynx", at = { 24, 2 }, weapon = "Laser" } },
  [0xB820] = {
    { type = "Tiger", at = { 20, 2 }, weapon = "AcidCloud" },
    { type = "Panther", at = { 21, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 22, 2 }, weapon = "RailGun" },
    { type = "Lynx", at = { 23, 2 }, weapon = "Laser" },
    { type = "Lynx", at = { 24, 2 }, weapon = "Laser" } },
  [0xBB60] = {
    { type = "Lynx", at = { 76, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 77, 3 }, weapon = "Laser" },
    { type = "Lynx", at = { 78, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 79, 3 }, weapon = "RailGun" },
    { type = "Lynx", at = { 80, 3 }, weapon = "Laser" },
    { type = "Panther", at = { 76, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 77, 2 }, weapon = "EMP" },
    { type = "Tiger", at = { 78, 2 }, weapon = "RailGun" } },
  [0xB9B8] = {
    { type = "Lynx", at = { 76, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 77, 3 }, weapon = "Laser" },
    { type = "Lynx", at = { 78, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 79, 3 }, weapon = "AcidCloud" },
    { type = "Lynx", at = { 80, 3 }, weapon = "Laser" },
    { type = "Panther", at = { 76, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 77, 2 }, weapon = "EMP" },
    { type = "Tiger", at = { 78, 2 }, weapon = "RailGun" } },
  [0xB1B0] = {
    { type = "Tiger", at = { 128, 32 }, weapon = "Laser" },
    { type = "Panther", at = { 128, 33 }, weapon = "RailGun" },
    { type = "Panther", at = { 128, 34 }, weapon = "RailGun" },
    { type = "Lynx", at = { 127, 32 }, weapon = "Laser" },
    { type = "Lynx", at = { 127, 33 }, weapon = "Laser" } },
  [0xB930] = {
    { type = "Tiger", at = { 128, 32 }, weapon = "AcidCloud" },
    { type = "Panther", at = { 128, 33 }, weapon = "RailGun" },
    { type = "Panther", at = { 128, 34 }, weapon = "RailGun" },
    { type = "Lynx", at = { 127, 32 }, weapon = "Laser" },
    { type = "Lynx", at = { 127, 33 }, weapon = "Laser" } },
  [0xB3E0] = {
    { type = "Lynx", at = { 76, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 77, 3 }, weapon = "Laser" },
    { type = "Lynx", at = { 78, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 79, 3 }, weapon = "Laser" },
    { type = "Lynx", at = { 80, 3 }, weapon = "Laser" },
    { type = "Panther", at = { 76, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 77, 2 }, weapon = "EMP" },
    { type = "Tiger", at = { 78, 2 }, weapon = "RailGun" } },
  [0xB578] = {
    { type = "Lynx", at = { 76, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 77, 3 }, weapon = "Laser" },
    { type = "Lynx", at = { 78, 3 }, weapon = "EMP" },
    { type = "Lynx", at = { 79, 3 }, weapon = "AcidCloud" },
    { type = "Lynx", at = { 80, 3 }, weapon = "Laser" },
    { type = "Panther", at = { 76, 2 }, weapon = "RailGun" },
    { type = "Panther", at = { 77, 2 }, weapon = "EMP" },
    { type = "Tiger", at = { 78, 2 }, weapon = "RailGun" } },
  [0xAF70] = {
    { type = "Tiger", at = { 45, 127 }, weapon = "Laser" },
    { type = "Panther", at = { 46, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 47, 127 }, weapon = "RailGun" },
    { type = "Lynx", at = { 48, 127 }, weapon = "Laser" },
    { type = "Lynx", at = { 49, 127 }, weapon = "Laser" } },
  [0xB4F0] = {
    { type = "Tiger", at = { 45, 127 }, weapon = "AcidCloud" },
    { type = "Panther", at = { 46, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 47, 127 }, weapon = "RailGun" },
    { type = "Lynx", at = { 48, 127 }, weapon = "Laser" },
    { type = "Lynx", at = { 49, 127 }, weapon = "Laser" } },
  [0xBA40] = {
    { type = "Lynx", at = { 124, 33 }, weapon = "EMP" },
    { type = "Lynx", at = { 125, 33 }, weapon = "Laser" },
    { type = "Lynx", at = { 126, 33 }, weapon = "EMP" },
    { type = "Lynx", at = { 127, 33 }, weapon = "Laser" },
    { type = "Lynx", at = { 128, 33 }, weapon = "Laser" },
    { type = "Panther", at = { 124, 32 }, weapon = "RailGun" },
    { type = "Panther", at = { 125, 32 }, weapon = "EMP" },
    { type = "Tiger", at = { 126, 32 }, weapon = "RailGun" } },
  [0xB798] = {
    { type = "Lynx", at = { 124, 33 }, weapon = "EMP" },
    { type = "Lynx", at = { 125, 33 }, weapon = "Laser" },
    { type = "Lynx", at = { 126, 33 }, weapon = "EMP" },
    { type = "Lynx", at = { 127, 33 }, weapon = "AcidCloud" },
    { type = "Lynx", at = { 128, 33 }, weapon = "Laser" },
    { type = "Panther", at = { 124, 32 }, weapon = "RailGun" },
    { type = "Panther", at = { 125, 32 }, weapon = "EMP" },
    { type = "Tiger", at = { 126, 32 }, weapon = "RailGun" } },
  [0xAFF8] = {
    { type = "Tiger", at = { 86, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 87, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 88, 127 }, weapon = "RailGun" },
    { type = "Lynx", at = { 86, 128 }, weapon = "Laser" },
    { type = "Lynx", at = { 87, 128 }, weapon = "Laser" } },
  [0xB688] = {
    { type = "Tiger", at = { 86, 127 }, weapon = "AcidCloud" },
    { type = "Panther", at = { 87, 127 }, weapon = "RailGun" },
    { type = "Panther", at = { 88, 127 }, weapon = "RailGun" },
    { type = "Lynx", at = { 86, 128 }, weapon = "Laser" },
    { type = "Lynx", at = { 87, 128 }, weapon = "Laser" } },
  [0xBD90] = {
    { type = "Scout", at = { 1, 44 } },
    { type = "Lynx", at = { 3, 44 }, weapon = "Laser" },
    { type = "Lynx", at = { 3, 46 }, weapon = "Laser" },
    { type = "Lynx", at = { 3, 48 }, weapon = "Laser" },
    { type = "Lynx", at = { 3, 42 }, weapon = "Laser" },
    { type = "Lynx", at = { 1, 42 }, weapon = "RailGun" },
    { type = "Lynx", at = { 1, 48 }, weapon = "RailGun" } },
  [0xB358] = {
    { type = "Lynx", at = { 128, 11 }, weapon = "Laser" },
    { type = "Lynx", at = { 128, 13 }, weapon = "Laser" },
    { type = "Panther", at = { 45, 127 }, weapon = "EMP" },
    { type = "Tiger", at = { 47, 127 }, weapon = "RailGun" },
    { type = "Tiger", at = { 49, 127 }, weapon = "RailGun" } },
  [0xB2D0] = {
    { type = "Lynx", at = { 1, 45 }, weapon = "EMP" },
    { type = "Lynx", at = { 1, 47 }, weapon = "Laser" },
    { type = "Lynx", at = { 21, 127 }, weapon = "EMP" },
    { type = "Lynx", at = { 23, 127 }, weapon = "AcidCloud" } },
}
local made_blocks = {}
local function block(addr)
  made_blocks[addr] = made_blocks[addr] or ai.unit_block(BLOCKS[addr])
  return made_blocks[addr]
end
-- The convoy's five (0x11001E50): by the two techs, each unit's type, weapon, x and facing, all on row y (the
-- setup's convoy uses rows 109 to 111, ReinforceP's row 127).
local CONVOYS = {
  both = { { "Lynx", "EMP", 117, "North" }, { "Lynx", "Microwave", 118, "NorthWest" }, { "Lynx", "RPG", 116, "NorthWest" },
           { "Tiger", "ESG", 125, "North" }, { "Tiger", "Supernova", 127, "NorthEast" } },
  only_8203 = { { "Lynx", "Microwave", 117, "North" }, { "Lynx", "Microwave", 118, "NorthWest" }, { "Lynx", "Stickyfoam", 116, "NorthWest" },
                { "Tiger", "RPG", 125, "North" }, { "Tiger", "Supernova", 127, "NorthEast" } },
  only_7103 = { { "Lynx", "EMP", 117, "North" }, { "Lynx", "Microwave", 118, "NorthWest" }, { "Lynx", "RPG", 116, "NorthWest" },
                { "Tiger", "ESG", 125, "North" }, { "Tiger", "ESG", 127, "NorthEast" } },
  none = { { "Lynx", "EMP", 117, "North" }, { "Lynx", "Microwave", 118, "NorthWest" }, { "Lynx", "Microwave", 116, "NorthWest" },
           { "Tiger", "RPG", 125, "North" }, { "Tiger", "RPG", 127, "NorthEast" } },
}
local function convoy(y)
  local kind = has_8203 and (has_7103 and "both" or "only_8203") or (has_7103 and "only_7103" or "none")
  for _, u in ipairs(CONVOYS[kind]) do
    game.create_unit{type = u[1], weapon = u[2], player = 1, at = { u[3], y }, direction = u[4], exact = true}
  end
end
-- After a pickup (0x11002F80): when exactly one part is left on the map, Eden sends a Cargo Truck for it from the west
-- edge, a trigger to repeat its move every 40 ticks, and an escort that follows it.
local function eden_goes_for_last()
  last_wreck = nil
  for i = 1, 4 do
    if not wreck_loaded[i] then
      if last_wreck then return end
      last_wreck = i
    end
  end
  if not last_wreck then return end
  eden_truck = game.create_unit{type = "CargoTruck", player = ai_player, at = { 1, 46 }, direction = "East", exact = true,
                                lights = false}[1]
  eden_truck:move(wreck_spots[last_wreck])
  reissue = trigger.time{time = 40, one_shot = false, on = ReissueMove}
  escort = ai.fight_group(ai_player)
  escort:do_guard_unit()
  escort:set_target_unit(eden_truck)
  escort:set_follow_mode(1)
  escort:set_rect(TRUCK_RECT)
  escort:add_units(block(0xBD90))
  escort:set_lights(true)
end
-- A player's vehicle on a wreck's tile (0x11002890 and on): a Cargo Truck there with a part in it has picked it up.
local function wreck_touch(i)
  local at = wreck_spots[i]
  for _, u in ipairs(game.units_in_rect({ at[1], at[2], at[1], at[2] })) do
    if u.type == "CargoTruck" and u.cargo == "Wreckage" then
      wreck_triggers[i]:disable()
      wreck_loaded[i] = true
      eden_goes_for_last()
    end
  end
end
-- An ambush (0x11003A80 and on): the four ambush triggers off, then two attacking groups, each with Easy's block or
-- the others'.
local function do_ambush(first, second)
  for i = 1, 4 do ambush[i]:disable() end
  local k = players[1].difficulty == "Easy" and 1 or 2
  for _, blocks in ipairs({ first, second }) do
    local g = ai.fight_group(ai_player)
    g:do_attack_enemy()
    g:set_rect(EDEN_RECT)
    g:add_units(block(blocks[k]))
    g:set_lights(true)
  end
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Meteor, Quake1, Quake2, StartTruckCheck, Storm1, Storm2, Storm3, Tornado

function Meteor(t)
  local r1 = game.rand(3)
  local r2 = game.rand(5)
  local r3 = game.rand(5)
  if r1 == 0 then
    game.create_meteor({ r3 + 101, r2 + 73 }, -1)
  elseif r1 == 1 then
    game.create_meteor({ r3 + 50, r2 + 103 }, -1)
  else
    game.create_meteor({ r3 + 19, r2 + 42 }, -1)
  end
end

function Quake1(t)
  game.create_earthquake({ 110, 39 }, 2)
end

function Quake2(t)
  game.create_earthquake({ 92, 6 }, 1)
end

function StartTruckCheck(t)
  trigger.time{time = 40, one_shot = false, on = CheckForTrucks}  -- after 0 marks
end

function Storm1(t)
  local r1 = game.rand(63)
  game.create_lightning({ 1, 75 }, { 128, r1 + 1 }, 20)
end

function Storm2(t)
  local r1 = game.rand(128)
  game.create_lightning({ 51, 128 }, { r1, 2 }, 20)
end

function Storm3(t)
  local r1 = game.rand(10)
  game.create_lightning({ 108, 2 }, { 0, r1 + 61 }, 20)
end

function Tornado(t)
  game.create_tornado({ 123, 125 }, { 115, 32 }, 20)
end

-- Easy, 40 ticks in (0x11003720): the sound that the parts have been located.
function Located(t)
  game.sound(151, 0)
end

-- Every 40 ticks (0x11002DA0): the parts left on the map, those in the player's Cargo Trucks, and the one in Eden's
-- truck when the player has a Spider and an EMP Lynx, Panther or Tiger to take it back; fewer than four, or one
-- still undiscovered with no Scout left to find it, and the mission fails.
function CheckForEnd(t)
  local p = players[1]
  local parts, hidden = 0, false
  for _, w in ipairs(game.wreckage()) do
    parts = parts + 1
    if not w.is_discovered then hidden = true end
  end
  for _, u in ipairs(p:units("CargoTruck")) do
    if u.cargo == "Wreckage" then parts = parts + 1 end
  end
  local scout = #p:units("Scout") > 0
  if eden_truck and eden_truck.alive and eden_truck.cargo ~= "Empty" then
    local spider, emp = #p:units("Spider") > 0, false
    for _, kind in ipairs({ "Lynx", "Panther", "Tiger" }) do
      for _, u in ipairs(p:units(kind)) do
        if u.weapon == "EMP" then emp = true end
      end
    end
    if spider and emp then parts = parts + 1 end
  end
  if parts < 4 or (hidden and not scout) then mission.failure(trigger.time{time = 1}) end
end

-- Every 40 ticks once fewer than four Cargo Trucks are left (0x11002C80): with fewer than four, Eden's count too, and
-- unless that makes four and the player has an EMP vehicle and a Spider to take one, the mission fails.
function CheckForTrucks(t)
  local p = players[1]
  local trucks = #p:units("CargoTruck")
  local spider, emp = #p:units("Spider") > 0, false
  for _, kind in ipairs({ "Lynx", "Panther", "Tiger" }) do
    for _, u in ipairs(p:units(kind)) do
      if u.weapon == "EMP" then emp = true end
    end
  end
  if trucks >= 4 then return end
  trucks = trucks + #ai_player:units("CargoTruck")
  if trucks < 4 or not emp or not spider then mission.failure(trigger.time{time = 1}) end
end

-- The four parts home (0x11004560): the ore the player came with back.
function RestoreOre(t)
  players[1].ore = saved_ore
end

-- The player on the first wreck (0x11002890).
function Wreck1Touch(t) wreck_touch(1) end

-- The player on the second wreck (0x11002930).
function Wreck2Touch(t) wreck_touch(2) end

-- The player on the third wreck (0x110029D0).
function Wreck3Touch(t) wreck_touch(3) end

-- The player on the fourth wreck (0x11002A70).
function Wreck4Touch(t) wreck_touch(4) end

-- Every 40 ticks while Eden's truck goes for the last part (0x11002C10): its move again.
function ReissueMove(t)
  if eden_truck and eden_truck.alive and last_wreck then eden_truck:move(wreck_spots[last_wreck]) end
end

-- Eden's truck has the part (0x11002B10): no more moves; the truck in a group of its own, to Eden's corner on Easy,
-- else off the map by the west edge, its escort guarding it; with the truck gone, the escort guards the corner.
function EdenGotWreck(t)
  if reissue then reissue:disable() end
  if not escort then return end
  if eden_truck and eden_truck.alive then
    local g = ai.fight_group(ai_player)
    g:take_unit(eden_truck)
    if players[1].difficulty == "Easy" then
      g:do_guard_rect()
      g:set_rect(EDEN_CORNER)
    else
      g:do_exit_map()
      g:set_rect(EDEN_EXIT)
    end
    escort:do_guard_group()
    escort:set_target_group(g)
    escort:set_follow_mode(1)
    escort:set_rect(EDEN_CORNER)
  else
    escort:do_guard_rect()
    escort:set_rect(EDEN_CORNER)
  end
end

-- AIProc (0x110013A0): once Eden's truck's unit belongs to someone else, its escort attacks it and its moves stop.
function on_tick()
  if eden_truck and eden_truck.alive and eden_truck.owner ~= 1 then
    escort:do_attack_unit()
    escort:set_target_unit(eden_truck)
    escort:set_rect(TRUCK_RECT)
    reissue:disable()
  end
end

-- Down to 7 vehicles, or all four parts loaded (0x11003FC0): both triggers off, a convoy at the bottom edge (row
-- 127), and the message.
function ReinforceP(t)
  reinforce_p1:disable()
  reinforce_p2:disable()
  convoy(128)
  game.message_at("Reinforcements have arrived!", 162, players[1], 4768, 4064)
end

-- Eden down to 7 vehicles (0x11004020): this trigger off, ToggleE's timer on, and a group guarding the base, from
-- the east and south edges.
function ReinforceE(t)
  reinforce_e:disable()
  toggle_e:enable()
  reinforce_e_group = ai.fight_group(ai_player)
  reinforce_e_group:do_guard_rect()
  reinforce_e_group:set_rect(EDEN_RECT)
  reinforce_e_group:add_units(block(0xB358))
  reinforce_e_group:add_units(block(0xB2D0))
  reinforce_e_group:set_lights(true)
end

-- 12 marks after ReinforceE (0x110040D0): ReinforceE on again and the timer off.
function ToggleE(t)
  reinforce_e:enable()
  toggle_e:disable()
end

-- All four parts loaded (0x110038B0): the four ambush rectangles on; off Easy, every Eden group (the setup's ten,
-- the escort, ReinforceE's last) attacks, at the base.
function EnableAmbush(t)
  for i = 1, 4 do ambush[i]:enable() end
  if players[1].difficulty == "Easy" then return end
  for _, g in ipairs({ ai_fight1, ai_fight2, ai_fight3, ai_fight4, escort or false, ai_fight5, ai_fight6, ai_fight7,
                       ai_fight8, ai_fight9, ai_fight10, reinforce_e_group or false }) do
    if g then
      g:do_attack_enemy()
      g:set_rect(EDEN_RECT)
    end
  end
end

-- The player at 44,80 (0x11003A80): an ambush from the south edge and the north edge.
function DoAmbush1(t) do_ambush({ 0xBC80, 0xB8A8 }, { 0xB238, 0xB820 }) end

-- The player at 45,8 (0x11003BD0): an ambush from the north edge and the east edge.
function DoAmbush2(t) do_ambush({ 0xBB60, 0xB9B8 }, { 0xB1B0, 0xB930 }) end

-- The player at 120,32 (0x11003D20): an ambush from the north edge and the south edge.
function DoAmbush3(t) do_ambush({ 0xB3E0, 0xB578 }, { 0xAF70, 0xB4F0 }) end

-- The player at 100,75 (0x11003E70): an ambush from the east edge and the south edge.
function DoAmbush4(t) do_ambush({ 0xBA40, 0xB798 }, { 0xAFF8, 0xB688 }) end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  saved_ore = players[1].ore
  has_8203, has_7103 = players[1]:has_tech(8203), players[1]:has_tech(7103)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(difficulty == "Easy" or difficulty == "Normal")
  game.set_daylight_moves(false)

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  if players[1].difficulty == "Easy" then
    wreck_at({ 77, 118 }, 8801, true)
    wreck_at({ 105, 7 }, 8801, true)
    wreck_at({ 49, 53 }, 8801, true)
    wreck_at({ 26, 28 }, 8801, true)
  elseif players[1].difficulty == "Normal" then
    wreck_at(({ { 123, 33 }, { 100, 45 }, { 86, 78 }, { 81, 98 }, { 107, 107 }, { 103, 117 }, { 79, 103 }, { 86, 115 } })[game.rand(8) + 1], 8801)
    wreck_at(({ { 43, 124 }, { 46, 84 }, { 49, 75 }, { 42, 91 }, { 70, 75 }, { 93, 38 }, { 95, 38 }, { 89, 34 } })[game.rand(8) + 1], 8801)
    wreck_at(({ { 77, 19 }, { 68, 5 }, { 59, 14 }, { 105, 7 }, { 35, 13 }, { 16, 2 }, { 7, 13 }, { 36, 30 }, { 49, 53 }, { 38, 49 }, { 23, 34 }, { 25, 31 } })[game.rand(12) + 1], 8801)
    wreck_at(({ { 15, 123 }, { 16, 112 }, { 16, 101 }, { 18, 99 } })[game.rand(4) + 1], 8801)
  elseif players[1].difficulty == "Hard" then
    wreck_at(({ { 123, 33 }, { 100, 45 }, { 86, 78 }, { 81, 98 }, { 107, 107 }, { 103, 117 }, { 79, 103 }, { 86, 115 } })[game.rand(8) + 1], 8801)
    wreck_at(({ { 43, 124 }, { 46, 84 }, { 49, 75 }, { 42, 91 }, { 70, 75 }, { 93, 38 }, { 95, 38 }, { 89, 34 } })[game.rand(8) + 1], 8801)
    wreck_at(({ { 77, 19 }, { 68, 5 }, { 59, 14 }, { 105, 7 }, { 35, 13 }, { 16, 2 }, { 7, 13 }, { 36, 30 }, { 49, 53 }, { 38, 49 }, { 23, 34 }, { 25, 31 } })[game.rand(12) + 1], 8801)
    wreck_at(({ { 15, 123 }, { 16, 112 }, { 16, 101 }, { 18, 99 } })[game.rand(4) + 1], 8801)
  end
  -- The tubes and walls the setup makes here, after the computer player's base.
  make_walls({
    { "Tube", { 1, 120 } }, { "Tube", { 1, 125 } }, { "Tube", { 3, 123 } }, { "Tube", { 6, 121 } }, { "Tube", { 7, 121 } }, { "Tube", { 7, 125 } },
    { "Tube", { 8, 121 } }, { "Tube", { 8, 125 } }, { "Tube", { 9, 125 } }, { "Tube", { 10, 118 } }, { "Tube", { 10, 119 } }, { "Tube", { 10, 124 } },
    { "Tube", { 10, 125 } }, { "Tube", { 17, 10 } }, { "Tube", { 18, 10 } }, { "Tube", { 19, 10 } },
  })
  if difficulty == "Easy" then
    trigger.time{time = 40, on = Located}  -- after 0 marks
    wreck_triggers[1] = trigger.point{at = wreck_spots[1], player = 1, on = Wreck1Touch}
    wreck_triggers[2] = trigger.point{at = wreck_spots[2], player = 1, on = Wreck2Touch}
    wreck_triggers[3] = trigger.point{at = wreck_spots[3], player = 1, on = Wreck3Touch}
    wreck_triggers[4] = trigger.point{at = wreck_spots[4], player = 1, on = Wreck4Touch}
  elseif difficulty == "Normal" or difficulty == "Hard" then
    wreck_triggers[1] = trigger.point{at = wreck_spots[1], player = 1, on = Wreck1Touch}
    wreck_triggers[2] = trigger.point{at = wreck_spots[2], player = 1, on = Wreck2Touch}
    wreck_triggers[3] = trigger.point{at = wreck_spots[3], player = 1, on = Wreck3Touch}
    wreck_triggers[4] = trigger.point{at = wreck_spots[4], player = 1, on = Wreck4Touch}
  end
  game.create_marker({ 124, 121 })

  -- The win.
  local t19 = trigger.escape{at = { x = 150, y = 115, raw = true }, width = 10, height = 10, type = "CargoTruck", count = 4, cargo = 9, amount = -1, one_shot = true, on = RestoreOre}
  if difficulty == "Easy" then
    mission.victory(t19, "Return spacecraft parts at (77,118), (105,7), (49,53) and (26,28) to the convoy starting location.", {one_shot = true})
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t19, "Return all 4 spacecraft parts to the convoy starting location.", {one_shot = true})
  end
  trigger.time{min = 30000, max = 32000, on = Tornado}  -- after 300 to 320 marks
  trigger.time{min = 10800, max = 14400, one_shot = false, on = Meteor}  -- after 108 to 144 marks
  trigger.time{min = 6000, max = 9600, on = Quake1}  -- after 60 to 96 marks
  trigger.time{min = 18000, max = 24000, on = Quake2}  -- after 180 to 240 marks
  trigger.time{min = 12000, max = 18000, on = Storm1}  -- after 120 to 180 marks
  trigger.time{min = 30000, max = 36000, on = Storm2}  -- after 300 to 360 marks
  trigger.time{min = 36000, max = 42000, on = Storm3}  -- after 360 to 420 marks
  reinforce_p1 = trigger.vehicle_count{compare = "<", count = 8, player = 1, one_shot = true, on = ReinforceP}
  reinforce_p2 = trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 4, player = 1, one_shot = true, on = ReinforceP}
  toggle_e = trigger.time{time = 1200, one_shot = false, enabled = false, on = ToggleE}  -- after 12 marks
  reinforce_e = trigger.vehicle_count{compare = "<", count = 8, player = ai_player, on = ReinforceE}
  trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 4, player = 1, one_shot = true, on = EnableAmbush}
  ambush[1] = trigger.rect{at = { x = 44, y = 80, raw = true }, width = 13, height = 7, player = 1, one_shot = true, enabled = false, on = DoAmbush1}
  ambush[2] = trigger.rect{at = { x = 45, y = 8, raw = true }, width = 13, height = 13, player = 1, one_shot = true, enabled = false, on = DoAmbush2}
  ambush[3] = trigger.rect{at = { x = 120, y = 32, raw = true }, width = 19, height = 7, player = 1, one_shot = true, enabled = false, on = DoAmbush3}
  ambush[4] = trigger.rect{at = { x = 100, y = 75, raw = true }, width = 29, height = 45, player = 1, one_shot = true, enabled = false, on = DoAmbush4}
  trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 1, player = ai_player, one_shot = true, on = EdenGotWreck}
  trigger.count{type = "CargoTruck", compare = "<", count = 4, player = 1, one_shot = true, on = StartTruckCheck}
  trigger.time{time = 40, one_shot = false, on = CheckForEnd}  -- after 0 marks
end

-- Not converted:
-- - Easy: units are made other ways than CreateUnit (84 on the map, 32 made)
-- - Normal: units are made other ways than CreateUnit (92 on the map, 29 made)
-- - Hard: units are made other ways than CreateUnit (96 on the map, 33 made)
-- - the setup's markers change with the difficulty (Normal's are made)
