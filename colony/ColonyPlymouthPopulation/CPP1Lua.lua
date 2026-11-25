-- CPP1Lua.lua  -  Colony Builder - Plymouth, Population (Lua)
-- Trigger functions finished by hand (Rand_Meteor, Bad_Meteor, CheckForFail, TopQuakeLine, SideQuakeLine, Fault1Line, Fault2Line, RandStorm, TornadoAlley, TimeUpgrades, ScoutWave, SpawnAttack, StageDone, ReleaseMorale), from the disassembly of CPP1.dll.
-- Converted by op2dll from CPP1.dll. With CPP1Lua.placement.lua (what every difficulty makes alike),
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
        workers = 25, scientists = 20, kids = 30, food = 3000, ore = 8000,
        research = {  },
        kits = { [4] = { "Residence" } },
        view = { 228, 74 },
        units = {
          { type = "StandardLab", at = { 233, 81 } },
          { type = "Residence", at = { 234, 68 } },
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
      { "Tube", { 230, 81 } }, { "Tube", { 231, 68 } }, { "Tube", { 231, 81 } }, { "Tube", { 232, 68 } },
    },
    beacons = {
    },
  },
  Normal = {
    players = {
      [1] = {
        workers = 20, scientists = 15, kids = 25, food = 2000, ore = 5000,
        research = {  },
        kits = { [3] = { "StandardLab" }, [4] = { "Residence" }, [5] = { "Residence" }, [6] = { "Agridome" } },
        view = { 228, 74 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
    },
    beacons = {
    },
  },
  Hard = {
    players = {
      [1] = {
        workers = 25, scientists = 10, kids = 15, food = 1000, ore = 5000,
        research = {  },
        kits = { [3] = { "StandardLab" }, [4] = { "Residence" }, [5] = { "CommandCenter" }, [6] = { "CommonStorage" } },
        view = { 228, 74 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
    },
    walls = {
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

local function tdiv(a, b)
  local q = a // b
  if q < 0 and q * b ~= a then q = q + 1 end
  return q
end

-- TimeUpgrades' count, the step of the waves' unit lists it sets (0x1100D52C, 0x1100D520) and their size, 16.16 fixed
-- point (0x1100D524).
local upgrades, wave_step, wave_size = 0, 0, 0x8000
-- By upgrade 3 to 12, Normal's sizes and the other difficulties' (0x11009168, 0x11009190).
local WAVE_SIZE_NORMAL = { 65536, 65536, 45875, 45875, 45875, 45875, 45875, 45875, 32768, 26214 }
local WAVE_SIZE_OTHER = { 72089, 72089, 58982, 58982, 58982, 58982, 58982, 58982, 39321, 32768 }
-- The quake lines' triggers (0x1100D4F8, D4FC, D500, D504), filled by the setup with Top's, Side's, Fault1's and
-- Fault2's. Each line ends the trigger in a slot and keeps its next one there, but Side uses Fault2's slot, Fault1
-- Side's and Fault2 Fault1's: a line that fires ends another's waiting trigger (Fault2's first quake cancels Fault1's).
local quake_slots = {}
-- Bad_Meteor's wait by difficulty (0x110091B8).
local BAD_METEOR_TIME = { Easy = 60000, Normal = 50000, Hard = 40000 }

-- SpawnAttack's state: the attack group (0x1100D518), the waves sent (0x1100D51C), the zone of the last
-- (0x1100D528), the trigger of the next stage (0x1100D510, the setup's SpawnAttack trigger at first) and ScoutWave's
-- (0x1100D534).
local attack_group, waves, zone, stage_trigger, scout_trigger = nil, 0, 1, nil, nil
-- Where the waves go (0x11009000, nine dwords each): the area searched for player 1's buildings and the area the wave
-- gathers in (game tiles), and the wait before it attacks. The last is for when no area has enough buildings.
local ZONES = {
  { { 32, 0, 93, 76 }, { 32, 0, 93, 76 }, 0 },
  { { 32, 76, 93, 148 }, { 74, 58, 88, 66 }, 2000 },
  { { 93, 0, 164, 76 }, { 84, 4, 93, 20 }, 2000 },
  { { 93, 76, 164, 148 }, { 115, 66, 135, 76 }, 3500 },
  { { 164, 0, 221, 76 }, { 155, 4, 160, 32 }, 4500 },
  { { 221, 0, 287, 123 }, { 213, 34, 221, 49 }, 7000 },
  { { 164, 76, 221, 148 }, { 170, 66, 184, 76 }, 5000 },
  { { 164, 148, 221, 253 }, { 215, 139, 230, 150 }, 8000 },
  { { 32, 148, 93, 253 }, { 44, 144, 60, 150 }, 3500 },
  { { 93, 148, 164, 253 }, { 133, 161, 144, 171 }, 5000 },
}
-- A wave's units by TimeUpgrades' step (0x1100A580): type, weapon, weight in the draws, and how many always come.
local WAVES = {
  { { "Lynx", "Laser", 10, 1 } },
  { { "Lynx", "Laser", 10, 1 }, { "Lynx", "Starflare", 4, 1 }, { "Lynx", "RailGun", 6, 1 } },
  { { "Lynx", "Laser", 10, 1 }, { "Lynx", "Starflare", 4, 0 }, { "Lynx", "RailGun", 4, 0 }, { "Lynx", "AcidCloud", 1, 0 },
    { "Lynx", "EMP", 2, 0 } },
  { { "Lynx", "Laser", 10, 1 }, { "Lynx", "Starflare", 2, 0 }, { "Lynx", "RailGun", 10, 0 }, { "Lynx", "AcidCloud", 2, 0 },
    { "Lynx", "EMP", 4, 0 }, { "Panther", "Laser", 4, 1 } },
  { { "Lynx", "Laser", 10, 1 }, { "Lynx", "Starflare", 2, 0 }, { "Lynx", "RailGun", 10, 0 }, { "Lynx", "AcidCloud", 6, 1 },
    { "Lynx", "EMP", 4, 0 }, { "Panther", "AcidCloud", 2, 0 }, { "Panther", "Laser", 4, 0 }, { "Panther", "RailGun", 4, 0 } },
  { { "Lynx", "Laser", 3, 1 }, { "Lynx", "Starflare", 2, 0 }, { "Lynx", "RailGun", 3, 0 }, { "Lynx", "AcidCloud", 2, 1 },
    { "Lynx", "EMP", 2, 0 }, { "Panther", "AcidCloud", 8, 0 }, { "Panther", "Laser", 4, 1 }, { "Panther", "RailGun", 8, 0 },
    { "Panther", "EMP", 8, 0 }, { "Tiger", "Laser", 2, 0 }, { "Tiger", "RailGun", 2, 0 } },
  { { "Panther", "AcidCloud", 8, 0 }, { "Panther", "Laser", 4, 1 }, { "Panther", "RailGun", 8, 0 }, { "Panther", "EMP", 8, 0 },
    { "Panther", "ThorsHammer", 2, 0 }, { "Tiger", "Laser", 2, 0 }, { "Tiger", "RailGun", 2, 0 }, { "Panther", "AcidCloud", 2, 0 } },
  { { "Lynx", "Laser", 3, 1 }, { "Lynx", "ThorsHammer", 8, 0 }, { "Lynx", "AcidCloud", 6, 1 }, { "Lynx", "EMP", 3, 0 } },
  { { "Panther", "Laser", 4, 1 }, { "Panther", "ThorsHammer", 2, 1 }, { "Tiger", "Laser", 5, 1 }, { "Tiger", "RailGun", 8, 0 },
    { "Panther", "AcidCloud", 4, 0 }, { "Tiger", "EMP", 4, 0 }, { "Tiger", "ThorsHammer", 1, 0 } },
  { { "Lynx", "Laser", 2, 1 }, { "Lynx", "ThorsHammer", 8, 0 }, { "Lynx", "AcidCloud", 6, 0 }, { "Tiger", "Laser", 2, 1 },
    { "Tiger", "RailGun", 8, 0 }, { "Panther", "AcidCloud", 4, 0 }, { "Tiger", "EMP", 4, 0 }, { "Tiger", "ThorsHammer", 16, 0 } },
}

-- One of player 2's attackers at the west edge (x 1, y 5 to 32), into the attack group; whether it was made.
local function attacker(type, weapon)
  local u = game.create_unit{ type = type, weapon = weapon, player = 2, at = { 1, game.rand(28) + 5 }, lights = false,
                              exact = true }[1]
  if u and u.valid then attack_group:take_unit(u) return true end
  return false
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava1_Flow, Lava1_Vent, Lava2_Flow, Lava2_H_Flow, Lava2_H_Warn, Lava2_N_Flow, Lava2_N_Warn, Lava2_Vent

function Lava1_Flow(t)
  game.initial_set_tile({ 135, 232 }, 1104)
  game.initial_set_tile({ 136, 232 }, 1115)
  game.initial_set_tile({ 135, 233 }, 1126)
  game.initial_set_tile({ 136, 233 }, 1137)
  for _, r in ipairs({
    { 121, 130, 123, 130 }, { 120, 131, 126, 131 }, { 129, 131, 131, 131 }, { 119, 132, 132, 132 }, { 119, 133, 133, 133 }, { 117, 134, 133, 134 },
    { 116, 135, 133, 135 }, { 115, 136, 133, 138 }, { 116, 139, 133, 139 }, { 117, 140, 133, 140 }, { 119, 141, 132, 141 }, { 122, 142, 132, 142 },
    { 124, 143, 133, 143 }, { 125, 144, 134, 144 }, { 127, 145, 134, 146 }, { 128, 147, 134, 148 }, { 127, 149, 133, 149 }, { 126, 150, 132, 150 },
    { 126, 151, 133, 151 }, { 125, 152, 133, 152 }, { 117, 153, 119, 153 }, { 124, 153, 133, 153 }, { 67, 154, 70, 154 }, { 116, 154, 133, 154 },
    { 66, 155, 71, 155 }, { 73, 155, 73, 155 }, { 115, 155, 132, 158 }, { 67, 156, 74, 156 }, { 68, 157, 73, 157 }, { 69, 158, 73, 159 },
    { 116, 159, 131, 159 }, { 67, 160, 75, 160 }, { 116, 160, 130, 160 }, { 66, 161, 74, 162 }, { 116, 161, 129, 161 }, { 117, 162, 128, 162 },
    { 65, 163, 73, 163 }, { 117, 163, 127, 164 }, { 64, 164, 75, 165 }, { 118, 165, 127, 165 }, { 64, 166, 71, 166 }, { 74, 166, 75, 166 },
    { 119, 166, 127, 166 }, { 63, 167, 67, 168 }, { 120, 167, 128, 167 }, { 121, 168, 128, 168 }, { 63, 169, 66, 169 }, { 122, 169, 129, 169 },
    { 139, 169, 142, 169 }, { 63, 170, 67, 171 }, { 122, 170, 130, 170 }, { 138, 170, 143, 170 }, { 122, 171, 131, 171 }, { 137, 171, 144, 171 },
    { 64, 172, 67, 173 }, { 123, 172, 145, 172 }, { 123, 173, 146, 173 }, { 63, 174, 67, 174 }, { 124, 174, 146, 174 }, { 61, 175, 67, 176 },
    { 125, 175, 146, 175 }, { 127, 176, 146, 176 }, { 59, 177, 67, 177 }, { 131, 177, 145, 177 }, { 59, 178, 63, 178 }, { 66, 178, 66, 178 },
    { 132, 178, 145, 178 }, { 58, 179, 63, 179 }, { 133, 179, 145, 179 }, { 58, 180, 61, 183 }, { 134, 180, 145, 181 }, { 134, 182, 146, 182 },
    { 135, 183, 146, 183 }, { 57, 184, 60, 184 }, { 136, 184, 146, 184 }, { 53, 185, 60, 185 }, { 138, 185, 147, 185 }, { 53, 186, 59, 186 },
    { 139, 186, 148, 186 }, { 52, 187, 59, 187 }, { 139, 187, 149, 188 }, { 52, 188, 54, 188 }, { 58, 188, 59, 188 }, { 53, 189, 54, 190 },
    { 139, 189, 150, 189 }, { 140, 190, 151, 190 }, { 52, 191, 56, 192 }, { 140, 191, 152, 192 }, { 52, 193, 55, 193 }, { 141, 193, 152, 194 },
    { 52, 194, 54, 194 }, { 51, 195, 54, 195 }, { 140, 195, 151, 195 }, { 49, 196, 53, 197 }, { 139, 196, 150, 196 }, { 139, 197, 148, 198 },
    { 49, 198, 52, 199 }, { 140, 199, 148, 199 }, { 50, 200, 52, 201 }, { 140, 200, 147, 200 }, { 140, 201, 148, 201 }, { 49, 202, 52, 203 },
    { 139, 202, 148, 202 }, { 138, 203, 148, 203 }, { 48, 204, 52, 204 }, { 137, 204, 147, 206 }, { 47, 205, 51, 205 }, { 44, 206, 51, 207 },
    { 136, 207, 147, 207 }, { 44, 208, 50, 208 }, { 135, 208, 147, 209 }, { 43, 209, 50, 210 }, { 135, 210, 148, 211 }, { 41, 211, 48, 211 },
    { 40, 212, 48, 214 }, { 134, 212, 148, 213 }, { 66, 214, 67, 214 }, { 134, 214, 149, 218 }, { 39, 215, 47, 217 }, { 66, 215, 68, 216 },
    { 31, 217, 32, 217 }, { 65, 217, 67, 217 }, { 28, 218, 34, 218 }, { 38, 218, 48, 218 }, { 64, 218, 68, 219 }, { 28, 219, 48, 219 },
    { 133, 219, 148, 219 }, { 29, 220, 47, 221 }, { 63, 220, 69, 220 }, { 132, 220, 147, 220 }, { 62, 221, 69, 221 }, { 131, 221, 146, 221 },
    { 30, 222, 48, 222 }, { 61, 222, 69, 222 }, { 131, 222, 145, 222 }, { 31, 223, 48, 223 }, { 59, 223, 69, 223 }, { 130, 223, 140, 223 },
    { 33, 224, 48, 224 }, { 58, 224, 69, 225 }, { 129, 224, 137, 224 }, { 34, 225, 51, 225 }, { 53, 225, 54, 225 }, { 129, 225, 136, 225 },
    { 35, 226, 54, 226 }, { 56, 226, 57, 226 }, { 59, 226, 68, 226 }, { 129, 226, 135, 226 }, { 37, 227, 68, 227 }, { 130, 227, 134, 228 },
    { 38, 228, 68, 228 }, { 38, 229, 69, 229 }, { 130, 229, 133, 229 }, { 39, 230, 73, 230 }, { 129, 230, 133, 232 }, { 40, 231, 76, 231 },
    { 41, 232, 77, 232 }, { 42, 233, 78, 233 }, { 128, 233, 134, 233 }, { 43, 234, 78, 234 }, { 128, 234, 136, 234 }, { 43, 235, 44, 235 },
    { 50, 235, 79, 236 }, { 129, 235, 136, 235 }, { 129, 236, 137, 236 }, { 50, 237, 80, 237 }, { 130, 237, 140, 237 }, { 49, 238, 80, 238 },
    { 131, 238, 141, 238 }, { 143, 238, 145, 238 }, { 48, 239, 79, 239 }, { 132, 239, 146, 239 }, { 47, 240, 78, 240 }, { 97, 240, 98, 240 },
    { 112, 240, 114, 240 }, { 116, 240, 117, 240 }, { 133, 240, 147, 240 }, { 46, 241, 78, 241 }, { 95, 241, 100, 241 }, { 104, 241, 106, 241 },
    { 110, 241, 118, 241 }, { 131, 241, 148, 241 }, { 44, 242, 78, 242 }, { 87, 242, 87, 242 }, { 93, 242, 118, 243 }, { 131, 242, 152, 242 },
    { 43, 243, 78, 243 }, { 86, 243, 88, 243 }, { 130, 243, 153, 244 }, { 43, 244, 76, 245 }, { 86, 244, 89, 244 }, { 92, 244, 119, 244 },
    { 86, 245, 121, 245 }, { 131, 245, 154, 245 }, { 42, 246, 55, 246 }, { 62, 246, 77, 248 }, { 83, 246, 110, 246 }, { 117, 246, 121, 246 },
    { 132, 246, 154, 247 }, { 42, 247, 54, 247 }, { 82, 247, 99, 247 }, { 117, 247, 122, 248 }, { 43, 248, 54, 248 }, { 81, 248, 88, 248 },
    { 92, 248, 97, 250 }, { 126, 248, 128, 248 }, { 131, 248, 154, 248 }, { 44, 249, 54, 250 }, { 62, 249, 88, 250 }, { 117, 249, 153, 249 },
    { 117, 250, 152, 251 }, { 45, 251, 55, 251 }, { 62, 251, 97, 251 }, { 48, 252, 82, 252 }, { 84, 252, 99, 252 }, { 111, 252, 151, 252 },
    { 49, 253, 99, 253 }, { 113, 253, 150, 253 }, { 57, 254, 74, 254 }, { 85, 254, 92, 254 }, { 136, 254, 143, 254 }, { 57, 255, 73, 255 },
    { 137, 255, 143, 255 },
  }) do game.set_lava_possible(r) end
  game.create_eruption({ 135, 234 }, 20)
  t:destroy()
end

function Lava1_Vent(t)
  game.initial_set_tile({ 135, 232 }, 1095)
  game.initial_set_tile({ 136, 232 }, 1107)
  game.initial_set_tile({ 135, 233 }, 1118)
  game.initial_set_tile({ 136, 233 }, 1129)
  t:destroy()
  trigger.time{time = 1500, on = Lava1_Flow}  -- after 15 marks
end

function Lava2_Flow(t)
  if players[1].difficulty == "Easy" then
    game.set_tile({ 205, 102 }, 1147)
    game.set_tile({ 205, 103 }, 1158)
    for _, r in ipairs({
      { 207, 80, 209, 80 }, { 206, 81, 210, 81 }, { 205, 82, 211, 83 }, { 204, 84, 211, 85 }, { 203, 86, 212, 86 }, { 203, 87, 215, 87 },
      { 203, 88, 218, 88 }, { 204, 89, 220, 89 }, { 204, 90, 224, 90 }, { 198, 91, 199, 91 }, { 202, 91, 225, 91 }, { 196, 92, 226, 92 },
      { 194, 93, 226, 93 }, { 193, 94, 226, 94 }, { 192, 95, 225, 95 }, { 192, 96, 224, 96 }, { 192, 97, 207, 97 }, { 211, 97, 221, 97 },
      { 192, 98, 206, 98 }, { 212, 98, 218, 98 }, { 192, 99, 204, 99 }, { 214, 99, 216, 99 }, { 192, 100, 203, 100 }, { 193, 101, 202, 101 },
      { 193, 102, 203, 102 }, { 192, 103, 204, 103 }, { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 },
      { 192, 109, 209, 109 }, { 192, 110, 210, 111 }, { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 },
      { 196, 120, 209, 120 }, { 197, 121, 208, 122 }, { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 199, 126, 211, 126 },
      { 200, 127, 211, 127 }, { 201, 128, 211, 128 }, { 202, 129, 211, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 },
      { 202, 136, 209, 136 }, { 202, 137, 210, 137 }, { 203, 138, 210, 138 }, { 203, 139, 211, 139 }, { 204, 140, 211, 140 }, { 205, 141, 212, 141 },
      { 206, 142, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 },
    }) do game.set_lava_possible(r) end
    game.create_eruption({ 205, 104 }, 20)
    t:destroy()
  elseif players[1].difficulty == "Normal" then
    game.set_tile({ 205, 102 }, 1147)
    game.set_tile({ 205, 103 }, 1158)
    for _, r in ipairs({
      { 207, 80, 209, 80 }, { 206, 81, 210, 81 }, { 205, 82, 211, 83 }, { 204, 84, 211, 85 }, { 203, 86, 212, 86 }, { 203, 87, 215, 87 },
      { 203, 88, 218, 88 }, { 204, 89, 220, 89 }, { 204, 90, 224, 90 }, { 198, 91, 199, 91 }, { 202, 91, 225, 91 }, { 196, 92, 226, 92 },
      { 194, 93, 226, 93 }, { 193, 94, 226, 94 }, { 192, 95, 225, 95 }, { 192, 96, 224, 96 }, { 192, 97, 207, 97 }, { 211, 97, 221, 97 },
      { 192, 98, 206, 98 }, { 212, 98, 218, 98 }, { 192, 99, 204, 99 }, { 214, 99, 216, 99 }, { 192, 100, 203, 100 }, { 193, 101, 202, 101 },
      { 193, 102, 203, 102 }, { 192, 103, 204, 103 }, { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 },
      { 192, 109, 209, 109 }, { 192, 110, 210, 111 }, { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 },
      { 196, 120, 209, 120 }, { 197, 121, 208, 122 }, { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 199, 126, 211, 126 },
      { 200, 127, 211, 127 }, { 201, 128, 211, 128 }, { 202, 129, 211, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 },
      { 202, 136, 209, 136 }, { 202, 137, 210, 137 }, { 203, 138, 210, 138 }, { 203, 139, 211, 139 }, { 204, 140, 211, 140 }, { 205, 141, 212, 141 },
      { 206, 142, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 },
    }) do game.set_lava_possible(r) end
    game.create_eruption({ 205, 104 }, 20)
    t:destroy()
    trigger.time{time = 30000, on = Lava2_N_Warn}  -- after 300 marks
  else
    game.set_tile({ 205, 102 }, 1147)
    game.set_tile({ 205, 103 }, 1158)
    for _, r in ipairs({
      { 207, 80, 209, 80 }, { 206, 81, 210, 81 }, { 205, 82, 211, 83 }, { 204, 84, 211, 85 }, { 203, 86, 212, 86 }, { 203, 87, 215, 87 },
      { 203, 88, 218, 88 }, { 204, 89, 220, 89 }, { 204, 90, 224, 90 }, { 198, 91, 199, 91 }, { 202, 91, 225, 91 }, { 196, 92, 226, 92 },
      { 194, 93, 226, 93 }, { 193, 94, 226, 94 }, { 192, 95, 225, 95 }, { 192, 96, 224, 96 }, { 192, 97, 207, 97 }, { 211, 97, 221, 97 },
      { 192, 98, 206, 98 }, { 212, 98, 218, 98 }, { 192, 99, 204, 99 }, { 214, 99, 216, 99 }, { 192, 100, 203, 100 }, { 193, 101, 202, 101 },
      { 193, 102, 203, 102 }, { 192, 103, 204, 103 }, { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 },
      { 192, 109, 209, 109 }, { 192, 110, 210, 111 }, { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 },
      { 196, 120, 209, 120 }, { 197, 121, 208, 122 }, { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 199, 126, 211, 126 },
      { 200, 127, 211, 127 }, { 201, 128, 211, 128 }, { 202, 129, 211, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 },
      { 202, 136, 209, 136 }, { 202, 137, 210, 137 }, { 203, 138, 210, 138 }, { 203, 139, 211, 139 }, { 204, 140, 211, 140 }, { 205, 141, 212, 141 },
      { 206, 142, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 },
    }) do game.set_lava_possible(r) end
    game.create_eruption({ 205, 104 }, 20)
    t:destroy()
    trigger.time{time = 30000, on = Lava2_N_Warn}  -- after 300 marks
  end
end

function Lava2_H_Flow(t)
  for _, r in ipairs({
    { 237, 56, 238, 56 }, { 236, 57, 239, 57 }, { 236, 58, 240, 58 }, { 235, 59, 241, 59 }, { 235, 60, 242, 60 }, { 236, 61, 244, 61 },
    { 236, 62, 245, 62 }, { 235, 63, 246, 63 }, { 234, 64, 246, 64 }, { 234, 65, 245, 65 }, { 230, 66, 231, 66 }, { 233, 66, 245, 66 },
    { 227, 67, 244, 67 }, { 226, 68, 244, 68 }, { 225, 69, 244, 70 }, { 221, 70, 222, 70 }, { 220, 71, 244, 72 }, { 219, 73, 245, 73 },
    { 219, 74, 246, 74 }, { 219, 75, 247, 75 }, { 220, 76, 248, 76 }, { 221, 77, 248, 77 }, { 224, 78, 248, 78 }, { 225, 79, 247, 79 },
    { 207, 80, 209, 80 }, { 225, 80, 248, 81 }, { 206, 81, 210, 81 }, { 205, 82, 211, 83 }, { 224, 82, 238, 82 }, { 244, 82, 247, 82 },
    { 224, 83, 237, 83 }, { 204, 84, 211, 85 }, { 223, 84, 236, 85 }, { 186, 85, 187, 85 }, { 184, 86, 189, 86 }, { 203, 86, 212, 86 },
    { 222, 86, 235, 86 }, { 183, 87, 190, 88 }, { 203, 87, 215, 87 }, { 221, 87, 230, 87 }, { 233, 87, 234, 87 }, { 203, 88, 229, 88 },
    { 184, 89, 192, 89 }, { 204, 89, 229, 89 }, { 184, 90, 195, 90 }, { 204, 90, 228, 90 }, { 184, 91, 196, 91 }, { 198, 91, 199, 91 },
    { 202, 91, 226, 91 }, { 184, 92, 226, 92 }, { 185, 93, 226, 94 }, { 184, 95, 186, 95 }, { 188, 95, 225, 95 }, { 183, 96, 185, 96 },
    { 190, 96, 224, 96 }, { 191, 97, 207, 97 }, { 211, 97, 221, 97 }, { 192, 98, 206, 98 }, { 212, 98, 221, 98 }, { 192, 99, 204, 99 },
    { 214, 99, 220, 99 }, { 192, 100, 203, 100 }, { 216, 100, 219, 100 }, { 193, 101, 202, 101 }, { 193, 102, 203, 102 }, { 192, 103, 204, 103 },
    { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 }, { 192, 109, 209, 109 }, { 192, 110, 210, 111 },
    { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 }, { 196, 120, 209, 120 }, { 197, 121, 208, 122 },
    { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 197, 126, 211, 127 }, { 198, 128, 212, 128 }, { 202, 129, 213, 130 },
    { 202, 131, 212, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 }, { 202, 136, 209, 136 }, { 202, 137, 210, 137 },
    { 201, 138, 210, 138 }, { 201, 139, 211, 139 }, { 202, 140, 211, 140 }, { 205, 141, 212, 141 }, { 206, 142, 212, 142 }, { 206, 143, 213, 144 },
    { 206, 145, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 }, { 210, 148, 211, 148 },
  }) do game.set_lava_possible(r) end
  t:destroy()
end

function Lava2_H_Warn(t)
  t:destroy()
  game.create_earthquake({ 226, 86 }, 2)
  trigger.time{time = 1000, on = Lava2_H_Flow}  -- after 10 marks
end

function Lava2_N_Flow(t)
  if players[1].difficulty == "Easy" then
    for _, r in ipairs({
      { 237, 78, 238, 78 }, { 232, 79, 233, 79 }, { 236, 79, 239, 79 }, { 207, 80, 209, 80 }, { 229, 80, 239, 80 }, { 206, 81, 210, 81 },
      { 225, 81, 238, 81 }, { 205, 82, 211, 83 }, { 224, 82, 238, 82 }, { 224, 83, 237, 83 }, { 204, 84, 211, 85 }, { 223, 84, 236, 85 },
      { 186, 85, 187, 85 }, { 184, 86, 189, 86 }, { 203, 86, 212, 86 }, { 222, 86, 235, 86 }, { 183, 87, 190, 88 }, { 203, 87, 215, 87 },
      { 221, 87, 230, 87 }, { 233, 87, 234, 87 }, { 203, 88, 229, 88 }, { 184, 89, 192, 89 }, { 204, 89, 229, 89 }, { 184, 90, 195, 90 },
      { 204, 90, 228, 90 }, { 184, 91, 196, 91 }, { 198, 91, 199, 91 }, { 202, 91, 226, 91 }, { 184, 92, 226, 92 }, { 185, 93, 226, 94 },
      { 184, 95, 186, 95 }, { 188, 95, 225, 95 }, { 183, 96, 185, 96 }, { 190, 96, 224, 96 }, { 191, 97, 207, 97 }, { 211, 97, 221, 97 },
      { 192, 98, 206, 98 }, { 212, 98, 218, 98 }, { 192, 99, 204, 99 }, { 214, 99, 216, 99 }, { 192, 100, 203, 100 }, { 193, 101, 202, 101 },
      { 193, 102, 203, 102 }, { 192, 103, 204, 103 }, { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 },
      { 192, 109, 209, 109 }, { 192, 110, 210, 111 }, { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 },
      { 196, 120, 209, 120 }, { 197, 121, 208, 122 }, { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 199, 126, 211, 126 },
      { 200, 127, 211, 127 }, { 201, 128, 211, 128 }, { 202, 129, 211, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 },
      { 202, 136, 209, 136 }, { 202, 137, 210, 137 }, { 203, 138, 210, 138 }, { 203, 139, 211, 139 }, { 204, 140, 211, 140 }, { 205, 141, 212, 141 },
      { 206, 142, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 },
    }) do game.set_lava_possible(r) end
    t:destroy()
  elseif players[1].difficulty == "Normal" then
    for _, r in ipairs({
      { 237, 78, 238, 78 }, { 232, 79, 233, 79 }, { 236, 79, 239, 79 }, { 207, 80, 209, 80 }, { 229, 80, 239, 80 }, { 206, 81, 210, 81 },
      { 225, 81, 238, 81 }, { 205, 82, 211, 83 }, { 224, 82, 238, 82 }, { 224, 83, 237, 83 }, { 204, 84, 211, 85 }, { 223, 84, 236, 85 },
      { 186, 85, 187, 85 }, { 184, 86, 189, 86 }, { 203, 86, 212, 86 }, { 222, 86, 235, 86 }, { 183, 87, 190, 88 }, { 203, 87, 215, 87 },
      { 221, 87, 230, 87 }, { 233, 87, 234, 87 }, { 203, 88, 229, 88 }, { 184, 89, 192, 89 }, { 204, 89, 229, 89 }, { 184, 90, 195, 90 },
      { 204, 90, 228, 90 }, { 184, 91, 196, 91 }, { 198, 91, 199, 91 }, { 202, 91, 226, 91 }, { 184, 92, 226, 92 }, { 185, 93, 226, 94 },
      { 184, 95, 186, 95 }, { 188, 95, 225, 95 }, { 183, 96, 185, 96 }, { 190, 96, 224, 96 }, { 191, 97, 207, 97 }, { 211, 97, 221, 97 },
      { 192, 98, 206, 98 }, { 212, 98, 218, 98 }, { 192, 99, 204, 99 }, { 214, 99, 216, 99 }, { 192, 100, 203, 100 }, { 193, 101, 202, 101 },
      { 193, 102, 203, 102 }, { 192, 103, 204, 103 }, { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 },
      { 192, 109, 209, 109 }, { 192, 110, 210, 111 }, { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 },
      { 196, 120, 209, 120 }, { 197, 121, 208, 122 }, { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 199, 126, 211, 126 },
      { 200, 127, 211, 127 }, { 201, 128, 211, 128 }, { 202, 129, 211, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 },
      { 202, 136, 209, 136 }, { 202, 137, 210, 137 }, { 203, 138, 210, 138 }, { 203, 139, 211, 139 }, { 204, 140, 211, 140 }, { 205, 141, 212, 141 },
      { 206, 142, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 },
    }) do game.set_lava_possible(r) end
    t:destroy()
  else
    for _, r in ipairs({
      { 237, 78, 238, 78 }, { 232, 79, 233, 79 }, { 236, 79, 239, 79 }, { 207, 80, 209, 80 }, { 229, 80, 239, 80 }, { 206, 81, 210, 81 },
      { 225, 81, 238, 81 }, { 205, 82, 211, 83 }, { 224, 82, 238, 82 }, { 224, 83, 237, 83 }, { 204, 84, 211, 85 }, { 223, 84, 236, 85 },
      { 186, 85, 187, 85 }, { 184, 86, 189, 86 }, { 203, 86, 212, 86 }, { 222, 86, 235, 86 }, { 183, 87, 190, 88 }, { 203, 87, 215, 87 },
      { 221, 87, 230, 87 }, { 233, 87, 234, 87 }, { 203, 88, 229, 88 }, { 184, 89, 192, 89 }, { 204, 89, 229, 89 }, { 184, 90, 195, 90 },
      { 204, 90, 228, 90 }, { 184, 91, 196, 91 }, { 198, 91, 199, 91 }, { 202, 91, 226, 91 }, { 184, 92, 226, 92 }, { 185, 93, 226, 94 },
      { 184, 95, 186, 95 }, { 188, 95, 225, 95 }, { 183, 96, 185, 96 }, { 190, 96, 224, 96 }, { 191, 97, 207, 97 }, { 211, 97, 221, 97 },
      { 192, 98, 206, 98 }, { 212, 98, 218, 98 }, { 192, 99, 204, 99 }, { 214, 99, 216, 99 }, { 192, 100, 203, 100 }, { 193, 101, 202, 101 },
      { 193, 102, 203, 102 }, { 192, 103, 204, 103 }, { 192, 104, 206, 104 }, { 192, 105, 207, 105 }, { 193, 106, 207, 107 }, { 192, 108, 208, 108 },
      { 192, 109, 209, 109 }, { 192, 110, 210, 111 }, { 193, 112, 210, 115 }, { 193, 116, 209, 116 }, { 194, 117, 209, 117 }, { 195, 118, 209, 119 },
      { 196, 120, 209, 120 }, { 197, 121, 208, 122 }, { 197, 123, 209, 123 }, { 198, 124, 210, 124 }, { 198, 125, 211, 125 }, { 199, 126, 211, 126 },
      { 200, 127, 211, 127 }, { 201, 128, 211, 128 }, { 202, 129, 211, 131 }, { 201, 132, 211, 132 }, { 201, 133, 210, 133 }, { 202, 134, 210, 135 },
      { 202, 136, 209, 136 }, { 202, 137, 210, 137 }, { 203, 138, 210, 138 }, { 203, 139, 211, 139 }, { 204, 140, 211, 140 }, { 205, 141, 212, 141 },
      { 206, 142, 212, 145 }, { 207, 146, 212, 146 }, { 208, 147, 212, 147 },
    }) do game.set_lava_possible(r) end
    t:destroy()
    trigger.time{time = 40000, on = Lava2_H_Warn}  -- after 400 marks
  end
end

function Lava2_N_Warn(t)
  t:destroy()
  game.create_earthquake({ 216, 95 }, 2)
  trigger.time{time = 1000, on = Lava2_N_Flow}  -- after 10 marks
end

function Lava2_Vent(t)
  game.set_tile({ 205, 102 }, 1140)
  game.set_tile({ 205, 103 }, 1150)
  t:destroy()
  trigger.time{time = 1500, on = Lava2_Flow}  -- after 15 marks
end

-- A meteor of any size on a tile drawn anywhere, drawn again while a building of player 1 stands within 4 tiles
-- (0x11002BE0); the next in 1 to 60 marks.
function Rand_Meteor(t)
  local x, y
  repeat
    x, y = game.rand(256) + 1, game.rand(256) + 1
    local near = false
    for _, u in ipairs(game.units_in_range({ x, y }, 4)) do
      if u.is_building and u.owner == 0 then near = true break end
    end
  until not near
  game.create_meteor({ x, y }, -1)
  t:destroy()
  trigger.time{min = 100, max = 6000, on = Rand_Meteor}
end

-- A meteor of any size on one of player 1's buildings, drawn among them, leaving out the Command Center, the
-- Structure Factory and the Common Ore Smelter (0x11002CB0); the next after the difficulty's wait to 5/4 of it.
function Bad_Meteor(t)
  t:destroy()
  local wait = BAD_METEOR_TIME[players[1].difficulty] or 50000
  trigger.time{min = wait, max = wait * 5 // 4, on = Bad_Meteor}
  local spots = {}
  for _, u in ipairs(players[1]:units()) do
    if u.is_building and #spots < 128 and u.type ~= "CommandCenter" and u.type ~= "StructureFactory"
        and u.type ~= "CommonOreSmelter" then
      spots[#spots + 1] = { u.x, u.y }
    end
  end
  if #spots > 0 then game.create_meteor(spots[game.rand(#spots) + 1], -1) end
end

-- Every 40 ticks: the colony fails at once with fewer than 8 workers or 3 scientists, or with no Nursery, no
-- University and nothing that can build one (0x11001FB0).
function CheckForFail(t)
  local p = players[1]
  p:reset_checks()
  if p.workers < 8 or p.scientists < 3
      or (not p:owns_any("Nursery") and not p:owns_any("University") and not p:can_build_building()) then
    mission.failure(trigger.time{time = 1})
  end
end

-- An earthquake on the line 93,56 - 167,9 (0x110027A0): the point at (draw(512) + 1) / 512 of
-- the way, magnitude 3 or 4.
function TopQuakeLine(t)
  local r = game.rand(512) + 1
  local x = 93 + tdiv(r * 74, 512)
  local y = 56 + tdiv(r * -47, 512)
  game.create_earthquake({ x, y }, game.rand(2) + 3)
  quake_slots[1]:destroy()
  quake_slots[1] = trigger.time{min = 7500, max = 22500, on = TopQuakeLine}
end

-- An earthquake on the line 234,105 - 231,232 (0x110028C0): the point at (draw(512) + 1) / 512 of
-- the way, magnitude 3 or 4.
function SideQuakeLine(t)
  local r = game.rand(512) + 1
  local x = 234 + tdiv(r * -3, 512)
  local y = 105 + tdiv(r * 127, 512)
  game.create_earthquake({ x, y }, game.rand(2) + 3)
  quake_slots[4]:destroy()
  quake_slots[4] = trigger.time{min = 7500, max = 22500, on = SideQuakeLine}
end

-- An earthquake on the line 24,65 - 93,104 (0x110029E0): the point at (draw(512) + 1) / 512 of
-- the way, magnitude 3 or 4.
function Fault1Line(t)
  local r = game.rand(512) + 1
  local x = 24 + tdiv(r * 69, 512)
  local y = 65 + tdiv(r * 39, 512)
  game.create_earthquake({ x, y }, game.rand(2) + 3)
  quake_slots[2]:destroy()
  quake_slots[2] = trigger.time{min = 7500, max = 22500, on = Fault1Line}
end

-- An earthquake on the line 24,65 - 86,188 (0x11002B00): the point at (draw(512) + 1) / 512 of
-- the way, magnitude 3 or 4.
function Fault2Line(t)
  local r = game.rand(512) + 1
  local x = 24 + tdiv(r * 62, 512)
  local y = 65 + tdiv(r * 123, 512)
  game.create_earthquake({ x, y }, game.rand(2) + 3)
  quake_slots[3]:destroy()
  quake_slots[3] = trigger.time{min = 7500, max = 22500, on = Fault2Line}
end

-- A storm of 10 to 16 ticks on a tile drawn anywhere (the game's MAP_RECT::RandPt; 0x110026D0); the next in 1 to 240
-- marks.
function RandStorm(t)
  t:destroy()
  local at = game.rand_point({ 1, 1, 256, 253 })
  game.create_lightning(at, nil, game.rand(7) + 10)
  trigger.time{min = 100, max = 24000, on = RandStorm}
end

-- A vortex for 127 ticks between two tiles drawn in the alley 162,211 - 242,241 (0x11002610); the next in 1 to 240
-- marks.
function TornadoAlley(t)
  t:destroy()
  local from = game.rand_point({ 162, 211, 242, 241 })
  local to = game.rand_point({ 162, 211, 242, 241 })
  game.create_tornado(from, to, 127)
  trigger.time{min = 100, max = 24000, on = TornadoAlley}
end

-- Every 220 marks from the third: player 2's tech level goes up, and with it the size of its waves; after the
-- twelfth it stops (0x11001DE0).
function TimeUpgrades(t)
  upgrades = upgrades + 1
  if upgrades < 3 then return end
  if upgrades >= 13 then t:destroy() return end
  players[2]:set_tech_level(upgrades)
  wave_step = upgrades - 3
  local sizes = players[1].difficulty == "Normal" and WAVE_SIZE_NORMAL or WAVE_SIZE_OTHER
  wave_size = sizes[wave_step + 1]
end

-- Every 80 marks: player 2 sends 1 to 3 Scouts in from the west edge (x 1, y 21 to 48), and after tick 20000 a Laser
-- Lynx too, as a fight group that leaves the map at the east edge, 255,63 - 256,81 (0x11001E90).
function ScoutWave(t)
  local group = ai.fight_group(players[2])
  group:do_exit_map()
  group:set_rect({ 255, 63, 256, 81 })
  group:set_delete_when_empty(true)
  for _ = 1, game.rand(3) + 1 do
    local u = game.create_unit{ type = "Scout", player = 2, at = { 1, game.rand(28) + 21 }, lights = false, exact = true }[1]
    if u then group:take_unit(u) end
  end
  if game.tick() > 20000 then
    local u = game.create_unit{ type = "Lynx", weapon = "Laser", player = 2, at = { 1, game.rand(28) + 21 }, lights = false,
                                exact = true }[1]
    if u then group:take_unit(u) end
  end
end

-- A wave of player 2's tanks (0x110018E0). It goes to the first area with more than 2 of player 1's buildings in it (a
-- mine counts 2), the last area if none. The first two waves are 1 and 3 Laser Lynx (and end ScoutWave); then each
-- unit of the step's list that always comes, and more drawn by weight up to the larger of player 1's strength and a
-- floor that grows with the waves (by 3/4 below Hard; 1 to 8), times TimeUpgrades' size, at most 32 in all. Lights
-- on 3 times in 4; StageDone after the area's wait, half as long again with the lights off.
function SpawnAttack(t)
  if attack_group and attack_group.valid then attack_group:set_delete_when_empty(true) end
  zone = #ZONES
  for i = 1, #ZONES - 1 do
    local r, points = ZONES[i][1], 0
    for _, u in ipairs(players[1]:units()) do
      if u.is_building then
        local x, y = u.x + 31, u.y - 1
        if x >= r[1] and x <= r[3] and y >= r[2] and y <= r[4] then
          points = points + ((u.type == "CommonOreMine" or u.type == "RareOreMine") and 2 or 1)
          if points > 2 then break end
        end
      end
    end
    if points > 2 then zone = i break end
  end
  waves = waves + 1
  local z = ZONES[zone]
  attack_group = ai.fight_group(players[2])
  attack_group:do_guard_rect()
  attack_group:set_rect({ z[2][1] - 31, z[2][2] + 1, z[2][3] - 31, z[2][4] + 1 })
  if waves < 3 then
    scout_trigger:destroy()
    for _ = 1, waves == 2 and 3 or 1 do attacker("Lynx", "Laser") end
  else
    local list, made, cumulative, total = WAVES[wave_step + 1], 0, {}, 0
    for i, w in ipairs(list) do
      for _ = 1, w[4] do
        if attacker(w[1], w[2]) then made = made + 1 end
      end
      total = total + w[3]
      cumulative[i] = total
    end
    local floor = waves
    if players[1].difficulty ~= "Hard" then floor = waves * 3 // 4 end
    floor = math.min(floor + 1, 8)
    local count = math.min(math.max(players[1]:total_strength(), floor) * wave_size // 65536, 32) - made
    for _ = 1, count do
      local r, i = game.rand(total), 1
      while cumulative[i] <= r do i = i + 1 end
      attacker(list[i][1], list[i][2])
    end
  end
  local lights = game.rand(100) > 25
  attack_group:set_lights(lights)
  stage_trigger:destroy()
  stage_trigger = trigger.time{time = lights and z[3] or z[3] * 3 // 2, on = StageDone}
end

-- The wave attacks, from 1,1 - 33,33, lights on; on Normal its first three go for the Command Center or the Structure
-- Factory, even odds. The next wave comes 140 to 180 marks later, less the area's wait, at least 10 (0x11001CE0).
function StageDone(t)
  attack_group:do_attack_enemy()
  attack_group:set_rect({ 1, 1, 33, 33 })
  attack_group:set_lights(true)
  if players[1].difficulty == "Normal" and waves <= 3 then
    attack_group:set_attack_type(game.rand(100) > 49 and "CommandCenter" or "StructureFactory")
  end
  stage_trigger:destroy()
  local wait = game.rand(16000 // 4) + 16000 * 7 // 8 - ZONES[zone][3]
  stage_trigger = trigger.time{time = math.max(wait, 1000), on = SpawnAttack}
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
  roll_beacons(BEACONS.rolled)
  for id, p in pairs(d.players) do make_player(players[id], p) end
  -- The setup's own map edits, after its units (and the draws it makes for them).
  game.set_cell_type({ 217, 66 }, 21)
  game.initial_set_tile({ 217, 66 }, 921)
  game.set_cell_type({ 217, 67 }, 21)
  game.initial_set_tile({ 217, 67 }, 921)
  game.set_cell_type({ 217, 68 }, 21)
  game.initial_set_tile({ 217, 68 }, 921)
  game.set_cell_type({ 217, 69 }, 21)
  game.initial_set_tile({ 217, 69 }, 921)
  game.set_cell_type({ 217, 70 }, 21)
  game.initial_set_tile({ 217, 70 }, 921)
  game.set_cell_type({ 217, 71 }, 21)
  game.initial_set_tile({ 217, 71 }, 921)
  game.set_cell_type({ 217, 76 }, 21)
  game.initial_set_tile({ 217, 76 }, 921)
  game.set_cell_type({ 217, 77 }, 21)
  game.initial_set_tile({ 217, 77 }, 921)
  game.set_cell_type({ 217, 78 }, 21)
  game.initial_set_tile({ 217, 78 }, 921)
  game.set_cell_type({ 217, 79 }, 21)
  game.initial_set_tile({ 217, 79 }, 921)
  game.set_cell_type({ 217, 80 }, 21)
  game.initial_set_tile({ 217, 80 }, 921)
  game.set_cell_type({ 217, 81 }, 21)
  game.initial_set_tile({ 217, 81 }, 921)
  game.set_cell_type({ 217, 82 }, 21)
  game.initial_set_tile({ 217, 82 }, 921)
  game.set_cell_type({ 218, 66 }, 21)
  game.initial_set_tile({ 218, 66 }, 921)
  game.set_cell_type({ 218, 67 }, 21)
  game.initial_set_tile({ 218, 67 }, 921)
  game.set_cell_type({ 218, 68 }, 21)
  game.initial_set_tile({ 218, 68 }, 921)
  game.set_cell_type({ 218, 69 }, 21)
  game.initial_set_tile({ 218, 69 }, 921)
  game.set_cell_type({ 218, 70 }, 21)
  game.initial_set_tile({ 218, 70 }, 921)
  game.set_cell_type({ 218, 71 }, 21)
  game.initial_set_tile({ 218, 71 }, 921)
  game.set_cell_type({ 218, 77 }, 21)
  game.initial_set_tile({ 218, 77 }, 921)
  game.set_cell_type({ 218, 78 }, 21)
  game.initial_set_tile({ 218, 78 }, 921)
  game.set_cell_type({ 218, 79 }, 21)
  game.initial_set_tile({ 218, 79 }, 921)
  game.set_cell_type({ 218, 80 }, 21)
  game.initial_set_tile({ 218, 80 }, 921)
  game.set_cell_type({ 218, 81 }, 21)
  game.initial_set_tile({ 218, 81 }, 921)
  game.set_cell_type({ 218, 82 }, 21)
  game.initial_set_tile({ 218, 82 }, 921)
  game.set_cell_type({ 219, 66 }, 21)
  game.initial_set_tile({ 219, 66 }, 921)
  game.set_cell_type({ 219, 67 }, 21)
  game.initial_set_tile({ 219, 67 }, 921)
  game.set_cell_type({ 219, 68 }, 21)
  game.initial_set_tile({ 219, 68 }, 921)
  game.set_cell_type({ 219, 69 }, 21)
  game.initial_set_tile({ 219, 69 }, 921)
  game.set_cell_type({ 219, 70 }, 21)
  game.initial_set_tile({ 219, 70 }, 921)
  game.set_cell_type({ 219, 71 }, 21)
  game.initial_set_tile({ 219, 71 }, 921)
  game.set_cell_type({ 219, 77 }, 21)
  game.initial_set_tile({ 219, 77 }, 921)
  game.set_cell_type({ 219, 78 }, 21)
  game.initial_set_tile({ 219, 78 }, 921)
  game.set_cell_type({ 219, 79 }, 21)
  game.initial_set_tile({ 219, 79 }, 921)
  game.set_cell_type({ 219, 80 }, 21)
  game.initial_set_tile({ 219, 80 }, 921)
  game.set_cell_type({ 219, 81 }, 21)
  game.initial_set_tile({ 219, 81 }, 921)
  game.set_cell_type({ 219, 82 }, 21)
  game.initial_set_tile({ 219, 82 }, 921)
  game.set_cell_type({ 220, 66 }, 21)
  game.initial_set_tile({ 220, 66 }, 921)
  game.set_cell_type({ 220, 67 }, 21)
  game.initial_set_tile({ 220, 67 }, 921)
  game.set_cell_type({ 220, 68 }, 21)
  game.initial_set_tile({ 220, 68 }, 921)
  game.set_cell_type({ 220, 69 }, 21)
  game.initial_set_tile({ 220, 69 }, 921)
  game.set_cell_type({ 220, 70 }, 21)
  game.initial_set_tile({ 220, 70 }, 921)
  game.set_cell_type({ 220, 71 }, 21)
  game.initial_set_tile({ 220, 71 }, 921)
  game.set_cell_type({ 220, 77 }, 21)
  game.initial_set_tile({ 220, 77 }, 921)
  game.set_cell_type({ 220, 78 }, 21)
  game.initial_set_tile({ 220, 78 }, 921)
  game.set_cell_type({ 220, 79 }, 21)
  game.initial_set_tile({ 220, 79 }, 921)
  game.set_cell_type({ 220, 80 }, 21)
  game.initial_set_tile({ 220, 80 }, 921)
  game.set_cell_type({ 220, 81 }, 21)
  game.initial_set_tile({ 220, 81 }, 921)
  game.set_cell_type({ 220, 82 }, 21)
  game.initial_set_tile({ 220, 82 }, 921)
  game.set_cell_type({ 221, 66 }, 21)
  game.initial_set_tile({ 221, 66 }, 921)
  game.set_cell_type({ 221, 67 }, 21)
  game.initial_set_tile({ 221, 67 }, 921)
  game.set_cell_type({ 221, 68 }, 21)
  game.initial_set_tile({ 221, 68 }, 921)
  game.set_cell_type({ 221, 69 }, 21)
  game.initial_set_tile({ 221, 69 }, 921)
  game.set_cell_type({ 221, 70 }, 21)
  game.initial_set_tile({ 221, 70 }, 921)
  game.set_cell_type({ 221, 71 }, 21)
  game.initial_set_tile({ 221, 71 }, 921)
  game.set_cell_type({ 221, 77 }, 21)
  game.initial_set_tile({ 221, 77 }, 921)
  game.set_cell_type({ 221, 78 }, 21)
  game.initial_set_tile({ 221, 78 }, 921)
  game.set_cell_type({ 221, 79 }, 21)
  game.initial_set_tile({ 221, 79 }, 921)
  game.set_cell_type({ 221, 80 }, 21)
  game.initial_set_tile({ 221, 80 }, 921)
  game.set_cell_type({ 221, 81 }, 21)
  game.initial_set_tile({ 221, 81 }, 921)
  game.set_cell_type({ 221, 82 }, 21)
  game.initial_set_tile({ 221, 82 }, 921)
  game.set_cell_type({ 222, 66 }, 21)
  game.initial_set_tile({ 222, 66 }, 921)
  game.set_cell_type({ 222, 67 }, 21)
  game.initial_set_tile({ 222, 67 }, 921)
  game.set_cell_type({ 222, 68 }, 21)
  game.initial_set_tile({ 222, 68 }, 921)
  game.set_cell_type({ 222, 69 }, 21)
  game.initial_set_tile({ 222, 69 }, 921)
  game.set_cell_type({ 222, 70 }, 21)
  game.initial_set_tile({ 222, 70 }, 921)
  game.set_cell_type({ 222, 71 }, 21)
  game.initial_set_tile({ 222, 71 }, 921)
  game.set_cell_type({ 222, 77 }, 21)
  game.initial_set_tile({ 222, 77 }, 921)
  game.set_cell_type({ 222, 78 }, 21)
  game.initial_set_tile({ 222, 78 }, 921)
  game.set_cell_type({ 222, 79 }, 21)
  game.initial_set_tile({ 222, 79 }, 921)
  game.set_cell_type({ 222, 80 }, 21)
  game.initial_set_tile({ 222, 80 }, 921)
  game.set_cell_type({ 222, 81 }, 21)
  game.initial_set_tile({ 222, 81 }, 921)
  game.set_cell_type({ 222, 82 }, 21)
  game.initial_set_tile({ 222, 82 }, 921)
  game.set_cell_type({ 223, 66 }, 21)
  game.initial_set_tile({ 223, 66 }, 921)
  game.set_cell_type({ 223, 67 }, 21)
  game.initial_set_tile({ 223, 67 }, 921)
  game.set_cell_type({ 223, 68 }, 21)
  game.initial_set_tile({ 223, 68 }, 921)
  game.set_cell_type({ 223, 69 }, 21)
  game.initial_set_tile({ 223, 69 }, 921)
  game.set_cell_type({ 223, 70 }, 21)
  game.initial_set_tile({ 223, 70 }, 921)
  game.set_cell_type({ 223, 71 }, 21)
  game.initial_set_tile({ 223, 71 }, 921)
  game.set_cell_type({ 223, 72 }, 21)
  game.initial_set_tile({ 223, 72 }, 921)
  game.set_cell_type({ 223, 73 }, 21)
  game.initial_set_tile({ 223, 73 }, 921)
  game.set_cell_type({ 223, 75 }, 21)
  game.initial_set_tile({ 223, 75 }, 921)
  game.set_cell_type({ 223, 76 }, 21)
  game.initial_set_tile({ 223, 76 }, 921)
  game.set_cell_type({ 223, 77 }, 21)
  game.initial_set_tile({ 223, 77 }, 921)
  game.set_cell_type({ 223, 78 }, 21)
  game.initial_set_tile({ 223, 78 }, 921)
  game.set_cell_type({ 223, 79 }, 21)
  game.initial_set_tile({ 223, 79 }, 921)
  game.set_cell_type({ 223, 80 }, 21)
  game.initial_set_tile({ 223, 80 }, 921)
  game.set_cell_type({ 223, 81 }, 21)
  game.initial_set_tile({ 223, 81 }, 921)
  game.set_cell_type({ 223, 82 }, 21)
  game.initial_set_tile({ 223, 82 }, 921)
  game.set_cell_type({ 224, 66 }, 21)
  game.initial_set_tile({ 224, 66 }, 921)
  game.set_cell_type({ 224, 67 }, 21)
  game.initial_set_tile({ 224, 67 }, 921)
  game.set_cell_type({ 224, 68 }, 21)
  game.initial_set_tile({ 224, 68 }, 921)
  game.set_cell_type({ 224, 69 }, 21)
  game.initial_set_tile({ 224, 69 }, 921)
  game.set_cell_type({ 224, 70 }, 21)
  game.initial_set_tile({ 224, 70 }, 921)
  game.set_cell_type({ 224, 71 }, 21)
  game.initial_set_tile({ 224, 71 }, 921)
  game.set_cell_type({ 224, 72 }, 21)
  game.initial_set_tile({ 224, 72 }, 921)
  game.set_cell_type({ 224, 73 }, 21)
  game.initial_set_tile({ 224, 73 }, 921)
  game.set_cell_type({ 224, 75 }, 21)
  game.initial_set_tile({ 224, 75 }, 921)
  game.set_cell_type({ 224, 76 }, 21)
  game.initial_set_tile({ 224, 76 }, 921)
  game.set_cell_type({ 224, 77 }, 21)
  game.initial_set_tile({ 224, 77 }, 921)
  game.set_cell_type({ 224, 78 }, 21)
  game.initial_set_tile({ 224, 78 }, 921)
  game.set_cell_type({ 224, 79 }, 21)
  game.initial_set_tile({ 224, 79 }, 921)
  game.set_cell_type({ 224, 80 }, 21)
  game.initial_set_tile({ 224, 80 }, 921)
  game.set_cell_type({ 224, 81 }, 21)
  game.initial_set_tile({ 224, 81 }, 921)
  game.set_cell_type({ 224, 82 }, 21)
  game.initial_set_tile({ 224, 82 }, 921)
  game.set_cell_type({ 225, 66 }, 21)
  game.initial_set_tile({ 225, 66 }, 921)
  game.set_cell_type({ 225, 67 }, 21)
  game.initial_set_tile({ 225, 67 }, 921)
  game.set_cell_type({ 225, 68 }, 21)
  game.initial_set_tile({ 225, 68 }, 921)
  game.set_cell_type({ 225, 69 }, 21)
  game.initial_set_tile({ 225, 69 }, 921)
  game.set_cell_type({ 225, 70 }, 21)
  game.initial_set_tile({ 225, 70 }, 921)
  game.set_cell_type({ 225, 71 }, 21)
  game.initial_set_tile({ 225, 71 }, 921)
  game.set_cell_type({ 225, 77 }, 21)
  game.initial_set_tile({ 225, 77 }, 921)
  game.set_cell_type({ 225, 78 }, 21)
  game.initial_set_tile({ 225, 78 }, 921)
  game.set_cell_type({ 225, 82 }, 21)
  game.initial_set_tile({ 225, 82 }, 921)
  game.set_cell_type({ 226, 70 }, 21)
  game.initial_set_tile({ 226, 70 }, 921)
  game.set_cell_type({ 226, 71 }, 21)
  game.initial_set_tile({ 226, 71 }, 921)
  game.set_cell_type({ 226, 77 }, 21)
  game.initial_set_tile({ 226, 77 }, 921)
  game.set_cell_type({ 226, 78 }, 21)
  game.initial_set_tile({ 226, 78 }, 921)
  game.set_cell_type({ 227, 70 }, 21)
  game.initial_set_tile({ 227, 70 }, 921)
  game.set_cell_type({ 227, 71 }, 21)
  game.initial_set_tile({ 227, 71 }, 921)
  game.set_cell_type({ 227, 77 }, 21)
  game.initial_set_tile({ 227, 77 }, 921)
  game.set_cell_type({ 227, 78 }, 21)
  game.initial_set_tile({ 227, 78 }, 921)
  game.set_cell_type({ 229, 70 }, 21)
  game.initial_set_tile({ 229, 70 }, 921)
  game.set_cell_type({ 229, 71 }, 21)
  game.initial_set_tile({ 229, 71 }, 921)
  game.set_cell_type({ 229, 77 }, 21)
  game.initial_set_tile({ 229, 77 }, 921)
  game.set_cell_type({ 229, 78 }, 21)
  game.initial_set_tile({ 229, 78 }, 921)
  game.set_cell_type({ 230, 70 }, 21)
  game.initial_set_tile({ 230, 70 }, 921)
  game.set_cell_type({ 230, 71 }, 21)
  game.initial_set_tile({ 230, 71 }, 921)
  game.set_cell_type({ 230, 76 }, 21)
  game.initial_set_tile({ 230, 76 }, 921)
  game.set_cell_type({ 230, 77 }, 21)
  game.initial_set_tile({ 230, 77 }, 921)
  game.set_cell_type({ 230, 78 }, 21)
  game.initial_set_tile({ 230, 78 }, 921)
  game.set_cell_type({ 230, 79 }, 21)
  game.initial_set_tile({ 230, 79 }, 921)
  game.set_cell_type({ 230, 80 }, 21)
  game.initial_set_tile({ 230, 80 }, 921)
  game.set_cell_type({ 231, 70 }, 21)
  game.initial_set_tile({ 231, 70 }, 921)
  game.set_cell_type({ 231, 71 }, 21)
  game.initial_set_tile({ 231, 71 }, 921)
  game.set_cell_type({ 231, 72 }, 21)
  game.initial_set_tile({ 231, 72 }, 921)
  game.set_cell_type({ 231, 73 }, 21)
  game.initial_set_tile({ 231, 73 }, 921)
  game.set_cell_type({ 231, 74 }, 21)
  game.initial_set_tile({ 231, 74 }, 921)
  game.set_cell_type({ 231, 75 }, 21)
  game.initial_set_tile({ 231, 75 }, 921)
  game.set_cell_type({ 231, 76 }, 21)
  game.initial_set_tile({ 231, 76 }, 921)
  game.set_cell_type({ 231, 77 }, 21)
  game.initial_set_tile({ 231, 77 }, 921)
  game.set_cell_type({ 231, 78 }, 21)
  game.initial_set_tile({ 231, 78 }, 921)
  game.set_cell_type({ 232, 70 }, 21)
  game.initial_set_tile({ 232, 70 }, 921)
  game.set_cell_type({ 232, 71 }, 21)
  game.initial_set_tile({ 232, 71 }, 921)
  game.set_cell_type({ 232, 72 }, 21)
  game.initial_set_tile({ 232, 72 }, 921)
  game.set_cell_type({ 232, 73 }, 21)
  game.initial_set_tile({ 232, 73 }, 921)
  game.set_cell_type({ 232, 74 }, 21)
  game.initial_set_tile({ 232, 74 }, 921)
  game.set_cell_type({ 232, 75 }, 21)
  game.initial_set_tile({ 232, 75 }, 921)
  game.set_cell_type({ 232, 76 }, 21)
  game.initial_set_tile({ 232, 76 }, 921)
  game.set_cell_type({ 232, 77 }, 21)
  game.initial_set_tile({ 232, 77 }, 921)
  game.set_cell_type({ 232, 78 }, 21)
  game.initial_set_tile({ 232, 78 }, 921)
  game.set_cell_type({ 233, 70 }, 21)
  game.initial_set_tile({ 233, 70 }, 921)
  game.set_cell_type({ 233, 71 }, 21)
  game.initial_set_tile({ 233, 71 }, 921)
  game.set_cell_type({ 233, 72 }, 21)
  game.initial_set_tile({ 233, 72 }, 921)
  game.set_cell_type({ 233, 73 }, 21)
  game.initial_set_tile({ 233, 73 }, 921)
  game.set_cell_type({ 233, 74 }, 21)
  game.initial_set_tile({ 233, 74 }, 921)
  game.set_cell_type({ 233, 75 }, 21)
  game.initial_set_tile({ 233, 75 }, 921)
  game.set_cell_type({ 233, 76 }, 21)
  game.initial_set_tile({ 233, 76 }, 921)
  game.set_cell_type({ 233, 77 }, 21)
  game.initial_set_tile({ 233, 77 }, 921)
  game.set_cell_type({ 233, 78 }, 21)
  game.initial_set_tile({ 233, 78 }, 921)
  game.set_cell_type({ 234, 70 }, 21)
  game.initial_set_tile({ 234, 70 }, 921)
  game.set_cell_type({ 234, 71 }, 21)
  game.initial_set_tile({ 234, 71 }, 921)
  game.set_cell_type({ 234, 72 }, 21)
  game.initial_set_tile({ 234, 72 }, 921)
  game.set_cell_type({ 234, 73 }, 21)
  game.initial_set_tile({ 234, 73 }, 921)
  game.set_cell_type({ 234, 74 }, 21)
  game.initial_set_tile({ 234, 74 }, 921)
  game.set_cell_type({ 234, 75 }, 21)
  game.initial_set_tile({ 234, 75 }, 921)
  game.set_cell_type({ 234, 76 }, 21)
  game.initial_set_tile({ 234, 76 }, 921)
  game.set_cell_type({ 234, 77 }, 21)
  game.initial_set_tile({ 234, 77 }, 921)
  game.set_cell_type({ 234, 78 }, 21)
  game.initial_set_tile({ 234, 78 }, 921)
  game.set_cell_type({ 235, 70 }, 21)
  game.initial_set_tile({ 235, 70 }, 921)
  game.set_cell_type({ 235, 71 }, 21)
  game.initial_set_tile({ 235, 71 }, 921)
  game.set_cell_type({ 235, 72 }, 21)
  game.initial_set_tile({ 235, 72 }, 921)
  game.set_cell_type({ 235, 73 }, 21)
  game.initial_set_tile({ 235, 73 }, 921)
  game.set_cell_type({ 235, 74 }, 21)
  game.initial_set_tile({ 235, 74 }, 921)
  game.set_cell_type({ 235, 75 }, 21)
  game.initial_set_tile({ 235, 75 }, 921)
  game.set_cell_type({ 235, 76 }, 21)
  game.initial_set_tile({ 235, 76 }, 921)
  game.set_cell_type({ 235, 77 }, 21)
  game.initial_set_tile({ 235, 77 }, 921)
  game.set_cell_type({ 235, 78 }, 21)
  game.initial_set_tile({ 235, 78 }, 921)
  game.set_cell_type({ 236, 70 }, 21)
  game.initial_set_tile({ 236, 70 }, 921)
  game.set_cell_type({ 236, 71 }, 21)
  game.initial_set_tile({ 236, 71 }, 921)
  game.set_cell_type({ 236, 72 }, 21)
  game.initial_set_tile({ 236, 72 }, 921)
  game.set_cell_type({ 236, 73 }, 21)
  game.initial_set_tile({ 236, 73 }, 921)
  game.set_cell_type({ 236, 74 }, 21)
  game.initial_set_tile({ 236, 74 }, 921)
  game.set_cell_type({ 236, 75 }, 21)
  game.initial_set_tile({ 236, 75 }, 921)
  game.set_cell_type({ 236, 76 }, 21)
  game.initial_set_tile({ 236, 76 }, 921)
  game.set_cell_type({ 236, 77 }, 21)
  game.initial_set_tile({ 236, 77 }, 921)
  game.set_cell_type({ 236, 78 }, 21)
  game.initial_set_tile({ 236, 78 }, 921)
  game.set_cell_type({ 237, 70 }, 21)
  game.initial_set_tile({ 237, 70 }, 921)
  game.set_cell_type({ 237, 71 }, 21)
  game.initial_set_tile({ 237, 71 }, 921)
  game.set_cell_type({ 237, 72 }, 21)
  game.initial_set_tile({ 237, 72 }, 921)
  game.set_cell_type({ 237, 73 }, 21)
  game.initial_set_tile({ 237, 73 }, 921)
  game.set_cell_type({ 237, 74 }, 21)
  game.initial_set_tile({ 237, 74 }, 921)
  game.set_cell_type({ 237, 75 }, 21)
  game.initial_set_tile({ 237, 75 }, 921)
  game.set_cell_type({ 237, 76 }, 21)
  game.initial_set_tile({ 237, 76 }, 921)
  game.set_cell_type({ 237, 77 }, 21)
  game.initial_set_tile({ 237, 77 }, 921)
  game.set_cell_type({ 237, 78 }, 21)
  game.initial_set_tile({ 237, 78 }, 921)
  game.set_cell_type({ 238, 70 }, 21)
  game.initial_set_tile({ 238, 70 }, 921)
  game.set_cell_type({ 238, 71 }, 21)
  game.initial_set_tile({ 238, 71 }, 921)
  game.set_cell_type({ 238, 72 }, 21)
  game.initial_set_tile({ 238, 72 }, 921)
  game.set_cell_type({ 238, 73 }, 21)
  game.initial_set_tile({ 238, 73 }, 921)
  game.set_cell_type({ 238, 74 }, 21)
  game.initial_set_tile({ 238, 74 }, 921)
  game.set_cell_type({ 238, 75 }, 21)
  game.initial_set_tile({ 238, 75 }, 921)
  game.set_cell_type({ 238, 76 }, 21)
  game.initial_set_tile({ 238, 76 }, 921)
  game.set_cell_type({ 238, 77 }, 21)
  game.initial_set_tile({ 238, 77 }, 921)
  game.set_cell_type({ 238, 78 }, 21)
  game.initial_set_tile({ 238, 78 }, 921)
  game.set_cell_type({ 239, 70 }, 21)
  game.initial_set_tile({ 239, 70 }, 921)
  game.set_cell_type({ 239, 71 }, 21)
  game.initial_set_tile({ 239, 71 }, 921)
  game.set_cell_type({ 239, 72 }, 21)
  game.initial_set_tile({ 239, 72 }, 921)
  game.set_cell_type({ 239, 73 }, 21)
  game.initial_set_tile({ 239, 73 }, 921)
  game.set_cell_type({ 239, 74 }, 21)
  game.initial_set_tile({ 239, 74 }, 921)
  game.set_cell_type({ 239, 75 }, 21)
  game.initial_set_tile({ 239, 75 }, 921)
  game.set_cell_type({ 239, 76 }, 21)
  game.initial_set_tile({ 239, 76 }, 921)
  game.set_cell_type({ 239, 77 }, 21)
  game.initial_set_tile({ 239, 77 }, 921)
  game.set_cell_type({ 239, 78 }, 21)
  game.initial_set_tile({ 239, 78 }, 921)
  game.set_cell_type({ 240, 70 }, 21)
  game.initial_set_tile({ 240, 70 }, 921)
  game.set_cell_type({ 240, 71 }, 21)
  game.initial_set_tile({ 240, 71 }, 921)
  game.set_cell_type({ 240, 72 }, 21)
  game.initial_set_tile({ 240, 72 }, 921)
  game.set_cell_type({ 240, 73 }, 21)
  game.initial_set_tile({ 240, 73 }, 921)
  game.set_cell_type({ 240, 74 }, 21)
  game.initial_set_tile({ 240, 74 }, 921)
  game.set_cell_type({ 240, 75 }, 21)
  game.initial_set_tile({ 240, 75 }, 921)
  game.set_cell_type({ 240, 76 }, 21)
  game.initial_set_tile({ 240, 76 }, 921)
  game.set_cell_type({ 240, 77 }, 21)
  game.initial_set_tile({ 240, 77 }, 921)
  game.set_cell_type({ 240, 78 }, 21)
  game.initial_set_tile({ 240, 78 }, 921)
  game.set_daylight_everywhere(false)
  game.set_daylight_moves(true)
  if difficulty == "Easy" then game.morale_steady("Good") end

  -- The win.
  local t5
  if difficulty == "Easy" then
    t5 = trigger.resource{resource = "Colonists", compare = ">=", amount = 450, player = 1, one_shot = true}
    mission.victory(t5, "Build your population to 450 colonists.")
  elseif difficulty == "Normal" then
    t5 = trigger.resource{resource = "Colonists", compare = ">=", amount = 600, player = 1, one_shot = true}
    mission.victory(t5, "Build your population to 600 colonists.")
  elseif difficulty == "Hard" then
    t5 = trigger.resource{resource = "Colonists", compare = ">=", amount = 750, player = 1, one_shot = true}
    mission.victory(t5, "Build your population to 750 colonists.")
  end
  local t7 = trigger.operational{type = "CommandCenter", compare = "==", count = 0, player = 1}
  mission.failure(t7)
  trigger.time{time = 40, one_shot = false, on = CheckForFail}  -- after 0 marks
  trigger.time{time = 300, on = Lava1_Vent}  -- after 3 marks
  trigger.time{time = 40000, on = Lava2_Vent}  -- after 400 marks
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 219, 112 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 179, 63 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 154, 222 } }
  game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 11, 207 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 6, 156 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 34, 246 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 68, 151 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 147, 238 } }
  game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 237, 56 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 95 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 181, 12 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = { 71, 163 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 11, 27 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar1", variant = "Random", at = { 89, 102 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 188, 233 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar2", variant = "Random", at = { 129, 245 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = { 235, 227 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 53, 155 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 111, 78 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 168, 197 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 91, 209 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 114, 142 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 9, 200 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 21, 11 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 86, 181 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 67, 64 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 47, 243 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 27, 69 } }
  trigger.time{time = 500, on = Rand_Meteor}  -- after 5 marks
  trigger.time{min = 55000, max = 65000, on = Bad_Meteor}  -- after 550 to 650 marks
  quake_slots[1] = trigger.time{min = 7500, max = 22500, on = TopQuakeLine}  -- after 75 to 225 marks
  quake_slots[2] = trigger.time{min = 7500, max = 22500, on = SideQuakeLine}  -- after 75 to 225 marks
  quake_slots[3] = trigger.time{min = 7500, max = 22500, on = Fault1Line}  -- after 75 to 225 marks
  quake_slots[4] = trigger.time{min = 7500, max = 22500, on = Fault2Line}  -- after 75 to 225 marks
  trigger.time{min = 100, max = 24000, on = TornadoAlley}  -- after 1 to 240 marks
  trigger.time{min = 100, max = 8000, on = RandStorm}  -- after 1 to 80 marks
  if difficulty == "Easy" then
    trigger.time{time = 10, on = ReleaseMorale}  -- after 0 marks
  elseif difficulty == "Normal" then
    stage_trigger = trigger.time{time = 50000, on = SpawnAttack}  -- after 500 marks
    trigger.time{time = 22000, one_shot = false, on = TimeUpgrades}  -- after 220 marks
  elseif difficulty == "Hard" then
    stage_trigger = trigger.time{time = 40000, on = SpawnAttack}  -- after 400 marks
    trigger.time{time = 18000, one_shot = false, on = TimeUpgrades}  -- after 180 marks
  end
  scout_trigger = trigger.time{time = 8000, one_shot = false, on = ScoutWave}  -- after 80 marks
end

-- Not converted:
