-- ademo2Lua.lua  -  AutoDemo Mission #2 (Lua)
-- Finished by hand (the AI groups and the trigger functions op2dll leaves), from op2dll calls of ademo2.dll: complete.
-- Converted by op2dll from ademo2.dll. With ademo2Lua.placement.lua (what every difficulty makes alike),
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
        view = { 34, 17 },
        units = {
        },
      },
      [2] = {
        research = {  },
        units = {
        },
      },
      [3] = {
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

local plymouth_trucks, plymouth_tanks

-- Plymouth's two attack groups switch their lights on (LightsOn).
function LightsOn()
  print("tick " .. game.tick() .. ": Plymouth's attack groups switch their lights on")
  plymouth_trucks:set_lights(true)
  plymouth_tanks:set_lights(true)
end

-- Plymouth's default group switches its lights on (LightsOn2). The Arachnids' reprogrammed vehicles join it.
function LightsOn2()
  print("tick " .. game.tick() .. ": Plymouth's default group switches its lights on")
  players[3]:default_group():set_lights(true)
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
  -- Eden's three Laser Lynx and three Cargo Trucks (carrying wreckage) guard 1,17 - 3,19, lights on.
  local eden = ai.fight_group(players[2])
  eden:do_guard_rect()
  eden:set_rect({ 1, 17, 3, 19 })
  eden:add_units(ai.unit_block{
    { type = "Lynx", weapon = "Laser", direction = "West", at = { 38, 17 } },
    { type = "Lynx", weapon = "Laser", direction = "West", at = { 38, 20 } },
    { type = "CargoTruck", direction = "West", cargo = "Wreckage", amount = 1, at = { 40, 19 } },
    { type = "CargoTruck", direction = "West", cargo = "Wreckage", amount = 1, at = { 42, 19 } },
    { type = "CargoTruck", direction = "West", cargo = "Wreckage", amount = 1, at = { 44, 19 } },
    { type = "Lynx", weapon = "Laser", direction = "West", at = { 46, 17 } },
  })
  eden:set_lights(true)
  -- Plymouth's three EMP Lynx and six Spiders attack, Cargo Trucks first; they wait in 49,17 - 51,19.
  plymouth_trucks = ai.fight_group(players[3])
  plymouth_trucks:do_attack_enemy()
  plymouth_trucks:set_rect({ 49, 17, 51, 19 })
  plymouth_trucks:set_attack_type("CargoTruck")
  plymouth_trucks:add_units(ai.unit_block{
    { type = "Lynx", weapon = "EMP", direction = "North", at = { 34, 11 } },
    { type = "Lynx", weapon = "EMP", direction = "North", at = { 36, 11 } },
    { type = "Lynx", weapon = "EMP", direction = "North", at = { 38, 11 } },
    { type = "Spider", direction = "East", at = { 32, 11 } },
    { type = "Spider", direction = "East", at = { 35, 11 } },
    { type = "Spider", direction = "East", at = { 39, 11 } },
    { type = "Spider", direction = "East", at = { 37, 26 } },
    { type = "Spider", direction = "East", at = { 38, 26 } },
    { type = "Spider", direction = "East", at = { 33, 26 } },
  })
  -- Plymouth's three Microwave Lynx attack, Lynx first.
  plymouth_tanks = ai.fight_group(players[3])
  plymouth_tanks:do_attack_enemy()
  plymouth_tanks:set_rect({ 49, 17, 51, 19 })
  plymouth_tanks:set_attack_type("Lynx")
  plymouth_tanks:add_units(ai.unit_block{
    { type = "Lynx", weapon = "Microwave", direction = "North", at = { 29, 16 } },
    { type = "Lynx", weapon = "Microwave", direction = "North", at = { 28, 17 } },
    { type = "Lynx", weapon = "Microwave", direction = "North", at = { 29, 20 } },
  })
  -- Plymouth's default group (the game's own) waits in the same area.
  players[3]:default_group():set_rect({ 49, 17, 51, 19 })

  -- The win.
  local t8 = trigger.time{time = 900}
  mission.victory(t8, "      Outpost 2 demo mode.\n\nPress any key to return to the Main Menu.", {one_shot = true})
  trigger.time{time = 80, on = LightsOn}  -- after 0 marks
  trigger.time{time = 700, on = LightsOn2}  -- after 7 marks
end

