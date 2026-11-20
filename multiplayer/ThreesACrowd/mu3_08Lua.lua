-- mu3_08Lua.lua  -  3 Player, LandRush, 'Three's a Crowd' map. (Lua)
--
-- Converted by op2dll from mu3_08.dll ("3 Player, LandRush, 'Three's a Crowd' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

-- Where lava may flow from an eruption, as areas { x1, y1, x2, y2 }.
local LAVA_POSSIBLE = {
  { 59, 1, 64, 1 }, { 59, 2, 65, 3 }, { 59, 4, 61, 5 }, { 58, 6, 61, 6 }, { 56, 7, 60, 7 }, { 55, 8, 59, 9 },
  { 52, 10, 58, 11 }, { 53, 12, 59, 12 }, { 53, 13, 60, 14 }, { 52, 15, 62, 15 }, { 46, 16, 63, 16 }, { 46, 17, 67, 17 },
  { 45, 18, 71, 18 }, { 45, 19, 72, 19 }, { 45, 20, 73, 20 }, { 44, 21, 51, 21 }, { 58, 21, 73, 21 }, { 44, 22, 47, 23 },
  { 59, 22, 74, 22 }, { 60, 23, 75, 23 }, { 45, 24, 46, 24 }, { 60, 24, 71, 24 }, { 73, 24, 76, 24 }, { 60, 25, 64, 25 },
  { 70, 25, 76, 25 }, { 60, 26, 63, 26 }, { 72, 26, 76, 26 }, { 60, 27, 61, 28 }, { 74, 27, 75, 27 }, { 38, 41, 38, 41 },
  { 22, 42, 22, 42 }, { 35, 42, 40, 42 }, { 18, 43, 23, 43 }, { 29, 43, 41, 43 }, { 17, 44, 41, 44 }, { 16, 45, 39, 45 },
  { 16, 46, 26, 46 }, { 30, 46, 35, 46 }, { 37, 46, 37, 46 }, { 15, 47, 24, 47 }, { 31, 47, 34, 47 }, { 11, 48, 24, 48 },
  { 33, 48, 34, 49 }, { 9, 49, 24, 49 }, { 7, 50, 13, 50 }, { 16, 50, 24, 52 }, { 32, 50, 34, 50 }, { 1, 51, 12, 51 },
  { 32, 51, 33, 51 }, { 1, 52, 3, 52 }, { 5, 52, 12, 52 }, { 1, 53, 9, 53 }, { 18, 53, 23, 53 }, { 1, 54, 6, 55 },
  { 1, 56, 5, 56 }, { 1, 57, 3, 57 },
}

-- The setup's draws (R) and the units it made (U), in order.
local R, U = {}, {}
local LEVEL_OF = { Easy = 0, Normal = 1, Hard = 2 }
local DIRS = { "East", "SouthEast", "South", "SouthWest", "West", "NorthWest", "North", "NorthEast" }
-- A branch of the setup no sampled game took: logged, so a game that differs from the original says where.
         local function unseen(what, value)
  print("replay: " .. what .. " = " .. tostring(value) .. ": a way no sampled game took")
end
-- k different values of 0 to range - 1, each redrawn while it's one already drawn, into R[at[1]] on.
local function pick(range, k, at)
  local seen = {}
  for i = 1, k do
    local v
    repeat v = game.rand(range) until not seen[v]
    seen[v] = true
    R[at[i]] = v
  end
end

-- Disasters and timed events: what the mission's trigger functions did over 600 calls each, with
-- the same draws of the game's random numbers. Each is called with the trigger that fired.
local Lava1, Lava2, Meteors, Tornados

function Lava1(t)
  game.create_eruption({ 52, 10 }, 200)
end

function Lava2(t)
  game.create_eruption({ 38, 41 }, 200)
end

function Meteors(t)
  local r1 = game.rand(127)
  local r2 = game.rand(127)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Tornados(t)
  local r1 = game.rand(127)
  local r2 = game.rand(127)
  local r3 = game.rand(10)
  local r4 = game.rand(127)
  local r5 = game.rand(127)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  for _, area in ipairs(LAVA_POSSIBLE) do game.set_lava_possible(area) end
  game.initial_set_tile({ 38, 40 }, 1140)
  game.initial_set_tile({ 38, 41 }, 1150)
  game.initial_set_tile({ 51, 9 }, 1161)
  game.initial_set_tile({ 51, 10 }, 1184)
  game.initial_set_tile({ 52, 9 }, 1172)
  game.initial_set_tile({ 52, 10 }, 1195)
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 13, 3 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 26, 73 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 79, 9 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 111, 98 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 29, 33 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 92 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 121 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 105, 42 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 9, 56 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 59 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 81, 53 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 72, 30 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 73 } }
  pick(3, ({ [2] = 2, [3] = 3 })[n], { 0, 1, 2 })
  R[3] = game.rand(8)
  players[1]:center_view({ ({ [0] = 77, [1] = 65, [2] = 57 })[R[0]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[0]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 77, [1] = 65, [2] = 57 })[R[0]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 75, [1] = 63, [2] = 55 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 79, [1] = 67, [2] = 59 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[3]][R[0]], ({ [0] = { [0] = 39, [1] = 62, [2] = 42 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 35, [1] = 58, [2] = 38 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[3]][R[0]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[3]][R[0]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[3]][R[0]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[3]][R[0]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[3]][R[0]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 73, [1] = 61, [2] = 53 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 73, [1] = 61, [2] = 53 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 81, [1] = 69, [2] = 61 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 81, [1] = 69, [2] = 61 } })[R[3]][R[0]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 39, [1] = 62, [2] = 42 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 35, [1] = 58, [2] = 38 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 35, [1] = 58, [2] = 38 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 39, [1] = 62, [2] = 42 } })[R[3]][R[0]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 75, [1] = 63, [2] = 55 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 75, [1] = 63, [2] = 55 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 79, [1] = 67, [2] = 59 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 79, [1] = 67, [2] = 59 } })[R[3]][R[0]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 41, [1] = 64, [2] = 44 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 33, [1] = 56, [2] = 36 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 33, [1] = 56, [2] = 36 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 41, [1] = 64, [2] = 44 } })[R[3]][R[0]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[3]][R[0]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[3]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[3]][R[0]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[3]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 69, [1] = 57, [2] = 49 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 85, [1] = 73, [2] = 65 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[3]][R[0]], ({ [0] = { [0] = 47, [1] = 70, [2] = 50 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 27, [1] = 50, [2] = 30 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[3]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 70, [1] = 58, [2] = 50 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 70, [1] = 58, [2] = 50 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 84, [1] = 72, [2] = 64 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 84, [1] = 72, [2] = 64 } })[R[3]][R[0]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[3]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[3]][R[0]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 44, [1] = 67, [2] = 47 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 30, [1] = 53, [2] = 33 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 30, [1] = 53, [2] = 33 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 44, [1] = 67, [2] = 47 } })[R[3]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[4] = game.rand(4)
      if R[3] == 0 then
        if R[0] == 0 then
          if R[4] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[0] == 1 then
          if R[4] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[0] == 2 then
          if R[4] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[4]", R[4])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[3] == 1 then
        if R[4] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 36 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 36 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 59 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 59 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 40 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 40 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 45 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 45 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 68 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 68 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[4]", R[4])
        end
      elseif R[3] == 2 then
        if R[4] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[4]", R[4])
        end
      elseif R[3] == 3 then
        if R[4] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 34 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 34 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 57 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 57 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 35 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 35 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 58 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 58, 58 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 50, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 29 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 29 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 52 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 52 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[4]", R[4])
        end
      elseif R[3] == 4 then
        if R[0] == 0 then
          if R[4] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[0] == 1 then
          if R[4] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[0] == 2 then
          if R[4] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[4] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[4]", R[4])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[3] == 5 then
        if R[4] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 34 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 34 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 57 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 57 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 35 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 35 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 58 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 58 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 29 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 29 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 52 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 52 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[4]", R[4])
        end
      elseif R[3] == 6 then
        if R[4] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 79, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 79, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 79, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 79, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[4]", R[4])
        end
      elseif R[3] == 7 then
        if R[4] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 36 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 36 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 59 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 59 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 40 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 40 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[4] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 45 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 45 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 68 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 68 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[4]", R[4])
        end
      else
        unseen("R[3]", R[3])
      end
      U[#U]:set_lights(true)
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  R[5] = game.rand(8)
  players[2]:center_view({ ({ [0] = 77, [1] = 65, [2] = 57 })[R[1]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[1]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 77, [1] = 65, [2] = 57 })[R[1]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 75, [1] = 63, [2] = 55 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 79, [1] = 67, [2] = 59 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[5]][R[1]], ({ [0] = { [0] = 39, [1] = 62, [2] = 42 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 35, [1] = 58, [2] = 38 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[5]][R[1]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[5]][R[1]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[5]][R[1]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[5]][R[1]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[5]][R[1]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 73, [1] = 61, [2] = 53 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 73, [1] = 61, [2] = 53 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 81, [1] = 69, [2] = 61 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 81, [1] = 69, [2] = 61 } })[R[5]][R[1]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 39, [1] = 62, [2] = 42 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 35, [1] = 58, [2] = 38 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 35, [1] = 58, [2] = 38 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 39, [1] = 62, [2] = 42 } })[R[5]][R[1]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 75, [1] = 63, [2] = 55 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 75, [1] = 63, [2] = 55 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 79, [1] = 67, [2] = 59 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 79, [1] = 67, [2] = 59 } })[R[5]][R[1]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 41, [1] = 64, [2] = 44 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 33, [1] = 56, [2] = 36 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 33, [1] = 56, [2] = 36 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 41, [1] = 64, [2] = 44 } })[R[5]][R[1]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[5]][R[1]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[5]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[5]][R[1]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[5]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 69, [1] = 57, [2] = 49 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 85, [1] = 73, [2] = 65 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[5]][R[1]], ({ [0] = { [0] = 47, [1] = 70, [2] = 50 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 27, [1] = 50, [2] = 30 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[5]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 70, [1] = 58, [2] = 50 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 70, [1] = 58, [2] = 50 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 84, [1] = 72, [2] = 64 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 84, [1] = 72, [2] = 64 } })[R[5]][R[1]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[5]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[5]][R[1]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 44, [1] = 67, [2] = 47 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 30, [1] = 53, [2] = 33 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 30, [1] = 53, [2] = 33 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 44, [1] = 67, [2] = 47 } })[R[5]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if n == 2 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[6] = game.rand(4)
        if R[5] == 0 then
          if R[1] == 0 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[1] == 1 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[1] == 2 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[6] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 40 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 40 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 45 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 45 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 68 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 68 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 2 then
          if R[6] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 3 then
          if R[6] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 34 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 34 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 57 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 57 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 35 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 35 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 58 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 58 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 29 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 29 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 52 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 52 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 4 then
          if R[1] == 0 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[1] == 1 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[1] == 2 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 5 then
          if R[6] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 34 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 34 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 57 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 57 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 35 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 35 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 58 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 58 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 29 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 29 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 52 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 52 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 6 then
          if R[6] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 7 then
          if R[6] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 36 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 36 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 59 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 59 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 40 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 40 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[6] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 45 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 45 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 68 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 68 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[6]", R[6])
          end
        else
          unseen("R[5]", R[5])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif n == 3 then
    if game.initial_units() == 0 then
      R[7] = game.rand(8)
      players[3]:center_view({ ({ [0] = 77, [1] = 65, [2] = 57 })[R[2]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 77, [1] = 65, [2] = 57 })[R[2]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 75, [1] = 63, [2] = 55 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 79, [1] = 67, [2] = 59 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[7]][R[2]], ({ [0] = { [0] = 39, [1] = 62, [2] = 42 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 35, [1] = 58, [2] = 38 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[7]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[7]][R[2]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[7]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[7]][R[2]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[7]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 73, [1] = 61, [2] = 53 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 73, [1] = 61, [2] = 53 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 81, [1] = 69, [2] = 61 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 81, [1] = 69, [2] = 61 } })[R[7]][R[2]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 39, [1] = 62, [2] = 42 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 35, [1] = 58, [2] = 38 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 35, [1] = 58, [2] = 38 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 39, [1] = 62, [2] = 42 } })[R[7]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 75, [1] = 63, [2] = 55 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 75, [1] = 63, [2] = 55 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 79, [1] = 67, [2] = 59 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 79, [1] = 67, [2] = 59 } })[R[7]][R[2]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 41, [1] = 64, [2] = 44 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 33, [1] = 56, [2] = 36 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 33, [1] = 56, [2] = 36 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 41, [1] = 64, [2] = 44 } })[R[7]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[7]][R[2]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[7]][R[2]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 69, [1] = 57, [2] = 49 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 85, [1] = 73, [2] = 65 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[7]][R[2]], ({ [0] = { [0] = 47, [1] = 70, [2] = 50 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 27, [1] = 50, [2] = 30 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 70, [1] = 58, [2] = 50 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 70, [1] = 58, [2] = 50 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 84, [1] = 72, [2] = 64 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 84, [1] = 72, [2] = 64 } })[R[7]][R[2]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[7]][R[2]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 44, [1] = 67, [2] = 47 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 30, [1] = 53, [2] = 33 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 30, [1] = 53, [2] = 33 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 44, [1] = 67, [2] = 47 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[8] = game.rand(4)
        if R[5] == 0 then
          if R[1] == 0 then
            if R[8] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[1] == 1 then
            if R[8] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[1] == 2 then
            if R[8] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 1 then
          if R[8] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 40 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 40 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 45 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 45 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 68 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 68 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[5] == 2 then
          if R[8] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[5] == 3 then
          if R[8] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 34 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 34 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 57 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 57 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 35 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 35 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 58 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 58, 58 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 50, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 29 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 29 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 52 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 52 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[5] == 4 then
          if R[1] == 0 then
            if R[8] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[1] == 1 then
            if R[8] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[1] == 2 then
            if R[8] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[5] == 5 then
          if R[8] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 34 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 34 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 57 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 57 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 35 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 35 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 58 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 58 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 29 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 29 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 52 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 52 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[5] == 6 then
          if R[8] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 79, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[5] == 7 then
          if R[8] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 36 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 36 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 59 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 59 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 40 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 40 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[8] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 45 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 45 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 68 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 68 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[8]", R[8])
          end
        else
          unseen("R[5]", R[5])
        end
        U[#U]:set_lights(true)
      end
      R[7] = game.rand(8)
      players[3]:center_view({ ({ [0] = 77, [1] = 65, [2] = 57 })[R[2]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 77, [1] = 65, [2] = 57 })[R[2]], ({ [0] = 37, [1] = 60, [2] = 40 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 75, [1] = 63, [2] = 55 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 79, [1] = 67, [2] = 59 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[7]][R[2]], ({ [0] = { [0] = 39, [1] = 62, [2] = 42 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 35, [1] = 58, [2] = 38 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[7]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[7]][R[2]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 38, [1] = 61, [2] = 41 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 36, [1] = 59, [2] = 39 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 36, [1] = 59, [2] = 39 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 38, [1] = 61, [2] = 41 } })[R[7]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 76, [1] = 64, [2] = 56 }, [2] = { [0] = 74, [1] = 62, [2] = 54 }, [3] = { [0] = 76, [1] = 64, [2] = 56 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 78, [1] = 66, [2] = 58 }, [6] = { [0] = 80, [1] = 68, [2] = 60 }, [7] = { [0] = 78, [1] = 66, [2] = 58 } })[R[7]][R[2]], ({ [0] = { [0] = 41, [1] = 64, [2] = 44 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 33, [1] = 56, [2] = 36 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[7]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 73, [1] = 61, [2] = 53 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 73, [1] = 61, [2] = 53 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 81, [1] = 69, [2] = 61 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 81, [1] = 69, [2] = 61 } })[R[7]][R[2]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 39, [1] = 62, [2] = 42 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 35, [1] = 58, [2] = 38 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 35, [1] = 58, [2] = 38 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 39, [1] = 62, [2] = 42 } })[R[7]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 75, [1] = 63, [2] = 55 }, [2] = { [0] = 72, [1] = 60, [2] = 52 }, [3] = { [0] = 75, [1] = 63, [2] = 55 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 79, [1] = 67, [2] = 59 }, [6] = { [0] = 82, [1] = 70, [2] = 62 }, [7] = { [0] = 79, [1] = 67, [2] = 59 } })[R[7]][R[2]], ({ [0] = { [0] = 43, [1] = 66, [2] = 46 }, [1] = { [0] = 41, [1] = 64, [2] = 44 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 33, [1] = 56, [2] = 36 }, [4] = { [0] = 31, [1] = 54, [2] = 34 }, [5] = { [0] = 33, [1] = 56, [2] = 36 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 41, [1] = 64, [2] = 44 } })[R[7]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[7]][R[2]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 40, [1] = 63, [2] = 43 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 34, [1] = 57, [2] = 37 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 34, [1] = 57, [2] = 37 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 40, [1] = 63, [2] = 43 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 74, [1] = 62, [2] = 54 }, [2] = { [0] = 70, [1] = 58, [2] = 50 }, [3] = { [0] = 74, [1] = 62, [2] = 54 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 80, [1] = 68, [2] = 60 }, [6] = { [0] = 84, [1] = 72, [2] = 64 }, [7] = { [0] = 80, [1] = 68, [2] = 60 } })[R[7]][R[2]], ({ [0] = { [0] = 45, [1] = 68, [2] = 48 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 29, [1] = 52, [2] = 32 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 77, [1] = 65, [2] = 57 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 69, [1] = 57, [2] = 49 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 77, [1] = 65, [2] = 57 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 85, [1] = 73, [2] = 65 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[7]][R[2]], ({ [0] = { [0] = 47, [1] = 70, [2] = 50 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 37, [1] = 60, [2] = 40 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 27, [1] = 50, [2] = 30 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 37, [1] = 60, [2] = 40 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 76, [1] = 64, [2] = 56 }, [1] = { [0] = 70, [1] = 58, [2] = 50 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 70, [1] = 58, [2] = 50 }, [4] = { [0] = 76, [1] = 64, [2] = 56 }, [5] = { [0] = 84, [1] = 72, [2] = 64 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 84, [1] = 72, [2] = 64 } })[R[7]][R[2]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 42, [1] = 65, [2] = 45 }, [2] = { [0] = 36, [1] = 59, [2] = 39 }, [3] = { [0] = 32, [1] = 55, [2] = 35 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 32, [1] = 55, [2] = 35 }, [6] = { [0] = 36, [1] = 59, [2] = 39 }, [7] = { [0] = 42, [1] = 65, [2] = 45 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 78, [1] = 66, [2] = 58 }, [1] = { [0] = 72, [1] = 60, [2] = 52 }, [2] = { [0] = 68, [1] = 56, [2] = 48 }, [3] = { [0] = 72, [1] = 60, [2] = 52 }, [4] = { [0] = 78, [1] = 66, [2] = 58 }, [5] = { [0] = 82, [1] = 70, [2] = 62 }, [6] = { [0] = 86, [1] = 74, [2] = 66 }, [7] = { [0] = 82, [1] = 70, [2] = 62 } })[R[7]][R[2]], ({ [0] = { [0] = 49, [1] = 72, [2] = 52 }, [1] = { [0] = 44, [1] = 67, [2] = 47 }, [2] = { [0] = 38, [1] = 61, [2] = 41 }, [3] = { [0] = 30, [1] = 53, [2] = 33 }, [4] = { [0] = 25, [1] = 48, [2] = 28 }, [5] = { [0] = 30, [1] = 53, [2] = 33 }, [6] = { [0] = 38, [1] = 61, [2] = 41 }, [7] = { [0] = 44, [1] = 67, [2] = 47 } })[R[7]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[7]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[9] = game.rand(4)
        if R[7] == 0 then
          if R[2] == 0 then
            if R[9] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 38 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 38 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 47 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 47 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 1 then
            if R[9] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 61 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 61 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 2 then
            if R[9] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[7] == 1 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 36 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 36 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 59 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 59 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 40 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 40 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 45 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 45 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 68 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 68 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[7] == 2 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 34 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 34 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 57 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 57 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 40 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 40 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 63 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 63 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[7] == 3 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 34 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 34 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 57 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 57 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 35 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 35 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 58 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 58, 58 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 50, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 29 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 29 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 52 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 52 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[7] == 4 then
          if R[2] == 0 then
            if R[9] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 36 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 36 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 27 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 27 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 1 then
            if R[9] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 59 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 62, 59 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 50 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 50 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 2 then
            if R[9] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 54, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[7] == 5 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 34 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 34 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 57 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 57 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 35 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 35 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 58 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 58 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 29 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 29 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 52 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 52 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[7] == 6 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 79, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 79, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 34 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 34 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 57 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 57 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 79, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 79, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 40 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 40 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 63 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 63 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[7] == 7 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 36 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 36 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 59 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 59 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 40 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 40 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 45 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 45 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 68 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 68 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        else
          unseen("R[7]", R[7])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  else
    unseen("n", n)
  end
  players[1]:mark_research(3303)
  players[1].workers = 30 - 4 * LEVEL_OF[players[1].difficulty]
  players[1].scientists = 16 - 3 * LEVEL_OF[players[1].difficulty]
  players[1].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[1].difficulty]]
  players[1].food = 5000 - 1500 * LEVEL_OF[players[1].difficulty]
  players[({ [0] = 0, [1] = 0, [2] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
  if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
    players[1]:mark_research(3305)
    players[({ [0] = 0, [1] = 1 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[2].difficulty] == 0 then
      players[2]:mark_research(3303)
    elseif LEVEL_OF[players[2].difficulty] == 1 then
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif LEVEL_OF[players[1].difficulty] == 2 then
  else
    unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
  end
  players[2].workers = 30 - 4 * LEVEL_OF[players[2].difficulty]
  players[2].scientists = 16 - 3 * LEVEL_OF[players[2].difficulty]
  players[2].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[2].difficulty]]
  players[2].food = 5000 - 1500 * LEVEL_OF[players[2].difficulty]
  if n == 2 then
    if LEVEL_OF[players[2].difficulty] == 0 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[2]:mark_research(3401)
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    elseif LEVEL_OF[players[2].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
  elseif n == 3 then
    if LEVEL_OF[players[1].difficulty] == 0 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[2]:mark_research(3401)
      players[3]:mark_research(3303)
      players[3].workers = 30
      players[3].scientists = 16
      players[3].kids = 24
      players[3].food = 5000
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
      players[3]:mark_research(3401)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      players[3]:mark_research(3303)
      players[3].workers = 22
      players[3].scientists = 10
      players[3].kids = 22
      players[3].food = 2000
    elseif LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      players[3]:mark_research(3303)
      players[3].workers = 26
      players[3].scientists = 13
      players[3].kids = 21
      players[3].food = 3500
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  else
    unseen("n", n)
  end
  game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
  game.morale_steady(({ [0] = "Good", [1] = "Fair" })[(game.uses_morale() and 1 or 0)])

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
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Tornados}  -- after 60 to 120 marks
    trigger.time{min = 6000, max = 12000, one_shot = false, on = Meteors}  -- after 60 to 120 marks
    trigger.research{tech = 5201, one_shot = true, on = Lava1}
    trigger.resource{resource = "Colonists", compare = ">=", amount = 85, one_shot = true, on = Lava2}
  end
  return true
end
