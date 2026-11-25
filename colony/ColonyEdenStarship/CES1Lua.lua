-- CES1Lua.lua  -  Colony Builder - Eden, Starship (Lua)
-- Trigger functions finished by hand (CheckForFail, DoMeteor, DoQuake, DoLightning, DoTornado, Base2CommonCheck, ExpandBase1_B, Base2RareCheck, SpawnAttack, StageDone, Base3CommonCheck, Base3RareCheck, ExitMapMultiple, ExpandBase1_C, GiveAIOre, LavaSpeedup, ReleaseMorale), from the disassembly of CES1.dll.
-- Converted by op2dll from CES1.dll. With CES1Lua.placement.lua (what every difficulty makes alike),
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
        workers = 28, scientists = 13, kids = 15, food = 3000, ore = 5000,
        research = {  },
        view = { 29, 211 },
        units = {
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
    made = {
      { type = "CommandCenter", player = 1, at = { 29, 211 } },
      { type = "Agridome", player = 1, at = { 24, 203 } },
      { type = "StructureFactory", player = 1, at = { 19, 213 } },
      { type = "CommonOreSmelter", player = 1, at = { 16, 201 } },
      { type = "Tokamak", player = 1, at = { 9, 209 } },
      { type = "StandardLab", player = 1, at = { 24, 211 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 20, 202 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 20, 204 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 18, 204 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 31, 208 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 33, 208 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 13, 208 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 13, 210 } },
      { type = "RoboDozer", direction = "NorthEast", player = 1, at = { 22, 215 } },
      { type = "Earthworker", direction = "SouthEast", player = 1, at = { 20, 209 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 3, 191 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 6, 219 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 85, 160 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 86, 206 }, beacon = true },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 26, scientists = 13, kids = 15, food = 2000, ore = 4000,
        research = {  },
        view = { 29, 211 },
        units = {
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
    made = {
      { type = "CommandCenter", player = 1, at = { 29, 211 } },
      { type = "Agridome", player = 1, at = { 24, 203 } },
      { type = "StructureFactory", player = 1, at = { 19, 213 } },
      { type = "CommonOreSmelter", player = 1, at = { 16, 201 } },
      { type = "Tokamak", player = 1, at = { 9, 209 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 20, 202 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 20, 204 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 18, 204 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 31, 208 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 33, 208 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 13, 208 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 13, 210 } },
      { type = "RoboDozer", direction = "NorthEast", player = 1, at = { 22, 215 } },
      { type = "Earthworker", direction = "SouthEast", player = 1, at = { 20, 209 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 3, 191 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 6, 219 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 85, 160 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 86, 206 }, beacon = true },
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 23, scientists = 13, kids = 15, food = 1000, ore = 3000,
        research = {  },
        view = { 29, 211 },
        units = {
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
    made = {
      { type = "CommandCenter", player = 1, at = { 29, 211 } },
      { type = "Agridome", player = 1, at = { 24, 203 } },
      { type = "StructureFactory", player = 1, at = { 19, 213 } },
      { type = "CommonOreSmelter", player = 1, at = { 16, 201 } },
      { type = "Tokamak", player = 1, at = { 9, 209 } },
      { type = "CargoTruck", direction = "North", player = 1, at = { 20, 202 } },
      { type = "CargoTruck", direction = "SouthEast", player = 1, at = { 20, 204 } },
      { type = "CargoTruck", direction = "South", player = 1, at = { 18, 204 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 31, 208 } },
      { type = "ConVec", direction = "SouthWest", player = 1, at = { 33, 208 } },
      { type = "RoboSurveyor", direction = "West", player = 1, at = { 13, 208 } },
      { type = "RoboMiner", direction = "NorthWest", player = 1, at = { 13, 210 } },
      { type = "RoboDozer", direction = "NorthEast", player = 1, at = { 22, 215 } },
      { type = "Earthworker", direction = "SouthEast", player = 1, at = { 20, 209 } },
      { type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 3, 191 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Bar1", variant = "Random", at = { 6, 219 }, beacon = true },
      { type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 85, 160 }, beacon = true },
      { type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 86, 206 }, beacon = true },
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
    { type = "Tokamak", at = { 166, 163 } },
    { type = "CommandCenter", at = { 173, 158 } },
    { type = "Agridome", at = { 173, 153 } },
    { type = "Residence", at = { 173, 148 } },
  },
  [2] = {
    { type = "StructureFactory", at = { 180, 157 } },
    { type = "VehicleFactory", at = { 180, 151 } },
    { type = "CommonOreMine", at = { 159, 173 } },
    { type = "CommonOreSmelter", at = { 165, 157 } },
  },
}
local ai_blocks = {}
local function ai_block(i)
  ai_blocks[i] = ai_blocks[i] or ai.unit_block(AI_UNITS[i])
  return ai_blocks[i]
end
local ai_player, ai_base1, ai_mining1, ai_base2, ai_base3, ai_fight1, ai_fight2, ai_fight3, ai_fight4, ai_fight5, ai_fight6, ai_fight7, ai_fight8, ai_mining2_hard
local TimeUpgrades_step = 0

local function setup_ai(p)
  ai_player = p
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  p:go_plymouth()
  p.ore = 10000
  ai_block(1):create_units(p, false)
  ai_base1 = ai.building_group(p)
  ai_base1:set_rect({ 166, 139, 181, 160 })
  ai_base1:add_units(ai_block(2))
  ai_base1:record_unit_block(ai_block(2), ai_base1)
  ai_base1:record_unit_block(ai_block(1))
  ai_base1:record_veh_reinforce_group(ai_base1, 1000)
  ai_base1:set_targ_count("ConVec", nil, 2)
  ai_base1:set_targ_count("Spider", nil, 4)
  ai_base1:set_targ_count("Earthworker", nil, 1)
  ai_base1:record_tubes_touching({ 173, 158 })
  ai_base1:take_unit(game.create_unit{ type = "ConVec", player = p, at = { 173, 150 }, exact = true, lights = false }[1])
  ai_mining1 = ai.mining_group(p)
  ai_mining1:setup({ 158, 173 }, { 166, 158 }, "CommonOreMine", "CommonOreSmelter", { 161, 154, 169, 161 })
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 163, 160 }, exact = true, lights = false }[1])
  ai_mining1:take_unit(game.create_unit{ type = "CargoTruck", player = p, at = { 163, 160 }, exact = true, lights = false }[1])
  if difficulty == "Easy" or difficulty == "Normal" then
    ai_mining1:set_targ_count("CargoTruck", nil, 5)
  elseif difficulty == "Hard" then
    ai_mining1:set_targ_count("CargoTruck", nil, 4)
  end
  ai_base1:record_veh_reinforce_group(ai_mining1, 100)
  if difficulty == "Hard" then
    ai_base1:record_building({ 154, 172 }, "CommonOreSmelter")
    ai_mining2_hard = ai.mining_group(p)
    ai_mining2_hard:setup({ 158, 173 }, { 155, 173 }, "CommonOreMine", "CommonOreSmelter", { 161, 154, 169, 161 })
    ai_mining2_hard:set_targ_count("CargoTruck", nil, 2)
    ai_base1:record_veh_reinforce_group(ai_mining2_hard, 100)
    ai_base1:record_tube({ 153, 160 })
    ai_base1:record_tube({ 152, 160 })
    ai_base1:record_tube({ 152, 161 })
    ai_base1:record_tube({ 152, 162 })
    ai_base1:record_tube({ 152, 163 })
    ai_base1:record_tube({ 152, 164 })
    ai_base1:record_tube({ 152, 165 })
    ai_base1:record_tube({ 152, 166 })
    ai_base1:record_tube({ 152, 167 })
    ai_base1:record_tube({ 152, 168 })
    ai_base1:record_tube({ 152, 169 })
    ai_base1:record_tube({ 152, 170 })
    ai_base1:record_tube({ 153, 159 })
    ai_base1:record_tube({ 154, 159 })
    ai_base1:record_tube({ 155, 159 })
    ai_base1:record_tube({ 156, 159 })
    ai_base1:record_tube({ 157, 159 })
    ai_base1:record_tube({ 158, 159 })
    ai_base1:record_tube({ 159, 159 })
    ai_base1:record_tube({ 160, 159 })
    ai_base1:record_tube({ 161, 159 })
    ai_base1:record_tube({ 162, 159 })
    ai_base1:record_tube({ 163, 159 })
  end
  p:set_tech_level(3)
  ai_base2 = ai.building_group(p)
  ai_base2:set_rect({ 166, 139, 181, 160 })
  ai_base2:record_veh_reinforce_group(ai_base2, 1000)
  ai_base2:set_targ_count("ConVec", nil, 2)
  ai_base2:set_targ_count("Spider", nil, 4)
  ai_base2:set_targ_count("Earthworker", nil, 1)
  ai_base2:take_unit(game.create_unit{ type = "ConVec", player = p, at = { 173, 150 }, weapon = "CommandCenter", exact = true, lights = false }[1])
  ai_base2:take_unit(game.create_unit{ type = "ConVec", player = p, at = { 179, 150 }, weapon = "StructureFactory", exact = true, lights = false }[1])
  ai_base3 = ai.building_group(p)
  ai_base3:set_rect({ 166, 139, 181, 160 })
  ai_base3:record_veh_reinforce_group(ai_base3, 1000)
  ai_base3:set_targ_count("ConVec", nil, 2)
  ai_base3:set_targ_count("Spider", nil, 4)
  ai_base3:set_targ_count("Earthworker", nil, 1)
  ai_base3:take_unit(game.create_unit{ type = "ConVec", player = p, at = { 177, 146 }, weapon = "CommandCenter", exact = true, lights = false }[1])
  ai_base3:take_unit(game.create_unit{ type = "ConVec", player = p, at = { 179, 150 }, weapon = "StructureFactory", exact = true, lights = false }[1])
  ai_base1:record_building({ 178, 146 }, "StandardLab")
  ai_base1:record_building({ 186, 152 }, "Nursery")
  ai_base1:record_building({ 173, 142 }, "University")
  ai_base1:record_building({ 168, 148 }, "Residence")
  ai_base1:record_building({ 186, 157 }, "Agridome")
  ai_base1:record_building({ 195, 154 }, "Tokamak")
  ai_base1:record_building({ 169, 158 }, "CommonStorage")
  ai_base1:record_building({ 189, 162 }, "AdvancedLab")
  ai_base1:record_building({ 168, 152 }, "DIRT")
  ai_base1:record_building({ 178, 142 }, "MedicalCenter")
  ai_base1:record_tube({ 178, 149 })
  ai_base1:record_tube({ 178, 148 })
  ai_base1:record_tube({ 183, 151 })
  ai_base1:record_tube({ 184, 151 })
  ai_base1:record_tube({ 173, 146 })
  ai_base1:record_tube({ 173, 145 })
  ai_base1:record_tube({ 173, 144 })
  ai_base1:record_tube({ 171, 148 })
  ai_base1:record_tube({ 170, 148 })
  ai_base1:record_tube({ 183, 157 })
  ai_base1:record_tube({ 184, 157 })
  ai_base1:record_tube({ 189, 157 })
  ai_base1:record_tube({ 189, 158 })
  ai_base1:record_tube({ 189, 159 })
  ai_base1:record_tube({ 189, 160 })
  ai_base1:record_tube({ 171, 152 })
  ai_base1:record_tube({ 168, 150 })
  ai_base1:record_tube({ 178, 144 })
  ai_base1:record_tube({ 175, 142 })
  ai_base1:record_tube({ 176, 142 })
  ai_base1:record_wall({ 147, 162 })
  ai_base1:record_wall({ 147, 163 })
  ai_base1:record_wall({ 147, 168 })
  ai_base1:record_wall({ 147, 169 })
  ai_base1:record_wall({ 147, 170 })
  ai_base1:record_wall({ 147, 171 })
  ai_base1:record_wall({ 147, 172 })
  ai_base1:record_wall({ 147, 173 })
  ai_base1:record_wall({ 147, 174 })
  ai_base1:record_wall({ 147, 175 })
  ai_base1:record_wall({ 147, 176 })
  ai_base1:record_wall({ 147, 177 })
  ai_base1:record_wall({ 148, 177 })
  ai_base1:record_wall({ 149, 177 })
  ai_base1:record_wall({ 150, 177 })
  ai_base1:record_wall({ 151, 177 })
  ai_base1:record_wall({ 152, 177 })
  ai_base1:record_wall({ 153, 177 })
  ai_base1:record_wall({ 154, 177 })
  ai_base1:record_wall({ 155, 177 })
  ai_base1:record_wall({ 156, 177 })
  ai_base1:record_wall({ 157, 177 })
  ai_base1:record_wall({ 158, 177 })
  ai_base1:record_wall({ 159, 177 })
  ai_base1:record_wall({ 160, 177 })
  ai_base1:record_wall({ 161, 177 })
  ai_base1:record_wall({ 162, 171 })
  ai_base1:record_wall({ 162, 172 })
  ai_base1:record_wall({ 162, 173 })
  ai_base1:record_wall({ 162, 174 })
  ai_base1:record_wall({ 162, 175 })
  ai_base1:record_wall({ 162, 176 })
  ai_base1:record_wall({ 162, 177 })
  ai_base1:record_wall({ 155, 152 })
  ai_base1:record_wall({ 156, 152 })
  ai_base1:record_wall({ 157, 152 })
  ai_base1:record_wall({ 158, 152 })
  ai_base1:record_wall({ 159, 152 })
  ai_base1:record_wall({ 160, 152 })
  ai_base1:record_wall({ 161, 152 })
  ai_base1:record_wall({ 162, 152 })
  ai_base1:record_wall({ 162, 169 })
  ai_base1:record_wall({ 162, 170 })
  ai_base1:record_wall({ 164, 139 })
  ai_base1:record_wall({ 164, 140 })
  ai_base1:record_wall({ 164, 141 })
  ai_base1:record_wall({ 164, 142 })
  ai_base1:record_wall({ 164, 143 })
  ai_base1:record_wall({ 164, 144 })
  ai_base1:record_wall({ 164, 145 })
  ai_base1:record_wall({ 164, 146 })
  ai_base1:record_wall({ 164, 147 })
  ai_base1:record_wall({ 164, 148 })
  ai_base1:record_wall({ 165, 139 })
  ai_base1:record_wall({ 166, 139 })
  ai_base1:record_wall({ 167, 139 })
  ai_base1:record_wall({ 168, 139 })
  ai_base1:record_wall({ 169, 139 })
  ai_base1:record_wall({ 170, 139 })
  ai_fight1 = ai.fight_group(p)
  ai_fight1:do_guard_rect()
  ai_fight1:set_rect({ 136, 142, 178, 160 })
  ai_fight1:clear_guarded_rects()
  ai_fight1:add_guarded_rect({ 160, 137, 193, 164 })
  ai_fight1:add_guarded_rect({ 142, 167, 165, 179 })
  ai_fight1:set_targ_count("Lynx", "Microwave", 5)
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 136, 142, 178, 160 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 136, 142, 178, 160 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 136, 142, 178, 160 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight1:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 136, 142, 178, 160 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_base1:record_veh_reinforce_group(ai_fight1, 10)
  ai_fight2 = ai.fight_group(p)
  ai_fight2:do_guard_group()
  ai_fight2:set_target_group(ai_fight1)
  ai_fight2:set_rect({ 136, 142, 178, 160 })
  ai_fight2:set_targ_count("Lynx", "Microwave", 0)
  ai_base1:record_veh_reinforce_group(ai_fight2, 7)
  ai_fight3 = ai.fight_group(p)
  ai_fight3:do_guard_rect()
  ai_fight3:set_rect({ 151, 179, 203, 222 })
  ai_fight3:clear_guarded_rects()
  ai_fight3:add_guarded_rect({ 143, 177, 216, 253 })
  ai_fight3:add_guarded_rect({ 195, 145, 214, 170 })
  ai_fight3:set_targ_count("Lynx", "Microwave", 3)
  ai_base1:record_veh_reinforce_group(ai_fight3, 8)
  ai_fight3:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 151, 179, 203, 222 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight3:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 151, 179, 203, 222 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight4 = ai.fight_group(p)
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 2, 68, 119, 111 })
  ai_fight4:clear_guarded_rects()
  ai_fight4:add_guarded_rect({ 0, 2, 146, 124 })
  ai_fight4:set_targ_count("Lynx", "Microwave", 5)
  ai_fight4:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 2, 68, 119, 111 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight4:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 2, 68, 119, 111 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight4:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 2, 68, 119, 111 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight4:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 2, 68, 119, 111 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_base1:record_veh_reinforce_group(ai_fight4, 1)
  ai_fight5 = ai.fight_group(p)
  ai_fight5:do_guard_group()
  ai_fight5:set_target_group(ai_fight4)
  ai_fight5:set_rect({ 8, 19, 23, 36 })
  ai_fight5:set_targ_count("Lynx", "Microwave", 0)
  ai_fight6 = ai.fight_group(p)
  ai_fight6:do_guard_rect()
  ai_fight6:set_rect({ 205, 4, 256, 154 })
  ai_fight6:clear_guarded_rects()
  ai_fight6:add_guarded_rect({ 189, 4, 256, 154 })
  ai_fight6:set_targ_count("Lynx", "Microwave", 5)
  ai_fight6:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 205, 4, 256, 154 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight6:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 205, 4, 256, 154 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_fight6:take_unit(game.create_unit{ type = "Lynx", player = p, at = game.rand_point({ 205, 4, 256, 154 }), weapon = "Microwave", exact = true, lights = false }[1])
  ai_base1:record_veh_reinforce_group(ai_fight6, 1)
  ai_fight7 = ai.fight_group(p)
  ai_fight7:do_guard_group()
  ai_fight7:set_target_group(ai_fight6)
  ai_fight7:set_rect({ 223, 71, 236, 90 })
  ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  ai_fight8 = ai.fight_group(p)
  ai_fight8:do_patrol_only()
  ai_fight8:set_patrol({ { 244, 95 }, { 157, 242 }, { 8, 235 }, { 63, 171 }, { 15, 12 }, { 162, 24 }, { 237, 226 } }, 6)
  ai_fight8:set_rect({ 143, 123, 193, 165 })
  ai_fight8:take_unit(game.create_unit{ type = "Scout", player = p, at = { 176, 189 }, exact = true, lights = false }[1])
  ai_fight8:take_unit(game.create_unit{ type = "Scout", player = p, at = { 186, 145 }, exact = true, lights = false }[1])
  ai_fight8:take_unit(game.create_unit{ type = "Scout", player = p, at = { 190, 251 }, exact = true, lights = false }[1])
end

-- Not converted (the list at the end says why); their triggers are made as the original makes them.
function TraceOre(t) end


-- The win's Common Metals and Rare Metals evacuations (the setup's triggers 14 and 16, kept at 0x1101841C and
-- 0x11018420): once one has been met, CheckForFail no longer asks for that ore.
local t14, t16
-- Where CES1's disasters don't strike (game tiles, 0x11018228, 0x110184F0, 0x110183D0), and before tick 20000 not
-- in the last either (0x110184D0).
local CALM = { { 174, 122, 224, 164 }, { 31, 1, 69, 53 }, { 247, 55, 287, 101 } }
local CALM_EARLY = { 32, 193, 62, 229 }
-- Base 1's expansion trigger (0x11018440: ExpandBase1_A's, then B's, then C's) and whether ExpandBase1_B has run
-- (0x11018444); base 2's and base 3's mining groups (0x11018454, 0x1101846C); how many of the computer's outer
-- bases have a smelter (0x11018490, which SpawnAttack's waves grow with).
local expand_trigger, expand_b_done, base2_mining, base3_mining, bases_up = nil, false, nil, nil, 0
-- The trigger of the computer's first move (0x11018488).
local attack_trigger
-- SpawnAttack's areas (0x11013000; status-bar tiles): where player 1's buildings are counted, where the wave gathers
-- and how long it gathers; the last when no area has more than 2 of them.
local ATTACK_AREAS = {
  { area = { 119, 106, 215, 253 }, rally = { 164, 181, 184, 201 }, wait = 3000 },
  { area = { 1, 2, 118, 129 }, rally = { 91, 73, 105, 85 }, wait = 5600 },
  { area = { 119, 3, 256, 105 }, rally = { 130, 62, 147, 70 }, wait = 4000 },
  { area = { 216, 106, 256, 237 }, rally = { 239, 163, 256, 179 }, wait = 6100 },
  { area = { 1, 106, 118, 191 }, rally = { 61, 134, 81, 144 }, wait = 5000 },
  { area = { 77, 192, 118, 233 }, rally = { 90, 200, 105, 211 }, wait = 6000 },
  { area = { 1, 192, 76, 233 }, rally = { 59, 211, 69, 231 }, wait = 7000 },
}
-- The buildings a wave goes for, the first seen of these in its area (0x11013100); none if it saw none.
local ATTACK_TYPES = { "CommandCenter", "StructureFactory", "VehicleFactory", "GuardPost", "None" }
-- Where an escort waits once its wave has gone (0x110181D8), and the time between waves by difficulty (0x110184A8).
local ESCORT_HOME = { 166, 139, 181, 160 }
local WAVE_PERIOD = { Easy = 10000, Normal = 14000, Hard = 12000 }
-- The wave (0x1101847C), its escort (0x11018480) and from the sixth wave fight group 3 too (0x11018484); how many
-- waves (0x1101848C), and the last one's area and target (0x11018498, 0x1101849C).
local wave_group, wave_escort, wave_attack, waves, wave_area, wave_target = nil, nil, nil, 0, nil, nil
-- What GiveAIOre gives player 2 by difficulty (0x11013118, 0x11013128).
local AI_ORE = { Easy = 1000, Normal = 2000, Hard = 3000 }
local AI_RARE_ORE = { Easy = 100, Normal = 300, Hard = 500 }

local function in_rect(x, y, r) return x >= r[1] and x <= r[3] and y >= r[2] and y <= r[4] end
-- A tile drawn anywhere (x and y 32 to 287, game tiles), again while it falls in a calm area. A y past 255 is off
-- the map: the game's own tile is passed unconverted, as the DLL passes it (a meteor there falls at the bottom edge).
local function wild_tile()
  local x, y
  repeat
    x, y = game.rand(256) + 32, game.rand(256) + 32
    local calm = in_rect(x, y, CALM[1]) or in_rect(x, y, CALM[2]) or in_rect(x, y, CALM[3])
        or (game.tick() < 20000 and in_rect(x, y, CALM_EARLY))
  until not calm
  return { x = x, y = y, raw = true }
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Base2CommonCheck, Base3CommonCheck, ExpandBase1_A, Lava1_Flow, Lava1_Vent, Lava2_Flow, Lava2_Vent, Lava3_Flow, Lava3_Vent, Lava4_Flow, Lava4_Vent, SetupBase2, SetupBase3, TimeUpgrades

function Base2CommonCheck(t)
end

function Base3CommonCheck(t)
end

function ExpandBase1_A(t)
  if players[1].difficulty == "Easy" then
    t:destroy()
    expand_trigger = trigger.time{min = 20000, max = 30000, on = ExpandBase1_B}
    local mining1 = ai.mining_group(ai_player)
    mining1:setup({ 185, 135 }, { 168, 136 }, "RareOreMine", "RareOreSmelter", { 167, 132, 176, 138 })
    mining1:set_targ_count("CargoTruck", nil, 5)
    ai_base1:record_veh_reinforce_group(mining1, 100)
    ai_base1:record_building({ 170, 135 }, "RareOreSmelter")
    ai_base1:record_building({ 181, 140 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 166, 141 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 154, 164 }, "Tokamak")
    ai_base1:record_building({ 160, 149 }, "RecreationFacility")
    ai_base1:record_building({ 156, 149 }, "Residence")
    ai_base1:record_building({ 155, 145 }, "Agridome")
    ai_base1:record_building({ 160, 145 }, "GORF")
    ai_base1:record_building({ 148, 165 }, "GuardPost", "EMP")
    ai_base1:record_building({ 186, 135 }, "RareOreMine")
    ai_base1:record_building({ 150, 172 }, "Tokamak")
    ai_base1:record_building({ 170, 142 }, "CommonStorage")
    ai_base1:record_building({ 170, 145 }, "RareStorage")
    ai_base1:record_building({ 151, 145 }, "ArachnidFactory", nil, ai_base1)
    ai_base1:record_building({ 155, 175 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 150, 148 }, "GuardPost", "EMP")
    ai_base1:record_building({ 183, 131 }, "GuardPost", "EMP")
    ai_base1:record_building({ 167, 126 }, "GuardPost", "EMP")
    ai_base1:record_building({ 175, 148 }, "GuardPost", "EMP")
    ai_base1:record_building({ 164, 151 }, "GuardPost", "EMP")
    ai_base1:record_tube({ 166, 151 })
    ai_base1:record_tube({ 166, 150 })
    ai_base1:record_tube({ 165, 150 })
    ai_base1:record_tube({ 164, 150 })
    ai_base1:record_tube({ 163, 150 })
    ai_base1:record_tube({ 162, 150 })
    ai_base1:record_tube({ 161, 150 })
    ai_base1:record_tube({ 158, 149 })
    ai_base1:record_tube({ 155, 147 })
    ai_base1:record_tube({ 160, 147 })
    ai_base1:record_tube({ 173, 140 })
    ai_base1:record_tube({ 173, 139 })
    ai_base1:record_tube({ 173, 138 })
    ai_base1:record_tube({ 172, 138 })
    ai_base1:record_tube({ 171, 138 })
    ai_base1:record_tube({ 170, 138 })
    ai_base1:record_tube({ 153, 145 })
    ai_base1:record_tube({ 151, 147 })
    ai_base1:record_tube({ 180, 141 })
    ai_base1:record_tube({ 180, 142 })
    ai_base1:record_tube({ 182, 139 })
    ai_base1:record_tube({ 182, 138 })
    ai_base1:record_tube({ 182, 137 })
    ai_base1:record_tube({ 182, 136 })
    ai_base1:record_tube({ 182, 135 })
    ai_base1:record_tube({ 182, 134 })
    ai_base1:record_tube({ 182, 133 })
    ai_base1:record_tube({ 182, 132 })
    ai_base1:record_wall({ 148, 141 })
    ai_base1:record_wall({ 148, 142 })
    ai_base1:record_wall({ 148, 143 })
    ai_base1:record_wall({ 148, 144 })
    ai_base1:record_wall({ 148, 145 })
    ai_base1:record_wall({ 149, 141 })
    ai_base1:record_wall({ 150, 141 })
    ai_base1:record_wall({ 151, 141 })
    ai_base1:record_wall({ 152, 141 })
    ai_base1:record_wall({ 153, 141 })
    ai_base1:record_wall({ 154, 141 })
    ai_base1:record_wall({ 155, 141 })
    ai_base1:record_wall({ 156, 141 })
    ai_base1:record_wall({ 157, 141 })
    ai_base1:record_wall({ 158, 141 })
    ai_base1:record_wall({ 159, 141 })
    ai_base1:record_wall({ 160, 141 })
    ai_base1:record_wall({ 161, 141 })
    ai_base1:record_wall({ 165, 124 })
    ai_base1:record_wall({ 165, 125 })
    ai_base1:record_wall({ 165, 126 })
    ai_base1:record_wall({ 165, 127 })
    ai_base1:record_wall({ 165, 131 })
    ai_base1:record_wall({ 165, 132 })
    ai_base1:record_wall({ 165, 133 })
    ai_base1:record_wall({ 165, 134 })
    ai_base1:record_wall({ 165, 135 })
    ai_base1:record_wall({ 165, 136 })
    ai_base1:record_wall({ 165, 137 })
    ai_base1:record_wall({ 166, 124 })
    ai_base1:record_wall({ 167, 124 })
    ai_base1:record_wall({ 181, 129 })
    ai_base1:record_wall({ 181, 130 })
    ai_base1:record_wall({ 182, 129 })
    ai_base1:record_wall({ 183, 141 })
    ai_base1:record_wall({ 184, 129 })
    ai_base1:record_wall({ 184, 141 })
    ai_base1:record_wall({ 185, 129 })
    ai_base1:record_wall({ 186, 129 })
    ai_base1:record_wall({ 186, 141 })
    ai_base1:record_wall({ 187, 129 })
    ai_base1:record_wall({ 187, 141 })
    ai_base1:record_wall({ 188, 132 })
    ai_base1:record_wall({ 188, 133 })
    ai_base1:record_wall({ 188, 134 })
    ai_base1:record_wall({ 188, 135 })
    ai_base1:record_wall({ 188, 136 })
    ai_base1:record_wall({ 188, 137 })
    ai_base1:record_wall({ 188, 138 })
    ai_base1:record_wall({ 188, 139 })
    ai_base1:record_wall({ 188, 140 })
    ai_base1:record_wall({ 188, 141 })
    ai_base1:record_tube({ 167, 134 })
    ai_base1:record_tube({ 167, 133 })
    ai_base1:record_tube({ 167, 132 })
    ai_base1:record_tube({ 167, 131 })
    ai_base1:record_tube({ 167, 130 })
    ai_base1:record_tube({ 167, 129 })
    ai_base1:record_tube({ 167, 128 })
    ai_base1:record_tube({ 150, 165 })
    ai_base1:record_tube({ 151, 165 })
    ai_base1:record_tube({ 153, 160 })
    ai_base1:record_tube({ 152, 160 })
    ai_base1:record_tube({ 152, 161 })
    ai_base1:record_tube({ 152, 162 })
    ai_base1:record_tube({ 152, 163 })
    ai_base1:record_tube({ 152, 164 })
    ai_base1:record_tube({ 152, 165 })
    ai_base1:record_tube({ 153, 159 })
    ai_base1:record_tube({ 154, 159 })
    ai_base1:record_tube({ 155, 159 })
    ai_base1:record_tube({ 156, 159 })
    ai_base1:record_tube({ 157, 159 })
    ai_base1:record_tube({ 158, 159 })
    ai_base1:record_tube({ 159, 159 })
    ai_base1:record_tube({ 160, 159 })
    ai_base1:record_tube({ 161, 159 })
    ai_base1:record_tube({ 162, 159 })
    ai_base1:record_tube({ 163, 159 })
  elseif players[1].difficulty == "Normal" then
    t:destroy()
    expand_trigger = trigger.time{min = 20000, max = 30000, on = ExpandBase1_B}
    local mining1 = ai.mining_group(ai_player)
    mining1:setup({ 185, 135 }, { 168, 136 }, "RareOreMine", "RareOreSmelter", { 167, 132, 176, 138 })
    mining1:set_targ_count("CargoTruck", nil, 5)
    ai_base1:record_veh_reinforce_group(mining1, 100)
    ai_base1:record_building({ 170, 135 }, "RareOreSmelter")
    ai_base1:record_building({ 181, 140 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 166, 141 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 154, 164 }, "Tokamak")
    ai_base1:record_building({ 160, 149 }, "RecreationFacility")
    ai_base1:record_building({ 156, 149 }, "Residence")
    ai_base1:record_building({ 155, 145 }, "Agridome")
    ai_base1:record_building({ 160, 145 }, "GORF")
    ai_base1:record_building({ 148, 165 }, "GuardPost", "EMP")
    ai_base1:record_building({ 186, 135 }, "RareOreMine")
    ai_base1:record_building({ 150, 172 }, "Tokamak")
    ai_base1:record_building({ 170, 142 }, "CommonStorage")
    ai_base1:record_building({ 170, 145 }, "RareStorage")
    ai_base1:record_building({ 151, 145 }, "ArachnidFactory", nil, ai_base1)
    ai_base1:record_building({ 155, 175 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 150, 148 }, "GuardPost", "EMP")
    ai_base1:record_building({ 183, 131 }, "GuardPost", "EMP")
    ai_base1:record_building({ 167, 126 }, "GuardPost", "EMP")
    ai_base1:record_building({ 175, 148 }, "GuardPost", "EMP")
    ai_base1:record_building({ 164, 151 }, "GuardPost", "EMP")
    ai_base1:record_tube({ 166, 151 })
    ai_base1:record_tube({ 166, 150 })
    ai_base1:record_tube({ 165, 150 })
    ai_base1:record_tube({ 164, 150 })
    ai_base1:record_tube({ 163, 150 })
    ai_base1:record_tube({ 162, 150 })
    ai_base1:record_tube({ 161, 150 })
    ai_base1:record_tube({ 158, 149 })
    ai_base1:record_tube({ 155, 147 })
    ai_base1:record_tube({ 160, 147 })
    ai_base1:record_tube({ 173, 140 })
    ai_base1:record_tube({ 173, 139 })
    ai_base1:record_tube({ 173, 138 })
    ai_base1:record_tube({ 172, 138 })
    ai_base1:record_tube({ 171, 138 })
    ai_base1:record_tube({ 170, 138 })
    ai_base1:record_tube({ 153, 145 })
    ai_base1:record_tube({ 151, 147 })
    ai_base1:record_tube({ 180, 141 })
    ai_base1:record_tube({ 180, 142 })
    ai_base1:record_tube({ 182, 139 })
    ai_base1:record_tube({ 182, 138 })
    ai_base1:record_tube({ 182, 137 })
    ai_base1:record_tube({ 182, 136 })
    ai_base1:record_tube({ 182, 135 })
    ai_base1:record_tube({ 182, 134 })
    ai_base1:record_tube({ 182, 133 })
    ai_base1:record_tube({ 182, 132 })
    ai_base1:record_wall({ 148, 141 })
    ai_base1:record_wall({ 148, 142 })
    ai_base1:record_wall({ 148, 143 })
    ai_base1:record_wall({ 148, 144 })
    ai_base1:record_wall({ 148, 145 })
    ai_base1:record_wall({ 149, 141 })
    ai_base1:record_wall({ 150, 141 })
    ai_base1:record_wall({ 151, 141 })
    ai_base1:record_wall({ 152, 141 })
    ai_base1:record_wall({ 153, 141 })
    ai_base1:record_wall({ 154, 141 })
    ai_base1:record_wall({ 155, 141 })
    ai_base1:record_wall({ 156, 141 })
    ai_base1:record_wall({ 157, 141 })
    ai_base1:record_wall({ 158, 141 })
    ai_base1:record_wall({ 159, 141 })
    ai_base1:record_wall({ 160, 141 })
    ai_base1:record_wall({ 161, 141 })
    ai_base1:record_wall({ 165, 124 })
    ai_base1:record_wall({ 165, 125 })
    ai_base1:record_wall({ 165, 126 })
    ai_base1:record_wall({ 165, 127 })
    ai_base1:record_wall({ 165, 131 })
    ai_base1:record_wall({ 165, 132 })
    ai_base1:record_wall({ 165, 133 })
    ai_base1:record_wall({ 165, 134 })
    ai_base1:record_wall({ 165, 135 })
    ai_base1:record_wall({ 165, 136 })
    ai_base1:record_wall({ 165, 137 })
    ai_base1:record_wall({ 166, 124 })
    ai_base1:record_wall({ 167, 124 })
    ai_base1:record_wall({ 181, 129 })
    ai_base1:record_wall({ 181, 130 })
    ai_base1:record_wall({ 182, 129 })
    ai_base1:record_wall({ 183, 141 })
    ai_base1:record_wall({ 184, 129 })
    ai_base1:record_wall({ 184, 141 })
    ai_base1:record_wall({ 185, 129 })
    ai_base1:record_wall({ 186, 129 })
    ai_base1:record_wall({ 186, 141 })
    ai_base1:record_wall({ 187, 129 })
    ai_base1:record_wall({ 187, 141 })
    ai_base1:record_wall({ 188, 132 })
    ai_base1:record_wall({ 188, 133 })
    ai_base1:record_wall({ 188, 134 })
    ai_base1:record_wall({ 188, 135 })
    ai_base1:record_wall({ 188, 136 })
    ai_base1:record_wall({ 188, 137 })
    ai_base1:record_wall({ 188, 138 })
    ai_base1:record_wall({ 188, 139 })
    ai_base1:record_wall({ 188, 140 })
    ai_base1:record_wall({ 188, 141 })
    ai_base1:record_tube({ 167, 134 })
    ai_base1:record_tube({ 167, 133 })
    ai_base1:record_tube({ 167, 132 })
    ai_base1:record_tube({ 167, 131 })
    ai_base1:record_tube({ 167, 130 })
    ai_base1:record_tube({ 167, 129 })
    ai_base1:record_tube({ 167, 128 })
    ai_base1:record_tube({ 150, 165 })
    ai_base1:record_tube({ 151, 165 })
    ai_base1:record_tube({ 153, 160 })
    ai_base1:record_tube({ 152, 160 })
    ai_base1:record_tube({ 152, 161 })
    ai_base1:record_tube({ 152, 162 })
    ai_base1:record_tube({ 152, 163 })
    ai_base1:record_tube({ 152, 164 })
    ai_base1:record_tube({ 152, 165 })
    ai_base1:record_tube({ 153, 159 })
    ai_base1:record_tube({ 154, 159 })
    ai_base1:record_tube({ 155, 159 })
    ai_base1:record_tube({ 156, 159 })
    ai_base1:record_tube({ 157, 159 })
    ai_base1:record_tube({ 158, 159 })
    ai_base1:record_tube({ 159, 159 })
    ai_base1:record_tube({ 160, 159 })
    ai_base1:record_tube({ 161, 159 })
    ai_base1:record_tube({ 162, 159 })
    ai_base1:record_tube({ 163, 159 })
  else
    t:destroy()
    expand_trigger = trigger.time{min = 20000, max = 30000, on = ExpandBase1_B}
    local mining1 = ai.mining_group(ai_player)
    mining1:setup({ 185, 135 }, { 168, 136 }, "RareOreMine", "RareOreSmelter", { 167, 132, 176, 138 })
    mining1:set_targ_count("CargoTruck", nil, 5)
    ai_base1:record_veh_reinforce_group(mining1, 100)
    ai_base1:record_building({ 170, 135 }, "RareOreSmelter")
    ai_base1:record_building({ 181, 140 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 166, 141 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 154, 164 }, "Tokamak")
    ai_base1:record_building({ 160, 149 }, "RecreationFacility")
    ai_base1:record_building({ 156, 149 }, "Residence")
    ai_base1:record_building({ 155, 145 }, "Agridome")
    ai_base1:record_building({ 160, 145 }, "GORF")
    ai_base1:record_building({ 148, 165 }, "GuardPost", "EMP")
    ai_base1:record_building({ 186, 135 }, "RareOreMine")
    ai_base1:record_building({ 150, 172 }, "Tokamak")
    ai_base1:record_building({ 170, 142 }, "CommonStorage")
    ai_base1:record_building({ 170, 145 }, "RareStorage")
    ai_base1:record_building({ 151, 145 }, "ArachnidFactory", nil, ai_base1)
    ai_base1:record_building({ 155, 175 }, "GuardPost", "Stickyfoam")
    ai_base1:record_building({ 150, 148 }, "GuardPost", "EMP")
    ai_base1:record_building({ 183, 131 }, "GuardPost", "EMP")
    ai_base1:record_building({ 167, 126 }, "GuardPost", "EMP")
    ai_base1:record_building({ 175, 148 }, "GuardPost", "EMP")
    ai_base1:record_building({ 164, 151 }, "GuardPost", "EMP")
    ai_base1:record_tube({ 166, 151 })
    ai_base1:record_tube({ 166, 150 })
    ai_base1:record_tube({ 165, 150 })
    ai_base1:record_tube({ 164, 150 })
    ai_base1:record_tube({ 163, 150 })
    ai_base1:record_tube({ 162, 150 })
    ai_base1:record_tube({ 161, 150 })
    ai_base1:record_tube({ 158, 149 })
    ai_base1:record_tube({ 155, 147 })
    ai_base1:record_tube({ 160, 147 })
    ai_base1:record_tube({ 173, 140 })
    ai_base1:record_tube({ 173, 139 })
    ai_base1:record_tube({ 173, 138 })
    ai_base1:record_tube({ 172, 138 })
    ai_base1:record_tube({ 171, 138 })
    ai_base1:record_tube({ 170, 138 })
    ai_base1:record_tube({ 153, 145 })
    ai_base1:record_tube({ 151, 147 })
    ai_base1:record_tube({ 180, 141 })
    ai_base1:record_tube({ 180, 142 })
    ai_base1:record_tube({ 182, 139 })
    ai_base1:record_tube({ 182, 138 })
    ai_base1:record_tube({ 182, 137 })
    ai_base1:record_tube({ 182, 136 })
    ai_base1:record_tube({ 182, 135 })
    ai_base1:record_tube({ 182, 134 })
    ai_base1:record_tube({ 182, 133 })
    ai_base1:record_tube({ 182, 132 })
    ai_base1:record_wall({ 148, 141 })
    ai_base1:record_wall({ 148, 142 })
    ai_base1:record_wall({ 148, 143 })
    ai_base1:record_wall({ 148, 144 })
    ai_base1:record_wall({ 148, 145 })
    ai_base1:record_wall({ 149, 141 })
    ai_base1:record_wall({ 150, 141 })
    ai_base1:record_wall({ 151, 141 })
    ai_base1:record_wall({ 152, 141 })
    ai_base1:record_wall({ 153, 141 })
    ai_base1:record_wall({ 154, 141 })
    ai_base1:record_wall({ 155, 141 })
    ai_base1:record_wall({ 156, 141 })
    ai_base1:record_wall({ 157, 141 })
    ai_base1:record_wall({ 158, 141 })
    ai_base1:record_wall({ 159, 141 })
    ai_base1:record_wall({ 160, 141 })
    ai_base1:record_wall({ 161, 141 })
    ai_base1:record_wall({ 165, 124 })
    ai_base1:record_wall({ 165, 125 })
    ai_base1:record_wall({ 165, 126 })
    ai_base1:record_wall({ 165, 127 })
    ai_base1:record_wall({ 165, 131 })
    ai_base1:record_wall({ 165, 132 })
    ai_base1:record_wall({ 165, 133 })
    ai_base1:record_wall({ 165, 134 })
    ai_base1:record_wall({ 165, 135 })
    ai_base1:record_wall({ 165, 136 })
    ai_base1:record_wall({ 165, 137 })
    ai_base1:record_wall({ 166, 124 })
    ai_base1:record_wall({ 167, 124 })
    ai_base1:record_wall({ 181, 129 })
    ai_base1:record_wall({ 181, 130 })
    ai_base1:record_wall({ 182, 129 })
    ai_base1:record_wall({ 183, 141 })
    ai_base1:record_wall({ 184, 129 })
    ai_base1:record_wall({ 184, 141 })
    ai_base1:record_wall({ 185, 129 })
    ai_base1:record_wall({ 186, 129 })
    ai_base1:record_wall({ 186, 141 })
    ai_base1:record_wall({ 187, 129 })
    ai_base1:record_wall({ 187, 141 })
    ai_base1:record_wall({ 188, 132 })
    ai_base1:record_wall({ 188, 133 })
    ai_base1:record_wall({ 188, 134 })
    ai_base1:record_wall({ 188, 135 })
    ai_base1:record_wall({ 188, 136 })
    ai_base1:record_wall({ 188, 137 })
    ai_base1:record_wall({ 188, 138 })
    ai_base1:record_wall({ 188, 139 })
    ai_base1:record_wall({ 188, 140 })
    ai_base1:record_wall({ 188, 141 })
    ai_base1:record_tube({ 167, 134 })
    ai_base1:record_tube({ 167, 133 })
    ai_base1:record_tube({ 167, 132 })
    ai_base1:record_tube({ 167, 131 })
    ai_base1:record_tube({ 167, 130 })
    ai_base1:record_tube({ 167, 129 })
    ai_base1:record_tube({ 167, 128 })
    ai_base1:record_tube({ 150, 165 })
    ai_base1:record_tube({ 151, 165 })
  end
end

function Lava1_Flow(t)
  game.set_tile({ 133, 197 }, 1147)
  game.set_tile({ 133, 198 }, 1158)
  for _, r in ipairs({
    { 121, 121, 123, 121 }, { 120, 122, 124, 122 }, { 119, 123, 128, 123 }, { 118, 124, 129, 124 }, { 118, 125, 130, 125 }, { 120, 126, 131, 127 },
    { 120, 128, 133, 128 }, { 120, 129, 134, 129 }, { 120, 130, 135, 130 }, { 121, 131, 135, 131 }, { 122, 132, 135, 133 }, { 123, 134, 134, 134 },
    { 123, 135, 133, 135 }, { 123, 136, 128, 136 }, { 123, 137, 129, 137 }, { 122, 138, 129, 138 }, { 123, 139, 129, 139 }, { 124, 140, 128, 141 },
    { 123, 142, 127, 143 }, { 122, 144, 128, 144 }, { 119, 145, 129, 146 }, { 118, 147, 129, 147 }, { 116, 148, 129, 148 }, { 116, 149, 132, 149 },
    { 116, 150, 133, 150 }, { 116, 151, 134, 151 }, { 117, 152, 135, 152 }, { 118, 153, 135, 153 }, { 119, 154, 135, 154 }, { 121, 155, 135, 155 },
    { 125, 156, 135, 156 }, { 126, 157, 134, 157 }, { 126, 158, 135, 158 }, { 127, 159, 135, 160 }, { 127, 161, 136, 162 }, { 128, 163, 136, 163 },
    { 130, 164, 137, 164 }, { 131, 165, 137, 167 }, { 131, 168, 138, 168 }, { 130, 169, 139, 169 }, { 130, 170, 140, 171 }, { 129, 172, 140, 172 },
    { 128, 173, 139, 173 }, { 125, 174, 140, 174 }, { 124, 175, 140, 175 }, { 123, 176, 141, 176 }, { 120, 177, 142, 178 }, { 119, 179, 142, 179 },
    { 120, 180, 143, 180 }, { 121, 181, 143, 181 }, { 122, 182, 144, 182 }, { 122, 183, 146, 183 }, { 123, 184, 146, 188 }, { 121, 188, 121, 188 },
    { 118, 189, 124, 191 }, { 128, 189, 147, 189 }, { 128, 190, 137, 190 }, { 140, 190, 145, 190 }, { 128, 191, 135, 191 }, { 143, 191, 143, 191 },
    { 117, 192, 134, 193 }, { 117, 194, 131, 194 }, { 118, 195, 130, 195 }, { 119, 196, 130, 197 }, { 120, 198, 130, 198 }, { 138, 198, 142, 198 },
    { 121, 199, 133, 199 }, { 137, 199, 143, 199 }, { 123, 200, 144, 200 }, { 124, 201, 144, 201 }, { 123, 202, 144, 202 }, { 122, 203, 143, 203 },
    { 121, 204, 138, 204 }, { 115, 205, 138, 205 }, { 114, 206, 138, 206 }, { 112, 207, 139, 207 }, { 108, 208, 139, 208 }, { 107, 209, 139, 210 },
    { 105, 211, 138, 211 }, { 106, 212, 138, 213 }, { 105, 214, 138, 214 }, { 104, 215, 139, 216 }, { 104, 217, 141, 217 }, { 105, 218, 141, 218 },
    { 105, 219, 140, 219 }, { 96, 220, 96, 220 }, { 104, 220, 140, 220 }, { 95, 221, 97, 221 }, { 105, 221, 141, 221 }, { 94, 222, 98, 222 },
    { 107, 222, 141, 222 }, { 94, 223, 99, 223 }, { 108, 223, 140, 223 }, { 94, 224, 100, 224 }, { 108, 224, 139, 224 }, { 93, 225, 101, 225 },
    { 108, 225, 137, 225 }, { 92, 226, 101, 226 }, { 108, 226, 116, 228 }, { 120, 226, 137, 226 }, { 91, 227, 101, 227 }, { 120, 227, 139, 228 },
    { 90, 228, 101, 228 }, { 89, 229, 100, 231 }, { 108, 229, 139, 229 }, { 108, 230, 138, 230 }, { 107, 231, 138, 231 }, { 89, 232, 101, 232 },
    { 107, 232, 122, 232 }, { 125, 232, 138, 232 }, { 87, 233, 101, 233 }, { 107, 233, 123, 233 }, { 126, 233, 138, 233 }, { 81, 234, 102, 234 },
    { 106, 234, 122, 234 }, { 125, 234, 137, 235 }, { 80, 235, 122, 235 }, { 79, 236, 122, 236 }, { 125, 236, 138, 236 }, { 78, 237, 122, 238 },
    { 125, 237, 126, 237 }, { 129, 237, 138, 237 }, { 128, 238, 137, 238 }, { 78, 239, 138, 239 }, { 79, 240, 95, 240 }, { 99, 240, 137, 240 },
    { 80, 241, 95, 242 }, { 99, 241, 120, 241 }, { 123, 241, 138, 241 }, { 99, 242, 138, 242 }, { 81, 243, 138, 243 }, { 82, 244, 139, 245 },
    { 82, 246, 142, 246 }, { 82, 247, 100, 247 }, { 104, 247, 106, 247 }, { 108, 247, 143, 247 }, { 81, 248, 100, 249 }, { 104, 248, 109, 248 },
    { 120, 248, 150, 249 }, { 104, 249, 108, 249 }, { 80, 250, 107, 250 }, { 120, 250, 144, 251 }, { 148, 250, 153, 251 }, { 76, 251, 76, 251 },
    { 78, 251, 107, 251 }, { 75, 252, 106, 252 }, { 120, 252, 120, 252 }, { 122, 252, 144, 252 }, { 148, 252, 149, 252 }, { 76, 253, 77, 253 },
    { 90, 253, 107, 253 }, { 120, 253, 127, 253 }, { 129, 253, 144, 253 },
  }) do game.set_lava_possible(r) end
  game.create_eruption({ 133, 199 }, 30)
  t:destroy()
end

function Lava1_Vent(t)
  game.set_tile({ 133, 197 }, 1140)
  game.set_tile({ 133, 198 }, 1150)
  t:destroy()
  trigger.time{time = 1500, on = Lava1_Flow}  -- after 15 marks
end

function Lava2_Flow(t)
  game.initial_set_tile({ 237, 177 }, 1104)
  game.initial_set_tile({ 238, 177 }, 1115)
  game.initial_set_tile({ 237, 178 }, 1126)
  game.initial_set_tile({ 238, 178 }, 1137)
  for _, r in ipairs({
    { 219, 1, 219, 1 }, { 209, 21, 210, 21 }, { 208, 22, 211, 22 }, { 208, 23, 212, 23 }, { 207, 24, 212, 24 }, { 207, 25, 217, 25 },
    { 207, 26, 218, 27 }, { 190, 27, 192, 27 }, { 194, 27, 196, 27 }, { 198, 27, 199, 27 }, { 189, 28, 202, 28 }, { 205, 28, 218, 28 },
    { 189, 29, 218, 29 }, { 189, 30, 192, 30 }, { 194, 30, 217, 30 }, { 190, 31, 191, 31 }, { 193, 31, 216, 31 }, { 193, 32, 215, 32 },
    { 194, 33, 213, 33 }, { 195, 34, 213, 34 }, { 196, 35, 200, 35 }, { 202, 35, 213, 35 }, { 198, 36, 199, 36 }, { 203, 36, 213, 36 },
    { 205, 37, 212, 37 }, { 206, 38, 212, 38 }, { 205, 39, 213, 42 }, { 202, 42, 203, 42 }, { 215, 42, 216, 42 }, { 201, 43, 219, 43 },
    { 200, 44, 220, 44 }, { 200, 45, 223, 45 }, { 200, 46, 224, 46 }, { 226, 46, 232, 46 }, { 195, 47, 196, 47 }, { 199, 47, 234, 47 },
    { 193, 48, 196, 48 }, { 198, 48, 206, 48 }, { 209, 48, 235, 48 }, { 192, 49, 205, 49 }, { 210, 49, 235, 49 }, { 192, 50, 204, 50 },
    { 211, 50, 234, 50 }, { 192, 51, 205, 51 }, { 210, 51, 235, 52 }, { 191, 52, 205, 52 }, { 191, 53, 206, 53 }, { 209, 53, 234, 53 },
    { 191, 54, 234, 55 }, { 192, 56, 234, 56 }, { 190, 57, 234, 57 }, { 189, 58, 233, 58 }, { 188, 59, 222, 59 }, { 224, 59, 233, 59 },
    { 187, 60, 221, 60 }, { 225, 60, 233, 60 }, { 183, 61, 184, 61 }, { 186, 61, 221, 61 }, { 225, 61, 232, 61 }, { 182, 62, 218, 62 },
    { 226, 62, 229, 62 }, { 182, 63, 217, 63 }, { 179, 64, 216, 64 }, { 178, 65, 216, 65 }, { 177, 66, 215, 66 }, { 176, 67, 215, 67 },
    { 176, 68, 214, 69 }, { 177, 70, 213, 71 }, { 177, 72, 206, 74 }, { 210, 72, 213, 72 }, { 210, 73, 214, 73 }, { 210, 74, 215, 74 },
    { 177, 75, 215, 75 }, { 178, 76, 214, 76 }, { 177, 77, 214, 77 }, { 177, 78, 215, 80 }, { 176, 81, 214, 81 }, { 176, 82, 213, 83 },
    { 177, 84, 193, 84 }, { 196, 84, 212, 84 }, { 177, 85, 192, 85 }, { 197, 85, 211, 85 }, { 175, 86, 191, 86 }, { 198, 86, 209, 86 },
    { 173, 87, 192, 87 }, { 197, 87, 209, 87 }, { 172, 88, 192, 88 }, { 197, 88, 210, 88 }, { 172, 89, 193, 89 }, { 196, 89, 210, 89 },
    { 173, 90, 210, 90 }, { 172, 91, 210, 91 }, { 166, 92, 168, 92 }, { 172, 92, 209, 92 }, { 165, 93, 169, 94 }, { 173, 93, 209, 95 },
    { 163, 95, 169, 95 }, { 152, 96, 155, 96 }, { 162, 96, 169, 96 }, { 174, 96, 210, 96 }, { 151, 97, 159, 97 }, { 162, 97, 168, 98 },
    { 177, 97, 210, 97 }, { 151, 98, 160, 98 }, { 178, 98, 210, 98 }, { 150, 99, 169, 99 }, { 179, 99, 209, 99 }, { 129, 100, 129, 100 },
    { 132, 100, 133, 100 }, { 149, 100, 170, 100 }, { 178, 100, 209, 100 }, { 129, 101, 135, 101 }, { 149, 101, 171, 101 }, { 177, 101, 209, 101 },
    { 127, 102, 138, 102 }, { 148, 102, 155, 102 }, { 157, 102, 172, 102 }, { 176, 102, 209, 102 }, { 132, 103, 139, 103 }, { 147, 103, 154, 103 },
    { 159, 103, 208, 103 }, { 133, 104, 142, 104 }, { 146, 104, 151, 104 }, { 160, 104, 207, 104 }, { 135, 105, 143, 105 }, { 147, 105, 151, 105 },
    { 162, 105, 164, 105 }, { 166, 105, 206, 105 }, { 137, 106, 144, 106 }, { 146, 106, 151, 106 }, { 169, 106, 207, 106 }, { 139, 107, 151, 107 },
    { 170, 107, 207, 107 }, { 140, 108, 150, 109 }, { 173, 108, 206, 108 }, { 177, 109, 178, 109 }, { 180, 109, 207, 109 }, { 140, 110, 149, 110 },
    { 183, 110, 208, 110 }, { 141, 111, 150, 111 }, { 186, 111, 187, 111 }, { 189, 111, 209, 111 }, { 142, 112, 150, 112 }, { 190, 112, 209, 112 },
    { 144, 113, 150, 113 }, { 190, 113, 210, 113 }, { 144, 114, 149, 114 }, { 190, 114, 211, 114 }, { 143, 115, 147, 116 }, { 191, 115, 211, 116 },
    { 143, 117, 146, 117 }, { 192, 117, 211, 117 }, { 144, 118, 145, 118 }, { 194, 118, 210, 120 }, { 195, 121, 209, 121 }, { 197, 122, 210, 122 },
    { 198, 123, 210, 125 }, { 199, 126, 209, 126 }, { 199, 127, 206, 128 }, { 200, 129, 206, 129 }, { 202, 130, 207, 130 }, { 202, 131, 208, 132 },
    { 203, 133, 209, 134 }, { 202, 135, 208, 135 }, { 201, 136, 209, 136 }, { 202, 137, 209, 137 }, { 212, 137, 214, 137 }, { 203, 138, 215, 138 },
    { 204, 139, 219, 139 }, { 204, 140, 220, 140 }, { 227, 140, 228, 140 }, { 204, 141, 221, 141 }, { 226, 141, 229, 141 }, { 204, 142, 210, 142 },
    { 213, 142, 222, 142 }, { 226, 142, 230, 142 }, { 246, 142, 248, 142 }, { 204, 143, 208, 143 }, { 214, 143, 222, 146 }, { 227, 143, 234, 143 },
    { 245, 143, 249, 143 }, { 205, 144, 207, 144 }, { 227, 144, 235, 144 }, { 240, 144, 250, 144 }, { 227, 145, 236, 145 }, { 239, 145, 250, 145 },
    { 228, 146, 237, 146 }, { 239, 146, 249, 146 }, { 215, 147, 221, 147 }, { 234, 147, 247, 147 }, { 216, 148, 221, 148 }, { 235, 148, 242, 148 },
    { 215, 149, 222, 150 }, { 236, 149, 241, 149 }, { 225, 150, 226, 150 }, { 237, 150, 241, 151 }, { 216, 151, 229, 151 }, { 216, 152, 230, 152 },
    { 236, 152, 241, 152 }, { 217, 153, 231, 153 }, { 236, 153, 240, 153 }, { 218, 154, 232, 154 }, { 236, 154, 239, 156 }, { 253, 154, 253, 154 },
    { 221, 155, 232, 155 }, { 245, 155, 249, 155 }, { 252, 155, 254, 155 }, { 222, 156, 231, 157 }, { 244, 156, 254, 158 }, { 236, 157, 240, 157 },
    { 222, 158, 233, 158 }, { 235, 158, 241, 158 }, { 223, 159, 254, 160 }, { 224, 161, 254, 161 }, { 225, 162, 245, 162 }, { 248, 162, 253, 162 },
    { 225, 163, 242, 163 }, { 226, 164, 242, 164 }, { 228, 165, 241, 165 }, { 228, 166, 239, 166 }, { 229, 167, 238, 167 }, { 229, 168, 237, 168 },
    { 227, 169, 236, 169 }, { 226, 170, 236, 170 }, { 224, 171, 236, 171 }, { 223, 172, 235, 173 }, { 224, 174, 235, 174 }, { 223, 175, 235, 177 },
    { 223, 178, 236, 178 }, { 224, 179, 237, 179 }, { 225, 180, 237, 180 }, { 226, 181, 237, 181 }, { 225, 182, 237, 182 }, { 224, 183, 238, 183 },
    { 224, 184, 239, 184 }, { 225, 185, 239, 185 }, { 226, 186, 239, 186 }, { 229, 187, 238, 187 }, { 230, 188, 239, 188 }, { 229, 189, 239, 189 },
    { 228, 190, 239, 190 }, { 228, 191, 240, 191 }, { 227, 192, 241, 194 }, { 228, 195, 242, 195 }, { 230, 196, 242, 196 }, { 231, 197, 232, 197 },
    { 234, 197, 243, 197 }, { 233, 198, 243, 200 }, { 234, 201, 241, 201 }, { 243, 201, 243, 201 }, { 235, 202, 242, 202 }, { 244, 202, 245, 202 },
    { 235, 203, 245, 203 }, { 234, 204, 236, 204 }, { 238, 204, 239, 204 }, { 242, 204, 244, 204 }, { 233, 205, 236, 205 }, { 230, 206, 235, 206 },
    { 229, 207, 235, 209 }, { 226, 210, 235, 210 }, { 225, 211, 236, 211 }, { 224, 212, 244, 215 }, { 225, 216, 244, 216 }, { 224, 217, 244, 217 },
    { 223, 218, 245, 218 }, { 223, 219, 226, 219 }, { 230, 219, 245, 219 }, { 221, 220, 226, 220 }, { 230, 220, 244, 221 }, { 220, 221, 226, 221 },
    { 219, 222, 245, 222 }, { 219, 223, 246, 224 }, { 219, 225, 244, 225 }, { 246, 225, 246, 225 }, { 220, 226, 244, 226 }, { 219, 227, 244, 228 },
    { 219, 229, 230, 230 }, { 233, 229, 245, 229 }, { 235, 230, 243, 230 }, { 220, 231, 230, 231 }, { 239, 231, 240, 231 }, { 221, 232, 231, 233 },
    { 245, 233, 249, 233 }, { 221, 234, 233, 234 }, { 235, 234, 238, 234 }, { 244, 234, 250, 234 }, { 221, 235, 239, 235 }, { 242, 235, 250, 235 },
    { 222, 236, 251, 236 }, { 222, 237, 253, 237 }, { 220, 238, 246, 238 }, { 248, 238, 253, 238 }, { 219, 239, 234, 239 }, { 238, 239, 243, 239 },
    { 249, 239, 254, 239 }, { 218, 240, 234, 241 }, { 250, 240, 254, 240 }, { 251, 241, 253, 241 }, { 218, 242, 221, 242 }, { 224, 242, 233, 242 },
    { 251, 242, 254, 242 }, { 216, 243, 221, 243 }, { 225, 243, 233, 244 }, { 252, 243, 254, 243 }, { 215, 244, 221, 244 }, { 253, 244, 254, 244 },
    { 215, 245, 220, 245 }, { 226, 245, 233, 246 }, { 215, 246, 219, 246 }, { 216, 247, 219, 247 }, { 226, 247, 234, 248 }, { 215, 248, 219, 248 },
    { 215, 249, 218, 249 }, { 227, 249, 233, 250 }, { 216, 250, 217, 250 }, { 228, 251, 231, 251 },
  }) do game.set_lava_possible(r) end
  game.create_eruption({ 236, 179 }, 15)
  t:destroy()
end

function Lava2_Vent(t)
  game.initial_set_tile({ 237, 177 }, 1095)
  game.initial_set_tile({ 238, 177 }, 1107)
  game.initial_set_tile({ 237, 178 }, 1118)
  game.initial_set_tile({ 238, 178 }, 1129)
  t:destroy()
  trigger.time{time = 1500, on = Lava2_Flow}  -- after 15 marks
end

function Lava3_Flow(t)
  game.set_tile({ 19, 185 }, 1147)
  game.set_tile({ 19, 186 }, 1158)
  for _, r in ipairs({
    { 17, 121, 18, 121 }, { 16, 122, 19, 122 }, { 16, 123, 20, 123 }, { 16, 124, 21, 125 }, { 23, 125, 24, 125 }, { 15, 126, 25, 126 },
    { 14, 127, 25, 127 }, { 14, 128, 26, 128 }, { 14, 129, 27, 130 }, { 15, 131, 26, 131 }, { 15, 132, 25, 132 }, { 15, 133, 24, 134 },
    { 16, 135, 24, 135 }, { 17, 136, 24, 136 }, { 19, 137, 24, 137 }, { 19, 138, 25, 138 }, { 20, 139, 26, 139 }, { 21, 140, 29, 140 },
    { 24, 141, 29, 141 }, { 27, 142, 30, 142 }, { 28, 143, 31, 144 }, { 29, 145, 33, 146 }, { 40, 145, 44, 145 }, { 41, 146, 44, 148 },
    { 30, 147, 32, 147 }, { 30, 148, 33, 149 }, { 42, 149, 46, 149 }, { 50, 149, 51, 149 }, { 29, 150, 33, 150 }, { 43, 150, 52, 150 },
    { 30, 151, 33, 152 }, { 42, 151, 54, 151 }, { 41, 152, 55, 152 }, { 30, 153, 34, 153 }, { 37, 153, 37, 153 }, { 40, 153, 45, 153 },
    { 48, 153, 55, 153 }, { 29, 154, 41, 154 }, { 49, 154, 55, 154 }, { 57, 154, 58, 154 }, { 29, 155, 40, 155 }, { 51, 155, 59, 155 },
    { 29, 156, 39, 156 }, { 53, 156, 62, 156 }, { 29, 157, 38, 157 }, { 53, 157, 63, 157 }, { 30, 158, 38, 159 }, { 54, 158, 64, 158 },
    { 57, 159, 65, 160 }, { 29, 160, 37, 160 }, { 28, 161, 38, 162 }, { 57, 161, 68, 161 }, { 58, 162, 69, 162 }, { 26, 163, 38, 163 },
    { 59, 163, 62, 163 }, { 65, 163, 65, 163 }, { 68, 163, 70, 163 }, { 23, 164, 38, 164 }, { 69, 164, 71, 164 }, { 22, 165, 37, 165 },
    { 70, 165, 71, 166 }, { 22, 166, 30, 166 }, { 33, 166, 37, 166 }, { 21, 167, 25, 167 }, { 34, 167, 38, 167 }, { 69, 167, 72, 167 },
    { 22, 168, 23, 169 }, { 35, 168, 38, 168 }, { 70, 168, 71, 168 }, { 34, 169, 38, 169 }, { 69, 169, 72, 170 }, { 34, 170, 37, 170 },
    { 35, 171, 36, 171 }, { 68, 171, 72, 171 }, { 34, 172, 37, 172 }, { 68, 172, 73, 172 }, { 34, 173, 38, 175 }, { 69, 173, 74, 173 },
    { 27, 174, 28, 174 }, { 70, 174, 74, 174 }, { 27, 175, 32, 175 }, { 71, 175, 73, 175 }, { 27, 176, 38, 176 }, { 19, 177, 21, 177 },
    { 28, 177, 38, 177 }, { 19, 178, 22, 178 }, { 28, 178, 37, 178 }, { 6, 179, 7, 179 }, { 20, 179, 22, 179 }, { 27, 179, 34, 181 },
    { 1, 180, 2, 180 }, { 5, 180, 7, 180 }, { 21, 180, 24, 180 }, { 1, 181, 7, 183 }, { 23, 181, 25, 181 }, { 24, 182, 33, 182 },
    { 25, 183, 33, 183 }, { 1, 184, 8, 185 }, { 26, 184, 32, 184 }, { 26, 185, 31, 185 }, { 1, 186, 10, 186 }, { 26, 186, 30, 186 },
    { 1, 187, 12, 187 }, { 14, 187, 15, 187 }, { 19, 187, 19, 187 }, { 25, 187, 29, 187 }, { 1, 188, 16, 188 }, { 18, 188, 20, 188 },
    { 24, 188, 30, 188 }, { 1, 189, 21, 189 }, { 23, 189, 30, 189 }, { 1, 190, 30, 191 }, { 1, 192, 29, 192 }, { 1, 193, 7, 193 },
    { 10, 193, 16, 193 }, { 18, 193, 24, 193 }, { 27, 193, 29, 193 }, { 1, 194, 4, 194 }, { 19, 194, 23, 194 }, { 28, 194, 29, 194 },
    { 2, 195, 3, 195 }, { 20, 195, 22, 195 }, { 19, 196, 22, 196 }, { 20, 197, 22, 197 },
  }) do game.set_lava_possible(r) end
  game.create_eruption({ 19, 187 }, 10)
  t:destroy()
end

function Lava3_Vent(t)
  game.set_tile({ 19, 185 }, 1140)
  game.set_tile({ 19, 186 }, 1150)
  t:destroy()
  trigger.time{time = 1500, on = Lava3_Flow}  -- after 15 marks
end

function Lava4_Flow(t)
  game.initial_set_tile({ 48, 58 }, 1104)
  game.initial_set_tile({ 49, 58 }, 1115)
  game.initial_set_tile({ 48, 59 }, 1126)
  game.initial_set_tile({ 49, 59 }, 1137)
  for _, r in ipairs({
    { 48, 36, 49, 36 }, { 47, 37, 50, 38 }, { 46, 39, 50, 39 }, { 45, 40, 50, 41 }, { 45, 42, 49, 42 }, { 45, 43, 48, 45 },
    { 43, 46, 48, 46 }, { 42, 47, 48, 47 }, { 40, 48, 48, 48 }, { 21, 49, 22, 49 }, { 39, 49, 47, 49 }, { 20, 50, 26, 50 },
    { 31, 50, 32, 50 }, { 39, 50, 45, 50 }, { 20, 51, 27, 52 }, { 30, 51, 34, 51 }, { 36, 51, 45, 51 }, { 16, 52, 17, 52 },
    { 29, 52, 45, 52 }, { 8, 53, 8, 53 }, { 13, 53, 44, 53 }, { 8, 54, 44, 54 }, { 9, 55, 44, 55 }, { 13, 56, 31, 56 },
    { 35, 56, 45, 57 }, { 15, 57, 15, 57 }, { 20, 57, 29, 57 }, { 21, 58, 28, 58 }, { 35, 58, 46, 58 }, { 62, 58, 63, 58 },
    { 23, 59, 26, 59 }, { 34, 59, 46, 59 }, { 57, 59, 64, 59 }, { 24, 60, 25, 60 }, { 34, 60, 47, 60 }, { 56, 60, 64, 60 },
    { 34, 61, 48, 61 }, { 53, 61, 70, 61 }, { 35, 62, 71, 63 }, { 36, 64, 71, 64 }, { 37, 65, 56, 65 }, { 61, 65, 70, 65 },
    { 38, 66, 54, 66 }, { 62, 66, 69, 66 }, { 38, 67, 55, 67 }, { 64, 67, 65, 67 }, { 39, 68, 56, 68 }, { 40, 69, 43, 71 },
    { 46, 69, 56, 69 }, { 45, 70, 54, 70 }, { 45, 71, 55, 71 }, { 41, 72, 42, 72 }, { 46, 72, 47, 72 }, { 49, 72, 56, 73 },
    { 45, 74, 46, 74 }, { 48, 74, 56, 74 }, { 44, 75, 55, 75 }, { 44, 76, 53, 76 }, { 45, 77, 46, 77 }, { 48, 77, 54, 77 },
    { 50, 78, 54, 78 }, { 49, 79, 54, 79 }, { 49, 80, 53, 80 }, { 49, 81, 54, 81 }, { 48, 82, 54, 82 }, { 48, 83, 53, 83 },
    { 49, 84, 53, 85 }, { 50, 86, 52, 86 },
  }) do game.set_lava_possible(r) end
  game.create_eruption({ 47, 60 }, 30)
  t:destroy()
end

function Lava4_Vent(t)
  game.initial_set_tile({ 48, 58 }, 1095)
  game.initial_set_tile({ 49, 58 }, 1107)
  game.initial_set_tile({ 48, 59 }, 1118)
  game.initial_set_tile({ 49, 59 }, 1129)
  t:destroy()
  trigger.time{time = 1500, on = Lava4_Flow}  -- after 15 marks
end

function SetupBase2(t)
  t:destroy()
  ai_base2:set_rect({ 7, 12, 21, 24 })
  base2_mining = ai.mining_group(ai_player)
  base2_mining:setup({ 3, 40 }, { 11, 36 }, "CommonOreMine", "CommonOreSmelter", { 6, 32, 13, 38 })
  base2_mining:set_targ_count("CargoTruck", nil, 2)
  ai_base2:record_veh_reinforce_group(base2_mining, 100)
  ai_fight4:set_targ_count("Lynx", "Microwave", 7)
  ai_fight4:set_targ_count("Lynx", "Stickyfoam", 2)
  ai_fight1:set_targ_count("Lynx", "Stickyfoam", 1)
  ai_fight3:set_targ_count("Lynx", "Stickyfoam", 1)
  trigger.time{time = 97, one_shot = false, on = Base2CommonCheck}
  ai_base2:record_building({ 10, 19 }, "CommandCenter")
  ai_base2:record_building({ 11, 22 }, "StructureFactory", nil, ai_base2)
  ai_base2:record_building({ 16, 22 }, "VehicleFactory", nil, ai_base2)
  ai_base2:record_building({ 10, 27 }, "Agridome")
  ai_base2:record_building({ 3, 26 }, "Tokamak")
  ai_base2:record_building({ 10, 30 }, "Agridome")
  ai_base2:record_building({ 10, 35 }, "CommonOreSmelter", nil, ai_base2)
  ai_base2:record_building({ 21, 22 }, "GuardPost", "Stickyfoam")
  ai_base2:record_building({ 20, 17 }, "GuardPost", "Stickyfoam")
  ai_base2:record_building({ 6, 26 }, "GuardPost", "Stickyfoam")
  ai_base2:record_building({ 15, 19 }, "StandardLab")
  ai_base2:record_building({ 4, 40 }, "CommonOreMine")
  ai_base2:record_building({ 15, 34 }, "GuardPost", "EMP")
  ai_base2:record_building({ 23, 28 }, "Tokamak")
  ai_base2:record_building({ 8, 40 }, "GuardPost", "EMP")
  ai_base2:record_building({ 11, 13 }, "Residence")
  ai_base2:record_building({ 7, 13 }, "Residence")
  ai_base2:record_building({ 6, 10 }, "RobotCommand")
  ai_base2:record_building({ 14, 27 }, "MedicalCenter")
  ai_base2:record_building({ 16, 26 }, "CommonStorage")
  ai_base2:record_building({ 3, 35 }, "MHDGenerator")
  ai_base2:record_building({ 10, 10 }, "Forum")
  ai_base2:record_building({ 9, 4 }, "MHDGenerator")
  ai_base2:record_building({ 31, 34 }, "GuardPost", "EMP")
  ai_base2:record_building({ 19, 39 }, "AdvancedLab")
  ai_base2:record_building({ 16, 6 }, "RareOreSmelter", nil, ai_base2)
  ai_base2:record_building({ 31, 8 }, "GuardPost", "Stickyfoam")
  ai_base2:record_building({ 3, 13 }, "ReinforcedResidence")
  ai_base2:record_building({ 3, 16 }, "CommonStorage")
  ai_base2:record_building({ 3, 10 }, "CommonStorage")
  ai_base2:record_building({ 19, 13 }, "MHDGenerator")
  ai_base2:record_building({ 14, 30 }, "DIRT")
  ai_base2:record_building({ 7, 30 }, "RareStorage")
  ai_base2:record_building({ 15, 16 }, "ArachnidFactory", nil, ai_base2)
  ai_base2:record_building({ 13, 13 }, "RareStorage")
  ai_base2:record_building({ 11, 48 }, "GuardPost", "ESG")
  ai_base2:record_building({ 3, 48 }, "GuardPost", "EMP")
  ai_base2:record_building({ 31, 45 }, "GuardPost", "ESG")
  ai_base2:record_building({ 31, 18 }, "GuardPost", "ESG")
  ai_base2:record_building({ 22, 5 }, "GuardPost", "ESG")
  ai_base2:record_tube({ 11, 25 })
  ai_base2:record_tube({ 13, 19 })
  ai_base2:record_tube({ 19, 22 })
  ai_base2:record_tube({ 20, 22 })
  ai_base2:record_tube({ 18, 19 })
  ai_base2:record_tube({ 19, 19 })
  ai_base2:record_tube({ 20, 19 })
  ai_base2:record_tube({ 8, 26 })
  ai_base2:record_tube({ 10, 32 })
  ai_base2:record_tube({ 10, 33 })
  ai_base2:record_tube({ 12, 34 })
  ai_base2:record_tube({ 13, 34 })
  ai_base2:record_tube({ 14, 34 })
  ai_base2:record_tube({ 11, 17 })
  ai_base2:record_tube({ 11, 16 })
  ai_base2:record_tube({ 11, 15 })
  ai_base2:record_tube({ 9, 13 })
  ai_base2:record_tube({ 15, 36 })
  ai_base2:record_tube({ 16, 36 })
  ai_base2:record_tube({ 17, 36 })
  ai_base2:record_tube({ 18, 36 })
  ai_base2:record_tube({ 19, 36 })
  ai_base2:record_tube({ 19, 37 })
  ai_base2:record_tube({ 12, 10 })
  ai_base2:record_tube({ 12, 9 })
  ai_base2:record_tube({ 12, 8 })
  ai_base2:record_tube({ 12, 7 })
  ai_base2:record_tube({ 13, 7 })
  ai_base2:record_tube({ 14, 14 })
  ai_base2:record_tube({ 10, 38 })
  ai_base2:record_tube({ 10, 39 })
  ai_base2:record_tube({ 10, 40 })
end

function SetupBase3(t)
  t:destroy()
  ai_base3:set_rect({ 226, 79, 235, 90 })
  base3_mining = ai.mining_group(ai_player)
  base3_mining:setup({ 236, 73 }, { 245, 70 }, "CommonOreMine", "CommonOreSmelter", { 241, 67, 246, 74 })
  base3_mining:set_targ_count("CargoTruck", nil, 2)
  ai_base3:record_veh_reinforce_group(base3_mining, 100)
  trigger.time{time = 97, one_shot = false, on = Base3CommonCheck}
  ai_base3:record_building({ 228, 85 }, "CommandCenter")
  ai_base3:record_building({ 229, 88 }, "StructureFactory", nil, ai_base3)
  ai_base3:record_building({ 224, 84 }, "VehicleFactory", nil, ai_base3)
  ai_base3:record_building({ 229, 80 }, "GuardPost", "Stickyfoam")
  ai_base3:record_building({ 224, 80 }, "Residence")
  ai_base3:record_building({ 225, 74 }, "Agridome")
  ai_base3:record_building({ 237, 73 }, "CommonOreMine")
  ai_base3:record_building({ 244, 69 }, "CommonOreSmelter", nil, ai_base3)
  ai_base3:record_building({ 220, 79 }, "GuardPost", "Stickyfoam")
  ai_base3:record_building({ 220, 88 }, "GuardPost", "Stickyfoam")
  ai_base3:record_building({ 234, 89 }, "GuardPost", "Stickyfoam")
  ai_base3:record_building({ 224, 69 }, "Residence")
  ai_base3:record_building({ 228, 69 }, "Agridome")
  ai_base3:record_building({ 220, 95 }, "GuardPost", "EMP")
  ai_base3:record_building({ 233, 65 }, "GuardPost", "EMP")
  ai_base3:record_building({ 242, 62 }, "GuardPost", "EMP")
  ai_base3:record_building({ 242, 86 }, "MHDGenerator")
  ai_base3:record_building({ 249, 69 }, "ArachnidFactory", nil, ai_base3)
  ai_base3:record_building({ 252, 68 }, "DIRT")
  ai_base3:record_building({ 233, 95 }, "GuardPost", "Stickyfoam")
  ai_base3:record_building({ 254, 100 }, "RareOreSmelter", nil, ai_base3)
  ai_base3:record_building({ 244, 74 }, "Forum")
  ai_base3:record_building({ 255, 64 }, "GuardPost", "RPG")
  ai_base3:record_building({ 237, 79 }, "Spaceport")
  ai_base3:record_building({ 224, 92 }, "ReinforcedResidence")
  ai_base3:record_building({ 254, 111 }, "MHDGenerator")
  ai_base3:record_building({ 249, 91 }, "RecreationFacility")
  ai_base3:record_building({ 254, 88 }, "MHDGenerator")
  ai_base3:record_building({ 242, 91 }, "ReinforcedResidence")
  ai_base3:record_building({ 246, 91 }, "MedicalCenter")
  ai_base3:record_tube({ 229, 83 })
  ai_base3:record_tube({ 229, 82 })
  ai_base3:record_tube({ 221, 83 })
  ai_base3:record_tube({ 220, 81 })
  ai_base3:record_tube({ 220, 82 })
  ai_base3:record_tube({ 220, 83 })
  ai_base3:record_tube({ 220, 84 })
  ai_base3:record_tube({ 220, 85 })
  ai_base3:record_tube({ 220, 86 })
  ai_base3:record_tube({ 220, 87 })
  ai_base3:record_tube({ 232, 88 })
  ai_base3:record_tube({ 233, 88 })
  ai_base3:record_tube({ 234, 88 })
  ai_base3:record_tube({ 224, 82 })
  ai_base3:record_tube({ 225, 79 })
  ai_base3:record_tube({ 225, 78 })
  ai_base3:record_tube({ 225, 77 })
  ai_base3:record_tube({ 225, 76 })
  ai_base3:record_tube({ 226, 72 })
  ai_base3:record_tube({ 227, 72 })
  ai_base3:record_tube({ 228, 72 })
  ai_base3:record_tube({ 229, 72 })
  ai_base3:record_tube({ 230, 72 })
  ai_base3:record_tube({ 231, 72 })
  ai_base3:record_tube({ 232, 72 })
  ai_base3:record_tube({ 232, 71 })
  ai_base3:record_tube({ 232, 70 })
  ai_base3:record_tube({ 232, 69 })
  ai_base3:record_tube({ 233, 69 })
  ai_base3:record_tube({ 234, 69 })
  ai_base3:record_tube({ 235, 69 })
  ai_base3:record_tube({ 236, 69 })
  ai_base3:record_tube({ 237, 69 })
  ai_base3:record_tube({ 238, 69 })
  ai_base3:record_tube({ 239, 69 })
  ai_base3:record_tube({ 240, 69 })
  ai_base3:record_tube({ 241, 69 })
  ai_base3:record_tube({ 224, 72 })
  ai_base3:record_tube({ 224, 71 })
  ai_base3:record_tube({ 228, 71 })
  ai_base3:record_tube({ 221, 89 })
  ai_base3:record_tube({ 221, 90 })
  ai_base3:record_tube({ 221, 91 })
  ai_base3:record_tube({ 221, 92 })
  ai_base3:record_tube({ 221, 93 })
  ai_base3:record_tube({ 221, 94 })
  ai_base3:record_tube({ 233, 68 })
  ai_base3:record_tube({ 233, 67 })
  ai_base3:record_tube({ 243, 67 })
  ai_base3:record_tube({ 243, 66 })
  ai_base3:record_tube({ 243, 65 })
  ai_base3:record_tube({ 243, 64 })
  ai_base3:record_tube({ 243, 63 })
  ai_base3:record_tube({ 247, 69 })
  ai_base3:record_tube({ 251, 69 })
  ai_base3:record_tube({ 234, 91 })
  ai_base3:record_tube({ 234, 92 })
  ai_base3:record_tube({ 234, 93 })
  ai_base3:record_tube({ 234, 94 })
  ai_base3:record_tube({ 235, 93 })
  ai_base3:record_tube({ 236, 93 })
  ai_base3:record_tube({ 237, 93 })
  ai_base3:record_tube({ 238, 93 })
  ai_base3:record_tube({ 239, 93 })
  ai_base3:record_tube({ 240, 93 })
  ai_base3:record_tube({ 241, 93 })
  ai_base3:record_tube({ 242, 93 })
  ai_base3:record_tube({ 242, 92 })
  ai_base3:record_tube({ 242, 92 })
  ai_base3:record_tube({ 243, 92 })
  ai_base3:record_tube({ 244, 92 })
  ai_base3:record_tube({ 245, 92 })
  ai_base3:record_tube({ 246, 92 })
  ai_base3:record_tube({ 247, 92 })
  ai_base3:record_tube({ 248, 92 })
  ai_base3:record_tube({ 249, 92 })
  ai_base3:record_tube({ 250, 92 })
  ai_base3:record_tube({ 251, 92 })
  ai_base3:record_tube({ 252, 92 })
  ai_base3:record_tube({ 252, 93 })
  ai_base3:record_tube({ 252, 94 })
  ai_base3:record_tube({ 252, 95 })
  ai_base3:record_tube({ 252, 96 })
  ai_base3:record_tube({ 252, 97 })
  ai_base3:record_tube({ 252, 98 })
  ai_base3:record_tube({ 224, 67 })
  ai_base3:record_tube({ 224, 68 })
  ai_base3:record_tube({ 224, 69 })
end

function TimeUpgrades(t)
  TimeUpgrades_step = TimeUpgrades_step + 1
  if TimeUpgrades_step == 1 then
  elseif TimeUpgrades_step == 2 then
  elseif TimeUpgrades_step == 3 then
  elseif TimeUpgrades_step == 4 then
    ai_player:set_tech_level(4)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "Microwave", 6)
    ai_fight1:set_targ_count("Panther", "Microwave", 1)
    ai_fight1:set_targ_count("Lynx", "Stickyfoam", 4)
    ai_fight1:set_targ_count("Lynx", "Starflare", 2)
    ai_fight3:set_targ_count("Lynx", "Microwave", 3)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight3:set_targ_count("Lynx", "Starflare", 2)
    ai_fight4:set_targ_count("Lynx", "Microwave", 6)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 3)
    ai_fight6:set_targ_count("Lynx", "Microwave", 4)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight2:set_targ_count("Lynx", "Microwave", 0)
    ai_fight5:set_targ_count("Lynx", "Microwave", 0)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 5 then
    ai_player:set_tech_level(5)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Lynx", "Microwave", 8)
    ai_fight1:set_targ_count("Panther", "Microwave", 1)
    ai_fight1:set_targ_count("Lynx", "Stickyfoam", 4)
    ai_fight1:set_targ_count("Lynx", "EMP", 2)
    ai_fight2:set_targ_count("Lynx", "EMP", 2)
    ai_fight3:set_targ_count("Lynx", "Microwave", 3)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Lynx", "Starflare", 2)
    ai_fight4:set_targ_count("Lynx", "Microwave", 8)
    ai_fight4:set_targ_count("Panther", "Microwave", 1)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 4)
    ai_fight4:set_targ_count("Lynx", "EMP", 2)
    ai_fight5:set_targ_count("Lynx", "EMP", 1)
    ai_fight6:set_targ_count("Lynx", "Microwave", 6)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight4:set_targ_count("Lynx", "EMP", 1)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 6 then
    ai_player:set_tech_level(6)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "Microwave", 4)
    ai_fight1:set_targ_count("Lynx", "Stickyfoam", 4)
    ai_fight1:set_targ_count("Lynx", "EMP", 6)
    ai_fight1:set_targ_count("Panther", "EMP", 6)
    ai_fight1:set_targ_count("Spider", nil, 6)
    ai_fight1:set_targ_count("Lynx", "Starflare", 2)
    ai_fight2:set_targ_count("Lynx", "EMP", 2)
    ai_fight3:set_targ_count("Lynx", "Microwave", 3)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 1)
    ai_fight3:set_targ_count("Spider", nil, 2)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Lynx", "Starflare", 2)
    ai_fight4:set_targ_count("Panther", "Microwave", 4)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 4)
    ai_fight4:set_targ_count("Lynx", "EMP", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 2)
    ai_fight4:set_targ_count("Spider", nil, 4)
    ai_fight5:set_targ_count("Lynx", "EMP", 1)
    ai_fight6:set_targ_count("Lynx", "Microwave", 3)
    ai_fight6:set_targ_count("Panther", "Microwave", 3)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Lynx", "EMP", 1)
    ai_fight6:set_targ_count("Spider", nil, 3)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 7 then
    ai_player:set_tech_level(7)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "RPG", 3)
    ai_fight1:set_targ_count("Panther", "Stickyfoam", 2)
    ai_fight1:set_targ_count("Lynx", "EMP", 2)
    ai_fight1:set_targ_count("Panther", "EMP", 6)
    ai_fight1:set_targ_count("Spider", nil, 12)
    ai_fight2:set_targ_count("Lynx", "EMP", 2)
    ai_fight2:set_targ_count("Lynx", "RPG", 2)
    ai_fight3:set_targ_count("Lynx", "RPG", 2)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 1)
    ai_fight3:set_targ_count("Spider", nil, 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "Starflare", 2)
    ai_fight4:set_targ_count("Panther", "Microwave", 1)
    ai_fight4:set_targ_count("Panther", "RPG", 4)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 3)
    ai_fight4:set_targ_count("Lynx", "EMP", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 2)
    ai_fight4:set_targ_count("Spider", nil, 8)
    ai_fight5:set_targ_count("Lynx", "EMP", 1)
    ai_fight6:set_targ_count("Lynx", "RPG", 3)
    ai_fight6:set_targ_count("Panther", "Microwave", 3)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Lynx", "EMP", 2)
    ai_fight6:set_targ_count("Spider", nil, 8)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 8 then
    ai_player:set_tech_level(8)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "Microwave", 1)
    ai_fight1:set_targ_count("Panther", "RPG", 3)
    ai_fight1:set_targ_count("Tiger", "RPG", 1)
    ai_fight1:set_targ_count("Panther", "Stickyfoam", 2)
    ai_fight1:set_targ_count("Lynx", "ESG", 2)
    ai_fight1:set_targ_count("Panther", "EMP", 4)
    ai_fight1:set_targ_count("Tiger", "EMP", 1)
    ai_fight1:set_targ_count("Spider", nil, 12)
    ai_fight2:set_targ_count("Lynx", "EMP", 2)
    ai_fight2:set_targ_count("Lynx", "RPG", 2)
    ai_fight3:set_targ_count("Lynx", "Microwave", 1)
    ai_fight3:set_targ_count("Lynx", "RPG", 1)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 1)
    ai_fight3:set_targ_count("Lynx", "ESG", 1)
    ai_fight3:set_targ_count("Spider", nil, 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 2)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "Starflare", 1)
    ai_fight3:set_targ_count("Lynx", "Supernova", 1)
    ai_fight4:set_targ_count("Panther", "Microwave", 2)
    ai_fight4:set_targ_count("Panther", "RPG", 8)
    ai_fight4:set_targ_count("Tiger", "RPG", 1)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 4)
    ai_fight4:set_targ_count("Lynx", "ESG", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 4)
    ai_fight4:set_targ_count("Spider", nil, 8)
    ai_fight5:set_targ_count("Lynx", "EMP", 2)
    ai_fight5:set_targ_count("Lynx", "RPG", 1)
    ai_fight6:set_targ_count("Lynx", "RPG", 3)
    ai_fight6:set_targ_count("Lynx", "Microwave", 1)
    ai_fight6:set_targ_count("Panther", "ESG", 3)
    ai_fight6:set_targ_count("Tiger", "RPG", 1)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Lynx", "EMP", 4)
    ai_fight6:set_targ_count("Spider", nil, 8)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 9 then
    ai_player:set_tech_level(9)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "Microwave", 1)
    ai_fight1:set_targ_count("Panther", "RPG", 1)
    ai_fight1:set_targ_count("Tiger", "RPG", 4)
    ai_fight1:set_targ_count("Panther", "Stickyfoam", 1)
    ai_fight1:set_targ_count("Lynx", "ESG", 3)
    ai_fight1:set_targ_count("Panther", "EMP", 4)
    ai_fight1:set_targ_count("Tiger", "EMP", 2)
    ai_fight1:set_targ_count("Spider", nil, 12)
    ai_fight2:set_targ_count("Lynx", "EMP", 2)
    ai_fight2:set_targ_count("Lynx", "RPG", 2)
    ai_fight3:set_targ_count("Lynx", "Microwave", 1)
    ai_fight3:set_targ_count("Lynx", "RPG", 1)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 1)
    ai_fight3:set_targ_count("Lynx", "ESG", 1)
    ai_fight3:set_targ_count("Spider", nil, 1)
    ai_fight3:set_targ_count("Lynx", "EMP", 1)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "Starflare", 1)
    ai_fight3:set_targ_count("Lynx", "Supernova", 1)
    ai_fight4:set_targ_count("Panther", "Microwave", 2)
    ai_fight4:set_targ_count("Panther", "RPG", 4)
    ai_fight4:set_targ_count("Tiger", "RPG", 4)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight4:set_targ_count("Lynx", "ESG", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 4)
    ai_fight4:set_targ_count("Tiger", "EMP", 2)
    ai_fight4:set_targ_count("Spider", nil, 8)
    ai_fight5:set_targ_count("Lynx", "EMP", 2)
    ai_fight5:set_targ_count("Lynx", "RPG", 1)
    ai_fight6:set_targ_count("Lynx", "RPG", 3)
    ai_fight6:set_targ_count("Tiger", "Microwave", 1)
    ai_fight6:set_targ_count("Panther", "ESG", 3)
    ai_fight6:set_targ_count("Tiger", "RPG", 2)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Lynx", "EMP", 4)
    ai_fight6:set_targ_count("Panther", "EMP", 4)
    ai_fight6:set_targ_count("Spider", nil, 8)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 10 then
    ai_player:set_tech_level(10)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Panther", "Microwave", 2)
    ai_fight1:set_targ_count("Tiger", "RPG", 6)
    ai_fight1:set_targ_count("Panther", "Stickyfoam", 1)
    ai_fight1:set_targ_count("Lynx", "ESG", 2)
    ai_fight1:set_targ_count("Tiger", "ESG", 1)
    ai_fight1:set_targ_count("Panther", "EMP", 2)
    ai_fight1:set_targ_count("Tiger", "EMP", 4)
    ai_fight1:set_targ_count("Spider", nil, 10)
    ai_fight2:set_targ_count("Lynx", "EMP", 7)
    ai_fight2:set_targ_count("Lynx", "RPG", 5)
    ai_fight3:set_targ_count("Lynx", "Microwave", 1)
    ai_fight3:set_targ_count("Lynx", "RPG", 3)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight3:set_targ_count("Lynx", "ESG", 1)
    ai_fight3:set_targ_count("Spider", nil, 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 3)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "Supernova", 3)
    ai_fight4:set_targ_count("Panther", "Microwave", 2)
    ai_fight4:set_targ_count("Panther", "RPG", 2)
    ai_fight4:set_targ_count("Tiger", "RPG", 6)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight4:set_targ_count("Lynx", "ESG", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 4)
    ai_fight4:set_targ_count("Tiger", "EMP", 4)
    ai_fight4:set_targ_count("Spider", nil, 8)
    ai_fight5:set_targ_count("Lynx", "EMP", 4)
    ai_fight5:set_targ_count("Lynx", "RPG", 5)
    ai_fight6:set_targ_count("Lynx", "RPG", 2)
    ai_fight6:set_targ_count("Tiger", "Microwave", 1)
    ai_fight6:set_targ_count("Panther", "ESG", 3)
    ai_fight6:set_targ_count("Tiger", "RPG", 4)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Lynx", "EMP", 4)
    ai_fight6:set_targ_count("Tiger", "EMP", 4)
    ai_fight6:set_targ_count("Spider", nil, 8)
    ai_fight7:set_targ_count("Lynx", "Microwave", 0)
  elseif TimeUpgrades_step == 11 then
    ai_player:set_tech_level(11)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Tiger", "Microwave", 1)
    ai_fight1:set_targ_count("Panther", "Microwave", 1)
    ai_fight1:set_targ_count("Tiger", "RPG", 5)
    ai_fight1:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight1:set_targ_count("Panther", "ESG", 2)
    ai_fight1:set_targ_count("Panther", "EMP", 4)
    ai_fight1:set_targ_count("Tiger", "EMP", 4)
    ai_fight1:set_targ_count("Spider", nil, 9)
    ai_fight2:set_targ_count("Lynx", "EMP", 4)
    ai_fight2:set_targ_count("Lynx", "RPG", 4)
    ai_fight4:set_targ_count("Tiger", "Microwave", 1)
    ai_fight4:set_targ_count("Panther", "Microwave", 1)
    ai_fight4:set_targ_count("Tiger", "RPG", 5)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight4:set_targ_count("Panther", "ESG", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 4)
    ai_fight4:set_targ_count("Tiger", "EMP", 4)
    ai_fight4:set_targ_count("Spider", nil, 9)
    ai_fight5:set_targ_count("Lynx", "EMP", 4)
    ai_fight5:set_targ_count("Lynx", "RPG", 4)
    ai_fight6:set_targ_count("Tiger", "Microwave", 1)
    ai_fight6:set_targ_count("Panther", "Microwave", 1)
    ai_fight6:set_targ_count("Tiger", "RPG", 5)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Panther", "ESG", 2)
    ai_fight6:set_targ_count("Panther", "EMP", 4)
    ai_fight6:set_targ_count("Tiger", "EMP", 4)
    ai_fight6:set_targ_count("Spider", nil, 9)
    ai_fight7:set_targ_count("Lynx", "EMP", 4)
    ai_fight7:set_targ_count("Lynx", "RPG", 4)
    ai_fight3:set_targ_count("Lynx", "Microwave", 1)
    ai_fight3:set_targ_count("Lynx", "RPG", 3)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight3:set_targ_count("Lynx", "ESG", 1)
    ai_fight3:set_targ_count("Spider", nil, 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 3)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "Supernova", 3)
  elseif TimeUpgrades_step == 12 then
    ai_player:set_tech_level(12)
    ai_fight1:clear_targ_count()
    ai_fight2:clear_targ_count()
    ai_fight3:clear_targ_count()
    ai_fight4:clear_targ_count()
    ai_fight5:clear_targ_count()
    ai_fight6:clear_targ_count()
    ai_fight7:clear_targ_count()
    ai_fight1:set_targ_count("Tiger", "Microwave", 1)
    ai_fight1:set_targ_count("Panther", "Microwave", 1)
    ai_fight1:set_targ_count("Tiger", "RPG", 5)
    ai_fight1:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight1:set_targ_count("Panther", "ESG", 2)
    ai_fight1:set_targ_count("Panther", "EMP", 4)
    ai_fight1:set_targ_count("Tiger", "EMP", 4)
    ai_fight1:set_targ_count("Spider", nil, 9)
    ai_fight2:set_targ_count("Lynx", "EMP", 4)
    ai_fight2:set_targ_count("Lynx", "RPG", 4)
    ai_fight4:set_targ_count("Tiger", "Microwave", 1)
    ai_fight4:set_targ_count("Panther", "Microwave", 1)
    ai_fight4:set_targ_count("Tiger", "RPG", 5)
    ai_fight4:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight4:set_targ_count("Panther", "ESG", 2)
    ai_fight4:set_targ_count("Panther", "EMP", 4)
    ai_fight4:set_targ_count("Tiger", "EMP", 4)
    ai_fight4:set_targ_count("Spider", nil, 9)
    ai_fight5:set_targ_count("Lynx", "EMP", 4)
    ai_fight5:set_targ_count("Lynx", "RPG", 4)
    ai_fight6:set_targ_count("Tiger", "Microwave", 1)
    ai_fight6:set_targ_count("Panther", "Microwave", 1)
    ai_fight6:set_targ_count("Tiger", "RPG", 5)
    ai_fight6:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight6:set_targ_count("Panther", "ESG", 2)
    ai_fight6:set_targ_count("Panther", "EMP", 4)
    ai_fight6:set_targ_count("Tiger", "EMP", 4)
    ai_fight6:set_targ_count("Spider", nil, 9)
    ai_fight7:set_targ_count("Lynx", "EMP", 4)
    ai_fight7:set_targ_count("Lynx", "RPG", 4)
    ai_fight3:set_targ_count("Lynx", "Microwave", 1)
    ai_fight3:set_targ_count("Lynx", "RPG", 3)
    ai_fight3:set_targ_count("Lynx", "Stickyfoam", 2)
    ai_fight3:set_targ_count("Lynx", "ESG", 1)
    ai_fight3:set_targ_count("Spider", nil, 2)
    ai_fight3:set_targ_count("Lynx", "EMP", 3)
    ai_fight3:set_targ_count("Scorpion", "EnergyCannon", 6)
    ai_fight3:set_targ_count("Lynx", "Supernova", 3)
  else
    ai_fight8:set_delete_when_empty(true)
    t:destroy()
  end
end

-- Every 40 ticks: the colony fails at once with fewer than 8 workers or 3 scientists, with nothing that can build
-- for space, or with no income of an ore whose evacuation isn't met yet (0x1100A550).
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  local fail = p.workers < 8 or p.scientists < 3
  if not p:can_build_space() then fail = true end
  if not t14:has_fired(1) and not p:can_accumulate_ore() then fail = true end
  if not t16:has_fired(1) and not p:can_accumulate_rare_ore() then fail = true end
  if fail then mission.failure(trigger.time{time = 1}) end
end

-- A meteor of size 1 on a wild tile (0x1100AC70); the next in 10 to 40 marks.
function DoMeteor(t)
  game.create_meteor(wild_tile(), 1)
  t:destroy()
  trigger.time{min = 1000, max = 4000, one_shot = false, on = DoMeteor}
end

-- An earthquake of magnitude 1 on a wild tile (0x1100A8D0); the next in 20 to 400 marks.
function DoQuake(t)
  game.create_earthquake(wild_tile(), 1)
  t:destroy()
  trigger.time{min = 2000, max = 40000, one_shot = false, on = DoQuake}
end

-- A storm of 10 ticks from one wild tile to another (0x1100A9B0); the next in 20 to 400 marks.
function DoLightning(t)
  local from = wild_tile()
  game.create_lightning(from, wild_tile(), 10)
  t:destroy()
  trigger.time{min = 2000, max = 40000, one_shot = false, on = DoLightning}
end

-- A vortex of 10 ticks from one wild tile to another (0x1100AB10); the next in 20 to 400 marks.
function DoTornado(t)
  local from = wild_tile()
  game.create_tornado(from, wild_tile(), 10)
  t:destroy()
  trigger.time{min = 2000, max = 40000, one_shot = false, on = DoTornado}
end

-- Every 97 ticks once base 2 is set up: when it has a Common Ore Smelter, its mining group wants 5 Cargo Trucks, it
-- counts as up, base 1's expansion comes in 30 to 40 marks unless it has begun, and fight group 4 guards base 2,
-- built for by base 2 (with group 5) instead of base 1; then it waits for a Rare Ore Smelter (0x11007440).
function Base2CommonCheck(t)
  if not ai_base2:first_of_type("CommonOreSmelter", "None") then return end
  base2_mining:set_targ_count("CargoTruck", nil, 5)
  bases_up = bases_up + 1
  if not expand_b_done then
    expand_trigger:destroy()
    expand_trigger = trigger.time{min = 3000, max = 4000, on = ExpandBase1_B}
  end
  ai_fight4:do_guard_rect()
  ai_fight4:set_rect({ 8, 19, 23, 36 })
  ai_fight4:clear_guarded_rects()
  ai_fight4:add_guarded_rect({ 0, 2, 38, 54 })
  ai_base1:unrecord_veh_group(ai_fight4)
  ai_base2:record_veh_reinforce_group(ai_fight4, 10)
  ai_base2:record_veh_reinforce_group(ai_fight5, 7)
  t:destroy()
  trigger.time{time = 97, one_shot = false, on = Base2RareCheck}
end

-- Base 1's second expansion: fight group 1 guards a new area, the third comes 1000 marks into the game (at least 100
-- marks from now, and up to 1/8 more), and base 1 records its new buildings (0x110058F0; the list from `op2dll calls
-- --call ExpandBase1_B`, alike at each difficulty, by tools/calls_to_lua.py).
function ExpandBase1_B(t)
  expand_b_done = true
  ai_fight1:set_rect({ 155, 142, 177, 160 })
  ai_fight1:clear_guarded_rects()
  ai_fight1:add_guarded_rect({ 143, 123, 193, 165 })
  ai_fight1:add_guarded_rect({ 142, 167, 165, 179 })
  expand_trigger:destroy()
  local wait = math.max(100000 - game.tick(), 10000)
  expand_trigger = trigger.time{min = wait, max = wait + wait // 8, on = ExpandBase1_C}
  ai_base1:record_building({ 160, 139 }, "Forum")
  ai_base1:record_building({ 156, 139 }, "ReinforcedResidence")
  ai_base1:record_building({ 152, 139 }, "ReinforcedResidence")
  ai_base1:record_building({ 148, 139 }, "CommandCenter")
  ai_base1:record_building({ 148, 154 }, "MHDGenerator")
  ai_base1:record_building({ 156, 131 }, "VehicleFactory", nil, ai_base1)
  ai_base1:record_building({ 156, 136 }, "Agridome")
  ai_base1:record_building({ 152, 136 }, "RecreationFacility")
  ai_base1:record_building({ 144, 143 }, "DIRT")
  ai_base1:record_building({ 145, 139 }, "ArachnidFactory", nil, ai_base1)
  ai_base1:record_building({ 142, 139 }, "RareStorage")
  ai_base1:record_building({ 144, 147 }, "StructureFactory", nil, ai_base1)
  ai_base1:record_building({ 143, 151 }, "DIRT")
  ai_base1:record_building({ 160, 131 }, "CommonStorage")
  ai_base1:record_building({ 183, 165 }, "MHDGenerator")
  ai_base1:record_building({ 138, 153 }, "GuardPost", "EMP")
  ai_base1:record_building({ 137, 148 }, "GuardPost", "Stickyfoam")
  ai_base1:record_building({ 203, 156 }, "MHDGenerator")
  ai_base1:record_building({ 145, 133 }, "GuardPost", "RPG")
  ai_base1:record_building({ 145, 128 }, "GuardPost", "ESG")
  ai_base1:record_building({ 163, 130 }, "GuardPost", "Stickyfoam")
  ai_base1:record_building({ 139, 139 }, "GuardPost", "EMP")
  ai_base1:record_tube({ 162, 144 })
  ai_base1:record_tube({ 162, 143 })
  ai_base1:record_tube({ 162, 143 })
  ai_base1:record_tube({ 162, 142 })
  ai_base1:record_tube({ 162, 141 })
  ai_base1:record_tube({ 162, 140 })
  ai_base1:record_tube({ 162, 139 })
  ai_base1:record_tube({ 162, 138 })
  ai_base1:record_tube({ 162, 137 })
  ai_base1:record_tube({ 162, 136 })
  ai_base1:record_tube({ 162, 135 })
  ai_base1:record_tube({ 162, 134 })
  ai_base1:record_tube({ 162, 133 })
  ai_base1:record_tube({ 162, 132 })
  ai_base1:record_tube({ 162, 131 })
  ai_base1:record_tube({ 159, 131 })
  ai_base1:record_tube({ 156, 134 })
  ai_base1:record_tube({ 145, 141 })
  ai_base1:record_tube({ 141, 139 })
  ai_base1:record_tube({ 144, 145 })
  ai_base1:record_tube({ 145, 147 })
  ai_base1:record_tube({ 146, 147 })
  ai_base1:record_tube({ 147, 147 })
  ai_base1:record_tube({ 148, 147 })
  ai_base1:record_tube({ 149, 147 })
  ai_base1:record_tube({ 150, 147 })
  ai_base1:record_tube({ 145, 137 })
  ai_base1:record_tube({ 145, 136 })
  ai_base1:record_tube({ 145, 135 })
  ai_base1:record_tube({ 145, 132 })
  ai_base1:record_tube({ 145, 131 })
  ai_base1:record_tube({ 145, 130 })
  ai_base1:record_tube({ 141, 139 })
  ai_base1:record_tube({ 141, 148 })
  ai_base1:record_tube({ 140, 148 })
  ai_base1:record_tube({ 139, 148 })
  ai_base1:record_tube({ 143, 153 })
  ai_base1:record_tube({ 142, 153 })
  ai_base1:record_tube({ 141, 153 })
  ai_base1:record_tube({ 140, 153 })
end

-- Not written yet: base 2's wait for a Rare Ore Smelter, which Base2CommonCheck starts.
function Base2RareCheck(t) end

-- A wave of the computer's (0x11001460): the last wave's groups go when empty, its escort attacks; the area is the
-- first with more than 2 of player 1's buildings; a new wave and its escort gather there. The first wave is one
-- Microwave Lynx for the scouts' group, the second and third none; from the fourth, units of the base groups join,
-- each by a draw against a share that grows with player 1's strength and the time (Microwave Lynxes, up to 11
-- Spiders, EMP and RPG Lynxes to the escort now and then), at most 30; a wave with no Microwave Lynx gets the first
-- found. From the sixth, fight group 3 attacks the area's target. Lights are on unless a draw says not; an idle
-- Spaceport builds an EMP missile; the wave sets out after the area's wait (half again in the dark).
function SpawnAttack(t)
  if wave_group then wave_group:set_delete_when_empty(true) end
  if wave_escort then
    wave_escort:set_delete_when_empty(true)
    wave_escort:do_attack_enemy()
    wave_escort:set_rect(ESCORT_HOME)
  end
  local area, best = #ATTACK_AREAS, #ATTACK_TYPES
  for i = 1, #ATTACK_AREAS - 1 do
    local n = 0
    for _, b in ipairs(players[1]:buildings()) do
      if in_rect(b.x, b.y, ATTACK_AREAS[i].area) then
        for j = 1, best - 1 do
          if ATTACK_TYPES[j] == b.type then best = j break end
        end
        n = n + 1
      end
    end
    if n > 2 then area = i break end
  end
  wave_area, wave_target = area, ATTACK_TYPES[best]
  waves = waves + 1
  local a = ATTACK_AREAS[area]
  wave_group = ai.fight_group(ai_player)
  wave_group:do_guard_rect()
  wave_group:set_rect(a.rally)
  wave_escort = ai.fight_group(ai_player)
  wave_escort:do_guard_group()
  wave_escort:set_follow_mode(0)
  wave_escort:set_target_group(wave_group)
  wave_escort:set_rect(a.rally)
  local sources = { ai_fight1, ai_fight4, ai_fight6, ai_fight5, ai_fight7, ai_fight2 }
  local taken, spiders, escorts, microwaves = 0, 0, 0, 0
  if waves == 1 then
    local u = game.create_unit{ type = "Lynx", weapon = "Microwave", player = ai_player, at = { 180, 151 }, exact = true, lights = false }[1]
    if u then ai_fight8:take_unit(u) end
    microwaves = 1
  elseif waves <= 3 then
    microwaves = 2 - waves
  else
    local share = bases_up * 17 + 33
    local strength = players[1]:total_strength()
    if players[1].difficulty == "Normal" then strength = strength * 7 // 8 end
    local count = 0
    for _, g in ipairs(sources) do count = count + g:unit_count() end
    if count == 0 then count = 1 end
    share = math.min(share, strength * 100 // count)
    share = math.max(share, game.tick() // (players[1].difficulty == "Normal" and 11000 or 9000))
    for _, g in ipairs(sources) do
      for _, u in ipairs(g:units()) do
        if game.rand(100) <= share then
          local weapon, kind = u.weapon, u.type
          local to = wave_group
          if weapon == "Microwave" then
            microwaves = microwaves + 1
          elseif kind == "Spider" then
            to = "spider"
          elseif kind == "Lynx" and (weapon == "EMP" or weapon == "RPG")
              and (taken > 20 or (taken - spiders > 8 and game.rand(100) < 25)) then
            to = wave_escort
          end
          if to == "spider" then
            -- Spiders join while there are 11 at most, without the count of 30.
            if spiders <= 10 then
              taken, spiders = taken + 1, spiders + 1
              g:remove_unit(u)
              wave_group:take_unit(u)
            end
          else
            if to == wave_escort then escorts = escorts + 1 else taken = taken + 1 end
            g:remove_unit(u)
            to:take_unit(u)
            if taken >= 30 then break end
          end
        end
      end
      if taken >= 30 or escorts >= 30 then break end
    end
  end
  if microwaves == 0 then
    for _, g in ipairs(sources) do
      local found
      for _, u in ipairs(g:units()) do
        if u.weapon == "Microwave" then found = u break end
      end
      if found then
        g:remove_unit(found)
        wave_group:take_unit(found)
        break
      end
    end
  end
  if waves >= 6 then
    wave_attack = ai.fight_group(ai_player)
    wave_attack:do_attack_enemy()
    wave_attack:set_attack_type(wave_target)
    wave_attack:set_rect(a.rally)
    wave_attack:take_all_units(ai_fight3)
    wave_attack:set_lights(false)
  end
  local lights = game.rand(100) > 25
  wave_group:set_lights(lights)
  wave_escort:set_lights(lights)
  local port = ai_player:buildings("Spaceport")[1]
  if port and not port.busy and port.object_on_pad ~= "EMPMissile" then
    if ai_player.ore < 4000 then ai_player.ore = ai_player.ore + 4000 end
    port:develop("EMPMissile")
  end
  attack_trigger:destroy()
  attack_trigger = trigger.time{time = lights and a.wait or a.wait * 3 // 2, on = StageDone}
end

-- The wave sets out (0x11001B80): it attacks, its escort follows, lights on; on Normal the first three go for the
-- Command Center or the Structure Factory by a draw. A Spaceport with an EMP missile ready fires it where the game
-- finds player 1's units thickest in the wave's area. The next wave comes 7/8 of the time between waves out, plus a
-- draw of up to 1/8, less this area's wait (at least 10 marks).
function StageDone(t)
  wave_group:do_attack_enemy()
  wave_group:set_rect(ESCORT_HOME)
  if players[1].difficulty == "Normal" and waves <= 3 then
    wave_group:set_attack_type(game.rand(100) > 49 and "CommandCenter" or "StructureFactory")
  end
  wave_group:set_lights(true)
  wave_escort:set_follow_mode(1)
  wave_escort:set_lights(true)
  if wave_attack then wave_attack:set_delete_when_empty(true) end
  local a = ATTACK_AREAS[wave_area]
  local port = ai_player:buildings("Spaceport")[1]
  if port and not port.busy and port.object_on_pad == "EMPMissile" then
    local at = game.find_emp_missile_target(a.area, players[1])
    port:launch_at_pixel(at.x * 32, at.y * 32)
  end
  attack_trigger:destroy()
  local period = WAVE_PERIOD[players[1].difficulty]
  local wait = game.rand(period // 8) + period * 7 // 8 - a.wait
  attack_trigger = trigger.time{time = math.max(wait, 1000), on = SpawnAttack}
end

-- Every 97 ticks once base 3 is set up: when it has a Common Ore Smelter, its mining group wants 5 Cargo Trucks, it
-- counts as up, and fight group 6 guards base 3 (6 Microwave Lynxes), built for by base 3 (with group 7) instead
-- of base 1; then it waits for a Rare Ore Smelter (0x110095E0).
function Base3CommonCheck(t)
  if not ai_base3:first_of_type("CommonOreSmelter", "None") then return end
  base3_mining:set_targ_count("CargoTruck", nil, 5)
  bases_up = bases_up + 1
  ai_fight6:do_guard_rect()
  ai_fight6:set_rect({ 223, 71, 236, 90 })
  ai_fight6:clear_guarded_rects()
  ai_fight6:add_guarded_rect({ 216, 56, 256, 102 })
  ai_fight6:add_guarded_rect({ 226, 103, 256, 117 })
  ai_fight6:set_targ_count("Lynx", "Microwave", 6)
  ai_base1:unrecord_veh_group(ai_fight6)
  ai_base3:record_veh_reinforce_group(ai_fight6, 10)
  ai_base3:record_veh_reinforce_group(ai_fight7, 7)
  t:destroy()
  trigger.time{time = 97, one_shot = false, on = Base3RareCheck}
end

-- Not written yet: base 3's wait for a Rare Ore Smelter, which Base3CommonCheck starts.
function Base3RareCheck(t) end

-- Easy's move instead of a wave (0x11001D60): a new group of player 2's, in the wave's slot, leaves the map by
-- 256,5 - 257,25 (0x11018140) and is deleted once empty. It takes, unit by unit, those of fight groups 1, 4, 6, 5, 7
-- and 2 (the list at 0x11014198) for which a draw of 100 comes to 50 or less, at most 31; the next comes 7/8 of the
-- time between waves and a draw of up to 1/8 of it later.
function ExitMapMultiple(t)
  wave_group = ai.fight_group(players[2])
  wave_group:do_exit_map()
  wave_group:set_rect({ 256, 5, 257, 25 })
  wave_group:set_delete_when_empty(true)
  local taken = 0
  for _, g in ipairs({ ai_fight1, ai_fight4, ai_fight6, ai_fight5, ai_fight7, ai_fight2 }) do
    for _, u in ipairs(g:units()) do
      if game.rand(100) <= 50 then
        taken = taken + 1
        g:remove_unit(u)
        wave_group:take_unit(u)
        if taken == 31 then break end
      end
    end
    if taken == 31 then break end
  end
  attack_trigger:destroy()
  local period = WAVE_PERIOD[players[1].difficulty] or 14000
  local wait = game.rand(period // 8)
  attack_trigger = trigger.time{time = period * 7 // 8 + wait, on = ExitMapMultiple}
end

-- Not written yet: base 1's third expansion, which ExpandBase1_B starts.
function ExpandBase1_C(t) end

-- Every 50 marks: player 2 gets ore and rare ore by player 1's difficulty, and 2000 more ore before tick 30000
-- (0x110049A0).
function GiveAIOre(t)
  local early = game.tick() < 30000 and 2000 or 0
  local level = players[1].difficulty
  players[2].ore = (AI_ORE[level] or 2000) + players[2].ore + early
  players[2].rare_ore = (AI_RARE_ORE[level] or 300) + players[2].rare_ore
end

-- At tick 90000 lava flows faster: speed 150 (0x1100B990).
function LavaSpeedup(t)
  game.set_lava_speed(150)
  t:destroy()
end

-- Easy's morale lock lasts 10 ticks: then every player's morale is free (FreeMoraleLevel(-1)).
function ReleaseMorale(t)
  game.free_morale()
end

function on_init()
  local difficulty = DIFFICULTIES[players[1].difficulty] and players[1].difficulty or "Normal"
  local d = DIFFICULTIES[difficulty]
  print("Difficulty: " .. difficulty)
  make_things(d)
  make_in_order(d, BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.set_cell_type({ 151, 165 }, 21)
  game.initial_set_tile({ 151, 165 }, 409)
  game.set_cell_type({ 151, 166 }, 21)
  game.initial_set_tile({ 151, 166 }, 409)
  game.set_cell_type({ 151, 167 }, 21)
  game.initial_set_tile({ 151, 167 }, 409)
  game.set_cell_type({ 151, 168 }, 21)
  game.initial_set_tile({ 151, 168 }, 409)
  game.set_cell_type({ 151, 169 }, 21)
  game.initial_set_tile({ 151, 169 }, 409)
  game.set_cell_type({ 151, 170 }, 21)
  game.initial_set_tile({ 151, 170 }, 409)
  game.set_cell_type({ 151, 171 }, 21)
  game.initial_set_tile({ 151, 171 }, 409)
  game.set_cell_type({ 151, 172 }, 21)
  game.initial_set_tile({ 151, 172 }, 409)
  game.set_cell_type({ 151, 173 }, 21)
  game.initial_set_tile({ 151, 173 }, 409)
  game.set_cell_type({ 151, 174 }, 21)
  game.initial_set_tile({ 151, 174 }, 409)
  game.set_cell_type({ 152, 158 }, 21)
  game.initial_set_tile({ 152, 158 }, 409)
  game.set_cell_type({ 152, 159 }, 21)
  game.initial_set_tile({ 152, 159 }, 409)
  game.set_cell_type({ 152, 160 }, 21)
  game.initial_set_tile({ 152, 160 }, 409)
  game.set_cell_type({ 152, 161 }, 21)
  game.initial_set_tile({ 152, 161 }, 409)
  game.set_cell_type({ 152, 162 }, 21)
  game.initial_set_tile({ 152, 162 }, 409)
  game.set_cell_type({ 152, 163 }, 21)
  game.initial_set_tile({ 152, 163 }, 409)
  game.set_cell_type({ 152, 164 }, 21)
  game.initial_set_tile({ 152, 164 }, 409)
  game.set_cell_type({ 152, 165 }, 21)
  game.initial_set_tile({ 152, 165 }, 409)
  game.set_cell_type({ 152, 166 }, 21)
  game.initial_set_tile({ 152, 166 }, 409)
  game.set_cell_type({ 152, 167 }, 21)
  game.initial_set_tile({ 152, 167 }, 409)
  game.set_cell_type({ 152, 168 }, 21)
  game.initial_set_tile({ 152, 168 }, 409)
  game.set_cell_type({ 152, 169 }, 21)
  game.initial_set_tile({ 152, 169 }, 409)
  game.set_cell_type({ 152, 170 }, 21)
  game.initial_set_tile({ 152, 170 }, 409)
  game.set_cell_type({ 152, 171 }, 21)
  game.initial_set_tile({ 152, 171 }, 409)
  game.set_cell_type({ 152, 172 }, 21)
  game.initial_set_tile({ 152, 172 }, 409)
  game.set_cell_type({ 152, 173 }, 21)
  game.initial_set_tile({ 152, 173 }, 409)
  game.set_cell_type({ 152, 174 }, 21)
  game.initial_set_tile({ 152, 174 }, 409)
  game.set_cell_type({ 153, 158 }, 21)
  game.initial_set_tile({ 153, 158 }, 409)
  game.set_cell_type({ 153, 159 }, 21)
  game.initial_set_tile({ 153, 159 }, 409)
  game.set_cell_type({ 153, 160 }, 21)
  game.initial_set_tile({ 153, 160 }, 409)
  game.set_cell_type({ 153, 161 }, 21)
  game.initial_set_tile({ 153, 161 }, 409)
  game.set_cell_type({ 153, 162 }, 21)
  game.initial_set_tile({ 153, 162 }, 409)
  game.set_cell_type({ 153, 163 }, 21)
  game.initial_set_tile({ 153, 163 }, 409)
  game.set_cell_type({ 153, 164 }, 21)
  game.initial_set_tile({ 153, 164 }, 409)
  game.set_cell_type({ 153, 165 }, 21)
  game.initial_set_tile({ 153, 165 }, 409)
  game.set_cell_type({ 153, 166 }, 21)
  game.initial_set_tile({ 153, 166 }, 409)
  game.set_cell_type({ 153, 167 }, 21)
  game.initial_set_tile({ 153, 167 }, 409)
  game.set_cell_type({ 153, 169 }, 21)
  game.initial_set_tile({ 153, 169 }, 409)
  game.set_cell_type({ 153, 170 }, 21)
  game.initial_set_tile({ 153, 170 }, 409)
  game.set_cell_type({ 153, 171 }, 21)
  game.initial_set_tile({ 153, 171 }, 409)
  game.set_cell_type({ 153, 172 }, 21)
  game.initial_set_tile({ 153, 172 }, 409)
  game.set_cell_type({ 153, 173 }, 21)
  game.initial_set_tile({ 153, 173 }, 409)
  game.set_cell_type({ 153, 174 }, 21)
  game.initial_set_tile({ 153, 174 }, 409)
  game.set_cell_type({ 154, 158 }, 21)
  game.initial_set_tile({ 154, 158 }, 409)
  game.set_cell_type({ 154, 159 }, 21)
  game.initial_set_tile({ 154, 159 }, 409)
  game.set_cell_type({ 154, 160 }, 21)
  game.initial_set_tile({ 154, 160 }, 409)
  game.set_cell_type({ 154, 161 }, 21)
  game.initial_set_tile({ 154, 161 }, 409)
  game.set_cell_type({ 154, 162 }, 21)
  game.initial_set_tile({ 154, 162 }, 409)
  game.set_cell_type({ 154, 163 }, 21)
  game.initial_set_tile({ 154, 163 }, 409)
  game.set_cell_type({ 154, 164 }, 21)
  game.initial_set_tile({ 154, 164 }, 409)
  game.set_cell_type({ 154, 165 }, 21)
  game.initial_set_tile({ 154, 165 }, 409)
  game.set_cell_type({ 154, 166 }, 21)
  game.initial_set_tile({ 154, 166 }, 409)
  game.set_cell_type({ 154, 170 }, 21)
  game.initial_set_tile({ 154, 170 }, 409)
  game.set_cell_type({ 154, 171 }, 21)
  game.initial_set_tile({ 154, 171 }, 409)
  game.set_cell_type({ 154, 172 }, 21)
  game.initial_set_tile({ 154, 172 }, 409)
  game.set_cell_type({ 154, 173 }, 21)
  game.initial_set_tile({ 154, 173 }, 409)
  game.set_cell_type({ 154, 174 }, 21)
  game.initial_set_tile({ 154, 174 }, 409)
  game.set_cell_type({ 155, 153 }, 21)
  game.initial_set_tile({ 155, 153 }, 409)
  game.set_cell_type({ 155, 154 }, 21)
  game.initial_set_tile({ 155, 154 }, 409)
  game.set_cell_type({ 155, 155 }, 21)
  game.initial_set_tile({ 155, 155 }, 409)
  game.set_cell_type({ 155, 156 }, 21)
  game.initial_set_tile({ 155, 156 }, 409)
  game.set_cell_type({ 155, 157 }, 21)
  game.initial_set_tile({ 155, 157 }, 409)
  game.set_cell_type({ 155, 158 }, 21)
  game.initial_set_tile({ 155, 158 }, 409)
  game.set_cell_type({ 155, 159 }, 21)
  game.initial_set_tile({ 155, 159 }, 409)
  game.set_cell_type({ 155, 160 }, 21)
  game.initial_set_tile({ 155, 160 }, 409)
  game.set_cell_type({ 155, 161 }, 21)
  game.initial_set_tile({ 155, 161 }, 409)
  game.set_cell_type({ 155, 162 }, 21)
  game.initial_set_tile({ 155, 162 }, 409)
  game.set_cell_type({ 155, 163 }, 21)
  game.initial_set_tile({ 155, 163 }, 409)
  game.set_cell_type({ 155, 164 }, 21)
  game.initial_set_tile({ 155, 164 }, 409)
  game.set_cell_type({ 155, 165 }, 21)
  game.initial_set_tile({ 155, 165 }, 409)
  game.set_cell_type({ 155, 166 }, 21)
  game.initial_set_tile({ 155, 166 }, 409)
  game.set_cell_type({ 155, 170 }, 21)
  game.initial_set_tile({ 155, 170 }, 409)
  game.set_cell_type({ 155, 171 }, 21)
  game.initial_set_tile({ 155, 171 }, 409)
  game.set_cell_type({ 155, 172 }, 21)
  game.initial_set_tile({ 155, 172 }, 409)
  game.set_cell_type({ 155, 173 }, 21)
  game.initial_set_tile({ 155, 173 }, 409)
  game.set_cell_type({ 155, 174 }, 21)
  game.initial_set_tile({ 155, 174 }, 409)
  game.set_cell_type({ 156, 153 }, 21)
  game.initial_set_tile({ 156, 153 }, 409)
  game.set_cell_type({ 156, 154 }, 21)
  game.initial_set_tile({ 156, 154 }, 409)
  game.set_cell_type({ 156, 155 }, 21)
  game.initial_set_tile({ 156, 155 }, 409)
  game.set_cell_type({ 156, 156 }, 21)
  game.initial_set_tile({ 156, 156 }, 409)
  game.set_cell_type({ 156, 157 }, 21)
  game.initial_set_tile({ 156, 157 }, 409)
  game.set_cell_type({ 156, 158 }, 21)
  game.initial_set_tile({ 156, 158 }, 409)
  game.set_cell_type({ 156, 159 }, 21)
  game.initial_set_tile({ 156, 159 }, 409)
  game.set_cell_type({ 156, 160 }, 21)
  game.initial_set_tile({ 156, 160 }, 409)
  game.set_cell_type({ 156, 161 }, 21)
  game.initial_set_tile({ 156, 161 }, 409)
  game.set_cell_type({ 156, 162 }, 21)
  game.initial_set_tile({ 156, 162 }, 409)
  game.set_cell_type({ 156, 163 }, 21)
  game.initial_set_tile({ 156, 163 }, 409)
  game.set_cell_type({ 156, 164 }, 21)
  game.initial_set_tile({ 156, 164 }, 409)
  game.set_cell_type({ 156, 165 }, 21)
  game.initial_set_tile({ 156, 165 }, 409)
  game.set_cell_type({ 156, 166 }, 21)
  game.initial_set_tile({ 156, 166 }, 409)
  game.set_cell_type({ 156, 170 }, 21)
  game.initial_set_tile({ 156, 170 }, 409)
  game.set_cell_type({ 156, 171 }, 21)
  game.initial_set_tile({ 156, 171 }, 409)
  game.set_cell_type({ 156, 172 }, 21)
  game.initial_set_tile({ 156, 172 }, 409)
  game.set_cell_type({ 156, 173 }, 21)
  game.initial_set_tile({ 156, 173 }, 409)
  game.set_cell_type({ 156, 174 }, 21)
  game.initial_set_tile({ 156, 174 }, 409)
  game.set_cell_type({ 157, 153 }, 21)
  game.initial_set_tile({ 157, 153 }, 409)
  game.set_cell_type({ 157, 154 }, 21)
  game.initial_set_tile({ 157, 154 }, 409)
  game.set_cell_type({ 157, 155 }, 21)
  game.initial_set_tile({ 157, 155 }, 409)
  game.set_cell_type({ 157, 156 }, 21)
  game.initial_set_tile({ 157, 156 }, 409)
  game.set_cell_type({ 157, 157 }, 21)
  game.initial_set_tile({ 157, 157 }, 409)
  game.set_cell_type({ 157, 158 }, 21)
  game.initial_set_tile({ 157, 158 }, 409)
  game.set_cell_type({ 157, 159 }, 21)
  game.initial_set_tile({ 157, 159 }, 409)
  game.set_cell_type({ 157, 160 }, 21)
  game.initial_set_tile({ 157, 160 }, 409)
  game.set_cell_type({ 157, 161 }, 21)
  game.initial_set_tile({ 157, 161 }, 409)
  game.set_cell_type({ 157, 162 }, 21)
  game.initial_set_tile({ 157, 162 }, 409)
  game.set_cell_type({ 157, 163 }, 21)
  game.initial_set_tile({ 157, 163 }, 409)
  game.set_cell_type({ 157, 164 }, 21)
  game.initial_set_tile({ 157, 164 }, 409)
  game.set_cell_type({ 157, 165 }, 21)
  game.initial_set_tile({ 157, 165 }, 409)
  game.set_cell_type({ 157, 172 }, 21)
  game.initial_set_tile({ 157, 172 }, 409)
  game.set_cell_type({ 157, 173 }, 21)
  game.initial_set_tile({ 157, 173 }, 409)
  game.set_cell_type({ 157, 174 }, 21)
  game.initial_set_tile({ 157, 174 }, 409)
  game.set_cell_type({ 158, 153 }, 21)
  game.initial_set_tile({ 158, 153 }, 409)
  game.set_cell_type({ 158, 154 }, 21)
  game.initial_set_tile({ 158, 154 }, 409)
  game.set_cell_type({ 158, 155 }, 21)
  game.initial_set_tile({ 158, 155 }, 409)
  game.set_cell_type({ 158, 159 }, 21)
  game.initial_set_tile({ 158, 159 }, 409)
  game.set_cell_type({ 158, 160 }, 21)
  game.initial_set_tile({ 158, 160 }, 409)
  game.set_cell_type({ 158, 161 }, 21)
  game.initial_set_tile({ 158, 161 }, 409)
  game.set_cell_type({ 158, 162 }, 21)
  game.initial_set_tile({ 158, 162 }, 409)
  game.set_cell_type({ 158, 163 }, 21)
  game.initial_set_tile({ 158, 163 }, 409)
  game.set_cell_type({ 159, 153 }, 21)
  game.initial_set_tile({ 159, 153 }, 409)
  game.set_cell_type({ 159, 154 }, 21)
  game.initial_set_tile({ 159, 154 }, 409)
  game.set_cell_type({ 159, 155 }, 21)
  game.initial_set_tile({ 159, 155 }, 409)
  game.set_cell_type({ 159, 159 }, 21)
  game.initial_set_tile({ 159, 159 }, 409)
  game.set_cell_type({ 159, 160 }, 21)
  game.initial_set_tile({ 159, 160 }, 409)
  game.set_cell_type({ 159, 161 }, 21)
  game.initial_set_tile({ 159, 161 }, 409)
  game.set_cell_type({ 160, 153 }, 21)
  game.initial_set_tile({ 160, 153 }, 409)
  game.set_cell_type({ 160, 154 }, 21)
  game.initial_set_tile({ 160, 154 }, 409)
  game.set_cell_type({ 160, 155 }, 21)
  game.initial_set_tile({ 160, 155 }, 409)
  game.set_cell_type({ 160, 159 }, 21)
  game.initial_set_tile({ 160, 159 }, 409)
  game.set_cell_type({ 160, 160 }, 21)
  game.initial_set_tile({ 160, 160 }, 409)
  game.set_cell_type({ 160, 161 }, 21)
  game.initial_set_tile({ 160, 161 }, 409)
  game.set_cell_type({ 161, 153 }, 21)
  game.initial_set_tile({ 161, 153 }, 409)
  game.set_cell_type({ 161, 154 }, 21)
  game.initial_set_tile({ 161, 154 }, 409)
  game.set_cell_type({ 161, 155 }, 21)
  game.initial_set_tile({ 161, 155 }, 409)
  game.set_cell_type({ 161, 156 }, 21)
  game.initial_set_tile({ 161, 156 }, 409)
  game.set_cell_type({ 161, 157 }, 21)
  game.initial_set_tile({ 161, 157 }, 409)
  game.set_cell_type({ 161, 158 }, 21)
  game.initial_set_tile({ 161, 158 }, 409)
  game.set_cell_type({ 161, 159 }, 21)
  game.initial_set_tile({ 161, 159 }, 409)
  game.set_cell_type({ 161, 160 }, 21)
  game.initial_set_tile({ 161, 160 }, 409)
  game.set_cell_type({ 161, 161 }, 21)
  game.initial_set_tile({ 161, 161 }, 409)
  game.set_cell_type({ 162, 153 }, 21)
  game.initial_set_tile({ 162, 153 }, 409)
  game.set_cell_type({ 162, 154 }, 21)
  game.initial_set_tile({ 162, 154 }, 409)
  game.set_cell_type({ 162, 160 }, 21)
  game.initial_set_tile({ 162, 160 }, 409)
  game.set_cell_type({ 162, 161 }, 21)
  game.initial_set_tile({ 162, 161 }, 409)
  game.set_cell_type({ 163, 153 }, 21)
  game.initial_set_tile({ 163, 153 }, 409)
  game.set_cell_type({ 163, 154 }, 21)
  game.initial_set_tile({ 163, 154 }, 409)
  game.set_cell_type({ 163, 160 }, 21)
  game.initial_set_tile({ 163, 160 }, 409)
  game.set_cell_type({ 163, 161 }, 21)
  game.initial_set_tile({ 163, 161 }, 409)
  game.set_cell_type({ 164, 153 }, 21)
  game.initial_set_tile({ 164, 153 }, 409)
  game.set_cell_type({ 164, 154 }, 21)
  game.initial_set_tile({ 164, 154 }, 409)
  game.set_cell_type({ 164, 160 }, 21)
  game.initial_set_tile({ 164, 160 }, 409)
  game.set_cell_type({ 165, 153 }, 21)
  game.initial_set_tile({ 165, 153 }, 409)
  game.set_cell_type({ 165, 154 }, 21)
  game.initial_set_tile({ 165, 154 }, 409)
  game.set_cell_type({ 165, 160 }, 21)
  game.initial_set_tile({ 165, 160 }, 409)
  game.set_cell_type({ 166, 153 }, 21)
  game.initial_set_tile({ 166, 153 }, 409)
  game.set_cell_type({ 166, 154 }, 21)
  game.initial_set_tile({ 166, 154 }, 409)
  game.set_cell_type({ 166, 160 }, 21)
  game.initial_set_tile({ 166, 160 }, 409)
  game.set_cell_type({ 167, 153 }, 21)
  game.initial_set_tile({ 167, 153 }, 409)
  game.set_cell_type({ 167, 154 }, 21)
  game.initial_set_tile({ 167, 154 }, 409)
  game.set_cell_type({ 167, 159 }, 21)
  game.initial_set_tile({ 167, 159 }, 409)
  game.set_cell_type({ 167, 160 }, 21)
  game.initial_set_tile({ 167, 160 }, 409)
  game.set_cell_type({ 168, 153 }, 21)
  game.initial_set_tile({ 168, 153 }, 409)
  game.set_cell_type({ 168, 154 }, 21)
  game.initial_set_tile({ 168, 154 }, 409)
  game.set_cell_type({ 168, 155 }, 21)
  game.initial_set_tile({ 168, 155 }, 409)
  game.set_cell_type({ 168, 156 }, 21)
  game.initial_set_tile({ 168, 156 }, 409)
  game.set_cell_type({ 168, 158 }, 21)
  game.initial_set_tile({ 168, 158 }, 409)
  game.set_cell_type({ 168, 159 }, 21)
  game.initial_set_tile({ 168, 159 }, 409)
  game.set_cell_type({ 168, 160 }, 21)
  game.initial_set_tile({ 168, 160 }, 409)
  game.set_cell_type({ 168, 161 }, 21)
  game.initial_set_tile({ 168, 161 }, 409)
  game.set_cell_type({ 169, 153 }, 21)
  game.initial_set_tile({ 169, 153 }, 409)
  game.set_cell_type({ 169, 154 }, 21)
  game.initial_set_tile({ 169, 154 }, 409)
  game.set_cell_type({ 169, 155 }, 21)
  game.initial_set_tile({ 169, 155 }, 409)
  game.set_cell_type({ 169, 156 }, 21)
  game.initial_set_tile({ 169, 156 }, 409)
  game.set_cell_type({ 169, 158 }, 21)
  game.initial_set_tile({ 169, 158 }, 409)
  game.set_cell_type({ 169, 159 }, 21)
  game.initial_set_tile({ 169, 159 }, 409)
  game.set_cell_type({ 169, 160 }, 21)
  game.initial_set_tile({ 169, 160 }, 409)
  game.set_cell_type({ 169, 161 }, 21)
  game.initial_set_tile({ 169, 161 }, 409)
  game.set_cell_type({ 170, 146 }, 21)
  game.initial_set_tile({ 170, 146 }, 409)
  game.set_cell_type({ 170, 147 }, 21)
  game.initial_set_tile({ 170, 147 }, 409)
  game.set_cell_type({ 170, 148 }, 21)
  game.initial_set_tile({ 170, 148 }, 409)
  game.set_cell_type({ 170, 149 }, 21)
  game.initial_set_tile({ 170, 149 }, 409)
  game.set_cell_type({ 170, 150 }, 21)
  game.initial_set_tile({ 170, 150 }, 409)
  game.set_cell_type({ 170, 151 }, 21)
  game.initial_set_tile({ 170, 151 }, 409)
  game.set_cell_type({ 170, 152 }, 21)
  game.initial_set_tile({ 170, 152 }, 409)
  game.set_cell_type({ 170, 153 }, 21)
  game.initial_set_tile({ 170, 153 }, 409)
  game.set_cell_type({ 170, 154 }, 21)
  game.initial_set_tile({ 170, 154 }, 409)
  game.set_cell_type({ 170, 155 }, 21)
  game.initial_set_tile({ 170, 155 }, 409)
  game.set_cell_type({ 170, 156 }, 21)
  game.initial_set_tile({ 170, 156 }, 409)
  game.set_cell_type({ 170, 158 }, 21)
  game.initial_set_tile({ 170, 158 }, 409)
  game.set_cell_type({ 170, 159 }, 21)
  game.initial_set_tile({ 170, 159 }, 409)
  game.set_cell_type({ 170, 160 }, 21)
  game.initial_set_tile({ 170, 160 }, 409)
  game.set_cell_type({ 170, 161 }, 21)
  game.initial_set_tile({ 170, 161 }, 409)
  game.set_cell_type({ 171, 150 }, 21)
  game.initial_set_tile({ 171, 150 }, 409)
  game.set_cell_type({ 171, 154 }, 21)
  game.initial_set_tile({ 171, 154 }, 409)
  game.set_cell_type({ 171, 155 }, 21)
  game.initial_set_tile({ 171, 155 }, 409)
  game.set_cell_type({ 171, 160 }, 21)
  game.initial_set_tile({ 171, 160 }, 409)
  game.set_cell_type({ 171, 161 }, 21)
  game.initial_set_tile({ 171, 161 }, 409)
  game.set_cell_type({ 172, 150 }, 21)
  game.initial_set_tile({ 172, 150 }, 409)
  game.set_cell_type({ 172, 155 }, 21)
  game.initial_set_tile({ 172, 155 }, 409)
  game.set_cell_type({ 172, 160 }, 21)
  game.initial_set_tile({ 172, 160 }, 409)
  game.set_cell_type({ 172, 161 }, 21)
  game.initial_set_tile({ 172, 161 }, 409)
  game.set_cell_type({ 173, 160 }, 21)
  game.initial_set_tile({ 173, 160 }, 409)
  game.set_cell_type({ 173, 161 }, 21)
  game.initial_set_tile({ 173, 161 }, 409)
  game.set_cell_type({ 174, 150 }, 21)
  game.initial_set_tile({ 174, 150 }, 409)
  game.set_cell_type({ 174, 155 }, 21)
  game.initial_set_tile({ 174, 155 }, 409)
  game.set_cell_type({ 174, 160 }, 21)
  game.initial_set_tile({ 174, 160 }, 409)
  game.set_cell_type({ 174, 161 }, 21)
  game.initial_set_tile({ 174, 161 }, 409)
  game.set_cell_type({ 175, 146 }, 21)
  game.initial_set_tile({ 175, 146 }, 409)
  game.set_cell_type({ 175, 147 }, 21)
  game.initial_set_tile({ 175, 147 }, 409)
  game.set_cell_type({ 175, 148 }, 21)
  game.initial_set_tile({ 175, 148 }, 409)
  game.set_cell_type({ 175, 149 }, 21)
  game.initial_set_tile({ 175, 149 }, 409)
  game.set_cell_type({ 175, 150 }, 21)
  game.initial_set_tile({ 175, 150 }, 409)
  game.set_cell_type({ 175, 155 }, 21)
  game.initial_set_tile({ 175, 155 }, 409)
  game.set_cell_type({ 175, 160 }, 21)
  game.initial_set_tile({ 175, 160 }, 409)
  game.set_cell_type({ 175, 161 }, 21)
  game.initial_set_tile({ 175, 161 }, 409)
  game.set_cell_type({ 176, 146 }, 21)
  game.initial_set_tile({ 176, 146 }, 409)
  game.set_cell_type({ 176, 147 }, 21)
  game.initial_set_tile({ 176, 147 }, 409)
  game.set_cell_type({ 176, 148 }, 21)
  game.initial_set_tile({ 176, 148 }, 409)
  game.set_cell_type({ 176, 149 }, 21)
  game.initial_set_tile({ 176, 149 }, 409)
  game.set_cell_type({ 176, 150 }, 21)
  game.initial_set_tile({ 176, 150 }, 409)
  game.set_cell_type({ 176, 151 }, 21)
  game.initial_set_tile({ 176, 151 }, 409)
  game.set_cell_type({ 176, 152 }, 21)
  game.initial_set_tile({ 176, 152 }, 409)
  game.set_cell_type({ 176, 154 }, 21)
  game.initial_set_tile({ 176, 154 }, 409)
  game.set_cell_type({ 176, 155 }, 21)
  game.initial_set_tile({ 176, 155 }, 409)
  game.set_cell_type({ 176, 156 }, 21)
  game.initial_set_tile({ 176, 156 }, 409)
  game.set_cell_type({ 176, 157 }, 21)
  game.initial_set_tile({ 176, 157 }, 409)
  game.set_cell_type({ 176, 159 }, 21)
  game.initial_set_tile({ 176, 159 }, 409)
  game.set_cell_type({ 176, 160 }, 21)
  game.initial_set_tile({ 176, 160 }, 409)
  game.set_cell_type({ 176, 161 }, 21)
  game.initial_set_tile({ 176, 161 }, 409)
  game.set_cell_type({ 177, 146 }, 21)
  game.initial_set_tile({ 177, 146 }, 409)
  game.set_cell_type({ 177, 147 }, 21)
  game.initial_set_tile({ 177, 147 }, 409)
  game.set_cell_type({ 177, 148 }, 21)
  game.initial_set_tile({ 177, 148 }, 409)
  game.set_cell_type({ 177, 154 }, 21)
  game.initial_set_tile({ 177, 154 }, 409)
  game.set_cell_type({ 177, 159 }, 21)
  game.initial_set_tile({ 177, 159 }, 409)
  game.set_cell_type({ 177, 160 }, 21)
  game.initial_set_tile({ 177, 160 }, 409)
  game.set_cell_type({ 177, 161 }, 21)
  game.initial_set_tile({ 177, 161 }, 409)
  game.set_cell_type({ 178, 146 }, 21)
  game.initial_set_tile({ 178, 146 }, 409)
  game.set_cell_type({ 178, 147 }, 21)
  game.initial_set_tile({ 178, 147 }, 409)
  game.set_cell_type({ 178, 148 }, 21)
  game.initial_set_tile({ 178, 148 }, 409)
  game.set_cell_type({ 178, 154 }, 21)
  game.initial_set_tile({ 178, 154 }, 409)
  game.set_cell_type({ 178, 160 }, 21)
  game.initial_set_tile({ 178, 160 }, 409)
  game.set_cell_type({ 179, 146 }, 21)
  game.initial_set_tile({ 179, 146 }, 409)
  game.set_cell_type({ 179, 147 }, 21)
  game.initial_set_tile({ 179, 147 }, 409)
  game.set_cell_type({ 179, 148 }, 21)
  game.initial_set_tile({ 179, 148 }, 409)
  game.set_cell_type({ 179, 154 }, 21)
  game.initial_set_tile({ 179, 154 }, 409)
  game.set_cell_type({ 179, 160 }, 21)
  game.initial_set_tile({ 179, 160 }, 409)
  game.set_cell_type({ 180, 146 }, 21)
  game.initial_set_tile({ 180, 146 }, 409)
  game.set_cell_type({ 180, 147 }, 21)
  game.initial_set_tile({ 180, 147 }, 409)
  game.set_cell_type({ 180, 148 }, 21)
  game.initial_set_tile({ 180, 148 }, 409)
  game.set_cell_type({ 181, 146 }, 21)
  game.initial_set_tile({ 181, 146 }, 409)
  game.set_cell_type({ 181, 147 }, 21)
  game.initial_set_tile({ 181, 147 }, 409)
  game.set_cell_type({ 181, 148 }, 21)
  game.initial_set_tile({ 181, 148 }, 409)
  game.set_cell_type({ 181, 154 }, 21)
  game.initial_set_tile({ 181, 154 }, 409)
  game.set_cell_type({ 182, 147 }, 21)
  game.initial_set_tile({ 182, 147 }, 409)
  game.set_cell_type({ 182, 148 }, 21)
  game.initial_set_tile({ 182, 148 }, 409)
  game.set_cell_type({ 182, 154 }, 21)
  game.initial_set_tile({ 182, 154 }, 409)
  game.set_cell_type({ 183, 148 }, 21)
  game.initial_set_tile({ 183, 148 }, 409)
  game.set_cell_type({ 183, 149 }, 21)
  game.initial_set_tile({ 183, 149 }, 409)
  game.set_cell_type({ 183, 150 }, 21)
  game.initial_set_tile({ 183, 150 }, 409)
  game.set_cell_type({ 183, 151 }, 21)
  game.initial_set_tile({ 183, 151 }, 409)
  game.set_cell_type({ 183, 152 }, 21)
  game.initial_set_tile({ 183, 152 }, 409)
  game.set_cell_type({ 183, 153 }, 21)
  game.initial_set_tile({ 183, 153 }, 409)
  game.set_cell_type({ 183, 154 }, 21)
  game.initial_set_tile({ 183, 154 }, 409)
  game.set_cell_type({ 183, 155 }, 21)
  game.initial_set_tile({ 183, 155 }, 409)
  game.set_cell_type({ 183, 156 }, 21)
  game.initial_set_tile({ 183, 156 }, 409)
  game.set_cell_type({ 183, 157 }, 21)
  game.initial_set_tile({ 183, 157 }, 409)
  game.set_cell_type({ 183, 158 }, 21)
  game.initial_set_tile({ 183, 158 }, 409)
  game.set_cell_type({ 183, 159 }, 21)
  game.initial_set_tile({ 183, 159 }, 409)
  game.set_cell_type({ 184, 146 }, 21)
  game.initial_set_tile({ 184, 146 }, 409)
  game.set_cell_type({ 184, 148 }, 21)
  game.initial_set_tile({ 184, 148 }, 409)
  game.set_cell_type({ 184, 149 }, 21)
  game.initial_set_tile({ 184, 149 }, 409)
  game.set_cell_type({ 184, 150 }, 21)
  game.initial_set_tile({ 184, 150 }, 409)
  game.set_cell_type({ 184, 151 }, 21)
  game.initial_set_tile({ 184, 151 }, 409)
  game.set_cell_type({ 184, 152 }, 21)
  game.initial_set_tile({ 184, 152 }, 409)
  game.set_cell_type({ 184, 153 }, 21)
  game.initial_set_tile({ 184, 153 }, 409)
  game.set_cell_type({ 184, 154 }, 21)
  game.initial_set_tile({ 184, 154 }, 409)
  game.set_cell_type({ 184, 155 }, 21)
  game.initial_set_tile({ 184, 155 }, 409)
  game.set_cell_type({ 184, 156 }, 21)
  game.initial_set_tile({ 184, 156 }, 409)
  game.set_cell_type({ 184, 157 }, 21)
  game.initial_set_tile({ 184, 157 }, 409)
  game.set_cell_type({ 184, 158 }, 21)
  game.initial_set_tile({ 184, 158 }, 409)
  game.set_cell_type({ 184, 159 }, 21)
  game.initial_set_tile({ 184, 159 }, 409)
  game.set_cell_type({ 185, 146 }, 21)
  game.initial_set_tile({ 185, 146 }, 409)
  game.set_cell_type({ 185, 150 }, 21)
  game.initial_set_tile({ 185, 150 }, 409)
  game.set_cell_type({ 185, 151 }, 21)
  game.initial_set_tile({ 185, 151 }, 409)
  game.set_cell_type({ 185, 152 }, 21)
  game.initial_set_tile({ 185, 152 }, 409)
  game.set_cell_type({ 185, 153 }, 21)
  game.initial_set_tile({ 185, 153 }, 409)
  game.set_cell_type({ 185, 154 }, 21)
  game.initial_set_tile({ 185, 154 }, 409)
  game.set_cell_type({ 185, 155 }, 21)
  game.initial_set_tile({ 185, 155 }, 409)
  game.set_cell_type({ 185, 156 }, 21)
  game.initial_set_tile({ 185, 156 }, 409)
  game.set_cell_type({ 185, 157 }, 21)
  game.initial_set_tile({ 185, 157 }, 409)
  game.set_cell_type({ 185, 158 }, 21)
  game.initial_set_tile({ 185, 158 }, 409)
  game.set_cell_type({ 185, 159 }, 21)
  game.initial_set_tile({ 185, 159 }, 409)
  game.set_daylight_everywhere(false)
  game.set_daylight_moves(true)
  if difficulty == "Easy" then game.morale_steady("Good") end
  trigger.time{time = 20000, on = Lava1_Vent}  -- after 200 marks
  trigger.time{time = 15000, on = Lava2_Vent}  -- after 150 marks
  trigger.time{time = 5000, on = Lava3_Vent}  -- after 50 marks
  trigger.time{time = 30000, on = Lava4_Vent}  -- after 300 marks
  trigger.time{time = 90000, on = LavaSpeedup}  -- after 900 marks
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 12, 145 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 48, 243 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 34, 109 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 119, 54 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 178, 13 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 149, 111 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 51, 35 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 166, 206 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 205, 208 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 254, 244 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 227, 20 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 45, 9 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 23, 149 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 119, 219 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 124 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 139, 191 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 70, 167 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 41, 63 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 61, 47 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 247, 19 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 181, 78 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 156, 93 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 253, 180 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 236, 236 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 32, 188 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 26, 250 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 97, 223 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 39, 143 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 22, 50 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 173, 107 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 213, 121 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 200, 75 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 208, 17 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 196, 20 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 162, 50 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 67, 16 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 94, 82 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 156, 241 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 136, 13 } }
  if players[1].difficulty ~= "Hard" then
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 6, 252 } }
  end
  if difficulty == "Easy" then
    trigger.time{time = 10, on = ReleaseMorale}  -- after 0 marks
  end

  -- The win.
  local t10 = trigger.count{type = "EvacuationModule", compare = ">=", count = 1, one_shot = true}
  mission.victory(t10, "Evacuate 200 colonists to spacecraft", {one_shot = true})
  local t12 = trigger.count{type = "FoodCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t12, "Evacuate 10000 units of food to spacecraft", {one_shot = true})
  t14 = trigger.count{type = "CommonMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t14, "Evacuate 10000 units of Common Metals to spacecraft", {one_shot = true})
  t16 = trigger.count{type = "RareMetalsCargo", compare = ">=", count = 1, one_shot = true}
  mission.victory(t16, "Evacuate 10000 units of Rare Metals to spacecraft", {one_shot = true})
  local t18 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t18)
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
  trigger.time{min = 10000, max = 20000, one_shot = false, on = DoQuake}  -- after 100 to 200 marks
  trigger.time{min = 20000, max = 25000, one_shot = false, on = DoLightning}  -- after 200 to 250 marks
  trigger.time{min = 25000, max = 30000, one_shot = false, on = DoTornado}  -- after 250 to 300 marks
  if difficulty == "Normal" or difficulty == "Hard" then
    trigger.time{min = 10000, max = 20000, one_shot = false, on = DoMeteor}  -- after 100 to 200 marks
  end
  trigger.time{time = 5000, one_shot = false, on = GiveAIOre}  -- after 50 marks
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 159, 173 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 186, 135 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 3, 40 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 27, 8 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 237, 73 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 245, 108 } }
  expand_trigger = trigger.time{min = 20000, max = 22000, on = ExpandBase1_A}  -- after 200 to 220 marks
  trigger.time{min = 12000, max = 14000, on = SetupBase2}  -- after 120 to 140 marks
  trigger.time{min = 34000, max = 38000, on = SetupBase3}  -- after 340 to 380 marks

  -- The computer player's base, where the setup makes it.
  setup_ai(players[2])
  trigger.time{time = ({ Easy = 20000, Normal = 13000, Hard = 11000 })[difficulty], one_shot = false, on = TimeUpgrades}
  -- The computer's first move, kept at 0x11018488: SpawnAttack's first wave 28000 ticks and up to 3500 more out,
  -- 5/4 of that on Normal; on Easy its leaving instead (0x11003694).
  if players[1].difficulty ~= "Easy" then
    local wait = game.rand(3500) + 28000
    if players[1].difficulty == "Normal" then wait = wait * 5 // 4 end
    attack_trigger = trigger.time{time = wait, one_shot = false, on = SpawnAttack}
  else
    attack_trigger = trigger.time{time = game.rand(3500) + 28000, one_shot = false, on = ExitMapMultiple}
  end
  trigger.time{time = 1000, one_shot = false, on = TraceOre}  -- after 10 marks  -- TraceOre isn't converted
end

-- Not converted:
-- - TraceOre isn't converted: it calls nothing
