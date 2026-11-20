-- mu4_13Lua.lua  -  4 Player, LandRush, 'Unsettled Earth' map. (Lua)
--
-- Converted by op2dll from mu4_13.dll ("4 Player, LandRush, 'Unsettled Earth' map."): its setup replayed. `on_init` makes the original's
-- draws of the game's random numbers in its order and, from them and the lobby, the same units,
-- beacons, walls and settings in the same order, as the original's setup did in every game
-- sampled (every player count, the lobby's colonies, resource levels, vehicles, day and night,
-- morale and disasters). Anything not converted is listed at the end. Coordinates are the in-game
-- status-bar ones (map file tile + 1).

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
local Meteors, Tornados

function Meteors(t)
  local r1 = game.rand(4)
  local r2 = game.rand(127)
  local r3 = game.rand(128)
  game.create_earthquake({ r3 + 1, r2 + 2 }, r1 + 1)
end

function Tornados(t)
  local r1 = game.rand(127)
  local r2 = game.rand(128)
  local r3 = game.rand(10)
  local r4 = game.rand(127)
  local r5 = game.rand(128)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 54, 7 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 92, 21 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 85, 112 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 48, 109 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 94 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 22, 74 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 66, 16 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 64 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 63, 40 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 49, 58 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 50, 88 } }
  pick(4, n, { 0, 1, 2, 3 })
  R[4] = game.rand(8)
  players[1]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[0]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[0]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[0]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[4]][R[0]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[4]][R[0]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[4]][R[0]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[4]][R[0]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[4]][R[0]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[4]][R[0]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[4]][R[0]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[4]][R[0]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[4]][R[0]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[4]][R[0]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[4]][R[0]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[4]][R[0]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[4]][R[0]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[4]][R[0]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[4]][R[0]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[5] = game.rand(4)
      if R[4] == 0 then
        if R[0] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[4] == 1 then
        if R[5] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 2 then
        if R[5] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 3 then
        if R[5] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 4 then
        if R[0] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[0]", R[0])
        end
      elseif R[4] == 5 then
        if R[5] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 6 then
        if R[5] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[5]", R[5])
        end
      elseif R[4] == 7 then
        if R[5] == 0 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        else
          unseen("R[5]", R[5])
        end
      else
        unseen("R[4]", R[4])
      end
      U[#U]:set_lights(true)
    end
  else
    unseen("game.initial_units()", game.initial_units())
  end
  R[6] = game.rand(8)
  players[2]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[1]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[1]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[1]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[6]][R[1]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[6]][R[1]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[6]][R[1]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[6]][R[1]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[6]][R[1]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[6]][R[1]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[6]][R[1]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[6]][R[1]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[6]][R[1]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[6]][R[1]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[6]][R[1]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[6]][R[1]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[6]][R[1]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[6]][R[1]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[6]][R[1]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if n == 2 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[7] = game.rand(4)
        if R[6] == 0 then
          if R[1] == 0 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 1 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 2 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 3 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[6] == 1 then
          if R[7] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[6] == 2 then
          if R[7] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[6] == 3 then
          if R[7] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[6] == 4 then
          if R[1] == 0 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 1 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 2 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 3 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[6] == 5 then
          if R[7] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[6] == 6 then
          if R[7] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[7]", R[7])
          end
        elseif R[6] == 7 then
          if R[7] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[7]", R[7])
          end
        else
          unseen("R[6]", R[6])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif n == 3 then
    if game.initial_units() == 0 then
      R[8] = game.rand(8)
      players[3]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[9] = game.rand(4)
        if R[6] == 0 then
          if R[1] == 0 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 1 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 2 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 3 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[6] == 1 then
          if R[9] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[6] == 2 then
          if R[9] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[6] == 3 then
          if R[9] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[6] == 4 then
          if R[1] == 0 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 1 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 2 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 3 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[6] == 5 then
          if R[9] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[6] == 6 then
          if R[9] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[6] == 7 then
          if R[9] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[9]", R[9])
          end
        else
          unseen("R[6]", R[6])
        end
        U[#U]:set_lights(true)
      end
      R[8] = game.rand(8)
      players[3]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[10] = game.rand(4)
        if R[8] == 0 then
          if R[2] == 0 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 1 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 2 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 3 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[8] == 1 then
          if R[10] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[8] == 2 then
          if R[10] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[8] == 3 then
          if R[10] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[8] == 4 then
          if R[2] == 0 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 1 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 2 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 3 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[8] == 5 then
          if R[10] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[8] == 6 then
          if R[10] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[10]", R[10])
          end
        elseif R[8] == 7 then
          if R[10] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[10]", R[10])
          end
        else
          unseen("R[8]", R[8])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
  elseif n == 4 then
    if game.initial_units() == 0 then
      R[8] = game.rand(8)
      players[3]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      R[11] = game.rand(8)
      players[4]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[3]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[3]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[3]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[11]][R[3]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[11]][R[3]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[11]][R[3]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[11]][R[3]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[11]][R[3]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[11]][R[3]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[11]][R[3]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[11]][R[3]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[11]][R[3]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[11]][R[3]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[11]][R[3]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[11]][R[3]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[11]][R[3]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[11]][R[3]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[11]][R[3]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(4)
        if R[6] == 0 then
          if R[1] == 0 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 1 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 2 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 3 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[6] == 1 then
          if R[12] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[6] == 2 then
          if R[12] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[6] == 3 then
          if R[12] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[6] == 4 then
          if R[1] == 0 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 1 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 2 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 3 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[1]", R[1])
          end
        elseif R[6] == 5 then
          if R[12] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[6] == 6 then
          if R[12] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[6] == 7 then
          if R[12] == 0 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[6]", R[6])
        end
        U[#U]:set_lights(true)
      end
      R[8] = game.rand(8)
      players[3]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[2]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[8]][R[2]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[8]][R[2]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[8]][R[2]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[8]][R[2]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[13] = game.rand(4)
        if R[8] == 0 then
          if R[2] == 0 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 1 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 2 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 3 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[8] == 1 then
          if R[13] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[8] == 2 then
          if R[13] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[8] == 3 then
          if R[13] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[8] == 4 then
          if R[2] == 0 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 1 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 2 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 3 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[8] == 5 then
          if R[13] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[8] == 6 then
          if R[13] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[8] == 7 then
          if R[13] == 0 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[13]", R[13])
          end
        else
          unseen("R[8]", R[8])
        end
        U[#U]:set_lights(true)
      end
      R[11] = game.rand(8)
      players[4]:center_view({ ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[3]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[3]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 85, [1] = 44, [2] = 94, [3] = 66 })[R[3]], ({ [0] = 64, [1] = 75, [2] = 79, [3] = 73 })[R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[11]][R[3]], ({ [0] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[11]][R[3]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[11]][R[3]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 } })[R[11]][R[3]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [2] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [3] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [6] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [7] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 } })[R[11]][R[3]], ({ [0] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[11]][R[3]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 81, [1] = 40, [2] = 90, [3] = 62 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 89, [1] = 48, [2] = 98, [3] = 70 } })[R[11]][R[3]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 62, [1] = 73, [2] = 77, [3] = 71 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 66, [1] = 77, [2] = 81, [3] = 75 } })[R[11]][R[3]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [2] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [3] = { [0] = 83, [1] = 42, [2] = 92, [3] = 64 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 }, [6] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [7] = { [0] = 87, [1] = 46, [2] = 96, [3] = 68 } })[R[11]][R[3]], ({ [0] = { [0] = 70, [1] = 81, [2] = 85, [3] = 79 }, [1] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [4] = { [0] = 58, [1] = 69, [2] = 73, [3] = 67 }, [5] = { [0] = 60, [1] = 71, [2] = 75, [3] = 69 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 68, [1] = 79, [2] = 83, [3] = 77 } })[R[11]][R[3]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[11]][R[3]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 61, [1] = 72, [2] = 76, [3] = 70 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 67, [1] = 78, [2] = 82, [3] = 76 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [2] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [3] = { [0] = 82, [1] = 41, [2] = 91, [3] = 63 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 }, [6] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [7] = { [0] = 88, [1] = 47, [2] = 97, [3] = 69 } })[R[11]][R[3]], ({ [0] = { [0] = 72, [1] = 83, [2] = 87, [3] = 81 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 56, [1] = 67, [2] = 71, [3] = 65 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 77, [1] = 36, [2] = 86, [3] = 58 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 85, [1] = 44, [2] = 94, [3] = 66 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 93, [1] = 52, [2] = 102, [3] = 74 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[11]][R[3]], ({ [0] = { [0] = 74, [1] = 85, [2] = 89, [3] = 83 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 54, [1] = 65, [2] = 69, [3] = 63 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 64, [1] = 75, [2] = 79, [3] = 73 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [1] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 78, [1] = 37, [2] = 87, [3] = 59 }, [4] = { [0] = 84, [1] = 43, [2] = 93, [3] = 65 }, [5] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 92, [1] = 51, [2] = 101, [3] = 73 } })[R[11]][R[3]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 }, [2] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [3] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 59, [1] = 70, [2] = 74, [3] = 68 }, [6] = { [0] = 63, [1] = 74, [2] = 78, [3] = 72 }, [7] = { [0] = 69, [1] = 80, [2] = 84, [3] = 78 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [1] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [2] = { [0] = 76, [1] = 35, [2] = 85, [3] = 57 }, [3] = { [0] = 80, [1] = 39, [2] = 89, [3] = 61 }, [4] = { [0] = 86, [1] = 45, [2] = 95, [3] = 67 }, [5] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 }, [6] = { [0] = 94, [1] = 53, [2] = 103, [3] = 75 }, [7] = { [0] = 90, [1] = 49, [2] = 99, [3] = 71 } })[R[11]][R[3]], ({ [0] = { [0] = 76, [1] = 87, [2] = 91, [3] = 85 }, [1] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 }, [2] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [3] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [4] = { [0] = 52, [1] = 63, [2] = 67, [3] = 61 }, [5] = { [0] = 57, [1] = 68, [2] = 72, [3] = 66 }, [6] = { [0] = 65, [1] = 76, [2] = 80, [3] = 74 }, [7] = { [0] = 71, [1] = 82, [2] = 86, [3] = 80 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[14] = game.rand(4)
        if R[11] == 0 then
          if R[3] == 0 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 65 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 65 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 1 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 76 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 76 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 85 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 85 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 2 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 80 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 80 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 89 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 89 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 3 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 74 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 74 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 83 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 83 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          else
            unseen("R[3]", R[3])
          end
        elseif R[11] == 1 then
          if R[14] == 0 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 63 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 63 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 74 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 74 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 86, 67 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 86, 67 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 45, 78 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 45, 78 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 95, 82 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 95, 82 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 67, 76 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 67, 76 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 75 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 75 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 72 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 72 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 83 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 83 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 87 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 87 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[11] == 2 then
          if R[14] == 0 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 83, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 83, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 42, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 42, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 64, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 64, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 61 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 61 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 72 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 72 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 70 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 70 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 83, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 83, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 42, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 42, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 64, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 64, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 67 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 67 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 78 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 78 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 82 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 82 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 76 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 76 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[11] == 3 then
          if R[14] == 0 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 80 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 80 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 74 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 74 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 86, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 86, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 45, 72 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 45, 72 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 95, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 95, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 67, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 67, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 62 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 78, 62 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 73 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 37, 73 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 77 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 77 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 56 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 56 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 67 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 67 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 71 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 71 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 65 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 65 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[11] == 4 then
          if R[3] == 0 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 82, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 54 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 54 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 1 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 74 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 41, 74 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 65 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 65 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 2 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 78 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 91, 78 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 69 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 69 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 3 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 72 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 63, 72 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 63 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 63 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          else
            unseen("R[3]", R[3])
          end
        elseif R[11] == 5 then
          if R[14] == 0 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 80 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 80 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 74 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 74 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 84, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 84, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 43, 72 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 43, 72 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 93, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 93, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 62 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 62 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 73 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 73 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 77 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 77 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 56 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 56 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 67 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 67 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 71 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 71 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 65 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 65 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[11] == 6 then
          if R[14] == 0 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 46, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 46, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 68, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 68, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 61 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 61 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 72 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 72 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 70 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 70 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 87, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 46, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 46, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 68, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 68, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 67 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 67 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 78 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 78 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 82 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 82 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 76 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 76 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[11] == 7 then
          if R[14] == 0 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 63 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 63 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 74 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 74 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 84, 67 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 84, 67 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 43, 78 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 43, 78 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 93, 82 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 93, 82 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 76 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 76 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 92, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 75 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 73, 75 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 72 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 88, 72 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 83 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 47, 83 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 87 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 97, 87 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 69, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          else
            unseen("R[14]", R[14])
          end
        else
          unseen("R[11]", R[11])
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
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      players[3]:mark_research(3303)
      players[3].workers = 22
      players[3].scientists = 10
      players[3].kids = 22
      players[3].food = 2000
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
  elseif n == 4 then
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
      players[4]:mark_research(3303)
      players[4].workers = 30
      players[4].scientists = 16
      players[4].kids = 24
      players[4].food = 5000
      players[4]:mark_research(3304)
      players[4]:mark_research(3305)
      players[4]:mark_research(3401)
    elseif LEVEL_OF[players[1].difficulty] == 2 then
      players[3]:mark_research(3303)
      players[3].workers = 22
      players[3].scientists = 10
      players[3].kids = 22
      players[3].food = 2000
      players[4]:mark_research(3303)
      players[4].workers = 22
      players[4].scientists = 10
      players[4].kids = 22
      players[4].food = 2000
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
      players[4]:mark_research(3303)
      players[4].workers = 26
      players[4].scientists = 13
      players[4].kids = 21
      players[4].food = 3500
      players[4]:mark_research(3304)
      players[4]:mark_research(3305)
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
  end
  return true
end
