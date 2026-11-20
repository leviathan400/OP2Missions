-- mu4_07Lua.lua  -  4 Player, LandRush, 'Four Mesas' map. (Lua)
--
-- Converted by op2dll from mu4_07.dll ("4 Player, LandRush, 'Four Mesas' map."): its setup replayed. `on_init` makes the original's
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
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Tornados(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  local r3 = game.rand(10)
  local r4 = game.rand(255)
  local r5 = game.rand(256)
  game.create_tornado({ r5 + 1, r4 + 2 }, { r2 + 1, r1 + 2 }, r3 + 10)
end

function on_init()
  local n = game.num_players()
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 36, 55 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 206, 58 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 220, 200 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 72, 212 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 112, 128 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 127, 112 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 128, 140 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 144, 123 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 111, 249 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 97, 214 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 125, 228 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 98, 173 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 165 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 132, 171 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 126, 211 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 39, 136 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 140 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 91, 105 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 110 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 11, 114 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 42, 123 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 57, 115 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 142, 8 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 159, 23 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 112, 47 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 118, 91 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 137, 68 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 152, 47 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 123, 30 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 161, 117 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 205, 100 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 244, 110 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 232, 131 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 122 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 224, 119 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 179, 124 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 199, 241 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 251, 212 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 148, 248 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 17, 210 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 40, 240 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 93, 244 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 54, 30 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 104, 7 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 6, 51 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 236, 58 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 180, 28 } }
  game.create_beacon{ type = "MiningBeacon", ore = "Random", yield = "Random", variant = "Random", at = { 231, 24 } }
  pick(4, n, { 0, 1, 2, 3 })
  R[4] = game.rand(8)
  players[1]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[0]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[0]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[0]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[4]][R[0]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[4]][R[0]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[4]][R[0]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[4]][R[0]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[4]][R[0]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[4]][R[0]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[4]][R[0]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[4]][R[0]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[4]][R[0]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[4]][R[0]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[4]][R[0]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[4]][R[0]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[4]][R[0]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[4]][R[0]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[4]][R[0]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[4]][R[0]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[4]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if game.initial_units() == 0 then
  elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
    for i = 1, game.initial_units() do
      R[5] = game.rand(4)
      if R[4] == 0 then
        if R[0] == 0 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
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
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
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
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
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
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
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
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 1 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 2 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[0] == 3 then
          if R[5] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[5] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
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
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
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
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
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
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 1 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 2 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          else
            unseen("R[0]", R[0])
          end
        elseif R[5] == 3 then
          if R[0] == 0 then
            if (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 1 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 2 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
            else
              unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
            end
          elseif R[0] == 3 then
            if (players[1].is_eden and 1 or 0) == 0 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
            elseif (players[1].is_eden and 1 or 0) == 1 then
              U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
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
  players[2]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[1]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[1]] })
  U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[1]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[6]][R[1]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[6]][R[1]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[6]][R[1]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[6]][R[1]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[6]][R[1]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[6]][R[1]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[6]][R[1]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[6]][R[1]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[6]][R[1]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[6]][R[1]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[6]][R[1]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[6]][R[1]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("CommonMetal", 1000)
  U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[6]][R[1]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U]:set_cargo("Food", 1000)
  U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[6]][R[1]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[6]][R[1]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[6]][R[1]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[6]] + 1], lights = false, exact = true }[1]
  U[#U]:set_lights(true)
  if n == 2 then
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[7] = game.rand(4)
        if R[6] == 0 then
          if R[1] == 0 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 1 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 2 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 3 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 1 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 2 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[7]", R[7])
            end
          elseif R[1] == 3 then
            if R[7] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[7] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[7] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
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
      players[3]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[9] = game.rand(4)
        if R[6] == 0 then
          if R[1] == 0 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 1 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 2 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 3 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 1 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 2 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[1] == 3 then
            if R[9] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[9] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
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
      players[3]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[10] = game.rand(4)
        if R[8] == 0 then
          if R[2] == 0 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 1 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 2 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 3 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
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
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 1 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 2 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[2] == 3 then
            if R[10] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
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
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[10] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
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
      players[3]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      R[11] = game.rand(8)
      players[4]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[3]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[3]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[3]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[11]][R[3]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[11]][R[3]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[11]][R[3]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[11]][R[3]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[11]][R[3]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[11]][R[3]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[11]][R[3]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[11]][R[3]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[11]][R[3]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[11]][R[3]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[11]][R[3]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[11]][R[3]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[11]][R[3]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[11]][R[3]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[11]][R[3]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(4)
        if R[6] == 0 then
          if R[1] == 0 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 1 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 2 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 3 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 1 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 2 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[1] == 3 then
            if R[12] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
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
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 1 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 2 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[1]", R[1])
            end
          elseif R[12] == 3 then
            if R[1] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[1] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
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
      players[3]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[2]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[8]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[8]][R[2]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[8]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[8]][R[2]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[8]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[8]][R[2]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[8]][R[2]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[8]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[8]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[13] = game.rand(4)
        if R[8] == 0 then
          if R[2] == 0 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 1 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 2 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 3 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
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
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 1 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 2 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[2] == 3 then
            if R[13] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
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
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
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
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
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
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 1 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 2 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[13] == 3 then
            if R[2] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
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
      players[4]:center_view({ ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[3]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[3]] })
      U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 103, [1] = 108, [2] = 147, [3] = 151 })[R[3]], ({ [0] = 111, [1] = 157, [2] = 148, [3] = 97 })[R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[11]][R[3]], ({ [0] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[11]][R[3]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[11]][R[3]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 } })[R[11]][R[3]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [2] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [3] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [6] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [7] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 } })[R[11]][R[3]], ({ [0] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[11]][R[3]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 99, [1] = 104, [2] = 143, [3] = 147 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 107, [1] = 112, [2] = 151, [3] = 155 } })[R[11]][R[3]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 109, [1] = 155, [2] = 146, [3] = 95 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 113, [1] = 159, [2] = 150, [3] = 99 } })[R[11]][R[3]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [2] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [3] = { [0] = 101, [1] = 106, [2] = 145, [3] = 149 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 }, [6] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [7] = { [0] = 105, [1] = 110, [2] = 149, [3] = 153 } })[R[11]][R[3]], ({ [0] = { [0] = 117, [1] = 163, [2] = 154, [3] = 103 }, [1] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [4] = { [0] = 105, [1] = 151, [2] = 142, [3] = 91 }, [5] = { [0] = 107, [1] = 153, [2] = 144, [3] = 93 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 115, [1] = 161, [2] = 152, [3] = 101 } })[R[11]][R[3]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[11]][R[3]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 108, [1] = 154, [2] = 145, [3] = 94 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 114, [1] = 160, [2] = 151, [3] = 100 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [2] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [3] = { [0] = 100, [1] = 105, [2] = 144, [3] = 148 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 }, [6] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [7] = { [0] = 106, [1] = 111, [2] = 150, [3] = 154 } })[R[11]][R[3]], ({ [0] = { [0] = 119, [1] = 165, [2] = 156, [3] = 105 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 103, [1] = 149, [2] = 140, [3] = 89 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("CommonMetal", 1000)
      U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 95, [1] = 100, [2] = 139, [3] = 143 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 103, [1] = 108, [2] = 147, [3] = 151 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 111, [1] = 116, [2] = 155, [3] = 159 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[11]][R[3]], ({ [0] = { [0] = 121, [1] = 167, [2] = 158, [3] = 107 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 101, [1] = 147, [2] = 138, [3] = 87 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 111, [1] = 157, [2] = 148, [3] = 97 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U]:set_cargo("Food", 1000)
      U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [1] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 96, [1] = 101, [2] = 140, [3] = 144 }, [4] = { [0] = 102, [1] = 107, [2] = 146, [3] = 150 }, [5] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 110, [1] = 115, [2] = 154, [3] = 158 } })[R[11]][R[3]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 }, [2] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [3] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 106, [1] = 152, [2] = 143, [3] = 92 }, [6] = { [0] = 110, [1] = 156, [2] = 147, [3] = 96 }, [7] = { [0] = 116, [1] = 162, [2] = 153, [3] = 102 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [1] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [2] = { [0] = 94, [1] = 99, [2] = 138, [3] = 142 }, [3] = { [0] = 98, [1] = 103, [2] = 142, [3] = 146 }, [4] = { [0] = 104, [1] = 109, [2] = 148, [3] = 152 }, [5] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 }, [6] = { [0] = 112, [1] = 117, [2] = 156, [3] = 160 }, [7] = { [0] = 108, [1] = 113, [2] = 152, [3] = 156 } })[R[11]][R[3]], ({ [0] = { [0] = 123, [1] = 169, [2] = 160, [3] = 109 }, [1] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 }, [2] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [3] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [4] = { [0] = 99, [1] = 145, [2] = 136, [3] = 85 }, [5] = { [0] = 104, [1] = 150, [2] = 141, [3] = 90 }, [6] = { [0] = 112, [1] = 158, [2] = 149, [3] = 98 }, [7] = { [0] = 118, [1] = 164, [2] = 155, [3] = 104 } })[R[11]][R[3]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
      U[#U]:set_lights(true)
      for i = 1, game.initial_units() do
        R[14] = game.rand(4)
        if R[11] == 0 then
          if R[3] == 0 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 112 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 112 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 121 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 121 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 1 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 167 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 167 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 2 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 149 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 149 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 158 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 158 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 3 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 98 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 98 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 107 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 107 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
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
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 110 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 110 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 147 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 147 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 96 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 96 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 104, 114 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 104, 114 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 160 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 160 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 151 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 151 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 152, 100 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 152, 100 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 113 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 113 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 159 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 159 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 150 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 150 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 119 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 119 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 165 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 165 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 156 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 156 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 105 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 105 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
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
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 145, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 145, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 108 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 108 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 154 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 154 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 145 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 145 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 94 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 94 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 145, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 145, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 114 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 114 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 160 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 160 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 151 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 151 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 100 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 100 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
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
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 112 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 112 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 158 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 158 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 104, 108 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 104, 108 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 154 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 154 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 145 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 145 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 152, 94 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 152, 94 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 109 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 96, 109 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 155 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 101, 155 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 146 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 140, 146 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 95 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 95 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 103 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 103 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 149 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 149 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 140 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 140 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 89 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 89 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
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
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 110 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 100, 110 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 101 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 101 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 1 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 156 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 156 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 2 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 147 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 144, 147 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 138 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 138 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[3] == 3 then
            if R[14] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 96 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 148, 96 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 87 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 87 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
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
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 112 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 112 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 158 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 158 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 102, 108 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 102, 108 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 154 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 154 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 146, 145 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 146, 145 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 94 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 94 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 109 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 109 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 155 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 155 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 146 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 146 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 95 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 95 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 103 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 103 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 149 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 149 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 140 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 140 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 89 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 89 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
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
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 153, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 153, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 108 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 108 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 154 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 154 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 145 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 145 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 94 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 94 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 105, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 149, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 153, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 153, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 114 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 114 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 160 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 160 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 151 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 151 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 100 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 100 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
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
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 110 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 110 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 147 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 147 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 96 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 96 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 1 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 102, 114 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 102, 114 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 160 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 160 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 146, 151 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 146, 151 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 100 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 100 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 2 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 113 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 110, 113 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 159 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 115, 159 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 150 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 150 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 158, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[3]", R[3])
            end
          elseif R[14] == 3 then
            if R[3] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 119 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 106, 119 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 165 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 165 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 156 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 150, 156 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[3] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 105 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 154, 105 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
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
