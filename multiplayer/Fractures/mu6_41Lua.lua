-- mu6_41Lua.lua  -  6 Player, LandRush, 'Fractures' map. (Lua)
--
-- Fractures' setup, written by hand from what the original's (mu6_41.dll) does over 500 games (op2dll calls): the
-- same beacon areas and starts, made with the same draws in the same order, so a game is the original's. Its win,
-- disasters and resource levels are op2dll's conversion. Coordinates are the in-game status-bar ones.

-- The seven starts, numbered as the original numbers them: it draws a start of 7 for each player, redrawing one already
-- taken. NE, N, C and E are in the top half of the map; S, SE and SW in the bottom.
local STARTS = {
  { name = "NE", at = { 89, 81 } }, { name = "N", at = { 45, 53 } }, { name = "C", at = { 60, 111 } },
  { name = "E", at = { 100, 120 } }, { name = "S", at = { 83, 172 } }, { name = "SE", at = { 88, 205 } },
  { name = "SW", at = { 43, 194 } },
}

-- Every player's kit, made in this order on their start tile, lights on, facing north; `high` units only at the
-- High resource level (OP2Lua's "Easy").
local KIT = {
  { type = "RoboSurveyor" },
  { type = "ConVec", kit = "CommandCenter" }, { type = "ConVec", kit = "Tokamak" },
  { type = "ConVec", kit = "CommonOreSmelter" }, { type = "ConVec", kit = "StructureFactory" },
  { type = "ConVec", kit = "Agridome" },
  { type = "CargoTruck", cargo = "CommonMetal" }, { type = "CargoTruck", cargo = "CommonMetal" },
  { type = "CargoTruck", cargo = "Food" },
  { type = "RoboMiner" }, { type = "Earthworker" },
  { type = "ConVec", kit = "StandardLab", high = true }, { type = "ConVec", kit = "VehicleFactory", high = true },
  { type = "CargoTruck", cargo = "CommonMetal", high = true },
}

-- The six beacon areas, each a list of spots (four of 14, two of 12). The original draws a spot a, then a spot b
-- redrawn while it's a: a common beacon (3 bars) on b, a rare one (3 bars) on a; then it walks the area's other spots
-- in order with a draw of 100 each: under 47, a beacon of either ore on the spot, 2 bars or 1 by a draw of 2.
local BEACON_AREAS = {
  { { 48, 15 }, { 28, 5 }, { 7, 43 }, { 11, 28 }, { 29, 30 }, { 42, 78 }, { 60, 40 }, { 62, 23 }, { 5, 70 }, { 41, 55 }, { 6, 86 }, { 48, 6 }, { 20, 62 }, { 5, 7 } },
  { { 91, 7 }, { 113, 5 }, { 91, 23 }, { 82, 29 }, { 79, 14 }, { 127, 84 }, { 125, 64 }, { 107, 62 }, { 100, 76 }, { 91, 59 }, { 80, 61 }, { 74, 78 }, { 123, 19 }, { 118, 45 } },
  { { 3, 120 }, { 12, 140 }, { 51, 131 }, { 55, 168 }, { 45, 165 }, { 29, 153 }, { 34, 127 }, { 37, 105 }, { 15, 92 }, { 5, 106 }, { 21, 109 }, { 55, 98 } },
  { { 103, 100 }, { 84, 94 }, { 115, 117 }, { 88, 119 }, { 80, 132 }, { 67, 105 }, { 123, 134 }, { 124, 152 }, { 106, 158 }, { 86, 162 }, { 68, 156 }, { 72, 87 } },
  { { 39, 210 }, { 13, 219 }, { 12, 245 }, { 17, 234 }, { 32, 249 }, { 40, 224 }, { 40, 240 }, { 61, 229 }, { 51, 217 }, { 23, 184 }, { 7, 184 }, { 12, 183 }, { 7, 204 }, { 39, 197 } },
  { { 77, 243 }, { 78, 230 }, { 74, 178 }, { 80, 194 }, { 91, 197 }, { 78, 210 }, { 85, 223 }, { 124, 181 }, { 99, 181 }, { 115, 197 }, { 104, 241 }, { 123, 235 }, { 94, 230 }, { 118, 217 } },
}

local function make_beacons()
  for _, spots in ipairs(BEACON_AREAS) do
    local a = game.rand(#spots)
    local b
    repeat b = game.rand(#spots) until b ~= a
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar3", variant = "Random", at = spots[b + 1] }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Bar3", variant = "Random", at = spots[a + 1] }
    for k = 0, #spots - 1 do
      if k ~= a and k ~= b and game.rand(100) < 47 then
        local yield = game.rand(2) == 0 and "Bar2" or "Bar1"
        game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = yield, variant = "Random", at = spots[k + 1] }
      end
    end
  end
end

-- By the lobby's resource level (player.difficulty: "Easy" is High, "Hard" Low): colonists, stores,
-- research, and the Structure Factory's kits by bay.
local LEVELS = {
  Easy = {
    workers = 30, scientists = 16, kids = 24, food = 5000, ore = 0, rare_ore = 0,
    research = { 3303, 3304, 3305, 3401 },
    kits = {  },
  },
  Normal = {
    workers = 26, scientists = 13, kids = 21, food = 3500, ore = 0, rare_ore = 0,
    research = { 3303, 3304, 3305 },
    kits = {  },
  },
  Hard = {
    workers = 22, scientists = 10, kids = 22, food = 2000, ore = 0, rare_ore = 0,
    research = { 3303 },
    kits = {  },
  },
}

local function on_off(on) return on and "on" or "off" end

-- The kit and the lobby's initial vehicles (Lynxes: Lasers for Eden, Microwaves for Plymouth) on the start tile.
local function make_kit(player, at)
  player:center_view(at)
  local high = player.difficulty == "Easy"
  for _, u in ipairs(KIT) do
    if high or not u.high then
      local made = game.create_unit{ type = u.type, player = player, at = at, weapon = u.kit, direction = "North",
                                     lights = false, exact = true }[1]
      if made then
        made:set_lights(true)
        if u.cargo then made:set_cargo(u.cargo, 1000) end
      end
    end
  end
  local weapon = player.is_eden and "Laser" or "Microwave"
  for _ = 1, game.initial_units() do
    local made = game.create_unit{ type = "Lynx", player = player, at = at, weapon = weapon, direction = "North",
                                   lights = false, exact = true }[1]
    if made then made:set_lights(true) end
  end
end

local function set_resources(player)
  local level = LEVELS[player.difficulty] or LEVELS.Easy
  if level.tech_level then player:set_tech_level(level.tech_level) end
  for _, tech in ipairs(level.research) do player:mark_research(tech) end
  player.workers, player.scientists, player.kids = level.workers, level.scientists, level.kids
  player.food, player.ore, player.rare_ore = level.food, level.ore, level.rare_ore
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local DoDisaster

function DoDisaster(t)
  local r1 = game.rand(4)
  local r2 = game.rand(128)
  local r3 = game.rand(256)
  if r1 == 0 then
    game.create_earthquake({ r2 + 1, r3 + 1 }, 1)
  elseif r1 == 1 then
    local r4 = game.rand(128)
    local r5 = game.rand(256)
    game.create_lightning({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  elseif r1 == 2 then
    local r4 = game.rand(128)
    local r5 = game.rand(256)
    game.create_tornado({ r2 + 1, r3 + 1 }, { r4 + 1, r5 + 1 }, 10)
  else
    game.create_meteor({ r2 + 1, r3 + 1 }, 1)
  end
  t:destroy()
  trigger.time{min = 5000, max = 10000, one_shot = false, on = DoDisaster}  -- after 50 to 100 marks
end

function on_init()
  local n = game.num_players()
  print(string.format("Lobby: %d players; morale steady %s, day and night %s, disasters %s, %d initial vehicles",
                      n, on_off(not game.uses_morale()), on_off(game.uses_day_night()),
                      on_off(game.disasters_enabled()), game.initial_units()))
  make_beacons()
  -- A start of 7 for each player, redrawn while it's one already taken; then each player's kit there.
  local starts, taken = {}, {}
  for id = 1, n do
    local k
    repeat k = game.rand(#STARTS) until not taken[k]
    taken[k] = true
    starts[id] = STARTS[k + 1]
  end
  for id = 1, n do
    local p = players[id]
    make_kit(p, starts[id].at)
    print(string.format("Player %d: %s, %s, resources %s, start %s", id, p.is_eden and "Eden" or "Plymouth",
                        p.is_human and "human" or "computer", p.difficulty, starts[id].name))
  end
  for id = 1, n do set_resources(players[id]) end

  game.set_daylight_everywhere(not game.uses_day_night())
  if game.uses_morale() then
    game.morale_steady("Fair")
  else
    game.morale_steady("Good")
  end

  -- The win.
  -- Land Rush: Last One Standing, switched on once every player has settled (a working Command Center)
  -- or is out of the rush (fewer than 5 colonists, or no vehicles). A player's first such moment frees
  -- their morale when the lobby left it free.
  local last_one = trigger.one_player_left{enabled = false}
  local victory = mission.victory(last_one, "Eliminate your opponents.", {one_shot = true, enabled = false})
  local settled, count = {}, 0
  for id = 1, n do
    local function settle()
      if settled[id] then return end
      settled[id] = true
      count = count + 1
      if game.uses_morale() then game.free_morale(id) end
      if count == n and not last_one.enabled then
        last_one:enable()
        victory:enable()
        game.message("New Objective", 122)
      end
    end
    trigger.operational{type = "CommandCenter", compare = ">=", count = 1, player = id, on = settle}
    trigger.resource{resource = "Colonists", compare = "<", amount = 5, player = id, one_shot = true, on = settle}
    trigger.vehicle_count{compare = "<", count = 1, player = id, one_shot = true, on = settle}
  end
  if game.disasters_enabled() then
    trigger.time{min = 5000, max = 10000, one_shot = false, on = DoDisaster}  -- after 50 to 100 marks
  end
  return true
end
