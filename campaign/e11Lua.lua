-- e11Lua.lua  -  Eden Mission #11 (Lua)
-- Trigger functions finished by hand (CheckWin, AllToAttack, GenebankFound, HostagesFound, FakeLabVisit3, FakeLabVisit4, GenebankGone, HostagesGone, CheckForLostBank, CheckForLostGuys, ReinforceP2, PursueTruck, ReinforceE, GiveOre, Lab1Dead, Lab2Dead), from the disassembly of e11.dll.
-- Converted by op2dll from e11.dll. With e11Lua.placement.lua (what every difficulty makes alike),
-- this makes the colony's start: what changes with the difficulty, and the beacons the setup rolls.
-- Games run: Easy 151, Normal 159, Hard 159.
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
        research = { 11000 },
        tech_level = 10,
        view = { 33, 23 },
        units = {
        },
      },
      [2] = {
        ore = 100000, rare_ore = 16000,
        research = {  },
        tech_level = 11,
        kits = { [1] = { "Tokamak" }, [2] = { "GuardPost", "EMP" } },
        units = {
        },
      },
    },
    walls = {
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 72 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 50, 33 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 5, 113 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 33, 23 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 32, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 34, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 36, 25 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 38, 25 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 38, 25 } },
      { type = "Scout", direction = "East", player = 1, at = { 41, 16 } },
      { type = "Scout", direction = "East", player = 1, at = { 41, 19 } },
      { type = "Scout", direction = "East", player = 1, at = { 42, 17 } },
      { type = "Scout", direction = "East", player = 1, at = { 42, 20 } },
      { type = "Scout", direction = "East", player = 1, at = { 43, 18 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 31, 23 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 36, 18 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 38, 18 } },
      { type = "Lynx", weapon = "ThorsHammer", direction = "East", player = 1, at = { 38, 20 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 33, 12 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 35, 12 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 1, at = { 33, 14 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 1, at = { 33, 14 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 38, 23 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 30, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 40, 23 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 32, 28 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 34, 28 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 32, 30 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 34, 30 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 34, 18 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 34, 20 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "East", player = 1, at = { 36, 20 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        research = { 11000 },
        tech_level = 10,
        view = { 33, 23 },
        units = {
        },
      },
      [2] = {
        ore = 100000, rare_ore = 16000,
        research = {  },
        tech_level = 11,
        kits = { [1] = { "Tokamak" }, [2] = { "GuardPost", "EMP" } },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 53, 119 } }, { "Tube", { 53, 120 } }, { "Tube", { 53, 121 } }, { "Tube", { 53, 122 } },
      { "Tube", { 72, 115 } }, { "Tube", { 73, 115 } }, { "Tube", { 74, 115 } }, { "Tube", { 75, 115 } },
      { "Tube", { 82, 96 } }, { "Tube", { 95, 120 } }, { "Tube", { 95, 121 } }, { "Tube", { 114, 98 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 72 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 50, 33 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 5, 113 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 33, 23 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 32, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 34, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 36, 25 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 38, 25 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 38, 25 } },
      { type = "Scout", direction = "East", player = 1, at = { 41, 16 } },
      { type = "Scout", direction = "East", player = 1, at = { 41, 19 } },
      { type = "Scout", direction = "East", player = 1, at = { 42, 17 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 31, 23 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 36, 18 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 38, 18 } },
      { type = "Lynx", weapon = "ThorsHammer", direction = "East", player = 1, at = { 38, 20 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 33, 12 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 35, 12 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 1, at = { 33, 14 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 1, at = { 33, 14 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 38, 23 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 30, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 40, 23 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 32, 28 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 34, 28 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 32, 30 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 34, 30 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 34, 18 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 34, 20 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "East", player = 1, at = { 36, 20 } },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        research = { 11000 },
        tech_level = 10,
        view = { 33, 23 },
        units = {
        },
      },
      [2] = {
        ore = 100000, rare_ore = 16000,
        research = {  },
        tech_level = 11,
        kits = { [1] = { "Tokamak" }, [2] = { "GuardPost", "EMP" } },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 53, 119 } }, { "Tube", { 53, 120 } }, { "Tube", { 53, 121 } }, { "Tube", { 53, 122 } },
      { "Tube", { 68, 92 } }, { "Tube", { 69, 92 } }, { "Tube", { 72, 115 } }, { "Tube", { 73, 115 } },
      { "Tube", { 74, 115 } }, { "Tube", { 75, 82 } }, { "Tube", { 75, 83 } }, { "Tube", { 75, 84 } },
      { "Tube", { 75, 85 } }, { "Tube", { 75, 87 } }, { "Tube", { 75, 88 } }, { "Tube", { 75, 89 } },
      { "Tube", { 75, 90 } }, { "Tube", { 75, 115 } }, { "Tube", { 82, 96 } }, { "Tube", { 82, 102 } },
      { "Tube", { 93, 100 } }, { "Tube", { 95, 120 } }, { "Tube", { 95, 121 } }, { "Tube", { 96, 120 } },
      { "Tube", { 97, 120 } }, { "Tube", { 98, 120 } }, { "Tube", { 99, 120 } }, { "Tube", { 100, 120 } },
      { "Tube", { 101, 120 } }, { "Tube", { 102, 120 } }, { "Tube", { 103, 120 } }, { "Tube", { 104, 120 } },
      { "Tube", { 105, 120 } }, { "Tube", { 106, 120 } }, { "Tube", { 107, 64 } }, { "Tube", { 107, 65 } },
      { "Tube", { 107, 66 } }, { "Tube", { 107, 67 } }, { "Tube", { 107, 68 } }, { "Tube", { 107, 69 } },
      { "Tube", { 107, 120 } }, { "Tube", { 108, 120 } }, { "Tube", { 109, 120 } }, { "Tube", { 110, 120 } },
      { "Tube", { 111, 120 } }, { "Tube", { 112, 120 } }, { "Tube", { 113, 120 } }, { "Tube", { 114, 98 } },
      { "Tube", { 114, 120 } }, { "Tube", { 115, 120 } }, { "Tube", { 116, 120 } }, { "Tube", { 117, 95 } },
      { "Tube", { 117, 120 } }, { "Tube", { 118, 59 } }, { "Tube", { 118, 60 } }, { "Tube", { 118, 61 } },
      { "Tube", { 118, 62 } }, { "Tube", { 118, 63 } }, { "Tube", { 118, 64 } }, { "Tube", { 118, 65 } },
      { "Tube", { 118, 95 } }, { "Tube", { 118, 102 } }, { "Tube", { 118, 103 } }, { "Tube", { 118, 104 } },
      { "Tube", { 118, 105 } }, { "Tube", { 118, 120 } }, { "Tube", { 119, 95 } }, { "Tube", { 119, 96 } },
      { "Tube", { 119, 97 } }, { "Tube", { 119, 98 } }, { "Tube", { 119, 120 } }, { "Tube", { 120, 71 } },
      { "Tube", { 120, 106 } }, { "Tube", { 120, 120 } }, { "Tube", { 121, 71 } }, { "Tube", { 121, 106 } },
      { "Tube", { 121, 120 } }, { "Tube", { 122, 106 } }, { "Tube", { 122, 120 } }, { "Tube", { 122, 121 } },
      { "Tube", { 122, 124 } }, { "Tube", { 122, 125 } }, { "Tube", { 123, 106 } }, { "Tube", { 123, 120 } },
      { "Tube", { 124, 120 } }, { "Tube", { 125, 64 } }, { "Tube", { 125, 65 } }, { "Tube", { 125, 66 } },
      { "Tube", { 125, 67 } }, { "Tube", { 125, 120 } }, { "Tube", { 126, 120 } },
    },
    made = {
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 72 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 50, 33 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 5, 113 }, beacon = true },
      { type = "CargoTruck", direction = "East", player = 1, at = { 33, 23 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 32, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 34, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 36, 25 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 38, 25 } },
      { type = "Lynx", weapon = "RailGun", direction = "East", player = 1, at = { 38, 25 } },
      { type = "Scout", direction = "East", player = 1, at = { 41, 16 } },
      { type = "Scout", direction = "East", player = 1, at = { 41, 19 } },
      { type = "Scout", direction = "East", player = 1, at = { 42, 17 } },
      { type = "EvacuationTransport", direction = "East", player = 1, at = { 31, 23 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 36, 18 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 38, 18 } },
      { type = "Lynx", weapon = "ThorsHammer", direction = "East", player = 1, at = { 38, 20 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 33, 12 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 35, 12 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 1, at = { 33, 14 } },
      { type = "Panther", weapon = "ThorsHammer", direction = "East", player = 1, at = { 33, 14 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 38, 23 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 30, 25 } },
      { type = "Lynx", weapon = "Laser", direction = "East", player = 1, at = { 40, 23 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 32, 28 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 34, 28 } },
      { type = "Panther", weapon = "Laser", direction = "East", player = 1, at = { 32, 30 } },
      { type = "Panther", weapon = "RailGun", direction = "East", player = 1, at = { 34, 30 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 34, 18 } },
      { type = "Tiger", weapon = "RailGun", direction = "East", player = 1, at = { 34, 20 } },
      { type = "Tiger", weapon = "ThorsHammer", direction = "East", player = 1, at = { 36, 20 } },
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
    { type = "Spaceport", at = { 73, 124 } },
  },
  [2] = {
    { type = "Lynx", at = { 64, 122 }, weapon = "EMP" },
    { type = "Spider", at = { 64, 122 } },
    { type = "Lynx", at = { 66, 120 }, weapon = "RPG" },
    { type = "Scorpion", at = { 66, 123 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 68, 121 }, weapon = "EnergyCannon" },
    { type = "Panther", at = { 72, 114 }, weapon = "EMP" },
  },
  [3] = {
    { type = "Lynx", at = { 125, 59 }, weapon = "EMP" },
    { type = "Spider", at = { 125, 59 } },
    { type = "Spider", at = { 125, 59 } },
    { type = "Lynx", at = { 125, 59 }, weapon = "EMP" },
    { type = "Lynx", at = { 127, 59 }, weapon = "Microwave" },
    { type = "Lynx", at = { 126, 61 }, weapon = "Microwave" },
  },
  [4] = {
    { type = "CommandCenter", at = { 100, 92 } },
    { type = "VehicleFactory", at = { 61, 116 } },
    { type = "Garage", at = { 69, 115 } },
    { type = "Garage", at = { 62, 126 } },
    { type = "ArachnidFactory", at = { 82, 114 } },
    { type = "CommonOreSmelter", at = { 78, 103 } },
    { type = "RareOreSmelter", at = { 93, 109 } },
    { type = "CommonOreSmelter", at = { 33, 118 } },
    { type = "StructureFactory", at = { 116, 84 } },
    { type = "StructureFactory", at = { 86, 98 } },
    { type = "CommonOreMine", at = { 6, 113 } },
    { type = "CommonOreMine", at = { 54, 72 } },
    { type = "CommonOreMine", at = { 51, 33 } },
  },
  [5] = {
    { type = "ConVec", at = { 116, 84 } },
    { type = "ConVec", at = { 116, 84 } },
    { type = "ConVec", at = { 73, 124 } },
    { type = "ConVec", at = { 119, 87 } },
    { type = "ConVec", at = { 106, 87 } },
    { type = "ConVec", at = { 94, 93 } },
  },
  [6] = {
    { type = "DIRT", at = { 36, 124 } },
    { type = "CommonStorage", at = { 20, 124 } },
    { type = "CommonStorage", at = { 25, 124 } },
    { type = "RecreationFacility", at = { 83, 84 } },
    { type = "ReinforcedResidence", at = { 100, 76 } },
    { type = "ReinforcedResidence", at = { 79, 73 } },
    { type = "GORF", at = { 91, 75 } },
    { type = "DIRT", at = { 107, 112 } },
    { type = "MHDGenerator", at = { 127, 72 } },
    { type = "MHDGenerator", at = { 99, 125 } },
    { type = "MHDGenerator", at = { 109, 125 } },
    { type = "Tokamak", at = { 127, 102 } },
    { type = "Tokamak", at = { 127, 126 } },
    { type = "Tokamak", at = { 36, 113 } },
    { type = "CommandCenter", at = { 48, 113 } },
    { type = "GuardPost", at = { 26, 115 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 75, 116 }, weapon = "Microwave" },
    { type = "Residence", at = { 107, 96 } },
    { type = "Residence", at = { 103, 84 } },
    { type = "RobotCommand", at = { 110, 89 } },
    { type = "MedicalCenter", at = { 100, 102 } },
    { type = "Nursery", at = { 94, 97 } },
    { type = "RecreationFacility", at = { 111, 80 } },
    { type = "University", at = { 115, 96 } },
    { type = "Agridome", at = { 91, 82 } },
    { type = "Agridome", at = { 95, 87 } },
    { type = "DIRT", at = { 88, 91 } },
    { type = "GuardPost", at = { 104, 121 }, weapon = "EMP" },
    { type = "GuardPost", at = { 105, 64 }, weapon = "EMP" },
    { type = "GuardPost", at = { 119, 93 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 122, 122 }, weapon = "RPG" },
    { type = "Agridome", at = { 82, 126 } },
    { type = "Agridome", at = { 108, 71 } },
    { type = "Agridome", at = { 86, 104 } },
    { type = "Agridome", at = { 41, 113 } },
    { type = "GuardPost", at = { 83, 41 }, weapon = "EMP" },
    { type = "GuardPost", at = { 106, 37 }, weapon = "RPG" },
    { type = "GuardPost", at = { 22, 80 }, weapon = "EMP" },
    { type = "GuardPost", at = { 12, 92 }, weapon = "RPG" },
    { type = "LightTower", at = { 56, 100 } },
    { type = "LightTower", at = { 56, 95 } },
    { type = "LightTower", at = { 30, 112 } },
    { type = "LightTower", at = { 63, 111 } },
    { type = "LightTower", at = { 87, 125 } },
    { type = "LightTower", at = { 115, 126 } },
    { type = "LightTower", at = { 71, 76 } },
    { type = "LightTower", at = { 87, 69 } },
    { type = "StandardLab", at = { 115, 115 } },
    { type = "LightTower", at = { 97, 69 } },
    { type = "CommonStorage", at = { 79, 97 } },
    { type = "CommonStorage", at = { 75, 97 } },
    { type = "CommonStorage", at = { 79, 91 } },
    { type = "CommonStorage", at = { 71, 97 } },
    { type = "RareStorage", at = { 99, 112 } },
    { type = "RareStorage", at = { 99, 118 } },
    { type = "RareStorage", at = { 95, 118 } },
    { type = "RareStorage", at = { 91, 118 } },
    { type = "Forum", at = { 79, 119 } },
    { type = "GuardPost", at = { 53, 117 }, weapon = "EMP" },
    { type = "GuardPost", at = { 55, 126 }, weapon = "RPG" },
    { type = "GuardPost", at = { 116, 59 }, weapon = "ESG" },
    { type = "GuardPost", at = { 63, 101 }, weapon = "EMP" },
    { type = "GuardPost", at = { 126, 121 }, weapon = "ESG" },
    { type = "GuardPost", at = { 122, 126 }, weapon = "ESG" },
    { type = "GuardPost", at = { 124, 106 }, weapon = "ESG" },
    { type = "GuardPost", at = { 124, 97 }, weapon = "ESG" },
    { type = "GuardPost", at = { 13, 118 }, weapon = "EMP" },
    { type = "GuardPost", at = { 94, 122 }, weapon = "ESG" },
    { type = "GuardPost", at = { 64, 120 }, weapon = "ESG" },
    { type = "GuardPost", at = { 63, 80 }, weapon = "ESG" },
    { type = "GuardPost", at = { 91, 100 }, weapon = "ESG" },
    { type = "GuardPost", at = { 82, 100 }, weapon = "ESG" },
    { type = "GuardPost", at = { 74, 91 }, weapon = "ESG" },
    { type = "GuardPost", at = { 112, 98 }, weapon = "RPG" },
    { type = "GuardPost", at = { 117, 111 }, weapon = "EMP" },
    { type = "GuardPost", at = { 107, 104 }, weapon = "EMP" },
  },
  [7] = {
    { type = "Garage", at = { 124, 85 } },
    { type = "Garage", at = { 124, 91 } },
    { type = "VehicleFactory", at = { 120, 77 } },
    { type = "ArachnidFactory", at = { 55, 112 } },
  },
  [8] = {
    { type = "GuardPost", at = { 43, 117 }, weapon = "EMP" },
    { type = "GuardPost", at = { 66, 92 }, weapon = "ESG" },
    { type = "GuardPost", at = { 84, 109 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 18, 116 }, weapon = "Microwave" },
    { type = "GuardPost", at = { 41, 125 }, weapon = "RPG" },
  },
  [9] = {
    { type = "GuardPost", at = { 119, 99 }, weapon = "RPG" },
  },
  [10] = {
    { type = "Scorpion", at = { 44, 43 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 42, 43 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 47, 35 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 54, 36 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 51, 38 }, weapon = "EnergyCannon" },
  },
  [11] = {
    { type = "Scorpion", at = { 6, 110 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 3, 109 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 9, 115 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 6, 105 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 4, 105 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 2, 107 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 4, 107 }, weapon = "EnergyCannon" },
  },
  [12] = {
    { type = "Scorpion", at = { 49, 73 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 58, 73 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 50, 72 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 65, 78 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 64, 81 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 62, 77 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 65, 81 }, weapon = "EnergyCannon" },
    { type = "Scorpion", at = { 63, 80 }, weapon = "EnergyCannon" },
  },
  [13] = {
    { type = "Panther", at = { 124, 81 }, weapon = "RPG" },
    { type = "Panther", at = { 126, 81 }, weapon = "ESG" },
  },
  [14] = {
    { type = "Panther", at = { 82, 94 }, weapon = "Stickyfoam" },
    { type = "Tiger", at = { 83, 96 }, weapon = "ESG" },
  },
  [15] = {
    { type = "Panther", at = { 82, 94 }, weapon = "Stickyfoam" },
    { type = "Lynx", at = { 83, 96 }, weapon = "ESG" },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_fight1, ai_fight2, ai_base1, ai_mining1, ai_mining2, ai_mining3, ai_fight3, ai_fight4, ai_fight5, ai_fight6, ai_fight7, ai_fight8

-- The four Advanced Labs (0x11005B4F): on Easy on fixed spots, else each on a different one of four spots drawn in
-- turn, redrawing a spot already taken (0x11005C3C). The first holds the Gene Bank, the second the captive
-- scientists (0x1100CB10 to 0x1100CB1C).
local LAB_SPOTS = { { 48, 123 }, { 115, 102 }, { 70, 86 }, { 122, 64 } }
local labs = {}
local function place_labs(p)
  local order = { 2, 3, 4, 1 }
  if players[1].difficulty ~= "Easy" then
    local a = game.rand(4)
    local b = game.rand(4)
    while b == a do b = game.rand(4) end
    local c = game.rand(4)
    while c == a or c == b do c = game.rand(4) end
    local d = game.rand(4)
    while d == a or d == b or d == c do d = game.rand(4) end
    order = { a + 1, b + 1, c + 1, d + 1 }
  end
  for i = 1, 4 do
    labs[i] = game.create_unit{ type = "AdvancedLab", player = p, at = LAB_SPOTS[order[i]], exact = true, lights = false }[1]
    ai_fight2:take_unit(labs[i])
  end
  for i = 1, 4 do labs[i]:set_opp_fired_upon(false) end
end

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_plymouth()
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 55, 112, 65, 122 })
  ai_fight1:add_units(ai_block(1))
  ai_fight1:add_units(ai_block(2))
  ai_fight1:set_lights(true)
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_rect()
  ai_fight2:set_rect({ 117, 59, 127, 69 })
  ai_fight2:add_units(ai_block(3))
  ai_fight2:set_lights(true)
  ai_fight2:set_targ_counts(ai_block(3))
  place_labs(p)
  ai_base1 = ai.building_group(p)
  ai_base1:add_units(ai_block(4))
  ai_base1:add_units(ai_block(5))
  ai_block(6):create_units(p, true)
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_block(7):create_units(p, true)
  elseif difficulty == "Hard" then
    ai_base1:add_units(ai_block(7))
    ai_base1:record_unit_block(ai_block(7))
  end
  ai_base1:record_unit_block(ai_block(4))
  ai_base1:record_unit_block(ai_block(6))
  ai_base1:record_unit_block(ai_block(8))
  if difficulty == "Normal" or difficulty == "Hard" then
    ai_block(9):create_units(p, true)
    ai_base1:record_unit_block(ai_block(9))
  end
  ai_base1:record_tubes_touching({ 48, 123 })
  ai_base1:set_rect({ 62, 95, 125, 123 })
  ai_base1:record_veh_reinforce_group(ai_base1, 1000)
  ai_base1:set_targ_count("ConVec", nil, 2)
  ai_base1:set_targ_count("Earthworker", nil, 1)
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_fight2, 1)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_fight2, 40)
  end
  local sf = ai_base1:first_of_type("StructureFactory")
  if sf then
    sf:set_factory_cargo(1, "Tokamak")
    sf:set_factory_cargo(2, "GuardPost", "EMP")
  end
  ai_mining1 = ai.mining_group(p)
  ai_mining1:setup({ 6, 113 }, { 33, 118 }, { 29, 112, 39, 122 })
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_mining1, 100)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_mining1, 30)
  end
  ai_mining1:set_targ_count("CargoTruck", nil, 3)
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 33, 118 }, exact = true, lights = false }[1])
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 33, 118 }, exact = true, lights = false }[1])
  ai_mining2 = ai.mining_group(p)
  ai_mining2:setup({ 51, 33 }, { 93, 109 }, { 89, 105, 99, 113 })
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_mining2, 100)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_mining2, 30)
  end
  ai_mining2:set_targ_count("CargoTruck", nil, 3)
  ai_mining2:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 33, 118 }, exact = true, lights = false }[1])
  ai_mining3 = ai.mining_group(p)
  ai_mining3:setup({ 54, 72 }, { 78, 103 }, { 70, 96, 87, 111 })
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_mining3, 100)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_mining3, 30)
  end
  ai_mining3:set_targ_count("CargoTruck", nil, 3)
  ai_mining3:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 33, 118 }, exact = true, lights = false }[1])
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 46, 27, 56, 37 })
  ai_fight3:add_units(ai_block(10))
  ai_fight3:set_lights(true)
  ai_fight3:set_targ_counts(ai_block(10))
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_fight3, 1)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_fight3, 40)
  end
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 1, 109, 11, 119 })
  ai_fight4:add_units(ai_block(11))
  ai_fight4:set_lights(true)
  ai_fight4:set_targ_counts(ai_block(11))
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_fight4, 1)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_fight4, 40)
  end
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_rect()
  ai_fight5:set_rect({ 49, 67, 59, 77 })
  ai_fight5:add_units(ai_block(12))
  ai_fight5:set_lights(true)
  ai_fight5:set_targ_counts(ai_block(12))
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_fight5, 1)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_fight5, 40)
  end
  ai_fight6 = ai.fight_group(p)
  ai_fight6:do_patrol_only()
  ai_fight6:set_patrol({ { 85, 43 }, { 97, 64 }, { 118, 65 }, { 126, 80 }, { 96, 75 } }, 3)
  ai_fight6:set_rect({ 124, 79, 127, 82 })
  ai_fight6:add_units(ai_block(13))
  ai_fight6:set_lights(true)
  ai_fight6:set_targ_counts(ai_block(13))
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_fight6, 1)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_fight6, 50)
  end
  ai_fight7 = ai.fight_group(p)
  ai_fight7:do_patrol_only()
  ai_fight7:set_patrol({ { 18, 93 }, { 23, 120 }, { 80, 119 }, { 66, 98 } }, 2)
  ai_fight7:set_rect({ 82, 94, 84, 96 })
  if difficulty == "Easy" then
    ai_fight7:add_units(ai_block(15))
    ai_fight7:set_targ_counts(ai_block(15))
    ai_base1:record_veh_reinforce_group(ai_fight7, 1)
  elseif difficulty == "Normal" then
    ai_fight7:add_units(ai_block(14))
    ai_fight7:set_targ_counts(ai_block(14))
    ai_base1:record_veh_reinforce_group(ai_fight7, 1)
  elseif difficulty == "Hard" then
    ai_fight7:add_units(ai_block(14))
    ai_fight7:set_targ_counts(ai_block(14))
    ai_base1:record_veh_reinforce_group(ai_fight7, 50)
  end
  ai_fight7:set_lights(true)
  ai_fight8 = ai.fight_group(p)
  ai_fight8:do_guard_rect()
  ai_fight8:set_rect({ 30, 112, 128, 128 })
  ai_fight8:add_guarded_rect({ 67, 68, 128, 112 })
  if difficulty == "Easy" then
    ai_fight8:add_units(ai_block(15))
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight8:add_units(ai_block(14))
  end
  ai_fight8:set_lights(true)
  ai_fight8:set_targ_count("Spider", nil, 8)
  if difficulty == "Easy" then
    ai_fight8:set_targ_count("Panther", "RPG", 6)
  elseif difficulty == "Normal" or difficulty == "Hard" then
    ai_fight8:set_targ_count("Tiger", "RPG", 6)
  end
  ai_fight8:set_targ_count("Lynx", "EMP", 4)
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_base1:record_veh_reinforce_group(ai_fight8, 1)
  elseif difficulty == "Hard" then
    ai_base1:record_veh_reinforce_group(ai_fight8, 60)
  end
  p:set_default_group(ai_fight8)
  p.ore = 100000
  p.rare_ore = 16000
  p:set_tech_level(11)
end


-- The wins CheckWin switches on (0x1100CB44: the Spaceport, 0x1100CB40: the labs) and the Scout count's failure,
-- which goes off once both labs are found (0x1100CB5C).
local t18, t20, t41
-- The special targets on the first two labs (0x1100CB30, 0x1100CB34), their markers (0x1100CB2C, 0x1100CB28), the
-- lab checks (0x1100CB38, 0x1100CB3C), how many labs are found (0x1100CB60), how many all-attacks CheckWin has made
-- (0x1100CB58), and whether the Gene Bank or the scientists are in the convoy (0x1100CAEC).
local genebank_target, hostages_target, bank_marker, guys_marker, lab_check1, lab_check2
local labs_found, attacks_made, cargo_taken = 0, 0, false
-- The convoy's Cargo Truck and Evacuation Transport (0x1100CB20, 0x1100CB24), and the research ReinforceE reads
-- (0x1100CAE4: 5508, 0x1100CAE0: 8503).
local convoy_truck, convoy_evac, has_5508, has_8503
-- The Plymouth base the attacks aim at (0x1100C3D0).
local BASE = { 62, 95, 125, 123 }
-- A message at a unit, as AddMessage(Unit, ...) posts it.
local function unit_message(u, text)
  game.message_at(text, 160, players[1], (u.x + 31) * 32 + 16, (u.y - 1) * 32 + 16)
end
-- ReinforceE's units (0x11001F40): type, weapon, row at the west edge, direction, where they drive. The first six
-- always; the last four by research: with 8503 Acid Cloud Panthers, else Rail Gun; with 5508 EMP Lynxes, else Laser.
local REINFORCE_E = {
  { "Lynx", "Laser", 53, "East", { 38, 10 } }, { "Lynx", "Laser", 55, "East", { 40, 10 } },
  { "Lynx", "Laser", 57, "East", { 42, 10 } }, { "Lynx", "Laser", 59, "East", { 41, 11 } },
  { "Tiger", "RailGun", 61, "East", { 39, 11 } }, { "Tiger", "RailGun", 63, "East", { 43, 11 } },
}
local function reinforce_e_rest()
  local lynx = has_5508 and "EMP" or "Laser"
  local panther = has_8503 and "AcidCloud" or "RailGun"
  return {
    { "Lynx", lynx, 65, "SouthEast", { 38, 12 } }, { "Lynx", lynx, 67, "West", { 40, 12 } },
    { "Panther", panther, 69, "SouthWest", { 42, 12 } }, { "Panther", panther, 71, "West", { 44, 12 } },
  }
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local AllToAttack, Storm, Tornado


function Storm(t)
  local r1 = game.rand(126)
  local r2 = game.rand(126)
  game.create_lightning({ 1, r2 + 2 }, { 127, r1 + 2 }, 12)
end

function Tornado(t)
  local r1 = game.rand(2)
  if r1 < 1 then
    local r2 = game.rand(36)
    local r3 = game.rand(26)
    game.create_tornado({ r3 + 28, 2 }, { 1, r2 + 58 }, 20)
  else
    local r2 = game.rand(26)
    local r3 = game.rand(36)
    game.create_tornado({ 1, r3 + 58 }, { r2 + 28, 2 }, 20)
  end
end

-- Every 40 ticks (0x11005790): with Plymouth's Spaceport gone its win is switched on, with all its Advanced Labs gone
-- theirs; the first time either is, every group attacks the base 875 to 1125 ticks later.
function CheckWin(t)
  if #ai_player:buildings("Spaceport") == 0 and not t18.enabled then
    t18:enable()
    if attacks_made == 0 then
      trigger.time{min = 875, max = 1125, on = AllToAttack}
      attacks_made = attacks_made + 1
    end
  end
  if #ai_player:buildings("AdvancedLab") == 0 and not t20.enabled then
    t20:enable()
    if attacks_made == 0 then
      trigger.time{min = 875, max = 1125, on = AllToAttack}
      attacks_made = attacks_made + 1
    end
  end
end

-- 400 marks in, or after CheckWin (0x11005070): the groups attack the base; the three that guard the way out only
-- while neither the Gene Bank nor the scientists are in the convoy.
function AllToAttack(t)
  for _, g in ipairs({ ai_fight1, ai_fight6, ai_fight7, ai_fight8 }) do
    g:do_attack_enemy()
    g:set_rect(BASE)
  end
  if cargo_taken then return end
  for _, g in ipairs({ ai_fight3, ai_fight4, ai_fight5 }) do
    g:do_attack_enemy()
    g:set_rect(BASE)
  end
end

-- A Scout at the first lab (0x11005950): a DNA marker on it, the Scout failure off once both labs are found, and a
-- Cargo Truck at the lab now takes the Gene Bank.
function GenebankFound(t)
  bank_marker = game.create_marker({ labs[1].x, labs[1].y }, "DNA")
  labs_found = labs_found + 1
  if labs_found >= 2 then t41:disable() end
  genebank_target:destroy()
  genebank_target = trigger.special_target{target = labs[1], type = "CargoTruck", one_shot = true, on = GenebankGone}
  unit_message(labs[1], "Data transmitted: Gene Bank located.")
end

-- A Scout at the second lab (0x110058B0): a beaker marker on it, the Scout failure off once both labs are found,
-- and an Evacuation Transport at the lab now takes the scientists.
function HostagesFound(t)
  guys_marker = game.create_marker({ labs[2].x, labs[2].y }, "Beaker")
  labs_found = labs_found + 1
  if labs_found >= 2 then t41:disable() end
  hostages_target:destroy()
  hostages_target = trigger.special_target{target = labs[2], type = "EvacuationTransport", one_shot = true, on = HostagesGone}
  unit_message(labs[2], "Data transmitted: scientists located.")
end

-- A Scout at the third lab (0x110059F0): nothing there, and the lab may now be fired upon.
function FakeLabVisit3(t)
  unit_message(labs[3], "Data transmitted: nothing at this location.")
  labs[3]:set_opp_fired_upon(true)
end

-- A Scout at the fourth lab (0x11005A20): the same.
function FakeLabVisit4(t)
  unit_message(labs[4], "Data transmitted: nothing at this location.")
  labs[4]:set_opp_fired_upon(true)
end

-- A Cargo Truck at the first lab (0x11005390): it carries the Gene Bank (while the convoy's truck lives); 200 ticks on
-- the Garages' reinforcements and the pursuit of the truck; the marker and the lab check go, and every 40 ticks the
-- truck must still have it.
function GenebankGone(t)
  game.message_at("Gene Bank Captured!", 0, nil, -1, -1)
  if convoy_truck.alive then
    genebank_target:special_target_unit():set_cargo("GeneBank", 1)
    cargo_taken = true
  end
  trigger.time{min = 200, max = 200, on = ReinforceP2}
  trigger.time{min = 200, max = 200, on = PursueTruck}
  if bank_marker then bank_marker:kill() end
  if lab_check1.valid then lab_check1:disable() end
  trigger.time{time = 40, one_shot = false, on = CheckForLostBank}
  labs[1]:set_opp_fired_upon(true)
end

-- An Evacuation Transport at the second lab (0x11005490): it carries the scientists (while the convoy's transport
-- lives); the marker and the lab check go, and every 40 ticks the transport must still have them.
function HostagesGone(t)
  game.message_at("Captives Rescued!", 0, nil, -1, -1)
  if convoy_evac.alive then
    hostages_target:special_target_unit():set_kit("Agridome")
    cargo_taken = true
  end
  if guys_marker then guys_marker:kill() end
  if lab_check2.valid then lab_check2:disable() end
  trigger.time{time = 40, one_shot = false, on = CheckForLostGuys}
  labs[2]:set_opp_fired_upon(true)
end

-- Every 40 ticks once the Gene Bank is taken (0x110052B0): the convoy's truck gone or without it fails the mission.
function CheckForLostBank(t)
  if not (convoy_truck.alive and convoy_truck.cargo == "GeneBank") then mission.failure(trigger.time{time = 1}) end
end

-- Every 40 ticks once the scientists are taken (0x11005320): the convoy's transport gone or without them fails it.
function CheckForLostGuys(t)
  if not (convoy_evac.alive and convoy_evac.kit == "Agridome") then mission.failure(trigger.time{time = 1}) end
end

-- 200 ticks after the Gene Bank is taken (0x11005540): at each Plymouth Garage a group that attacks the base, of
-- a draw of 0 to the difficulty (Easy 0, Normal 1, Hard 2) plus the difficulty pairs of EMP and ESG Lynxes.
function ReinforceP2(t)
  local level = ({ Easy = 0, Normal = 1, Hard = 2 })[players[1].difficulty] or 1
  for _, garage in ipairs(ai_player:buildings("Garage")) do
    local g = ai.fight_group(ai_player)
    g:do_attack_enemy()
    g:set_rect(BASE)
    local at = { garage.x, garage.y }
    for _ = 1, game.rand(level + 1) + level do
      g:take_unit(game.create_unit{type = "Lynx", weapon = "EMP", player = ai_player, at = at, exact = true, lights = false}[1])
      g:take_unit(game.create_unit{type = "Lynx", weapon = "ESG", player = ai_player, at = at, exact = true, lights = false}[1])
    end
    g:set_lights(true)
    g:set_delete_when_empty(true)
  end
end

-- 200 ticks after the Gene Bank is taken (0x11005120): the three groups on the way out go for the convoy's truck,
-- three others attack the base.
function PursueTruck(t)
  for _, g in ipairs({ ai_fight3, ai_fight4, ai_fight5 }) do
    g:do_attack_unit()
    g:set_target_unit(convoy_truck)
    g:set_rect(BASE)
  end
  for _, g in ipairs({ ai_fight2, ai_fight6, ai_fight7 }) do
    g:do_attack_enemy()
    g:set_rect(BASE)
  end
end

-- The player down to 15 vehicles (0x11005280, 0x11001F40): ten tanks from the west edge that drive to the convoy's
-- start, and the message.
function ReinforceE(t)
  for _, list in ipairs({ REINFORCE_E, reinforce_e_rest() }) do
    for _, r in ipairs(list) do
      local u = game.create_unit{type = r[1], weapon = r[2], player = 1, at = { 1, r[3] }, direction = r[4], exact = true}[1]
      u:move(r[5])
    end
  end
  game.message_at("Reinforcements have arrived!", 162, players[1], 1024, 1792)
end

-- Every 2400 ticks (0x11005740): Plymouth gets 2000 ore and 250 rare ore.
function GiveOre(t)
  ai_player.ore = ai_player.ore + 2000
  ai_player.rare_ore = ai_player.rare_ore + 250
end

-- Every 20 ticks until the Gene Bank is taken (0x11005680): the first lab destroyed fails the mission.
function Lab1Dead(t)
  if not labs[1].alive then mission.failure(trigger.time{time = 1}) end
end

-- Every 20 ticks until the scientists are taken (0x110056E0): the second lab destroyed fails the mission.
function Lab2Dead(t)
  if not labs[2].alive then mission.failure(trigger.time{time = 1}) end
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  has_5508, has_8503 = players[1]:has_tech(5508), players[1]:has_tech(8503)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  convoy_truck = players[1]:units("CargoTruck")[1]
  convoy_evac = players[1]:units("EvacuationTransport")[1]
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.set_cell_type({ 116, 85 }, 5)
  game.set_cell_type({ 117, 85 }, 5)
  game.set_cell_type({ 114, 86 }, 5)
  game.set_cell_type({ 115, 86 }, 5)
  game.set_cell_type({ 116, 86 }, 5)
  game.set_cell_type({ 117, 86 }, 5)
  game.set_cell_type({ 105, 111 }, 5)
  game.set_cell_type({ 105, 113 }, 5)
  game.set_cell_type({ 108, 113 }, 5)
  game.set_cell_type({ 109, 113 }, 5)
  game.set_daylight_everywhere(difficulty == "Easy")
  game.set_daylight_moves(false)

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  trigger.time{time = 40, one_shot = false, on = CheckWin}  -- after 0 marks

  -- The win.
  t18 = trigger.time{time = 1, enabled = false}
  mission.victory(t18, "Destroy the Spaceport.", {one_shot = true})
  t20 = trigger.time{time = 1, enabled = false}
  mission.victory(t20, "Destroy all Advanced Labs.", {one_shot = true})
  local t22 = trigger.escape{at = { x = 66, y = 4, raw = true }, width = 10, height = 10, type = "CargoTruck", count = 1, cargo = 10, amount = -1, one_shot = true}
  mission.victory(t22, "Return the Gene Bank to the convoy starting location.", {one_shot = true})
  local t24 = trigger.escape{at = { x = 66, y = 4, raw = true }, width = 10, height = 10, type = "EvacuationTransport", count = 1, cargo = 39, amount = -1, one_shot = true}
  mission.victory(t24, "Return the captive scientists to the convoy starting location.", {one_shot = true})
  genebank_target = trigger.special_target{target = labs[1], type = "Scout", one_shot = true, on = GenebankFound}
  hostages_target = trigger.special_target{target = labs[2], type = "Scout", one_shot = true, on = HostagesFound}
  trigger.special_target{target = labs[3], type = "Scout", one_shot = true, on = FakeLabVisit3}
  trigger.special_target{target = labs[4], type = "Scout", one_shot = true, on = FakeLabVisit4}
  local t37 = trigger.count{type = "CargoTruck", compare = "<", count = 1, player = 1}
  mission.failure(t37)
  local t39 = trigger.count{type = "EvacuationTransport", compare = "<", count = 1, player = 1}
  mission.failure(t39)
  t41 = trigger.count{type = "Scout", compare = "<", count = 1, player = 1, one_shot = true}
  mission.failure(t41)
  game.create_marker({ 40, 10 })
  trigger.time{min = 7200, max = 15600, one_shot = false, on = Tornado}  -- after 72 to 156 marks
  trigger.time{min = 8000, max = 10000, one_shot = false, on = Storm}  -- after 80 to 100 marks
  trigger.vehicle_count{compare = "<", count = 16, player = 1, one_shot = true, on = ReinforceE}
  trigger.time{min = 2400, max = 2400, one_shot = false, on = GiveOre}  -- after 24 to 24 marks
  trigger.time{min = 40000, max = 40000, on = AllToAttack}  -- after 400 to 400 marks
  lab_check1 = trigger.time{time = 20, one_shot = false, on = Lab1Dead}  -- after 0 marks
  lab_check2 = trigger.time{time = 20, one_shot = false, on = Lab2Dead}  -- after 0 marks
end

-- Not converted:
-- - Easy: units are made other ways than CreateUnit (175 on the map, 29 made)
-- - Normal: units are made other ways than CreateUnit (174 on the map, 27 made)
-- - Hard: units are made other ways than CreateUnit (174 on the map, 27 made)
