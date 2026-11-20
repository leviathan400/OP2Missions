-- mu4_03Lua.lua  -  4 Player, LandRush, 'Rock Garden' map. (Lua)
--
-- Converted by op2dll from mu4_03.dll ("4 Player, LandRush, 'Rock Garden' map."): its setup replayed. `on_init` makes the original's
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
local Meteor

function Meteor(t)
  local r1 = game.rand(255)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 235 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 246, 118 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 158, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 34, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 196, 199 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 213, 221 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 224, 238 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 219, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 164, 86 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 39, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 78, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 150 } }
    R[0] = game.rand(255)
    R[1] = game.rand(256)
    game.create_wreckage({ R[1] + 1, R[0] + 2 }, 11999, false)
    R[2] = game.rand(4)
    R[3] = game.rand(8)
    players[1]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[2]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[2]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[2]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[3]][R[2]], ({ [0] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[3]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[3]][R[2]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[3]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[3]][R[2]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[3]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 } })[R[3]][R[2]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 } })[R[3]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 } })[R[3]][R[2]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 } })[R[3]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[3]][R[2]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 132, [1] = 65, [2] = 168, [3] = 191 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 148, [1] = 81, [2] = 184, [3] = 207 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 135, [1] = 175, [2] = 110, [3] = 50 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 115, [1] = 155, [2] = 90, [3] = 30 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 } })[R[3]][R[2]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[4] = game.rand(4)
        if R[3] == 0 then
          if R[2] == 0 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          elseif R[2] == 1 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          elseif R[2] == 2 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          elseif R[2] == 3 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[3] == 1 then
          if R[4] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[3] == 2 then
          if R[4] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[3] == 3 then
          if R[4] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[3] == 4 then
          if R[2] == 0 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          elseif R[2] == 1 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          elseif R[2] == 2 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          elseif R[2] == 3 then
            if R[4] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[4] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[4]", R[4])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[3] == 5 then
          if R[4] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[3] == 6 then
          if R[4] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[4]", R[4])
          end
        elseif R[3] == 7 then
          if R[4] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[4] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
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
    players[2]:center_view({ ({ [0] = 73, [1] = 176, [2] = 199, [3] = 140 })[R[2]], ({ [0] = 165, [1] = 100, [2] = 40, [3] = 125 })[R[2]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 73, [1] = 176, [2] = 199, [3] = 140 })[R[2]], ({ [0] = 165, [1] = 100, [2] = 40, [3] = 125 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 73, [1] = 176, [2] = 199, [3] = 140 }, [1] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [2] = { [0] = 71, [1] = 174, [2] = 197, [3] = 138 }, [3] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [4] = { [0] = 73, [1] = 176, [2] = 199, [3] = 140 }, [5] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [6] = { [0] = 75, [1] = 178, [2] = 201, [3] = 142 }, [7] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 } })[R[5]][R[2]], ({ [0] = { [0] = 167, [1] = 102, [2] = 42, [3] = 127 }, [1] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [2] = { [0] = 165, [1] = 100, [2] = 40, [3] = 125 }, [3] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [4] = { [0] = 163, [1] = 98, [2] = 38, [3] = 123 }, [5] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [6] = { [0] = 165, [1] = 100, [2] = 40, [3] = 125 }, [7] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 } })[R[5]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [1] = { [0] = 70, [1] = 173, [2] = 196, [3] = 137 }, [2] = { [0] = 70, [1] = 173, [2] = 196, [3] = 137 }, [3] = { [0] = 70, [1] = 173, [2] = 196, [3] = 137 }, [4] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [5] = { [0] = 76, [1] = 179, [2] = 202, [3] = 143 }, [6] = { [0] = 76, [1] = 179, [2] = 202, [3] = 143 }, [7] = { [0] = 76, [1] = 179, [2] = 202, [3] = 143 } })[R[5]][R[2]], ({ [0] = { [0] = 169, [1] = 104, [2] = 44, [3] = 129 }, [1] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [2] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [3] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [4] = { [0] = 161, [1] = 96, [2] = 36, [3] = 121 }, [5] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [6] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [7] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 } })[R[5]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [1] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [2] = { [0] = 70, [1] = 173, [2] = 196, [3] = 137 }, [3] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [4] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [5] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [6] = { [0] = 76, [1] = 179, [2] = 202, [3] = 143 }, [7] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 } })[R[5]][R[2]], ({ [0] = { [0] = 169, [1] = 104, [2] = 44, [3] = 129 }, [1] = { [0] = 168, [1] = 103, [2] = 43, [3] = 128 }, [2] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [3] = { [0] = 162, [1] = 97, [2] = 37, [3] = 122 }, [4] = { [0] = 161, [1] = 96, [2] = 36, [3] = 121 }, [5] = { [0] = 162, [1] = 97, [2] = 37, [3] = 122 }, [6] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [7] = { [0] = 168, [1] = 103, [2] = 43, [3] = 128 } })[R[5]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [1] = { [0] = 69, [1] = 172, [2] = 195, [3] = 136 }, [2] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [3] = { [0] = 69, [1] = 172, [2] = 195, [3] = 136 }, [4] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [5] = { [0] = 77, [1] = 180, [2] = 203, [3] = 144 }, [6] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 }, [7] = { [0] = 77, [1] = 180, [2] = 203, [3] = 144 } })[R[5]][R[2]], ({ [0] = { [0] = 171, [1] = 106, [2] = 46, [3] = 131 }, [1] = { [0] = 167, [1] = 102, [2] = 42, [3] = 127 }, [2] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [3] = { [0] = 163, [1] = 98, [2] = 38, [3] = 123 }, [4] = { [0] = 159, [1] = 94, [2] = 34, [3] = 119 }, [5] = { [0] = 163, [1] = 98, [2] = 38, [3] = 123 }, [6] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [7] = { [0] = 167, [1] = 102, [2] = 42, [3] = 127 } })[R[5]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [1] = { [0] = 71, [1] = 174, [2] = 197, [3] = 138 }, [2] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [3] = { [0] = 71, [1] = 174, [2] = 197, [3] = 138 }, [4] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [5] = { [0] = 75, [1] = 178, [2] = 201, [3] = 142 }, [6] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 }, [7] = { [0] = 75, [1] = 178, [2] = 201, [3] = 142 } })[R[5]][R[2]], ({ [0] = { [0] = 171, [1] = 106, [2] = 46, [3] = 131 }, [1] = { [0] = 169, [1] = 104, [2] = 44, [3] = 129 }, [2] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [3] = { [0] = 161, [1] = 96, [2] = 36, [3] = 121 }, [4] = { [0] = 159, [1] = 94, [2] = 34, [3] = 119 }, [5] = { [0] = 161, [1] = 96, [2] = 36, [3] = 121 }, [6] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [7] = { [0] = 169, [1] = 104, [2] = 44, [3] = 129 } })[R[5]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [1] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [2] = { [0] = 66, [1] = 169, [2] = 192, [3] = 133 }, [3] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [4] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [5] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 }, [6] = { [0] = 80, [1] = 183, [2] = 206, [3] = 147 }, [7] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 } })[R[5]][R[2]], ({ [0] = { [0] = 173, [1] = 108, [2] = 48, [3] = 133 }, [1] = { [0] = 168, [1] = 103, [2] = 43, [3] = 128 }, [2] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [3] = { [0] = 162, [1] = 97, [2] = 37, [3] = 122 }, [4] = { [0] = 157, [1] = 92, [2] = 32, [3] = 117 }, [5] = { [0] = 162, [1] = 97, [2] = 37, [3] = 122 }, [6] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [7] = { [0] = 168, [1] = 103, [2] = 43, [3] = 128 } })[R[5]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [1] = { [0] = 70, [1] = 173, [2] = 196, [3] = 137 }, [2] = { [0] = 66, [1] = 169, [2] = 192, [3] = 133 }, [3] = { [0] = 70, [1] = 173, [2] = 196, [3] = 137 }, [4] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [5] = { [0] = 76, [1] = 179, [2] = 202, [3] = 143 }, [6] = { [0] = 80, [1] = 183, [2] = 206, [3] = 147 }, [7] = { [0] = 76, [1] = 179, [2] = 202, [3] = 143 } })[R[5]][R[2]], ({ [0] = { [0] = 173, [1] = 108, [2] = 48, [3] = 133 }, [1] = { [0] = 170, [1] = 105, [2] = 45, [3] = 130 }, [2] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [3] = { [0] = 160, [1] = 95, [2] = 35, [3] = 120 }, [4] = { [0] = 157, [1] = 92, [2] = 32, [3] = 117 }, [5] = { [0] = 160, [1] = 95, [2] = 35, [3] = 120 }, [6] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [7] = { [0] = 170, [1] = 105, [2] = 45, [3] = 130 } })[R[5]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 73, [1] = 176, [2] = 199, [3] = 140 }, [1] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [2] = { [0] = 65, [1] = 168, [2] = 191, [3] = 132 }, [3] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [4] = { [0] = 73, [1] = 176, [2] = 199, [3] = 140 }, [5] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 }, [6] = { [0] = 81, [1] = 184, [2] = 207, [3] = 148 }, [7] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 } })[R[5]][R[2]], ({ [0] = { [0] = 175, [1] = 110, [2] = 50, [3] = 135 }, [1] = { [0] = 170, [1] = 105, [2] = 45, [3] = 130 }, [2] = { [0] = 165, [1] = 100, [2] = 40, [3] = 125 }, [3] = { [0] = 160, [1] = 95, [2] = 35, [3] = 120 }, [4] = { [0] = 155, [1] = 90, [2] = 30, [3] = 115 }, [5] = { [0] = 160, [1] = 95, [2] = 35, [3] = 120 }, [6] = { [0] = 165, [1] = 100, [2] = 40, [3] = 125 }, [7] = { [0] = 170, [1] = 105, [2] = 45, [3] = 130 } })[R[5]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [1] = { [0] = 66, [1] = 169, [2] = 192, [3] = 133 }, [2] = { [0] = 64, [1] = 167, [2] = 190, [3] = 131 }, [3] = { [0] = 66, [1] = 169, [2] = 192, [3] = 133 }, [4] = { [0] = 72, [1] = 175, [2] = 198, [3] = 139 }, [5] = { [0] = 80, [1] = 183, [2] = 206, [3] = 147 }, [6] = { [0] = 82, [1] = 185, [2] = 208, [3] = 149 }, [7] = { [0] = 80, [1] = 183, [2] = 206, [3] = 147 } })[R[5]][R[2]], ({ [0] = { [0] = 177, [1] = 112, [2] = 52, [3] = 137 }, [1] = { [0] = 170, [1] = 105, [2] = 45, [3] = 130 }, [2] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [3] = { [0] = 160, [1] = 95, [2] = 35, [3] = 120 }, [4] = { [0] = 153, [1] = 88, [2] = 28, [3] = 113 }, [5] = { [0] = 160, [1] = 95, [2] = 35, [3] = 120 }, [6] = { [0] = 164, [1] = 99, [2] = 39, [3] = 124 }, [7] = { [0] = 170, [1] = 105, [2] = 45, [3] = 130 } })[R[5]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [1] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [2] = { [0] = 64, [1] = 167, [2] = 190, [3] = 131 }, [3] = { [0] = 68, [1] = 171, [2] = 194, [3] = 135 }, [4] = { [0] = 74, [1] = 177, [2] = 200, [3] = 141 }, [5] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 }, [6] = { [0] = 82, [1] = 185, [2] = 208, [3] = 149 }, [7] = { [0] = 78, [1] = 181, [2] = 204, [3] = 145 } })[R[5]][R[2]], ({ [0] = { [0] = 177, [1] = 112, [2] = 52, [3] = 137 }, [1] = { [0] = 172, [1] = 107, [2] = 47, [3] = 132 }, [2] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [3] = { [0] = 158, [1] = 93, [2] = 33, [3] = 118 }, [4] = { [0] = 153, [1] = 88, [2] = 28, [3] = 113 }, [5] = { [0] = 158, [1] = 93, [2] = 33, [3] = 118 }, [6] = { [0] = 166, [1] = 101, [2] = 41, [3] = 126 }, [7] = { [0] = 172, [1] = 107, [2] = 47, [3] = 132 } })[R[5]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[6] = game.rand(4)
        if R[5] == 0 then
          if R[2] == 0 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[2] == 1 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[2] == 2 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[2] == 3 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[5] == 1 then
          if R[6] == 0 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 1 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 2 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 3 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 2 then
          if R[6] == 0 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 1 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 2 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 3 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 3 then
          if R[6] == 0 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 1 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 2 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 3 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 4 then
          if R[2] == 0 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[2] == 1 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[2] == 2 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          elseif R[2] == 3 then
            if R[6] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[6] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[6]", R[6])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[5] == 5 then
          if R[6] == 0 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 1 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 2 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 3 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 6 then
          if R[6] == 0 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 1 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 2 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 3 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[6]", R[6])
          end
        elseif R[5] == 7 then
          if R[6] == 0 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 1 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 2 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[6] == 3 then
            if R[2] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
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
    if LEVEL_OF[players[2].difficulty] == 0 or LEVEL_OF[players[2].difficulty] == 1 then
      players[2]:mark_research(3304)
      players[2]:mark_research(3305)
      if LEVEL_OF[players[2].difficulty] == 0 then
        players[2]:mark_research(3401)
      elseif LEVEL_OF[players[2].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
      end
    elseif LEVEL_OF[players[2].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[2].difficulty]", LEVEL_OF[players[2].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  elseif n == 3 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 235 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 246, 118 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 158, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 34, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 196, 199 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 213, 221 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 224, 238 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 219, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 164, 86 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 39, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 78, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 150 } }
    R[0] = game.rand(255)
    R[1] = game.rand(256)
    game.create_wreckage({ R[1] + 1, R[0] + 2 }, 11999, false)
    pick(4, 3, { 2, 7, 8 })
    R[3] = game.rand(8)
    players[1]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[2]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[2]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[2]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[3]][R[2]], ({ [0] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[3]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[3]][R[2]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[3]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[3]][R[2]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[3]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 } })[R[3]][R[2]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 } })[R[3]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 } })[R[3]][R[2]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 } })[R[3]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[3]][R[2]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 132, [1] = 65, [2] = 168, [3] = 191 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 148, [1] = 81, [2] = 184, [3] = 207 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 135, [1] = 175, [2] = 110, [3] = 50 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 115, [1] = 155, [2] = 90, [3] = 30 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 } })[R[3]][R[2]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[9] = game.rand(4)
        if R[3] == 0 then
          if R[2] == 0 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 1 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 2 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 3 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[3] == 1 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[3] == 2 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[3] == 3 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[3] == 4 then
          if R[2] == 0 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 1 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 2 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          elseif R[2] == 3 then
            if R[9] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[9] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[9]", R[9])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[3] == 5 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[3] == 6 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
          end
        elseif R[3] == 7 then
          if R[9] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[9] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[9]", R[9])
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
    players[2]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[7]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[7]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[7]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[7]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 140, [1] = 139, [2] = 138, [3] = 139, [4] = 140, [5] = 141, [6] = 142, [7] = 141 }, [1] = { [0] = 73, [1] = 72, [2] = 71, [3] = 72, [4] = 73, [5] = 74, [6] = 75, [7] = 74 }, [2] = { [0] = 176, [1] = 175, [2] = 174, [3] = 175, [4] = 176, [5] = 177, [6] = 178, [7] = 177 }, [3] = { [0] = 199, [1] = 198, [2] = 197, [3] = 198, [4] = 199, [5] = 200, [6] = 201, [7] = 200 } })[R[7]][R[5]], ({ [0] = { [0] = 127, [1] = 126, [2] = 125, [3] = 124, [4] = 123, [5] = 124, [6] = 125, [7] = 126 }, [1] = { [0] = 167, [1] = 166, [2] = 165, [3] = 164, [4] = 163, [5] = 164, [6] = 165, [7] = 166 }, [2] = { [0] = 102, [1] = 101, [2] = 100, [3] = 99, [4] = 98, [5] = 99, [6] = 100, [7] = 101 }, [3] = { [0] = 42, [1] = 41, [2] = 40, [3] = 39, [4] = 38, [5] = 39, [6] = 40, [7] = 41 } })[R[7]][R[5]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 137, [2] = 137, [3] = 137, [4] = 139, [5] = 143, [6] = 143, [7] = 143 }, [1] = { [0] = 72, [1] = 70, [2] = 70, [3] = 70, [4] = 72, [5] = 76, [6] = 76, [7] = 76 }, [2] = { [0] = 175, [1] = 173, [2] = 173, [3] = 173, [4] = 175, [5] = 179, [6] = 179, [7] = 179 }, [3] = { [0] = 198, [1] = 196, [2] = 196, [3] = 196, [4] = 198, [5] = 202, [6] = 202, [7] = 202 } })[R[7]][R[5]], ({ [0] = { [0] = 129, [1] = 126, [2] = 124, [3] = 124, [4] = 121, [5] = 124, [6] = 124, [7] = 126 }, [1] = { [0] = 169, [1] = 166, [2] = 164, [3] = 164, [4] = 161, [5] = 164, [6] = 164, [7] = 166 }, [2] = { [0] = 104, [1] = 101, [2] = 99, [3] = 99, [4] = 96, [5] = 99, [6] = 99, [7] = 101 }, [3] = { [0] = 44, [1] = 41, [2] = 39, [3] = 39, [4] = 36, [5] = 39, [6] = 39, [7] = 41 } })[R[7]][R[5]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 139, [2] = 137, [3] = 139, [4] = 141, [5] = 141, [6] = 143, [7] = 141 }, [1] = { [0] = 74, [1] = 72, [2] = 70, [3] = 72, [4] = 74, [5] = 74, [6] = 76, [7] = 74 }, [2] = { [0] = 177, [1] = 175, [2] = 173, [3] = 175, [4] = 177, [5] = 177, [6] = 179, [7] = 177 }, [3] = { [0] = 200, [1] = 198, [2] = 196, [3] = 198, [4] = 200, [5] = 200, [6] = 202, [7] = 200 } })[R[7]][R[5]], ({ [0] = { [0] = 129, [1] = 128, [2] = 126, [3] = 122, [4] = 121, [5] = 122, [6] = 126, [7] = 128 }, [1] = { [0] = 169, [1] = 168, [2] = 166, [3] = 162, [4] = 161, [5] = 162, [6] = 166, [7] = 168 }, [2] = { [0] = 104, [1] = 103, [2] = 101, [3] = 97, [4] = 96, [5] = 97, [6] = 101, [7] = 103 }, [3] = { [0] = 44, [1] = 43, [2] = 41, [3] = 37, [4] = 36, [5] = 37, [6] = 41, [7] = 43 } })[R[7]][R[5]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 136, [2] = 135, [3] = 136, [4] = 139, [5] = 144, [6] = 145, [7] = 144 }, [1] = { [0] = 72, [1] = 69, [2] = 68, [3] = 69, [4] = 72, [5] = 77, [6] = 78, [7] = 77 }, [2] = { [0] = 175, [1] = 172, [2] = 171, [3] = 172, [4] = 175, [5] = 180, [6] = 181, [7] = 180 }, [3] = { [0] = 198, [1] = 195, [2] = 194, [3] = 195, [4] = 198, [5] = 203, [6] = 204, [7] = 203 } })[R[7]][R[5]], ({ [0] = { [0] = 131, [1] = 127, [2] = 124, [3] = 123, [4] = 119, [5] = 123, [6] = 124, [7] = 127 }, [1] = { [0] = 171, [1] = 167, [2] = 164, [3] = 163, [4] = 159, [5] = 163, [6] = 164, [7] = 167 }, [2] = { [0] = 106, [1] = 102, [2] = 99, [3] = 98, [4] = 94, [5] = 98, [6] = 99, [7] = 102 }, [3] = { [0] = 46, [1] = 42, [2] = 39, [3] = 38, [4] = 34, [5] = 38, [6] = 39, [7] = 42 } })[R[7]][R[5]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 138, [2] = 135, [3] = 138, [4] = 141, [5] = 142, [6] = 145, [7] = 142 }, [1] = { [0] = 74, [1] = 71, [2] = 68, [3] = 71, [4] = 74, [5] = 75, [6] = 78, [7] = 75 }, [2] = { [0] = 177, [1] = 174, [2] = 171, [3] = 174, [4] = 177, [5] = 178, [6] = 181, [7] = 178 }, [3] = { [0] = 200, [1] = 197, [2] = 194, [3] = 197, [4] = 200, [5] = 201, [6] = 204, [7] = 201 } })[R[7]][R[5]], ({ [0] = { [0] = 131, [1] = 129, [2] = 126, [3] = 121, [4] = 119, [5] = 121, [6] = 126, [7] = 129 }, [1] = { [0] = 171, [1] = 169, [2] = 166, [3] = 161, [4] = 159, [5] = 161, [6] = 166, [7] = 169 }, [2] = { [0] = 106, [1] = 104, [2] = 101, [3] = 96, [4] = 94, [5] = 96, [6] = 101, [7] = 104 }, [3] = { [0] = 46, [1] = 44, [2] = 41, [3] = 36, [4] = 34, [5] = 36, [6] = 41, [7] = 44 } })[R[7]][R[5]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 135, [2] = 133, [3] = 135, [4] = 139, [5] = 145, [6] = 147, [7] = 145 }, [1] = { [0] = 72, [1] = 68, [2] = 66, [3] = 68, [4] = 72, [5] = 78, [6] = 80, [7] = 78 }, [2] = { [0] = 175, [1] = 171, [2] = 169, [3] = 171, [4] = 175, [5] = 181, [6] = 183, [7] = 181 }, [3] = { [0] = 198, [1] = 194, [2] = 192, [3] = 194, [4] = 198, [5] = 204, [6] = 206, [7] = 204 } })[R[7]][R[5]], ({ [0] = { [0] = 133, [1] = 128, [2] = 124, [3] = 122, [4] = 117, [5] = 122, [6] = 124, [7] = 128 }, [1] = { [0] = 173, [1] = 168, [2] = 164, [3] = 162, [4] = 157, [5] = 162, [6] = 164, [7] = 168 }, [2] = { [0] = 108, [1] = 103, [2] = 99, [3] = 97, [4] = 92, [5] = 97, [6] = 99, [7] = 103 }, [3] = { [0] = 48, [1] = 43, [2] = 39, [3] = 37, [4] = 32, [5] = 37, [6] = 39, [7] = 43 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 137, [2] = 133, [3] = 137, [4] = 141, [5] = 143, [6] = 147, [7] = 143 }, [1] = { [0] = 74, [1] = 70, [2] = 66, [3] = 70, [4] = 74, [5] = 76, [6] = 80, [7] = 76 }, [2] = { [0] = 177, [1] = 173, [2] = 169, [3] = 173, [4] = 177, [5] = 179, [6] = 183, [7] = 179 }, [3] = { [0] = 200, [1] = 196, [2] = 192, [3] = 196, [4] = 200, [5] = 202, [6] = 206, [7] = 202 } })[R[7]][R[5]], ({ [0] = { [0] = 133, [1] = 130, [2] = 126, [3] = 120, [4] = 117, [5] = 120, [6] = 126, [7] = 130 }, [1] = { [0] = 173, [1] = 170, [2] = 166, [3] = 160, [4] = 157, [5] = 160, [6] = 166, [7] = 170 }, [2] = { [0] = 108, [1] = 105, [2] = 101, [3] = 95, [4] = 92, [5] = 95, [6] = 101, [7] = 105 }, [3] = { [0] = 48, [1] = 45, [2] = 41, [3] = 35, [4] = 32, [5] = 35, [6] = 41, [7] = 45 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 140, [1] = 135, [2] = 132, [3] = 135, [4] = 140, [5] = 145, [6] = 148, [7] = 145 }, [1] = { [0] = 73, [1] = 68, [2] = 65, [3] = 68, [4] = 73, [5] = 78, [6] = 81, [7] = 78 }, [2] = { [0] = 176, [1] = 171, [2] = 168, [3] = 171, [4] = 176, [5] = 181, [6] = 184, [7] = 181 }, [3] = { [0] = 199, [1] = 194, [2] = 191, [3] = 194, [4] = 199, [5] = 204, [6] = 207, [7] = 204 } })[R[7]][R[5]], ({ [0] = { [0] = 135, [1] = 130, [2] = 125, [3] = 120, [4] = 115, [5] = 120, [6] = 125, [7] = 130 }, [1] = { [0] = 175, [1] = 170, [2] = 165, [3] = 160, [4] = 155, [5] = 160, [6] = 165, [7] = 170 }, [2] = { [0] = 110, [1] = 105, [2] = 100, [3] = 95, [4] = 90, [5] = 95, [6] = 100, [7] = 105 }, [3] = { [0] = 50, [1] = 45, [2] = 40, [3] = 35, [4] = 30, [5] = 35, [6] = 40, [7] = 45 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 133, [2] = 131, [3] = 133, [4] = 139, [5] = 147, [6] = 149, [7] = 147 }, [1] = { [0] = 72, [1] = 66, [2] = 64, [3] = 66, [4] = 72, [5] = 80, [6] = 82, [7] = 80 }, [2] = { [0] = 175, [1] = 169, [2] = 167, [3] = 169, [4] = 175, [5] = 183, [6] = 185, [7] = 183 }, [3] = { [0] = 198, [1] = 192, [2] = 190, [3] = 192, [4] = 198, [5] = 206, [6] = 208, [7] = 206 } })[R[7]][R[5]], ({ [0] = { [0] = 137, [1] = 130, [2] = 124, [3] = 120, [4] = 113, [5] = 120, [6] = 124, [7] = 130 }, [1] = { [0] = 177, [1] = 170, [2] = 164, [3] = 160, [4] = 153, [5] = 160, [6] = 164, [7] = 170 }, [2] = { [0] = 112, [1] = 105, [2] = 99, [3] = 95, [4] = 88, [5] = 95, [6] = 99, [7] = 105 }, [3] = { [0] = 52, [1] = 45, [2] = 39, [3] = 35, [4] = 28, [5] = 35, [6] = 39, [7] = 45 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 135, [2] = 131, [3] = 135, [4] = 141, [5] = 145, [6] = 149, [7] = 145 }, [1] = { [0] = 74, [1] = 68, [2] = 64, [3] = 68, [4] = 74, [5] = 78, [6] = 82, [7] = 78 }, [2] = { [0] = 177, [1] = 171, [2] = 167, [3] = 171, [4] = 177, [5] = 181, [6] = 185, [7] = 181 }, [3] = { [0] = 200, [1] = 194, [2] = 190, [3] = 194, [4] = 200, [5] = 204, [6] = 208, [7] = 204 } })[R[7]][R[5]], ({ [0] = { [0] = 137, [1] = 132, [2] = 126, [3] = 118, [4] = 113, [5] = 118, [6] = 126, [7] = 132 }, [1] = { [0] = 177, [1] = 172, [2] = 166, [3] = 158, [4] = 153, [5] = 158, [6] = 166, [7] = 172 }, [2] = { [0] = 112, [1] = 107, [2] = 101, [3] = 93, [4] = 88, [5] = 93, [6] = 101, [7] = 107 }, [3] = { [0] = 52, [1] = 47, [2] = 41, [3] = 33, [4] = 28, [5] = 33, [6] = 41, [7] = 47 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[10] = game.rand(4)
        if R[7] == 0 then
          if R[5] == 0 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 1 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 2 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 3 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 4 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 5 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 6 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 7 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 1 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 2 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 3 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 4 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 5 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 6 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 7 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 1 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 2 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 3 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 4 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 5 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 6 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 7 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 1 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 2 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 3 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 4 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 5 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 6 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          elseif R[5] == 7 then
            if R[10] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[10] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[10]", R[10])
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[11] = game.rand(8)
    players[3]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[8]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[8]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[8]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[11]][R[8]], ({ [0] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[11]][R[8]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[11]][R[8]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[11]][R[8]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[11]][R[8]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[11]][R[8]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 } })[R[11]][R[8]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 } })[R[11]][R[8]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 } })[R[11]][R[8]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 } })[R[11]][R[8]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[11]][R[8]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[11]][R[8]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 132, [1] = 65, [2] = 168, [3] = 191 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 148, [1] = 81, [2] = 184, [3] = 207 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[11]][R[8]], ({ [0] = { [0] = 135, [1] = 175, [2] = 110, [3] = 50 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 115, [1] = 155, [2] = 90, [3] = 30 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 } })[R[11]][R[8]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[11]][R[8]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[12] = game.rand(4)
        if R[11] == 0 then
          if R[8] == 0 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[8] == 1 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[8] == 2 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[8] == 3 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[11] == 1 then
          if R[12] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[11] == 2 then
          if R[12] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[11] == 3 then
          if R[12] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[11] == 4 then
          if R[8] == 0 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[8] == 1 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[8] == 2 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          elseif R[8] == 3 then
            if R[12] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[12] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[12]", R[12])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[11] == 5 then
          if R[12] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[11] == 6 then
          if R[12] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[12]", R[12])
          end
        elseif R[11] == 7 then
          if R[12] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[12] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[12]", R[12])
          end
        else
          unseen("R[11]", R[11])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
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
    players[({ [0] = 1, [1] = 1, [2] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3305)
      players[({ [0] = 1, [1] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[3].difficulty] == 0 then
        players[3]:mark_research(3303)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[3].workers = 30 - 4 * LEVEL_OF[players[3].difficulty]
    players[3].scientists = 16 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[3].difficulty]]
    players[3].food = 5000 - 1500 * LEVEL_OF[players[3].difficulty]
    if LEVEL_OF[players[3].difficulty] == 0 or LEVEL_OF[players[3].difficulty] == 1 then
      players[3]:mark_research(3304)
      players[3]:mark_research(3305)
      if LEVEL_OF[players[3].difficulty] == 0 then
        players[3]:mark_research(3401)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif LEVEL_OF[players[3].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
  elseif n == 4 then
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 104, 235 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 246, 118 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 20, 128 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 158, 14 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 76, 45 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 53, 26 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 34, 17 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 196, 199 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 213, 221 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { 224, 238 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 219, 38 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 164, 86 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 39, 200 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 78, 159 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { 111, 150 } }
    R[0] = game.rand(255)
    R[1] = game.rand(256)
    game.create_wreckage({ R[1] + 1, R[0] + 2 }, 11999, false)
    pick(4, 4, { 2, 7, 8, 13 })
    R[3] = game.rand(8)
    players[1]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[2]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[2]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[2]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[3]][R[2]], ({ [0] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[3]][R[2]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[3]][R[2]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[3]][R[2]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[3]][R[2]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[3]][R[2]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 } })[R[3]][R[2]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 } })[R[3]][R[2]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 } })[R[3]][R[2]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 } })[R[3]][R[2]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[3]][R[2]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 132, [1] = 65, [2] = 168, [3] = 191 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 148, [1] = 81, [2] = 184, [3] = 207 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 135, [1] = 175, [2] = 110, [3] = 50 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 115, [1] = 155, [2] = 90, [3] = 30 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 } })[R[3]][R[2]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[3]][R[2]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 } })[R[3]][R[2]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[3]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[14] = game.rand(4)
        if R[3] == 0 then
          if R[2] == 0 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[2] == 1 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[2] == 2 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[2] == 3 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[3] == 1 then
          if R[14] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[3] == 2 then
          if R[14] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[3] == 3 then
          if R[14] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[3] == 4 then
          if R[2] == 0 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[2] == 1 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[2] == 2 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          elseif R[2] == 3 then
            if R[14] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[14] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[14]", R[14])
            end
          else
            unseen("R[2]", R[2])
          end
        elseif R[3] == 5 then
          if R[14] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[3] == 6 then
          if R[14] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[14]", R[14])
          end
        elseif R[3] == 7 then
          if R[14] == 0 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 1 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 2 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          elseif R[14] == 3 then
            if R[2] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[2] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[2]", R[2])
            end
          else
            unseen("R[14]", R[14])
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
    players[2]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[7]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[7]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[7]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[7]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 140, [1] = 139, [2] = 138, [3] = 139, [4] = 140, [5] = 141, [6] = 142, [7] = 141 }, [1] = { [0] = 73, [1] = 72, [2] = 71, [3] = 72, [4] = 73, [5] = 74, [6] = 75, [7] = 74 }, [2] = { [0] = 176, [1] = 175, [2] = 174, [3] = 175, [4] = 176, [5] = 177, [6] = 178, [7] = 177 }, [3] = { [0] = 199, [1] = 198, [2] = 197, [3] = 198, [4] = 199, [5] = 200, [6] = 201, [7] = 200 } })[R[7]][R[5]], ({ [0] = { [0] = 127, [1] = 126, [2] = 125, [3] = 124, [4] = 123, [5] = 124, [6] = 125, [7] = 126 }, [1] = { [0] = 167, [1] = 166, [2] = 165, [3] = 164, [4] = 163, [5] = 164, [6] = 165, [7] = 166 }, [2] = { [0] = 102, [1] = 101, [2] = 100, [3] = 99, [4] = 98, [5] = 99, [6] = 100, [7] = 101 }, [3] = { [0] = 42, [1] = 41, [2] = 40, [3] = 39, [4] = 38, [5] = 39, [6] = 40, [7] = 41 } })[R[7]][R[5]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 137, [2] = 137, [3] = 137, [4] = 139, [5] = 143, [6] = 143, [7] = 143 }, [1] = { [0] = 72, [1] = 70, [2] = 70, [3] = 70, [4] = 72, [5] = 76, [6] = 76, [7] = 76 }, [2] = { [0] = 175, [1] = 173, [2] = 173, [3] = 173, [4] = 175, [5] = 179, [6] = 179, [7] = 179 }, [3] = { [0] = 198, [1] = 196, [2] = 196, [3] = 196, [4] = 198, [5] = 202, [6] = 202, [7] = 202 } })[R[7]][R[5]], ({ [0] = { [0] = 129, [1] = 126, [2] = 124, [3] = 124, [4] = 121, [5] = 124, [6] = 124, [7] = 126 }, [1] = { [0] = 169, [1] = 166, [2] = 164, [3] = 164, [4] = 161, [5] = 164, [6] = 164, [7] = 166 }, [2] = { [0] = 104, [1] = 101, [2] = 99, [3] = 99, [4] = 96, [5] = 99, [6] = 99, [7] = 101 }, [3] = { [0] = 44, [1] = 41, [2] = 39, [3] = 39, [4] = 36, [5] = 39, [6] = 39, [7] = 41 } })[R[7]][R[5]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 139, [2] = 137, [3] = 139, [4] = 141, [5] = 141, [6] = 143, [7] = 141 }, [1] = { [0] = 74, [1] = 72, [2] = 70, [3] = 72, [4] = 74, [5] = 74, [6] = 76, [7] = 74 }, [2] = { [0] = 177, [1] = 175, [2] = 173, [3] = 175, [4] = 177, [5] = 177, [6] = 179, [7] = 177 }, [3] = { [0] = 200, [1] = 198, [2] = 196, [3] = 198, [4] = 200, [5] = 200, [6] = 202, [7] = 200 } })[R[7]][R[5]], ({ [0] = { [0] = 129, [1] = 128, [2] = 126, [3] = 122, [4] = 121, [5] = 122, [6] = 126, [7] = 128 }, [1] = { [0] = 169, [1] = 168, [2] = 166, [3] = 162, [4] = 161, [5] = 162, [6] = 166, [7] = 168 }, [2] = { [0] = 104, [1] = 103, [2] = 101, [3] = 97, [4] = 96, [5] = 97, [6] = 101, [7] = 103 }, [3] = { [0] = 44, [1] = 43, [2] = 41, [3] = 37, [4] = 36, [5] = 37, [6] = 41, [7] = 43 } })[R[7]][R[5]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 136, [2] = 135, [3] = 136, [4] = 139, [5] = 144, [6] = 145, [7] = 144 }, [1] = { [0] = 72, [1] = 69, [2] = 68, [3] = 69, [4] = 72, [5] = 77, [6] = 78, [7] = 77 }, [2] = { [0] = 175, [1] = 172, [2] = 171, [3] = 172, [4] = 175, [5] = 180, [6] = 181, [7] = 180 }, [3] = { [0] = 198, [1] = 195, [2] = 194, [3] = 195, [4] = 198, [5] = 203, [6] = 204, [7] = 203 } })[R[7]][R[5]], ({ [0] = { [0] = 131, [1] = 127, [2] = 124, [3] = 123, [4] = 119, [5] = 123, [6] = 124, [7] = 127 }, [1] = { [0] = 171, [1] = 167, [2] = 164, [3] = 163, [4] = 159, [5] = 163, [6] = 164, [7] = 167 }, [2] = { [0] = 106, [1] = 102, [2] = 99, [3] = 98, [4] = 94, [5] = 98, [6] = 99, [7] = 102 }, [3] = { [0] = 46, [1] = 42, [2] = 39, [3] = 38, [4] = 34, [5] = 38, [6] = 39, [7] = 42 } })[R[7]][R[5]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 138, [2] = 135, [3] = 138, [4] = 141, [5] = 142, [6] = 145, [7] = 142 }, [1] = { [0] = 74, [1] = 71, [2] = 68, [3] = 71, [4] = 74, [5] = 75, [6] = 78, [7] = 75 }, [2] = { [0] = 177, [1] = 174, [2] = 171, [3] = 174, [4] = 177, [5] = 178, [6] = 181, [7] = 178 }, [3] = { [0] = 200, [1] = 197, [2] = 194, [3] = 197, [4] = 200, [5] = 201, [6] = 204, [7] = 201 } })[R[7]][R[5]], ({ [0] = { [0] = 131, [1] = 129, [2] = 126, [3] = 121, [4] = 119, [5] = 121, [6] = 126, [7] = 129 }, [1] = { [0] = 171, [1] = 169, [2] = 166, [3] = 161, [4] = 159, [5] = 161, [6] = 166, [7] = 169 }, [2] = { [0] = 106, [1] = 104, [2] = 101, [3] = 96, [4] = 94, [5] = 96, [6] = 101, [7] = 104 }, [3] = { [0] = 46, [1] = 44, [2] = 41, [3] = 36, [4] = 34, [5] = 36, [6] = 41, [7] = 44 } })[R[7]][R[5]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 135, [2] = 133, [3] = 135, [4] = 139, [5] = 145, [6] = 147, [7] = 145 }, [1] = { [0] = 72, [1] = 68, [2] = 66, [3] = 68, [4] = 72, [5] = 78, [6] = 80, [7] = 78 }, [2] = { [0] = 175, [1] = 171, [2] = 169, [3] = 171, [4] = 175, [5] = 181, [6] = 183, [7] = 181 }, [3] = { [0] = 198, [1] = 194, [2] = 192, [3] = 194, [4] = 198, [5] = 204, [6] = 206, [7] = 204 } })[R[7]][R[5]], ({ [0] = { [0] = 133, [1] = 128, [2] = 124, [3] = 122, [4] = 117, [5] = 122, [6] = 124, [7] = 128 }, [1] = { [0] = 173, [1] = 168, [2] = 164, [3] = 162, [4] = 157, [5] = 162, [6] = 164, [7] = 168 }, [2] = { [0] = 108, [1] = 103, [2] = 99, [3] = 97, [4] = 92, [5] = 97, [6] = 99, [7] = 103 }, [3] = { [0] = 48, [1] = 43, [2] = 39, [3] = 37, [4] = 32, [5] = 37, [6] = 39, [7] = 43 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 137, [2] = 133, [3] = 137, [4] = 141, [5] = 143, [6] = 147, [7] = 143 }, [1] = { [0] = 74, [1] = 70, [2] = 66, [3] = 70, [4] = 74, [5] = 76, [6] = 80, [7] = 76 }, [2] = { [0] = 177, [1] = 173, [2] = 169, [3] = 173, [4] = 177, [5] = 179, [6] = 183, [7] = 179 }, [3] = { [0] = 200, [1] = 196, [2] = 192, [3] = 196, [4] = 200, [5] = 202, [6] = 206, [7] = 202 } })[R[7]][R[5]], ({ [0] = { [0] = 133, [1] = 130, [2] = 126, [3] = 120, [4] = 117, [5] = 120, [6] = 126, [7] = 130 }, [1] = { [0] = 173, [1] = 170, [2] = 166, [3] = 160, [4] = 157, [5] = 160, [6] = 166, [7] = 170 }, [2] = { [0] = 108, [1] = 105, [2] = 101, [3] = 95, [4] = 92, [5] = 95, [6] = 101, [7] = 105 }, [3] = { [0] = 48, [1] = 45, [2] = 41, [3] = 35, [4] = 32, [5] = 35, [6] = 41, [7] = 45 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 140, [1] = 135, [2] = 132, [3] = 135, [4] = 140, [5] = 145, [6] = 148, [7] = 145 }, [1] = { [0] = 73, [1] = 68, [2] = 65, [3] = 68, [4] = 73, [5] = 78, [6] = 81, [7] = 78 }, [2] = { [0] = 176, [1] = 171, [2] = 168, [3] = 171, [4] = 176, [5] = 181, [6] = 184, [7] = 181 }, [3] = { [0] = 199, [1] = 194, [2] = 191, [3] = 194, [4] = 199, [5] = 204, [6] = 207, [7] = 204 } })[R[7]][R[5]], ({ [0] = { [0] = 135, [1] = 130, [2] = 125, [3] = 120, [4] = 115, [5] = 120, [6] = 125, [7] = 130 }, [1] = { [0] = 175, [1] = 170, [2] = 165, [3] = 160, [4] = 155, [5] = 160, [6] = 165, [7] = 170 }, [2] = { [0] = 110, [1] = 105, [2] = 100, [3] = 95, [4] = 90, [5] = 95, [6] = 100, [7] = 105 }, [3] = { [0] = 50, [1] = 45, [2] = 40, [3] = 35, [4] = 30, [5] = 35, [6] = 40, [7] = 45 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 139, [1] = 133, [2] = 131, [3] = 133, [4] = 139, [5] = 147, [6] = 149, [7] = 147 }, [1] = { [0] = 72, [1] = 66, [2] = 64, [3] = 66, [4] = 72, [5] = 80, [6] = 82, [7] = 80 }, [2] = { [0] = 175, [1] = 169, [2] = 167, [3] = 169, [4] = 175, [5] = 183, [6] = 185, [7] = 183 }, [3] = { [0] = 198, [1] = 192, [2] = 190, [3] = 192, [4] = 198, [5] = 206, [6] = 208, [7] = 206 } })[R[7]][R[5]], ({ [0] = { [0] = 137, [1] = 130, [2] = 124, [3] = 120, [4] = 113, [5] = 120, [6] = 124, [7] = 130 }, [1] = { [0] = 177, [1] = 170, [2] = 164, [3] = 160, [4] = 153, [5] = 160, [6] = 164, [7] = 170 }, [2] = { [0] = 112, [1] = 105, [2] = 99, [3] = 95, [4] = 88, [5] = 95, [6] = 99, [7] = 105 }, [3] = { [0] = 52, [1] = 45, [2] = 39, [3] = 35, [4] = 28, [5] = 35, [6] = 39, [7] = 45 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 141, [1] = 135, [2] = 131, [3] = 135, [4] = 141, [5] = 145, [6] = 149, [7] = 145 }, [1] = { [0] = 74, [1] = 68, [2] = 64, [3] = 68, [4] = 74, [5] = 78, [6] = 82, [7] = 78 }, [2] = { [0] = 177, [1] = 171, [2] = 167, [3] = 171, [4] = 177, [5] = 181, [6] = 185, [7] = 181 }, [3] = { [0] = 200, [1] = 194, [2] = 190, [3] = 194, [4] = 200, [5] = 204, [6] = 208, [7] = 204 } })[R[7]][R[5]], ({ [0] = { [0] = 137, [1] = 132, [2] = 126, [3] = 118, [4] = 113, [5] = 118, [6] = 126, [7] = 132 }, [1] = { [0] = 177, [1] = 172, [2] = 166, [3] = 158, [4] = 153, [5] = 158, [6] = 166, [7] = 172 }, [2] = { [0] = 112, [1] = 107, [2] = 101, [3] = 93, [4] = 88, [5] = 93, [6] = 101, [7] = 107 }, [3] = { [0] = 52, [1] = 47, [2] = 41, [3] = 33, [4] = 28, [5] = 33, [6] = 41, [7] = 47 } })[R[7]][R[5]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[5]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[15] = game.rand(4)
        if R[7] == 0 then
          if R[5] == 0 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 1 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 2 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 3 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 4 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 5 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 6 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 7 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 1 then
          if R[5] == 0 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 1 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 2 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 3 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 4 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 5 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 6 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 7 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 2 then
          if R[5] == 0 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 1 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 2 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 3 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 4 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 5 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 6 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 7 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          else
            unseen("R[5]", R[5])
          end
        elseif R[7] == 3 then
          if R[5] == 0 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 1 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 2 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 3 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 4 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 5 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 6 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          elseif R[5] == 7 then
            if R[15] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[15] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[15]", R[15])
            end
          else
            unseen("R[5]", R[5])
          end
        else
          unseen("R[7]", R[7])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[11] = game.rand(8)
    players[3]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[8]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[8]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[8]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[11]][R[8]], ({ [0] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[11]][R[8]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[11]][R[8]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[11]][R[8]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[11]][R[8]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[11]][R[8]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 } })[R[11]][R[8]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 } })[R[11]][R[8]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 } })[R[11]][R[8]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 } })[R[11]][R[8]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[11]][R[8]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[11]][R[8]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 132, [1] = 65, [2] = 168, [3] = 191 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 148, [1] = 81, [2] = 184, [3] = 207 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[11]][R[8]], ({ [0] = { [0] = 135, [1] = 175, [2] = 110, [3] = 50 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 115, [1] = 155, [2] = 90, [3] = 30 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 } })[R[11]][R[8]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[11]][R[8]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 } })[R[11]][R[8]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[11]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[16] = game.rand(4)
        if R[11] == 0 then
          if R[8] == 0 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          elseif R[8] == 1 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          elseif R[8] == 2 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          elseif R[8] == 3 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[11] == 1 then
          if R[16] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[16]", R[16])
          end
        elseif R[11] == 2 then
          if R[16] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[16]", R[16])
          end
        elseif R[11] == 3 then
          if R[16] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[16]", R[16])
          end
        elseif R[11] == 4 then
          if R[8] == 0 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          elseif R[8] == 1 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          elseif R[8] == 2 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          elseif R[8] == 3 then
            if R[16] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[16] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[16]", R[16])
            end
          else
            unseen("R[8]", R[8])
          end
        elseif R[11] == 5 then
          if R[16] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[16]", R[16])
          end
        elseif R[11] == 6 then
          if R[16] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[16]", R[16])
          end
        elseif R[11] == 7 then
          if R[16] == 0 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 1 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 2 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          elseif R[16] == 3 then
            if R[8] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[8] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[8]", R[8])
            end
          else
            unseen("R[16]", R[16])
          end
        else
          unseen("R[11]", R[11])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[17] = game.rand(8)
    players[4]:center_view({ ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[13]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[13]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 140, [1] = 73, [2] = 176, [3] = 199 })[R[13]], ({ [0] = 125, [1] = 165, [2] = 100, [3] = 40 })[R[13]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[17]][R[13]], ({ [0] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[17]][R[13]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[17]][R[13]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 } })[R[17]][R[13]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [2] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [3] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [6] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [7] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 } })[R[17]][R[13]], ({ [0] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[17]][R[13]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 136, [1] = 69, [2] = 172, [3] = 195 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 144, [1] = 77, [2] = 180, [3] = 203 } })[R[17]][R[13]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 123, [1] = 163, [2] = 98, [3] = 38 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 127, [1] = 167, [2] = 102, [3] = 42 } })[R[17]][R[13]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [2] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [3] = { [0] = 138, [1] = 71, [2] = 174, [3] = 197 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 }, [6] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [7] = { [0] = 142, [1] = 75, [2] = 178, [3] = 201 } })[R[17]][R[13]], ({ [0] = { [0] = 131, [1] = 171, [2] = 106, [3] = 46 }, [1] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [4] = { [0] = 119, [1] = 159, [2] = 94, [3] = 34 }, [5] = { [0] = 121, [1] = 161, [2] = 96, [3] = 36 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 129, [1] = 169, [2] = 104, [3] = 44 } })[R[17]][R[13]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[17]][R[13]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 122, [1] = 162, [2] = 97, [3] = 37 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 128, [1] = 168, [2] = 103, [3] = 43 } })[R[17]][R[13]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [2] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [3] = { [0] = 137, [1] = 70, [2] = 173, [3] = 196 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 }, [6] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [7] = { [0] = 143, [1] = 76, [2] = 179, [3] = 202 } })[R[17]][R[13]], ({ [0] = { [0] = 133, [1] = 173, [2] = 108, [3] = 48 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 117, [1] = 157, [2] = 92, [3] = 32 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[17]][R[13]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 132, [1] = 65, [2] = 168, [3] = 191 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 140, [1] = 73, [2] = 176, [3] = 199 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 148, [1] = 81, [2] = 184, [3] = 207 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[17]][R[13]], ({ [0] = { [0] = 135, [1] = 175, [2] = 110, [3] = 50 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 115, [1] = 155, [2] = 90, [3] = 30 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 125, [1] = 165, [2] = 100, [3] = 40 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[17]][R[13]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [1] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 133, [1] = 66, [2] = 169, [3] = 192 }, [4] = { [0] = 139, [1] = 72, [2] = 175, [3] = 198 }, [5] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 147, [1] = 80, [2] = 183, [3] = 206 } })[R[17]][R[13]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 }, [2] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [3] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 120, [1] = 160, [2] = 95, [3] = 35 }, [6] = { [0] = 124, [1] = 164, [2] = 99, [3] = 39 }, [7] = { [0] = 130, [1] = 170, [2] = 105, [3] = 45 } })[R[17]][R[13]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [1] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [2] = { [0] = 131, [1] = 64, [2] = 167, [3] = 190 }, [3] = { [0] = 135, [1] = 68, [2] = 171, [3] = 194 }, [4] = { [0] = 141, [1] = 74, [2] = 177, [3] = 200 }, [5] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 }, [6] = { [0] = 149, [1] = 82, [2] = 185, [3] = 208 }, [7] = { [0] = 145, [1] = 78, [2] = 181, [3] = 204 } })[R[17]][R[13]], ({ [0] = { [0] = 137, [1] = 177, [2] = 112, [3] = 52 }, [1] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 }, [2] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [3] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [4] = { [0] = 113, [1] = 153, [2] = 88, [3] = 28 }, [5] = { [0] = 118, [1] = 158, [2] = 93, [3] = 33 }, [6] = { [0] = 126, [1] = 166, [2] = 101, [3] = 41 }, [7] = { [0] = 132, [1] = 172, [2] = 107, [3] = 47 } })[R[17]][R[13]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[17]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[18] = game.rand(4)
        if R[17] == 0 then
          if R[13] == 0 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 126 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 126 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 135 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 135 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[13] == 1 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 166 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 166 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 175 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 175 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[13] == 2 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 101 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 101 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 110 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 110 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[13] == 3 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[17] == 1 then
          if R[18] == 0 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 124 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 124 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 164 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 164 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 99 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 99 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 1 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 141, 128 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 141, 128 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 74, 168 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 74, 168 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 177, 103 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 177, 103 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 200, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 200, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 2 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 127 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 127 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 167 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 167 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 102 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 102 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 3 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 133 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 133 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 173 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 173 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 108 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 108 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[17] == 2 then
          if R[18] == 0 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 138, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 138, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 71, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 71, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 174, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 174, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 197, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 197, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 1 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 122 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 122 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 162 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 162 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 97 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 97 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 2 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 138, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 138, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 71, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 71, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 174, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 174, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 197, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 197, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 3 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 128 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 128 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 168 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 168 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 103 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 103 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[17] == 3 then
          if R[18] == 0 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 126 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 126 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 166 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 166 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 101 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 101 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 1 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 141, 122 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 141, 122 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 74, 162 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 74, 162 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 177, 97 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 177, 97 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 200, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 200, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 2 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 123 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 133, 123 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 163 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 66, 163 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 98 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 169, 98 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 192, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 3 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 117 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 117 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 157 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 157 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 92 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 92 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[17] == 4 then
          if R[13] == 0 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 124 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 137, 124 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 115 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 115 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[13] == 1 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 164 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 70, 164 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 155 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 155 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[13] == 2 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 99 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 173, 99 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 90 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 90 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[13] == 3 then
            if R[18] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 196, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[13]", R[13])
          end
        elseif R[17] == 5 then
          if R[18] == 0 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 126 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 126 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 166 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 166 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 101 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 101 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 1 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 139, 122 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 139, 122 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 72, 162 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 72, 162 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 175, 97 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 175, 97 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 198, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 198, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 2 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 123 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 123 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 163 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 163 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 98 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 98 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 3 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 117 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 117 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 157 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 157 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 92 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 92 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[17] == 6 then
          if R[18] == 0 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 142, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 142, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 75, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 75, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 178, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 178, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 201, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 201, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 1 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 122 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 122 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 162 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 162 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 97 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 97 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 2 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 142, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 142, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 75, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 75, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 178, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 178, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 201, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 201, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 3 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 128 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 128 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 168 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 168 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 103 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 103 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[17] == 7 then
          if R[18] == 0 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 124 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 124 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 164 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 164 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 99 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 99 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 1 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 139, 128 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 139, 128 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 72, 168 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 72, 168 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 175, 103 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 175, 103 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 198, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 198, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 2 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 127 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 147, 127 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 167 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 80, 167 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 102 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 183, 102 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 206, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          elseif R[18] == 3 then
            if R[13] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 133 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 143, 133 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 173 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 76, 173 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 108 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 179, 108 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[13] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 202, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[13]", R[13])
            end
          else
            unseen("R[18]", R[18])
          end
        else
          unseen("R[17]", R[17])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
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
    players[({ [0] = 1, [1] = 1, [2] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[2]:mark_research(3305)
      players[({ [0] = 1, [1] = 2 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[3].difficulty] == 0 then
        players[3]:mark_research(3303)
      elseif LEVEL_OF[players[3].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[3].difficulty]", LEVEL_OF[players[3].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[3].workers = 30 - 4 * LEVEL_OF[players[3].difficulty]
    players[3].scientists = 16 - 3 * LEVEL_OF[players[3].difficulty]
    players[3].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[3].difficulty]]
    players[3].food = 5000 - 1500 * LEVEL_OF[players[3].difficulty]
    players[({ [0] = 2, [1] = 2, [2] = 3 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3304, [1] = 3304, [2] = 3303 })[LEVEL_OF[players[1].difficulty]])
    if LEVEL_OF[players[1].difficulty] == 0 or LEVEL_OF[players[1].difficulty] == 1 then
      players[3]:mark_research(3305)
      players[({ [0] = 2, [1] = 3 })[LEVEL_OF[players[1].difficulty]] + 1]:mark_research(({ [0] = 3401, [1] = 3303 })[LEVEL_OF[players[1].difficulty]])
      if LEVEL_OF[players[4].difficulty] == 0 then
        players[4]:mark_research(3303)
      elseif LEVEL_OF[players[4].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif LEVEL_OF[players[1].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[1].difficulty]", LEVEL_OF[players[1].difficulty])
    end
    players[4].workers = 30 - 4 * LEVEL_OF[players[4].difficulty]
    players[4].scientists = 16 - 3 * LEVEL_OF[players[4].difficulty]
    players[4].kids = ({ [0] = 24, [1] = 21, [2] = 22 })[LEVEL_OF[players[4].difficulty]]
    players[4].food = 5000 - 1500 * LEVEL_OF[players[4].difficulty]
    if LEVEL_OF[players[4].difficulty] == 0 or LEVEL_OF[players[4].difficulty] == 1 then
      players[4]:mark_research(3304)
      players[4]:mark_research(3305)
      if LEVEL_OF[players[4].difficulty] == 0 then
        players[4]:mark_research(3401)
      elseif LEVEL_OF[players[4].difficulty] == 1 then
      else
        unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
      end
    elseif LEVEL_OF[players[4].difficulty] == 2 then
    else
      unseen("LEVEL_OF[players[4].difficulty]", LEVEL_OF[players[4].difficulty])
    end
    game.set_daylight_everywhere(({ [0] = 1, [1] = 0 })[(game.uses_day_night() and 1 or 0)] ~= 0)
    if (game.uses_morale() and 1 or 0) == 0 then
      game.morale_steady("Good")
    elseif (game.uses_morale() and 1 or 0) == 1 then
      game.free_morale()
    else
      unseen("(game.uses_morale() and 1 or 0)", (game.uses_morale() and 1 or 0))
    end
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
    trigger.time{min = 1200, max = 1800, one_shot = false, on = Meteor}  -- after 12 to 18 marks
  end
  return true
end
