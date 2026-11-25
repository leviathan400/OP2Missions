-- p06Lua.lua  -  Plymouth Mission #6 (Lua)
-- Trigger functions finished by hand (Located, Toggle1Active, Toggle2Active, Toggle3Active, CheckForEnd, KillTrucks, ReinforceTime, ReinforceTK, TruckArrive, TruckExitFunction, MoreConvoys, ConvoyWait, CheckForTrucks, RestoreOre, AIProc), from the disassembly of p06.dll.
-- Converted by op2dll from p06.dll. With p06Lua.placement.lua (what every difficulty makes alike),
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
        workers = 24, scientists = 16, kids = 7, ore = 0,
        research = { 6000 },
        tech_level = 5,
        view = { 122, 40 },
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
      { type = "CargoTruck", direction = "West", player = 1, at = { 126, 38 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 125, 40 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 127, 40 } },
      { type = "Spider", direction = "West", player = 1, at = { 124, 37 } },
      { type = "Spider", direction = "West", player = 1, at = { 123, 39 } },
      { type = "Spider", direction = "West", player = 1, at = { 124, 42 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 118, 38 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 118, 40 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 38 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 41 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 127, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 125, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 123, 36 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 121, 36 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 127, 44 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 124, 44 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 122, 43 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 119, 42 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 116, 35 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 117, 45 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 113, 39 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 24, scientists = 16, kids = 7, ore = 0,
        research = { 6000 },
        tech_level = 5,
        view = { 122, 40 },
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
      { type = "CargoTruck", direction = "West", player = 1, at = { 126, 38 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 125, 40 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 127, 40 } },
      { type = "Spider", direction = "West", player = 1, at = { 124, 37 } },
      { type = "Spider", direction = "West", player = 1, at = { 123, 39 } },
      { type = "Spider", direction = "West", player = 1, at = { 124, 42 } },
      { type = "Spider", direction = "West", player = 1, at = { 125, 42 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 118, 38 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 118, 40 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 38 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 41 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 39 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 127, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 125, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 123, 36 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 121, 36 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 127, 44 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 124, 44 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 122, 43 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 119, 42 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 116, 35 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 117, 45 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 113, 39 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 24, scientists = 16, kids = 7, ore = 0,
        research = { 6000 },
        tech_level = 5,
        view = { 122, 40 },
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
      { type = "CargoTruck", direction = "West", player = 1, at = { 126, 38 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 125, 40 } },
      { type = "CargoTruck", direction = "West", player = 1, at = { 127, 40 } },
      { type = "Spider", direction = "West", player = 1, at = { 124, 37 } },
      { type = "Spider", direction = "West", player = 1, at = { 123, 39 } },
      { type = "Spider", direction = "West", player = 1, at = { 124, 42 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 118, 38 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 118, 40 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 38 } },
      { type = "Scout", direction = "West", player = 1, at = { 121, 41 } },
      { type = "Lynx", weapon = "RPG", direction = "West", player = 1, at = { 118, 38 } },
      { type = "Lynx", weapon = "RPG", direction = "West", player = 1, at = { 118, 40 } },
      { type = "Lynx", weapon = "EMP", direction = "West", player = 1, at = { 125, 42 } },
      { type = "Spider", direction = "West", player = 1, at = { 125, 42 } },
      { type = "Spider", direction = "West", player = 1, at = { 125, 42 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 127, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 125, 35 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 123, 36 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 121, 36 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 127, 44 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 124, 44 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 122, 43 } },
      { type = "Lynx", weapon = "Microwave", direction = "West", player = 1, at = { 119, 42 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 116, 35 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 117, 45 } },
      { type = "Panther", weapon = "RPG", direction = "West", player = 1, at = { 113, 39 } },
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
    { type = "CommandCenter", at = { 4, 46 } },
    { type = "StandardLab", at = { 4, 43 } },
    { type = "Tokamak", at = { 7, 15 } },
    { type = "GuardPost", at = { 37, 58 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 36, 16 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 16, 44 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 34, 29 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 52, 10 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 7, 43 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 51, 31 }, weapon = "Laser" },
    { type = "GuardPost", at = { 46, 4 }, weapon = "Laser" },
    { type = "GuardPost", at = { 25, 45 }, weapon = "Laser" },
    { type = "GuardPost", at = { 9, 19 }, weapon = "Laser" },
  },
  [2] = {
    { type = "Lynx", at = { 39, 8 }, weapon = "RailGun" },
    { type = "Lynx", at = { 42, 9 }, weapon = "RailGun" },
    { type = "Panther", at = { 40, 10 }, weapon = "Laser" },
  },
  [3] = {
    { type = "Lynx", at = { 32, 9 }, weapon = "Laser" },
    { type = "Lynx", at = { 34, 11 }, weapon = "Laser" },
    { type = "Lynx", at = { 32, 12 }, weapon = "Laser" },
  },
  [4] = {
    { type = "Lynx", at = { 39, 33 }, weapon = "Laser" },
    { type = "Panther", at = { 41, 30 }, weapon = "RailGun" },
    { type = "Panther", at = { 38, 26 }, weapon = "RailGun" },
    { type = "Lynx", at = { 36, 29 }, weapon = "Laser" },
    { type = "Lynx", at = { 34, 31 }, weapon = "Laser" },
  },
  [5] = {
    { type = "Lynx", at = { 26, 55 }, weapon = "Laser" },
    { type = "Lynx", at = { 27, 53 }, weapon = "Laser" },
    { type = "Lynx", at = { 27, 51 }, weapon = "Laser" },
  },
  [6] = {
    { type = "Lynx", at = { 5, 39 }, weapon = "Laser" },
    { type = "Lynx", at = { 7, 38 }, weapon = "Laser" },
    { type = "Lynx", at = { 10, 39 }, weapon = "Laser" },
    { type = "Panther", at = { 7, 41 }, weapon = "RailGun" },
    { type = "Panther", at = { 10, 42 }, weapon = "RailGun" },
  },
  [7] = {
    { type = "Lynx", at = { 47, 40 }, weapon = "RailGun" },
    { type = "Lynx", at = { 47, 39 }, weapon = "RailGun" },
    { type = "Lynx", at = { 48, 39 }, weapon = "RailGun" },
  },
  [8] = {
    { type = "CargoTruck", at = { 114, 2 } },
  },
  [9] = {
    { type = "Scout", at = { 113, 3 } },
    { type = "Lynx", at = { 111, 2 }, weapon = "Laser" },
    { type = "Lynx", at = { 116, 2 }, weapon = "Laser" },
    { type = "Lynx", at = { 116, 4 }, weapon = "Laser" },
    { type = "Lynx", at = { 111, 4 }, weapon = "Laser" },
    { type = "Panther", at = { 109, 3 }, weapon = "RailGun" },
    { type = "Panther", at = { 115, 4 }, weapon = "RailGun" },
  },
  [10] = {
    { type = "Scout", at = { 113, 3 } },
    { type = "Lynx", at = { 111, 2 }, weapon = "Laser" },
    { type = "Lynx", at = { 116, 2 }, weapon = "Laser" },
    { type = "Lynx", at = { 116, 4 }, weapon = "Laser" },
    { type = "Lynx", at = { 111, 4 }, weapon = "Laser" },
    { type = "Lynx", at = { 113, 5 }, weapon = "Laser" },
    { type = "Lynx", at = { 114, 5 }, weapon = "Laser" },
    { type = "Panther", at = { 114, 1 }, weapon = "RailGun" },
    { type = "Panther", at = { 109, 3 }, weapon = "RailGun" },
    { type = "Panther", at = { 115, 4 }, weapon = "RailGun" },
  },
  [11] = {
    { type = "CommandCenter", at = { 4, 46 } },
    { type = "StandardLab", at = { 4, 43 } },
    { type = "Tokamak", at = { 7, 15 } },
    { type = "GuardPost", at = { 37, 58 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 36, 16 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 16, 44 }, weapon = "RailGun" },
    { type = "GuardPost", at = { 51, 31 }, weapon = "Laser" },
    { type = "GuardPost", at = { 46, 4 }, weapon = "Laser" },
  },
  [12] = {
    { type = "Lynx", at = { 26, 55 }, weapon = "Laser" },
    { type = "Lynx", at = { 27, 53 }, weapon = "Laser" },
    { type = "Lynx", at = { 27, 51 }, weapon = "Laser" },
    { type = "Lynx", at = { 27, 51 }, weapon = "RailGun" },
    { type = "Lynx", at = { 27, 51 }, weapon = "RailGun" },
  },
  [13] = {
    { type = "Panther", at = { 47, 40 }, weapon = "RailGun" },
    { type = "Panther", at = { 47, 39 }, weapon = "RailGun" },
    { type = "Panther", at = { 48, 39 }, weapon = "RailGun" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_fight1, ai_fight2, ai_fight3, ai_fight4, ai_fight5, ai_fight6

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_eden()
  if difficulty == "Easy" then
    ai_block(11):create_units(p, false)
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_block(1):create_units(p, false)
    ai_fight1 = ai.fight_group(p)
    ai_fight1:do_guard_rect()
    ai_fight1:set_rect({ 39, 8, 42, 10 })
    ai_fight1:add_units(ai_block(2))
    ai_fight1:set_lights(true)
  end
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 86, 6, 89, 8 })
  ai_fight2:add_units(ai_block(3))
  ai_fight2:set_lights(true)
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 34, 26, 41, 33 })
  ai_fight3:add_units(ai_block(4))
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_patrol_only()
  ai_fight4:set_rect({ 26, 51, 27, 55 })
  ai_fight4:set_patrol({ { 82, 61 }, { 24, 51 } }, 1)
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_fight4:add_units(ai_block(5))
  elseif difficulty == "Hard" then
    ai_fight4:add_units(ai_block(12))
  end
  ai_fight4:set_lights(true)
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_rect()
  ai_fight5:set_rect({ 7, 30, 12, 45 })
  ai_fight5:add_units(ai_block(6))
  if difficulty == "Normal" then
    ai_fight6 = ai.fight_group(p)
    ai_fight6:do_guard_rect()
    ai_fight6:set_rect({ 45, 39, 48, 40 })
    ai_fight6:add_units(ai_block(7))
    ai_fight6:set_lights(true)
  elseif difficulty == "Hard" then
    ai_fight6 = ai.fight_group(p)
    ai_fight6:do_guard_rect()
    ai_fight6:set_rect({ 45, 39, 48, 40 })
    ai_fight6:add_units(ai_block(13))
    ai_fight6:set_lights(true)
  end
  p:set_tech_level(6)
end


-- The round's time triggers (0x110081B0, 0x110081B4, 0x110081B8): each turns itself off and one of the others on.
local toggle1, toggle2, toggle3
-- The player's ore before the setup empties it (0x110081D0), given back on the win.
local saved_ore = 0
-- The convoy (TruckArrive): the group that leaves with the Eden truck (0x110081A4), its escort (0x110081A0), the
-- truck (0x110081AC), that it has come (0x110081C4) and that the truck was taken (0x110081C8).
local convoy_exit, convoy_escort, magic_truck
local convoy_came, truck_taken = false, false
-- Hard's reinforcements: the damage trigger on the Cargo Truck hunters (0x110081BC) and the wait (0x110081C0).
local reinforce_damaged, reinforce_wait
-- Group5 and Group5Hard (0x11007E60, 0x11007B30): the escort's units; GroupTKR (0x11007FB0): Hard's reinforcements.
local function escort_block()
  return ai_block(players[1].difficulty == "Hard" and 10 or 9)
end
local tkr_block

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local EasyStorm, Microbe1, Microbe2, StormRepeater, StormRepeaterStart, TruckArrive

function EasyStorm(t)
  local r1 = game.rand(6)
  game.create_lightning({ 81, 1 }, { 114, 62 }, r1 + 8)
end

function Microbe1(t)
  game.create_blight({ 1, 64 })
  game.create_blight({ 2, 64 })
  game.create_blight({ 3, 64 })
  game.set_blight_speed(300)
  game.message_at("Microbe growth detected!", 152, 1, 1024, 2016)
  trigger.time{time = 1000, on = Microbe2}  -- after 10 marks
end

function Microbe2(t)
  game.create_blight({ 129, 2 })
  game.create_blight({ 127, 2 })
  game.create_blight({ 126, 2 })
  game.set_blight_speed(300)
  game.message_at("Microbe growth detected!", 152, 1, 5120, 32)
end

function StormRepeater(t)
  local r1 = game.rand(8)
  local r2 = game.rand(51)
  local r3 = game.rand(10)
  local r4 = game.rand(8)
  local r5 = game.rand(55)
  game.create_lightning({ r5 + 66, r4 + 1 }, { r2 + 60, r1 + 57 }, r3 + 15)
end

function StormRepeaterStart(t)
  if players[1].difficulty == "Easy" then
    trigger.time{min = 1200, max = 1800, one_shot = false, on = StormRepeater}  -- after 12 to 18 marks
  elseif players[1].difficulty == "Normal" then
    trigger.time{min = 1500, max = 2000, one_shot = false, on = StormRepeater}  -- after 15 to 20 marks
  else
    trigger.time{min = 1200, max = 1800, one_shot = false, on = StormRepeater}  -- after 12 to 18 marks
  end
end


-- Easy, tick 40 (0x11001A00): the sound that the wrecks are found (151).
function Located(t)
  game.sound(151, 0)
end

-- While on, every 11 to 14 marks (0x11001D20): the second guard group moves to 39,5 - 43,8 (Toggle2Active next) or
-- 59,31 - 64,34 (Toggle3Active next), drawn.
function Toggle1Active(t)
  toggle1:disable()
  if game.rand(2) ~= 0 then
    toggle2:enable()
    ai_fight2:do_guard_rect()
    ai_fight2:set_rect({ 39, 5, 43, 8 })
  else
    toggle3:enable()
    ai_fight2:do_guard_rect()
    ai_fight2:set_rect({ 59, 31, 64, 34 })
  end
end

-- While on, every 12 to 15 marks (0x11001DA0): to 59,31 - 64,34 (Toggle3Active next) or back to 86,6 - 89,8
-- (Toggle1Active next), drawn.
function Toggle2Active(t)
  toggle2:disable()
  if game.rand(2) ~= 0 then
    toggle3:enable()
    ai_fight2:do_guard_rect()
    ai_fight2:set_rect({ 59, 31, 64, 34 })
  else
    toggle1:enable()
    ai_fight2:do_guard_rect()
    ai_fight2:set_rect({ 86, 6, 89, 8 })
  end
end

-- While on, every 10 to 13 marks (0x11001E20): back to 86,6 - 89,8 (Toggle1Active next) or to 39,5 - 43,8
-- (Toggle2Active next), drawn.
function Toggle3Active(t)
  toggle3:disable()
  if game.rand(2) ~= 0 then
    toggle1:enable()
    ai_fight2:do_guard_rect()
    ai_fight2:set_rect({ 86, 6, 89, 8 })
  else
    toggle2:enable()
    ai_fight2:do_guard_rect()
    ai_fight2:set_rect({ 39, 5, 43, 8 })
  end
end

-- Every 40 ticks (0x110024A0): the spacecraft parts left, wrecks on the ground and Cargo Trucks carrying one. Fewer
-- than three fails the mission, and so does a wreck still undiscovered when the colony has no Scout.
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
  if parts < 3 or (hidden and not scout) then mission.failure(trigger.time{time = 1}) end
end

-- Tick 6000, Normal and Hard (0x11002320): the guards at 45,39 - 48,40 go hunting Cargo Trucks; on Hard, once they
-- are damaged, reinforcements come every 35 to 40 marks (ReinforceTime, ReinforceTK).
function KillTrucks(t)
  ai_fight6:do_attack_enemy()
  ai_fight6:set_attack_type("CargoTruck")
  ai_fight6:set_rect({ 45, 39, 48, 40 })
  if players[1].difficulty == "Hard" then
    reinforce_damaged = trigger.damaged{group = ai_fight6, damage = 1, one_shot = false, on = ReinforceTime}
    reinforce_wait = trigger.time{min = 3500, max = 4000, one_shot = false, enabled = false, on = ReinforceTK}
  end
end

-- Hard, the hunters damaged (0x110023C0): the reinforcements' wait begins.
function ReinforceTime(t)
  reinforce_damaged:disable()
  reinforce_wait:enable()
end

-- Hard, the wait over (0x110023E0): three Lynx (Rail Gun) join the hunters, and the damage is watched again.
function ReinforceTK(t)
  tkr_block = tkr_block or ai.unit_block{
    { type = "Lynx", at = { 2, 47 }, weapon = "RailGun" },
    { type = "Lynx", at = { 2, 48 }, weapon = "RailGun" },
    { type = "Lynx", at = { 2, 49 }, weapon = "RailGun" },
  }
  ai_fight6:add_units(tkr_block)
  reinforce_wait:disable()
  reinforce_damaged:enable()
end

-- The colony first has a spacecraft part in a Cargo Truck (0x110020C0): an Eden Cargo Truck comes at 114,2 to leave by
-- 1,47 - 2,52, its escort following it; the truck is the one AIProc and CheckForTrucks watch.
function TruckArrive(t)
  convoy_exit = ai.fight_group(ai_player)
  convoy_exit:do_exit_map()
  convoy_exit:set_rect({ 1, 47, 2, 52 })
  convoy_exit:add_units(ai_block(8))
  convoy_exit:set_lights(true)
  convoy_escort = ai.fight_group(ai_player)
  convoy_escort:do_guard_group()
  convoy_escort:set_target_group(convoy_exit)
  convoy_escort:set_follow_mode(1)
  convoy_escort:set_rect({ 1, 47, 2, 52 })
  convoy_escort:add_units(escort_block())
  convoy_escort:set_lights(true)
  for _, u in ipairs(game.units_in_rect({ 114, 2, 114, 2 })) do
    magic_truck = u
    if u.type == "CargoTruck" then break end
  end
  convoy_came = true
end

-- A unit of player 1 reaches 15,2 - 15,6 (0x11002230; p06.dll passes player 32, which the game reads modulo 32 as
-- player 0): the escort leaves by 1,47 - 2,52; except on Easy, more escorts come in 5 to
-- 10 marks (MoreConvoys).
function TruckExitFunction(t)
  convoy_escort:do_exit_map()
  convoy_escort:set_rect({ 1, 47, 2, 52 })
  if players[1].difficulty ~= "Easy" then trigger.time{min = 500, max = 1000, on = MoreConvoys} end
end

-- (0x11002050) Another escort joins the group; once it is damaged, the next comes 5 to 10 marks later (ConvoyWait).
function MoreConvoys(t)
  trigger.damaged{group = convoy_escort, damage = 1, one_shot = true, on = ConvoyWait}
  convoy_escort:add_units(escort_block())
end

-- (0x11002010) The next escort in 5 to 10 marks.
function ConvoyWait(t)
  trigger.time{min = 500, max = 1000, on = MoreConvoys}
end

-- While the colony has fewer than 3 Cargo Trucks (0x11002420): once the convoy has come, the Eden truck taken or gone
-- fails the mission.
function CheckForTrucks(t)
  if convoy_came and (truck_taken or not (magic_truck and magic_truck.alive)) then
    mission.failure(trigger.time{time = 1})
  end
end

-- The win (0x11002940): the ore the colony had before the setup is given back.
function RestoreOre(t)
  players[1].ore = saved_ore
end

-- Every 4 ticks (AIProc, 0x110012B0): the Eden truck alive but not Eden's, the escort attacks it at 109,2 - 116,5;
-- once the convoy has come and the truck is gone, the escort attacks any enemy by 1,47 - 2,52. Until the colony
-- loads a spacecraft part (TruckArrive) it does nothing.
function AIProc()
  if magic_truck and magic_truck.alive then
    if magic_truck.owner ~= 1 then
      truck_taken = true
      convoy_escort:do_attack_unit()
      convoy_escort:set_target_unit(magic_truck)
      convoy_escort:set_rect({ 109, 2, 116, 5 })
    end
  elseif convoy_came then
    convoy_escort:do_attack_enemy()
    convoy_escort:set_rect({ 1, 47, 2, 52 })
  end
end

function on_tick()
  if convoy_came and game.tick() % 4 == 0 then AIProc() end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  saved_ore = players[1].ore
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  game.set_daylight_everywhere(true)

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  if difficulty == "Easy" then
    trigger.time{time = 40, on = Located}
  else
    trigger.time{time = 6000, on = KillTrucks}
  end
  local WRECKS = {
    { { 80, 43 }, { 38, 9 }, { 21, 42 } },
    { { 26, 8 }, { 84, 53 }, { 21, 42 } },
    { { 62, 2 }, { 64, 52 }, { 26, 8 } },
  }
  for _, at in ipairs(WRECKS[game.rand(3) + 1]) do game.create_wreckage(at, 8801, difficulty == "Easy") end
  if difficulty ~= "Easy" then game.create_marker({ 122, 39 }) end

  -- The win.
  local t12 = trigger.escape{at = { x = 148, y = 34, raw = true }, width = 10, height = 8, type = "CargoTruck", count = 3, cargo = 9, amount = -1, one_shot = true, on = RestoreOre}
  if difficulty == "Easy" then
    mission.victory(t12, "Return spacecraft parts at (26,8), (84,53), and (21,42) to the convoy starting location.", {one_shot = true})
  elseif difficulty == "Normal" or difficulty == "Hard" then
    mission.victory(t12, "Return all 3 spacecraft parts to the convoy starting location.", {one_shot = true})
  end
  if difficulty == "Easy" then
    game.create_marker({ 122, 39 })
  end
  trigger.count{type = "CargoTruck", cargo = 9, compare = ">=", count = 1, player = 1, one_shot = true, on = TruckArrive}
  trigger.rect{at = { x = 46, y = 1, raw = true }, width = 1, height = 5, player = 1, one_shot = true, on = TruckExitFunction}
  toggle1 = trigger.time{min = 1100, max = 1400, one_shot = false, on = Toggle1Active}  -- after 11 to 14 marks
  toggle2 = trigger.time{min = 1200, max = 1500, one_shot = false, enabled = false, on = Toggle2Active}  -- after 12 to 15 marks
  toggle3 = trigger.time{min = 1000, max = 1300, one_shot = false, enabled = false, on = Toggle3Active}  -- after 10 to 13 marks
  trigger.time{time = 40, one_shot = false, on = CheckForEnd}  -- after 0 marks
  trigger.count{type = "CargoTruck", compare = "<", count = 3, player = 1, on = CheckForTrucks}
  mission.failure(trigger.count{type = "CargoTruck", compare = "<", count = 2, player = 1})
  if difficulty == "Easy" then
    trigger.time{time = 12000, on = EasyStorm}  -- after 120 marks
  elseif difficulty == "Normal" then
    trigger.time{min = 2000, max = 2100, on = StormRepeaterStart}  -- after 20 to 21 marks
  elseif difficulty == "Hard" then
    trigger.time{min = 300, max = 350, on = StormRepeaterStart}  -- after 3 to 3 marks
  end
  trigger.time{time = 90000, on = Microbe1}  -- after 900 marks
end

-- Not converted:
-- - Easy: units are made other ways than CreateUnit (45 on the map, 21 made)
-- - Normal: units are made other ways than CreateUnit (58 on the map, 23 made)
-- - Hard: units are made other ways than CreateUnit (63 on the map, 26 made)
-- - the setup's markers change with the difficulty (Normal's are made)
