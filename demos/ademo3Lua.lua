-- ademo3Lua.lua  -  AutoDemo Mission #3 (Lua)
-- Finished by hand (the AI groups and the trigger functions op2dll leaves), from op2dll calls of ademo3.dll: complete.
-- Converted by op2dll from ademo3.dll. With ademo3Lua.placement.lua (what every difficulty makes alike),
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
-- The setup makes the same at every difficulty: `Normal` is used for all three.
local DIFFICULTIES = {
  Normal = {
    players = {
      [1] = {
        research = {  },
        view = { 36, 44 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
      [3] = {
        workers = 34, scientists = 27, kids = 38, food = 4000, ore = 9000, rare_ore = 5000,
        research = { 3000, 3402, 5000, 5104, 5111, 5601, 8000, 8301 },
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

function make_things(d)
  for _, w in ipairs(d.walls) do
    if w[1] == "Tube" then game.create_tube(w[2]) else game.create_wall(w[1], w[2]) end
  end
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

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Towers_Gone

function Towers_Gone(t)
  ai_fight1:set_attack_type("Spaceport")
end

local eden, launch_check

-- Plymouth's Spaceport builds an EMP missile, then checks every 30 ticks whether it's done (BuildIt).
function BuildIt()
  print("tick " .. game.tick() .. ": the Spaceport builds an EMP missile")
  units["spaceport"]:develop("EMPMissile")
  launch_check = trigger.time{time = 30, one_shot = false, on = LaunchIt}
end

-- Once the Spaceport is no longer busy, the checks stop and it launches (LaunchIt). The original launches at
-- pixel 0,0, as unit:launch() with no target does.
function LaunchIt()
  local port = units["spaceport"]
  if port.valid and port.busy then return end
  launch_check:disable()
  print("tick " .. game.tick() .. ": the Spaceport launches")
  if port.valid then port:launch() end
end

-- Every Guard Post down: Eden's tanks go for the Spaceport (Towers_Gone).
function Towers_Gone()
  print("tick " .. game.tick() .. ": every Guard Post is down; Eden attacks the Spaceport")
  eden:set_attack_type("Spaceport")
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

  -- The unit blocks list their units in the order of the DLL's UnitRecord tables: the game numbers units in the
  -- order it makes them, and that order decides which moves first each tick.
  -- Eden's Rail Gun Lynx and Thor's Hammer Tiger attack, Guard Posts first, from 30,39 - 42,53, lights on.
  eden = ai.fight_group(players[2])
  eden:do_attack_enemy()
  eden:set_rect({ 30, 39, 42, 53 })
  eden:set_attack_type("GuardPost")
  eden:add_units(ai.unit_block{
    { type = "Lynx", weapon = "RailGun", direction = "West", at = { 37, 31 } },
    { type = "Lynx", weapon = "RailGun", direction = "West", at = { 41, 31 } },
    { type = "Tiger", weapon = "ThorsHammer", direction = "West", at = { 39, 31 } },
    { type = "Lynx", weapon = "RailGun", direction = "West", at = { 26, 46 } },
    { type = "Lynx", weapon = "RailGun", direction = "West", at = { 26, 48 } },
    { type = "Lynx", weapon = "RailGun", direction = "West", at = { 26, 50 } },
  })
  eden:set_lights(true)

  -- The win.
  local t6 = trigger.time{time = 1100}
  mission.victory(t6, "      Outpost 2 demo mode.\n\nPress any key to return to the Main Menu.", {one_shot = true})
  trigger.time{time = 65, on = BuildIt}  -- after 0 marks
  trigger.count{type = "GuardPost", cargo = "None", compare = "==", count = 0, player = 3, one_shot = true, on = Towers_Gone}
end

