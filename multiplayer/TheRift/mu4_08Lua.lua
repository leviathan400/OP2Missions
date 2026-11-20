-- mu4_08Lua.lua  -  4 Player, LandRush, 'The Rift' map. (Lua)
--
-- Converted by op2dll from mu4_08.dll ("4 Player, LandRush, 'The Rift' map."): its setup replayed. `on_init` makes the original's
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
-- A value of 0 to range - 1, redrawn while it's one of `taken`.
             local function draw_avoid(range, taken)
  local no, left = {}, range
  for _, t in ipairs(taken) do
    if t >= 0 and t < range and not no[t] then no[t] = true; left = left - 1 end
  end
  if left == 0 then
    print("replay: draw_avoid(" .. range .. "): every value taken, a way no sampled game took")
    return game.rand(range)
  end
  local v
  repeat v = game.rand(range) until not no[v]
  return v
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
local Meteor, Vortex

function Meteor(t)
  local r1 = game.rand(128)
  local r2 = game.rand(256)
  game.create_meteor({ r2 + 1, r1 + 2 }, -1)
end

function Vortex(t)
  local r1 = game.rand(1)
  local r2 = game.rand(12)
  local r3 = game.rand(21)
  local r4 = game.rand(7)
  local r5 = game.rand(120)
  game.create_tornado({ r5 + 84, 2 }, { r3 + 116, r2 + 66 }, r4 + 10)
end

function on_init()
  local n = game.num_players()
  if n == 2 then
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 115, 79 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 136, 59 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 89 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 132, 19 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 171, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 81, 125 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 78, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 113 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 139, 44 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 129, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 183, 85 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 61 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[15]] } }
    R[16] = game.rand(128)
    R[17] = game.rand(256)
    game.create_wreckage({ R[17] + 1, R[16] + 2 }, 11999, false)
    R[18] = game.rand(4)
    R[19] = game.rand(8)
    players[1]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[18]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[18]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[18]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[19]][R[18]], ({ [0] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[19]][R[18]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[19]][R[18]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[19]][R[18]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[19]][R[18]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[19]][R[18]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 } })[R[19]][R[18]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 } })[R[19]][R[18]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 } })[R[19]][R[18]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 } })[R[19]][R[18]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[19]][R[18]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 50, [1] = 117, [2] = 102, [3] = 180 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 66, [1] = 133, [2] = 118, [3] = 196 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 88, [1] = 96, [2] = 50, [3] = 73 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 68, [1] = 76, [2] = 30, [3] = 53 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 } })[R[19]][R[18]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[20] = game.rand(4)
        if R[19] == 0 then
          if R[18] == 0 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          elseif R[18] == 1 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          elseif R[18] == 2 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          elseif R[18] == 3 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[19] == 1 then
          if R[20] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[20]", R[20])
          end
        elseif R[19] == 2 then
          if R[20] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[20]", R[20])
          end
        elseif R[19] == 3 then
          if R[20] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[20]", R[20])
          end
        elseif R[19] == 4 then
          if R[18] == 0 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          elseif R[18] == 1 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          elseif R[18] == 2 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          elseif R[18] == 3 then
            if R[20] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[20] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[20]", R[20])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[19] == 5 then
          if R[20] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[20]", R[20])
          end
        elseif R[19] == 6 then
          if R[20] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[20]", R[20])
          end
        elseif R[19] == 7 then
          if R[20] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[20] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[20]", R[20])
          end
        else
          unseen("R[19]", R[19])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[21] = game.rand(8)
    players[2]:center_view({ ({ [0] = 125, [1] = 58, [2] = 188, [3] = 110 })[R[18]], ({ [0] = 86, [1] = 78, [2] = 63, [3] = 40 })[R[18]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 125, [1] = 58, [2] = 188, [3] = 110 })[R[18]], ({ [0] = 86, [1] = 78, [2] = 63, [3] = 40 })[R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 58, [2] = 188, [3] = 110 }, [1] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [2] = { [0] = 123, [1] = 56, [2] = 186, [3] = 108 }, [3] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [4] = { [0] = 125, [1] = 58, [2] = 188, [3] = 110 }, [5] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [6] = { [0] = 127, [1] = 60, [2] = 190, [3] = 112 }, [7] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 } })[R[21]][R[18]], ({ [0] = { [0] = 88, [1] = 80, [2] = 65, [3] = 42 }, [1] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [2] = { [0] = 86, [1] = 78, [2] = 63, [3] = 40 }, [3] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [4] = { [0] = 84, [1] = 76, [2] = 61, [3] = 38 }, [5] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [6] = { [0] = 86, [1] = 78, [2] = 63, [3] = 40 }, [7] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 } })[R[21]][R[18]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [1] = { [0] = 122, [1] = 55, [2] = 185, [3] = 107 }, [2] = { [0] = 122, [1] = 55, [2] = 185, [3] = 107 }, [3] = { [0] = 122, [1] = 55, [2] = 185, [3] = 107 }, [4] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [5] = { [0] = 128, [1] = 61, [2] = 191, [3] = 113 }, [6] = { [0] = 128, [1] = 61, [2] = 191, [3] = 113 }, [7] = { [0] = 128, [1] = 61, [2] = 191, [3] = 113 } })[R[21]][R[18]], ({ [0] = { [0] = 90, [1] = 82, [2] = 67, [3] = 44 }, [1] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [2] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [3] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [4] = { [0] = 82, [1] = 74, [2] = 59, [3] = 36 }, [5] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [6] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [7] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 } })[R[21]][R[18]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [1] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [2] = { [0] = 122, [1] = 55, [2] = 185, [3] = 107 }, [3] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [4] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [5] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [6] = { [0] = 128, [1] = 61, [2] = 191, [3] = 113 }, [7] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 } })[R[21]][R[18]], ({ [0] = { [0] = 90, [1] = 82, [2] = 67, [3] = 44 }, [1] = { [0] = 89, [1] = 81, [2] = 66, [3] = 43 }, [2] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [3] = { [0] = 83, [1] = 75, [2] = 60, [3] = 37 }, [4] = { [0] = 82, [1] = 74, [2] = 59, [3] = 36 }, [5] = { [0] = 83, [1] = 75, [2] = 60, [3] = 37 }, [6] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [7] = { [0] = 89, [1] = 81, [2] = 66, [3] = 43 } })[R[21]][R[18]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [1] = { [0] = 121, [1] = 54, [2] = 184, [3] = 106 }, [2] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [3] = { [0] = 121, [1] = 54, [2] = 184, [3] = 106 }, [4] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [5] = { [0] = 129, [1] = 62, [2] = 192, [3] = 114 }, [6] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 }, [7] = { [0] = 129, [1] = 62, [2] = 192, [3] = 114 } })[R[21]][R[18]], ({ [0] = { [0] = 92, [1] = 84, [2] = 69, [3] = 46 }, [1] = { [0] = 88, [1] = 80, [2] = 65, [3] = 42 }, [2] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [3] = { [0] = 84, [1] = 76, [2] = 61, [3] = 38 }, [4] = { [0] = 80, [1] = 72, [2] = 57, [3] = 34 }, [5] = { [0] = 84, [1] = 76, [2] = 61, [3] = 38 }, [6] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [7] = { [0] = 88, [1] = 80, [2] = 65, [3] = 42 } })[R[21]][R[18]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [1] = { [0] = 123, [1] = 56, [2] = 186, [3] = 108 }, [2] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [3] = { [0] = 123, [1] = 56, [2] = 186, [3] = 108 }, [4] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [5] = { [0] = 127, [1] = 60, [2] = 190, [3] = 112 }, [6] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 }, [7] = { [0] = 127, [1] = 60, [2] = 190, [3] = 112 } })[R[21]][R[18]], ({ [0] = { [0] = 92, [1] = 84, [2] = 69, [3] = 46 }, [1] = { [0] = 90, [1] = 82, [2] = 67, [3] = 44 }, [2] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [3] = { [0] = 82, [1] = 74, [2] = 59, [3] = 36 }, [4] = { [0] = 80, [1] = 72, [2] = 57, [3] = 34 }, [5] = { [0] = 82, [1] = 74, [2] = 59, [3] = 36 }, [6] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [7] = { [0] = 90, [1] = 82, [2] = 67, [3] = 44 } })[R[21]][R[18]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [1] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [2] = { [0] = 118, [1] = 51, [2] = 181, [3] = 103 }, [3] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [4] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [5] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 }, [6] = { [0] = 132, [1] = 65, [2] = 195, [3] = 117 }, [7] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 } })[R[21]][R[18]], ({ [0] = { [0] = 94, [1] = 86, [2] = 71, [3] = 48 }, [1] = { [0] = 89, [1] = 81, [2] = 66, [3] = 43 }, [2] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [3] = { [0] = 83, [1] = 75, [2] = 60, [3] = 37 }, [4] = { [0] = 78, [1] = 70, [2] = 55, [3] = 32 }, [5] = { [0] = 83, [1] = 75, [2] = 60, [3] = 37 }, [6] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [7] = { [0] = 89, [1] = 81, [2] = 66, [3] = 43 } })[R[21]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [1] = { [0] = 122, [1] = 55, [2] = 185, [3] = 107 }, [2] = { [0] = 118, [1] = 51, [2] = 181, [3] = 103 }, [3] = { [0] = 122, [1] = 55, [2] = 185, [3] = 107 }, [4] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [5] = { [0] = 128, [1] = 61, [2] = 191, [3] = 113 }, [6] = { [0] = 132, [1] = 65, [2] = 195, [3] = 117 }, [7] = { [0] = 128, [1] = 61, [2] = 191, [3] = 113 } })[R[21]][R[18]], ({ [0] = { [0] = 94, [1] = 86, [2] = 71, [3] = 48 }, [1] = { [0] = 91, [1] = 83, [2] = 68, [3] = 45 }, [2] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [3] = { [0] = 81, [1] = 73, [2] = 58, [3] = 35 }, [4] = { [0] = 78, [1] = 70, [2] = 55, [3] = 32 }, [5] = { [0] = 81, [1] = 73, [2] = 58, [3] = 35 }, [6] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [7] = { [0] = 91, [1] = 83, [2] = 68, [3] = 45 } })[R[21]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 125, [1] = 58, [2] = 188, [3] = 110 }, [1] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [2] = { [0] = 117, [1] = 50, [2] = 180, [3] = 102 }, [3] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [4] = { [0] = 125, [1] = 58, [2] = 188, [3] = 110 }, [5] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 }, [6] = { [0] = 133, [1] = 66, [2] = 196, [3] = 118 }, [7] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 } })[R[21]][R[18]], ({ [0] = { [0] = 96, [1] = 88, [2] = 73, [3] = 50 }, [1] = { [0] = 91, [1] = 83, [2] = 68, [3] = 45 }, [2] = { [0] = 86, [1] = 78, [2] = 63, [3] = 40 }, [3] = { [0] = 81, [1] = 73, [2] = 58, [3] = 35 }, [4] = { [0] = 76, [1] = 68, [2] = 53, [3] = 30 }, [5] = { [0] = 81, [1] = 73, [2] = 58, [3] = 35 }, [6] = { [0] = 86, [1] = 78, [2] = 63, [3] = 40 }, [7] = { [0] = 91, [1] = 83, [2] = 68, [3] = 45 } })[R[21]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [1] = { [0] = 118, [1] = 51, [2] = 181, [3] = 103 }, [2] = { [0] = 116, [1] = 49, [2] = 179, [3] = 101 }, [3] = { [0] = 118, [1] = 51, [2] = 181, [3] = 103 }, [4] = { [0] = 124, [1] = 57, [2] = 187, [3] = 109 }, [5] = { [0] = 132, [1] = 65, [2] = 195, [3] = 117 }, [6] = { [0] = 134, [1] = 67, [2] = 197, [3] = 119 }, [7] = { [0] = 132, [1] = 65, [2] = 195, [3] = 117 } })[R[21]][R[18]], ({ [0] = { [0] = 98, [1] = 90, [2] = 75, [3] = 52 }, [1] = { [0] = 91, [1] = 83, [2] = 68, [3] = 45 }, [2] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [3] = { [0] = 81, [1] = 73, [2] = 58, [3] = 35 }, [4] = { [0] = 74, [1] = 66, [2] = 51, [3] = 28 }, [5] = { [0] = 81, [1] = 73, [2] = 58, [3] = 35 }, [6] = { [0] = 85, [1] = 77, [2] = 62, [3] = 39 }, [7] = { [0] = 91, [1] = 83, [2] = 68, [3] = 45 } })[R[21]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [1] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [2] = { [0] = 116, [1] = 49, [2] = 179, [3] = 101 }, [3] = { [0] = 120, [1] = 53, [2] = 183, [3] = 105 }, [4] = { [0] = 126, [1] = 59, [2] = 189, [3] = 111 }, [5] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 }, [6] = { [0] = 134, [1] = 67, [2] = 197, [3] = 119 }, [7] = { [0] = 130, [1] = 63, [2] = 193, [3] = 115 } })[R[21]][R[18]], ({ [0] = { [0] = 98, [1] = 90, [2] = 75, [3] = 52 }, [1] = { [0] = 93, [1] = 85, [2] = 70, [3] = 47 }, [2] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [3] = { [0] = 79, [1] = 71, [2] = 56, [3] = 33 }, [4] = { [0] = 74, [1] = 66, [2] = 51, [3] = 28 }, [5] = { [0] = 79, [1] = 71, [2] = 56, [3] = 33 }, [6] = { [0] = 87, [1] = 79, [2] = 64, [3] = 41 }, [7] = { [0] = 93, [1] = 85, [2] = 70, [3] = 47 } })[R[21]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[22] = game.rand(4)
        if R[21] == 0 then
          if R[18] == 0 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          elseif R[18] == 1 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          elseif R[18] == 2 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          elseif R[18] == 3 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[21] == 1 then
          if R[22] == 0 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 1 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 2 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 3 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[22]", R[22])
          end
        elseif R[21] == 2 then
          if R[22] == 0 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 1 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 2 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 3 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[22]", R[22])
          end
        elseif R[21] == 3 then
          if R[22] == 0 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 1 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 2 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 3 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[22]", R[22])
          end
        elseif R[21] == 4 then
          if R[18] == 0 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          elseif R[18] == 1 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          elseif R[18] == 2 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          elseif R[18] == 3 then
            if R[22] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[22] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[22]", R[22])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[21] == 5 then
          if R[22] == 0 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 1 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 2 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 3 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[22]", R[22])
          end
        elseif R[21] == 6 then
          if R[22] == 0 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 1 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 2 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 3 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[22]", R[22])
          end
        elseif R[21] == 7 then
          if R[22] == 0 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 1 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 2 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[22] == 3 then
            if R[18] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[22]", R[22])
          end
        else
          unseen("R[21]", R[21])
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
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 115, 79 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 136, 59 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 89 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 132, 19 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 171, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 81, 125 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 78, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 113 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 139, 44 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 129, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 183, 85 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 61 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[15]] } }
    R[16] = game.rand(128)
    R[17] = game.rand(256)
    game.create_wreckage({ R[17] + 1, R[16] + 2 }, 11999, false)
    pick(4, 3, { 18, 23, 24 })
    R[19] = game.rand(8)
    players[1]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[18]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[18]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[18]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[19]][R[18]], ({ [0] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[19]][R[18]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[19]][R[18]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[19]][R[18]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[19]][R[18]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[19]][R[18]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 } })[R[19]][R[18]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 } })[R[19]][R[18]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 } })[R[19]][R[18]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 } })[R[19]][R[18]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[19]][R[18]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 50, [1] = 117, [2] = 102, [3] = 180 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 66, [1] = 133, [2] = 118, [3] = 196 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 88, [1] = 96, [2] = 50, [3] = 73 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 68, [1] = 76, [2] = 30, [3] = 53 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 } })[R[19]][R[18]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[25] = game.rand(4)
        if R[19] == 0 then
          if R[18] == 0 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          elseif R[18] == 1 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          elseif R[18] == 2 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          elseif R[18] == 3 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[19] == 1 then
          if R[25] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[25]", R[25])
          end
        elseif R[19] == 2 then
          if R[25] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[25]", R[25])
          end
        elseif R[19] == 3 then
          if R[25] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[25]", R[25])
          end
        elseif R[19] == 4 then
          if R[18] == 0 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          elseif R[18] == 1 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          elseif R[18] == 2 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          elseif R[18] == 3 then
            if R[25] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[25] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[25]", R[25])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[19] == 5 then
          if R[25] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[25]", R[25])
          end
        elseif R[19] == 6 then
          if R[25] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[25]", R[25])
          end
        elseif R[19] == 7 then
          if R[25] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[25] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[25]", R[25])
          end
        else
          unseen("R[19]", R[19])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[21] = game.rand(8)
    players[2]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[23]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[23]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[23]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[23]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 58, [1] = 57, [2] = 56, [3] = 57, [4] = 58, [5] = 59, [6] = 60, [7] = 59 }, [1] = { [0] = 125, [1] = 124, [2] = 123, [3] = 124, [4] = 125, [5] = 126, [6] = 127, [7] = 126 }, [2] = { [0] = 110, [1] = 109, [2] = 108, [3] = 109, [4] = 110, [5] = 111, [6] = 112, [7] = 111 }, [3] = { [0] = 188, [1] = 187, [2] = 186, [3] = 187, [4] = 188, [5] = 189, [6] = 190, [7] = 189 } })[R[23]][R[21]], ({ [0] = { [0] = 80, [1] = 79, [2] = 78, [3] = 77, [4] = 76, [5] = 77, [6] = 78, [7] = 79 }, [1] = { [0] = 88, [1] = 87, [2] = 86, [3] = 85, [4] = 84, [5] = 85, [6] = 86, [7] = 87 }, [2] = { [0] = 42, [1] = 41, [2] = 40, [3] = 39, [4] = 38, [5] = 39, [6] = 40, [7] = 41 }, [3] = { [0] = 65, [1] = 64, [2] = 63, [3] = 62, [4] = 61, [5] = 62, [6] = 63, [7] = 64 } })[R[23]][R[21]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 55, [2] = 55, [3] = 55, [4] = 57, [5] = 61, [6] = 61, [7] = 61 }, [1] = { [0] = 124, [1] = 122, [2] = 122, [3] = 122, [4] = 124, [5] = 128, [6] = 128, [7] = 128 }, [2] = { [0] = 109, [1] = 107, [2] = 107, [3] = 107, [4] = 109, [5] = 113, [6] = 113, [7] = 113 }, [3] = { [0] = 187, [1] = 185, [2] = 185, [3] = 185, [4] = 187, [5] = 191, [6] = 191, [7] = 191 } })[R[23]][R[21]], ({ [0] = { [0] = 82, [1] = 79, [2] = 77, [3] = 77, [4] = 74, [5] = 77, [6] = 77, [7] = 79 }, [1] = { [0] = 90, [1] = 87, [2] = 85, [3] = 85, [4] = 82, [5] = 85, [6] = 85, [7] = 87 }, [2] = { [0] = 44, [1] = 41, [2] = 39, [3] = 39, [4] = 36, [5] = 39, [6] = 39, [7] = 41 }, [3] = { [0] = 67, [1] = 64, [2] = 62, [3] = 62, [4] = 59, [5] = 62, [6] = 62, [7] = 64 } })[R[23]][R[21]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 57, [2] = 55, [3] = 57, [4] = 59, [5] = 59, [6] = 61, [7] = 59 }, [1] = { [0] = 126, [1] = 124, [2] = 122, [3] = 124, [4] = 126, [5] = 126, [6] = 128, [7] = 126 }, [2] = { [0] = 111, [1] = 109, [2] = 107, [3] = 109, [4] = 111, [5] = 111, [6] = 113, [7] = 111 }, [3] = { [0] = 189, [1] = 187, [2] = 185, [3] = 187, [4] = 189, [5] = 189, [6] = 191, [7] = 189 } })[R[23]][R[21]], ({ [0] = { [0] = 82, [1] = 81, [2] = 79, [3] = 75, [4] = 74, [5] = 75, [6] = 79, [7] = 81 }, [1] = { [0] = 90, [1] = 89, [2] = 87, [3] = 83, [4] = 82, [5] = 83, [6] = 87, [7] = 89 }, [2] = { [0] = 44, [1] = 43, [2] = 41, [3] = 37, [4] = 36, [5] = 37, [6] = 41, [7] = 43 }, [3] = { [0] = 67, [1] = 66, [2] = 64, [3] = 60, [4] = 59, [5] = 60, [6] = 64, [7] = 66 } })[R[23]][R[21]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 54, [2] = 53, [3] = 54, [4] = 57, [5] = 62, [6] = 63, [7] = 62 }, [1] = { [0] = 124, [1] = 121, [2] = 120, [3] = 121, [4] = 124, [5] = 129, [6] = 130, [7] = 129 }, [2] = { [0] = 109, [1] = 106, [2] = 105, [3] = 106, [4] = 109, [5] = 114, [6] = 115, [7] = 114 }, [3] = { [0] = 187, [1] = 184, [2] = 183, [3] = 184, [4] = 187, [5] = 192, [6] = 193, [7] = 192 } })[R[23]][R[21]], ({ [0] = { [0] = 84, [1] = 80, [2] = 77, [3] = 76, [4] = 72, [5] = 76, [6] = 77, [7] = 80 }, [1] = { [0] = 92, [1] = 88, [2] = 85, [3] = 84, [4] = 80, [5] = 84, [6] = 85, [7] = 88 }, [2] = { [0] = 46, [1] = 42, [2] = 39, [3] = 38, [4] = 34, [5] = 38, [6] = 39, [7] = 42 }, [3] = { [0] = 69, [1] = 65, [2] = 62, [3] = 61, [4] = 57, [5] = 61, [6] = 62, [7] = 65 } })[R[23]][R[21]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 56, [2] = 53, [3] = 56, [4] = 59, [5] = 60, [6] = 63, [7] = 60 }, [1] = { [0] = 126, [1] = 123, [2] = 120, [3] = 123, [4] = 126, [5] = 127, [6] = 130, [7] = 127 }, [2] = { [0] = 111, [1] = 108, [2] = 105, [3] = 108, [4] = 111, [5] = 112, [6] = 115, [7] = 112 }, [3] = { [0] = 189, [1] = 186, [2] = 183, [3] = 186, [4] = 189, [5] = 190, [6] = 193, [7] = 190 } })[R[23]][R[21]], ({ [0] = { [0] = 84, [1] = 82, [2] = 79, [3] = 74, [4] = 72, [5] = 74, [6] = 79, [7] = 82 }, [1] = { [0] = 92, [1] = 90, [2] = 87, [3] = 82, [4] = 80, [5] = 82, [6] = 87, [7] = 90 }, [2] = { [0] = 46, [1] = 44, [2] = 41, [3] = 36, [4] = 34, [5] = 36, [6] = 41, [7] = 44 }, [3] = { [0] = 69, [1] = 67, [2] = 64, [3] = 59, [4] = 57, [5] = 59, [6] = 64, [7] = 67 } })[R[23]][R[21]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 53, [2] = 51, [3] = 53, [4] = 57, [5] = 63, [6] = 65, [7] = 63 }, [1] = { [0] = 124, [1] = 120, [2] = 118, [3] = 120, [4] = 124, [5] = 130, [6] = 132, [7] = 130 }, [2] = { [0] = 109, [1] = 105, [2] = 103, [3] = 105, [4] = 109, [5] = 115, [6] = 117, [7] = 115 }, [3] = { [0] = 187, [1] = 183, [2] = 181, [3] = 183, [4] = 187, [5] = 193, [6] = 195, [7] = 193 } })[R[23]][R[21]], ({ [0] = { [0] = 86, [1] = 81, [2] = 77, [3] = 75, [4] = 70, [5] = 75, [6] = 77, [7] = 81 }, [1] = { [0] = 94, [1] = 89, [2] = 85, [3] = 83, [4] = 78, [5] = 83, [6] = 85, [7] = 89 }, [2] = { [0] = 48, [1] = 43, [2] = 39, [3] = 37, [4] = 32, [5] = 37, [6] = 39, [7] = 43 }, [3] = { [0] = 71, [1] = 66, [2] = 62, [3] = 60, [4] = 55, [5] = 60, [6] = 62, [7] = 66 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 55, [2] = 51, [3] = 55, [4] = 59, [5] = 61, [6] = 65, [7] = 61 }, [1] = { [0] = 126, [1] = 122, [2] = 118, [3] = 122, [4] = 126, [5] = 128, [6] = 132, [7] = 128 }, [2] = { [0] = 111, [1] = 107, [2] = 103, [3] = 107, [4] = 111, [5] = 113, [6] = 117, [7] = 113 }, [3] = { [0] = 189, [1] = 185, [2] = 181, [3] = 185, [4] = 189, [5] = 191, [6] = 195, [7] = 191 } })[R[23]][R[21]], ({ [0] = { [0] = 86, [1] = 83, [2] = 79, [3] = 73, [4] = 70, [5] = 73, [6] = 79, [7] = 83 }, [1] = { [0] = 94, [1] = 91, [2] = 87, [3] = 81, [4] = 78, [5] = 81, [6] = 87, [7] = 91 }, [2] = { [0] = 48, [1] = 45, [2] = 41, [3] = 35, [4] = 32, [5] = 35, [6] = 41, [7] = 45 }, [3] = { [0] = 71, [1] = 68, [2] = 64, [3] = 58, [4] = 55, [5] = 58, [6] = 64, [7] = 68 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 58, [1] = 53, [2] = 50, [3] = 53, [4] = 58, [5] = 63, [6] = 66, [7] = 63 }, [1] = { [0] = 125, [1] = 120, [2] = 117, [3] = 120, [4] = 125, [5] = 130, [6] = 133, [7] = 130 }, [2] = { [0] = 110, [1] = 105, [2] = 102, [3] = 105, [4] = 110, [5] = 115, [6] = 118, [7] = 115 }, [3] = { [0] = 188, [1] = 183, [2] = 180, [3] = 183, [4] = 188, [5] = 193, [6] = 196, [7] = 193 } })[R[23]][R[21]], ({ [0] = { [0] = 88, [1] = 83, [2] = 78, [3] = 73, [4] = 68, [5] = 73, [6] = 78, [7] = 83 }, [1] = { [0] = 96, [1] = 91, [2] = 86, [3] = 81, [4] = 76, [5] = 81, [6] = 86, [7] = 91 }, [2] = { [0] = 50, [1] = 45, [2] = 40, [3] = 35, [4] = 30, [5] = 35, [6] = 40, [7] = 45 }, [3] = { [0] = 73, [1] = 68, [2] = 63, [3] = 58, [4] = 53, [5] = 58, [6] = 63, [7] = 68 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 51, [2] = 49, [3] = 51, [4] = 57, [5] = 65, [6] = 67, [7] = 65 }, [1] = { [0] = 124, [1] = 118, [2] = 116, [3] = 118, [4] = 124, [5] = 132, [6] = 134, [7] = 132 }, [2] = { [0] = 109, [1] = 103, [2] = 101, [3] = 103, [4] = 109, [5] = 117, [6] = 119, [7] = 117 }, [3] = { [0] = 187, [1] = 181, [2] = 179, [3] = 181, [4] = 187, [5] = 195, [6] = 197, [7] = 195 } })[R[23]][R[21]], ({ [0] = { [0] = 90, [1] = 83, [2] = 77, [3] = 73, [4] = 66, [5] = 73, [6] = 77, [7] = 83 }, [1] = { [0] = 98, [1] = 91, [2] = 85, [3] = 81, [4] = 74, [5] = 81, [6] = 85, [7] = 91 }, [2] = { [0] = 52, [1] = 45, [2] = 39, [3] = 35, [4] = 28, [5] = 35, [6] = 39, [7] = 45 }, [3] = { [0] = 75, [1] = 68, [2] = 62, [3] = 58, [4] = 51, [5] = 58, [6] = 62, [7] = 68 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 53, [2] = 49, [3] = 53, [4] = 59, [5] = 63, [6] = 67, [7] = 63 }, [1] = { [0] = 126, [1] = 120, [2] = 116, [3] = 120, [4] = 126, [5] = 130, [6] = 134, [7] = 130 }, [2] = { [0] = 111, [1] = 105, [2] = 101, [3] = 105, [4] = 111, [5] = 115, [6] = 119, [7] = 115 }, [3] = { [0] = 189, [1] = 183, [2] = 179, [3] = 183, [4] = 189, [5] = 193, [6] = 197, [7] = 193 } })[R[23]][R[21]], ({ [0] = { [0] = 90, [1] = 85, [2] = 79, [3] = 71, [4] = 66, [5] = 71, [6] = 79, [7] = 85 }, [1] = { [0] = 98, [1] = 93, [2] = 87, [3] = 79, [4] = 74, [5] = 79, [6] = 87, [7] = 93 }, [2] = { [0] = 52, [1] = 47, [2] = 41, [3] = 33, [4] = 28, [5] = 33, [6] = 41, [7] = 47 }, [3] = { [0] = 75, [1] = 70, [2] = 64, [3] = 56, [4] = 51, [5] = 56, [6] = 64, [7] = 70 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[26] = game.rand(4)
        if R[23] == 0 then
          if R[21] == 0 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 1 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 2 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 3 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 4 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 5 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 6 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 7 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          else
            unseen("R[21]", R[21])
          end
        elseif R[23] == 1 then
          if R[21] == 0 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 1 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 2 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 3 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 4 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 5 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 6 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 7 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          else
            unseen("R[21]", R[21])
          end
        elseif R[23] == 2 then
          if R[21] == 0 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 1 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 2 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 3 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 4 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 5 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 6 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 7 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          else
            unseen("R[21]", R[21])
          end
        elseif R[23] == 3 then
          if R[21] == 0 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 1 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 2 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 3 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 4 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 5 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 6 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          elseif R[21] == 7 then
            if R[26] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[26] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[26]", R[26])
            end
          else
            unseen("R[21]", R[21])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[27] = game.rand(8)
    players[3]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[24]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[24]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[24]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[27]][R[24]], ({ [0] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[27]][R[24]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[27]][R[24]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[27]][R[24]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[27]][R[24]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[27]][R[24]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 } })[R[27]][R[24]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 } })[R[27]][R[24]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 } })[R[27]][R[24]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 } })[R[27]][R[24]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[27]][R[24]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[27]][R[24]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 50, [1] = 117, [2] = 102, [3] = 180 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 66, [1] = 133, [2] = 118, [3] = 196 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[27]][R[24]], ({ [0] = { [0] = 88, [1] = 96, [2] = 50, [3] = 73 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 68, [1] = 76, [2] = 30, [3] = 53 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 } })[R[27]][R[24]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[27]][R[24]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[28] = game.rand(4)
        if R[27] == 0 then
          if R[24] == 0 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          elseif R[24] == 1 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          elseif R[24] == 2 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          elseif R[24] == 3 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          else
            unseen("R[24]", R[24])
          end
        elseif R[27] == 1 then
          if R[28] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[28]", R[28])
          end
        elseif R[27] == 2 then
          if R[28] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[28]", R[28])
          end
        elseif R[27] == 3 then
          if R[28] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[28]", R[28])
          end
        elseif R[27] == 4 then
          if R[24] == 0 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          elseif R[24] == 1 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          elseif R[24] == 2 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          elseif R[24] == 3 then
            if R[28] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[28] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[28]", R[28])
            end
          else
            unseen("R[24]", R[24])
          end
        elseif R[27] == 5 then
          if R[28] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[28]", R[28])
          end
        elseif R[27] == 6 then
          if R[28] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[28]", R[28])
          end
        elseif R[27] == 7 then
          if R[28] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[28] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[28]", R[28])
          end
        else
          unseen("R[27]", R[27])
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
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 115, 79 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 136, 59 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 116, 89 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 132, 19 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 171, 6 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 81, 125 } }
    game.create_beacon{ type = "MagmaVent", ore = "Random", yield = "Random", variant = "Random", at = { 78, 90 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 107, 99 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 112, 113 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 139, 44 } }
    game.create_beacon{ type = "Fumarole", ore = "Random", yield = "Random", variant = "Random", at = { 129, 3 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 183, 85 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 190, 119 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 71, 34 } }
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Bar2", variant = "Random", at = { 59, 61 } }
    R[0] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[0]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[0]] } }
    R[1] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[1]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[1]] } }
    R[2] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[2]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[2]] } }
    R[3] = game.rand(8)
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[3]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[3]] } }
    R[4] = draw_avoid(8, { R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[4]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[4]] } }
    R[5] = draw_avoid(8, { R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Rare", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[5]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[5]] } }
    R[6] = draw_avoid(8, { R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[6]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[6]] } }
    R[7] = draw_avoid(8, { R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[7]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[7]] } }
    R[8] = draw_avoid(8, { R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[8]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[8]] } }
    R[9] = draw_avoid(8, { R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[9]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[9]] } }
    R[10] = draw_avoid(8, { R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[10]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[10]] } }
    R[11] = draw_avoid(8, { R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[11]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[11]] } }
    R[12] = draw_avoid(8, { R[8], R[4], R[0] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 61, [1] = 70, [2] = 100, [3] = 120, [4] = 117, [5] = 94, [6] = 86, [7] = 120 })[R[12]], ({ [0] = 4, [1] = 26, [2] = 42, [3] = 8, [4] = 32, [5] = 8, [6] = 14, [7] = 43 })[R[12]] } }
    R[13] = draw_avoid(8, { R[9], R[5], R[1] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 8, [1] = 51, [2] = 66, [3] = 86, [4] = 33, [5] = 44, [6] = 79, [7] = 26 })[R[13]], ({ [0] = 79, [1] = 72, [2] = 71, [3] = 84, [4] = 108, [5] = 103, [6] = 111, [7] = 94 })[R[13]] } }
    R[14] = draw_avoid(8, { R[10], R[6], R[2] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 138, [1] = 155, [2] = 138, [3] = 122, [4] = 108, [5] = 118, [6] = 127, [7] = 138 })[R[14]], ({ [0] = 112, [1] = 126, [2] = 90, [3] = 83, [4] = 122, [5] = 102, [6] = 115, [7] = 123 })[R[14]] } }
    R[15] = draw_avoid(8, { R[11], R[7], R[3] })
    game.create_beacon{ type = "MiningBeacon", ore = "Common", yield = "Random", variant = "Random", at = { ({ [0] = 220, [1] = 209, [2] = 189, [3] = 167, [4] = 143, [5] = 234, [6] = 207, [7] = 243 })[R[15]], ({ [0] = 77, [1] = 73, [2] = 75, [3] = 51, [4] = 51, [5] = 50, [6] = 38, [7] = 29 })[R[15]] } }
    R[16] = game.rand(128)
    R[17] = game.rand(256)
    game.create_wreckage({ R[17] + 1, R[16] + 2 }, 11999, false)
    pick(4, 4, { 18, 23, 24, 29 })
    R[19] = game.rand(8)
    players[1]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[18]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[18]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[1], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[18]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[19]][R[18]], ({ [0] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[19]][R[18]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[19]][R[18]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[19]][R[18]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[19]][R[18]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[19]][R[18]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 } })[R[19]][R[18]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 } })[R[19]][R[18]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 } })[R[19]][R[18]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 } })[R[19]][R[18]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[19]][R[18]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[1], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 50, [1] = 117, [2] = 102, [3] = 180 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 66, [1] = 133, [2] = 118, [3] = 196 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 88, [1] = 96, [2] = 50, [3] = 73 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 68, [1] = 76, [2] = 30, [3] = 53 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[1], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 } })[R[19]][R[18]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[1], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[19]][R[18]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 } })[R[19]][R[18]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[19]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[30] = game.rand(4)
        if R[19] == 0 then
          if R[18] == 0 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          elseif R[18] == 1 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          elseif R[18] == 2 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          elseif R[18] == 3 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[19] == 1 then
          if R[30] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[30]", R[30])
          end
        elseif R[19] == 2 then
          if R[30] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[30]", R[30])
          end
        elseif R[19] == 3 then
          if R[30] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[30]", R[30])
          end
        elseif R[19] == 4 then
          if R[18] == 0 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          elseif R[18] == 1 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          elseif R[18] == 2 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          elseif R[18] == 3 then
            if R[30] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[30] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[30]", R[30])
            end
          else
            unseen("R[18]", R[18])
          end
        elseif R[19] == 5 then
          if R[30] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[30]", R[30])
          end
        elseif R[19] == 6 then
          if R[30] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[30]", R[30])
          end
        elseif R[19] == 7 then
          if R[30] == 0 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 1 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 2 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          elseif R[30] == 3 then
            if R[18] == 0 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 1 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 2 then
              if (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            elseif R[18] == 3 then
              if (players[1].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[1].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[1], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[1].is_eden and 1 or 0)", (players[1].is_eden and 1 or 0))
              end
            else
              unseen("R[18]", R[18])
            end
          else
            unseen("R[30]", R[30])
          end
        else
          unseen("R[19]", R[19])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[21] = game.rand(8)
    players[2]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[23]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[23]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[2], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[23]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[23]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 58, [1] = 57, [2] = 56, [3] = 57, [4] = 58, [5] = 59, [6] = 60, [7] = 59 }, [1] = { [0] = 125, [1] = 124, [2] = 123, [3] = 124, [4] = 125, [5] = 126, [6] = 127, [7] = 126 }, [2] = { [0] = 110, [1] = 109, [2] = 108, [3] = 109, [4] = 110, [5] = 111, [6] = 112, [7] = 111 }, [3] = { [0] = 188, [1] = 187, [2] = 186, [3] = 187, [4] = 188, [5] = 189, [6] = 190, [7] = 189 } })[R[23]][R[21]], ({ [0] = { [0] = 80, [1] = 79, [2] = 78, [3] = 77, [4] = 76, [5] = 77, [6] = 78, [7] = 79 }, [1] = { [0] = 88, [1] = 87, [2] = 86, [3] = 85, [4] = 84, [5] = 85, [6] = 86, [7] = 87 }, [2] = { [0] = 42, [1] = 41, [2] = 40, [3] = 39, [4] = 38, [5] = 39, [6] = 40, [7] = 41 }, [3] = { [0] = 65, [1] = 64, [2] = 63, [3] = 62, [4] = 61, [5] = 62, [6] = 63, [7] = 64 } })[R[23]][R[21]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 55, [2] = 55, [3] = 55, [4] = 57, [5] = 61, [6] = 61, [7] = 61 }, [1] = { [0] = 124, [1] = 122, [2] = 122, [3] = 122, [4] = 124, [5] = 128, [6] = 128, [7] = 128 }, [2] = { [0] = 109, [1] = 107, [2] = 107, [3] = 107, [4] = 109, [5] = 113, [6] = 113, [7] = 113 }, [3] = { [0] = 187, [1] = 185, [2] = 185, [3] = 185, [4] = 187, [5] = 191, [6] = 191, [7] = 191 } })[R[23]][R[21]], ({ [0] = { [0] = 82, [1] = 79, [2] = 77, [3] = 77, [4] = 74, [5] = 77, [6] = 77, [7] = 79 }, [1] = { [0] = 90, [1] = 87, [2] = 85, [3] = 85, [4] = 82, [5] = 85, [6] = 85, [7] = 87 }, [2] = { [0] = 44, [1] = 41, [2] = 39, [3] = 39, [4] = 36, [5] = 39, [6] = 39, [7] = 41 }, [3] = { [0] = 67, [1] = 64, [2] = 62, [3] = 62, [4] = 59, [5] = 62, [6] = 62, [7] = 64 } })[R[23]][R[21]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 57, [2] = 55, [3] = 57, [4] = 59, [5] = 59, [6] = 61, [7] = 59 }, [1] = { [0] = 126, [1] = 124, [2] = 122, [3] = 124, [4] = 126, [5] = 126, [6] = 128, [7] = 126 }, [2] = { [0] = 111, [1] = 109, [2] = 107, [3] = 109, [4] = 111, [5] = 111, [6] = 113, [7] = 111 }, [3] = { [0] = 189, [1] = 187, [2] = 185, [3] = 187, [4] = 189, [5] = 189, [6] = 191, [7] = 189 } })[R[23]][R[21]], ({ [0] = { [0] = 82, [1] = 81, [2] = 79, [3] = 75, [4] = 74, [5] = 75, [6] = 79, [7] = 81 }, [1] = { [0] = 90, [1] = 89, [2] = 87, [3] = 83, [4] = 82, [5] = 83, [6] = 87, [7] = 89 }, [2] = { [0] = 44, [1] = 43, [2] = 41, [3] = 37, [4] = 36, [5] = 37, [6] = 41, [7] = 43 }, [3] = { [0] = 67, [1] = 66, [2] = 64, [3] = 60, [4] = 59, [5] = 60, [6] = 64, [7] = 66 } })[R[23]][R[21]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 54, [2] = 53, [3] = 54, [4] = 57, [5] = 62, [6] = 63, [7] = 62 }, [1] = { [0] = 124, [1] = 121, [2] = 120, [3] = 121, [4] = 124, [5] = 129, [6] = 130, [7] = 129 }, [2] = { [0] = 109, [1] = 106, [2] = 105, [3] = 106, [4] = 109, [5] = 114, [6] = 115, [7] = 114 }, [3] = { [0] = 187, [1] = 184, [2] = 183, [3] = 184, [4] = 187, [5] = 192, [6] = 193, [7] = 192 } })[R[23]][R[21]], ({ [0] = { [0] = 84, [1] = 80, [2] = 77, [3] = 76, [4] = 72, [5] = 76, [6] = 77, [7] = 80 }, [1] = { [0] = 92, [1] = 88, [2] = 85, [3] = 84, [4] = 80, [5] = 84, [6] = 85, [7] = 88 }, [2] = { [0] = 46, [1] = 42, [2] = 39, [3] = 38, [4] = 34, [5] = 38, [6] = 39, [7] = 42 }, [3] = { [0] = 69, [1] = 65, [2] = 62, [3] = 61, [4] = 57, [5] = 61, [6] = 62, [7] = 65 } })[R[23]][R[21]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 56, [2] = 53, [3] = 56, [4] = 59, [5] = 60, [6] = 63, [7] = 60 }, [1] = { [0] = 126, [1] = 123, [2] = 120, [3] = 123, [4] = 126, [5] = 127, [6] = 130, [7] = 127 }, [2] = { [0] = 111, [1] = 108, [2] = 105, [3] = 108, [4] = 111, [5] = 112, [6] = 115, [7] = 112 }, [3] = { [0] = 189, [1] = 186, [2] = 183, [3] = 186, [4] = 189, [5] = 190, [6] = 193, [7] = 190 } })[R[23]][R[21]], ({ [0] = { [0] = 84, [1] = 82, [2] = 79, [3] = 74, [4] = 72, [5] = 74, [6] = 79, [7] = 82 }, [1] = { [0] = 92, [1] = 90, [2] = 87, [3] = 82, [4] = 80, [5] = 82, [6] = 87, [7] = 90 }, [2] = { [0] = 46, [1] = 44, [2] = 41, [3] = 36, [4] = 34, [5] = 36, [6] = 41, [7] = 44 }, [3] = { [0] = 69, [1] = 67, [2] = 64, [3] = 59, [4] = 57, [5] = 59, [6] = 64, [7] = 67 } })[R[23]][R[21]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 53, [2] = 51, [3] = 53, [4] = 57, [5] = 63, [6] = 65, [7] = 63 }, [1] = { [0] = 124, [1] = 120, [2] = 118, [3] = 120, [4] = 124, [5] = 130, [6] = 132, [7] = 130 }, [2] = { [0] = 109, [1] = 105, [2] = 103, [3] = 105, [4] = 109, [5] = 115, [6] = 117, [7] = 115 }, [3] = { [0] = 187, [1] = 183, [2] = 181, [3] = 183, [4] = 187, [5] = 193, [6] = 195, [7] = 193 } })[R[23]][R[21]], ({ [0] = { [0] = 86, [1] = 81, [2] = 77, [3] = 75, [4] = 70, [5] = 75, [6] = 77, [7] = 81 }, [1] = { [0] = 94, [1] = 89, [2] = 85, [3] = 83, [4] = 78, [5] = 83, [6] = 85, [7] = 89 }, [2] = { [0] = 48, [1] = 43, [2] = 39, [3] = 37, [4] = 32, [5] = 37, [6] = 39, [7] = 43 }, [3] = { [0] = 71, [1] = 66, [2] = 62, [3] = 60, [4] = 55, [5] = 60, [6] = 62, [7] = 66 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 55, [2] = 51, [3] = 55, [4] = 59, [5] = 61, [6] = 65, [7] = 61 }, [1] = { [0] = 126, [1] = 122, [2] = 118, [3] = 122, [4] = 126, [5] = 128, [6] = 132, [7] = 128 }, [2] = { [0] = 111, [1] = 107, [2] = 103, [3] = 107, [4] = 111, [5] = 113, [6] = 117, [7] = 113 }, [3] = { [0] = 189, [1] = 185, [2] = 181, [3] = 185, [4] = 189, [5] = 191, [6] = 195, [7] = 191 } })[R[23]][R[21]], ({ [0] = { [0] = 86, [1] = 83, [2] = 79, [3] = 73, [4] = 70, [5] = 73, [6] = 79, [7] = 83 }, [1] = { [0] = 94, [1] = 91, [2] = 87, [3] = 81, [4] = 78, [5] = 81, [6] = 87, [7] = 91 }, [2] = { [0] = 48, [1] = 45, [2] = 41, [3] = 35, [4] = 32, [5] = 35, [6] = 41, [7] = 45 }, [3] = { [0] = 71, [1] = 68, [2] = 64, [3] = 58, [4] = 55, [5] = 58, [6] = 64, [7] = 68 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[2], at = { ({ [0] = { [0] = 58, [1] = 53, [2] = 50, [3] = 53, [4] = 58, [5] = 63, [6] = 66, [7] = 63 }, [1] = { [0] = 125, [1] = 120, [2] = 117, [3] = 120, [4] = 125, [5] = 130, [6] = 133, [7] = 130 }, [2] = { [0] = 110, [1] = 105, [2] = 102, [3] = 105, [4] = 110, [5] = 115, [6] = 118, [7] = 115 }, [3] = { [0] = 188, [1] = 183, [2] = 180, [3] = 183, [4] = 188, [5] = 193, [6] = 196, [7] = 193 } })[R[23]][R[21]], ({ [0] = { [0] = 88, [1] = 83, [2] = 78, [3] = 73, [4] = 68, [5] = 73, [6] = 78, [7] = 83 }, [1] = { [0] = 96, [1] = 91, [2] = 86, [3] = 81, [4] = 76, [5] = 81, [6] = 86, [7] = 91 }, [2] = { [0] = 50, [1] = 45, [2] = 40, [3] = 35, [4] = 30, [5] = 35, [6] = 40, [7] = 45 }, [3] = { [0] = 73, [1] = 68, [2] = 63, [3] = 58, [4] = 53, [5] = 58, [6] = 63, [7] = 68 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[2], at = { ({ [0] = { [0] = 57, [1] = 51, [2] = 49, [3] = 51, [4] = 57, [5] = 65, [6] = 67, [7] = 65 }, [1] = { [0] = 124, [1] = 118, [2] = 116, [3] = 118, [4] = 124, [5] = 132, [6] = 134, [7] = 132 }, [2] = { [0] = 109, [1] = 103, [2] = 101, [3] = 103, [4] = 109, [5] = 117, [6] = 119, [7] = 117 }, [3] = { [0] = 187, [1] = 181, [2] = 179, [3] = 181, [4] = 187, [5] = 195, [6] = 197, [7] = 195 } })[R[23]][R[21]], ({ [0] = { [0] = 90, [1] = 83, [2] = 77, [3] = 73, [4] = 66, [5] = 73, [6] = 77, [7] = 83 }, [1] = { [0] = 98, [1] = 91, [2] = 85, [3] = 81, [4] = 74, [5] = 81, [6] = 85, [7] = 91 }, [2] = { [0] = 52, [1] = 45, [2] = 39, [3] = 35, [4] = 28, [5] = 35, [6] = 39, [7] = 45 }, [3] = { [0] = 75, [1] = 68, [2] = 62, [3] = 58, [4] = 51, [5] = 58, [6] = 62, [7] = 68 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[2], at = { ({ [0] = { [0] = 59, [1] = 53, [2] = 49, [3] = 53, [4] = 59, [5] = 63, [6] = 67, [7] = 63 }, [1] = { [0] = 126, [1] = 120, [2] = 116, [3] = 120, [4] = 126, [5] = 130, [6] = 134, [7] = 130 }, [2] = { [0] = 111, [1] = 105, [2] = 101, [3] = 105, [4] = 111, [5] = 115, [6] = 119, [7] = 115 }, [3] = { [0] = 189, [1] = 183, [2] = 179, [3] = 183, [4] = 189, [5] = 193, [6] = 197, [7] = 193 } })[R[23]][R[21]], ({ [0] = { [0] = 90, [1] = 85, [2] = 79, [3] = 71, [4] = 66, [5] = 71, [6] = 79, [7] = 85 }, [1] = { [0] = 98, [1] = 93, [2] = 87, [3] = 79, [4] = 74, [5] = 79, [6] = 87, [7] = 93 }, [2] = { [0] = 52, [1] = 47, [2] = 41, [3] = 33, [4] = 28, [5] = 33, [6] = 41, [7] = 47 }, [3] = { [0] = 75, [1] = 70, [2] = 64, [3] = 56, [4] = 51, [5] = 56, [6] = 64, [7] = 70 } })[R[23]][R[21]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[21]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[31] = game.rand(4)
        if R[23] == 0 then
          if R[21] == 0 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 1 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 2 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 3 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 4 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 5 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 6 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 7 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          else
            unseen("R[21]", R[21])
          end
        elseif R[23] == 1 then
          if R[21] == 0 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 1 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 2 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 3 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 4 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 5 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 6 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 7 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          else
            unseen("R[21]", R[21])
          end
        elseif R[23] == 2 then
          if R[21] == 0 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 1 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 2 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 3 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 4 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 5 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 6 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 7 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          else
            unseen("R[21]", R[21])
          end
        elseif R[23] == 3 then
          if R[21] == 0 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 1 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 2 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 3 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 4 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 5 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 6 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          elseif R[21] == 7 then
            if R[31] == 0 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 1 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 2 then
              if (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            elseif R[31] == 3 then
              if (players[2].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[2].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[2], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[2].is_eden and 1 or 0)", (players[2].is_eden and 1 or 0))
              end
            else
              unseen("R[31]", R[31])
            end
          else
            unseen("R[21]", R[21])
          end
        else
          unseen("R[23]", R[23])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[27] = game.rand(8)
    players[3]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[24]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[24]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[3], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[24]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[27]][R[24]], ({ [0] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[27]][R[24]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[27]][R[24]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[27]][R[24]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[27]][R[24]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[27]][R[24]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 } })[R[27]][R[24]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 } })[R[27]][R[24]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 } })[R[27]][R[24]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 } })[R[27]][R[24]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[27]][R[24]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[27]][R[24]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[3], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 50, [1] = 117, [2] = 102, [3] = 180 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 66, [1] = 133, [2] = 118, [3] = 196 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[27]][R[24]], ({ [0] = { [0] = 88, [1] = 96, [2] = 50, [3] = 73 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 68, [1] = 76, [2] = 30, [3] = 53 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[3], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 } })[R[27]][R[24]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[3], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[27]][R[24]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 } })[R[27]][R[24]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[27]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[32] = game.rand(4)
        if R[27] == 0 then
          if R[24] == 0 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          elseif R[24] == 1 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          elseif R[24] == 2 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          elseif R[24] == 3 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          else
            unseen("R[24]", R[24])
          end
        elseif R[27] == 1 then
          if R[32] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[32]", R[32])
          end
        elseif R[27] == 2 then
          if R[32] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[32]", R[32])
          end
        elseif R[27] == 3 then
          if R[32] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[32]", R[32])
          end
        elseif R[27] == 4 then
          if R[24] == 0 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          elseif R[24] == 1 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          elseif R[24] == 2 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          elseif R[24] == 3 then
            if R[32] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[32] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[32]", R[32])
            end
          else
            unseen("R[24]", R[24])
          end
        elseif R[27] == 5 then
          if R[32] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[32]", R[32])
          end
        elseif R[27] == 6 then
          if R[32] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[32]", R[32])
          end
        elseif R[27] == 7 then
          if R[32] == 0 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 1 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 2 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          elseif R[32] == 3 then
            if R[24] == 0 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 1 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 2 then
              if (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            elseif R[24] == 3 then
              if (players[3].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[3].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[3], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[3].is_eden and 1 or 0)", (players[3].is_eden and 1 or 0))
              end
            else
              unseen("R[24]", R[24])
            end
          else
            unseen("R[32]", R[32])
          end
        else
          unseen("R[27]", R[27])
        end
        U[#U]:set_lights(true)
      end
    else
      unseen("game.initial_units()", game.initial_units())
    end
    R[33] = game.rand(8)
    players[4]:center_view({ ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[29]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[29]] })
    U[#U + 1] = game.create_unit{ type = "RoboSurveyor", player = players[4], at = { ({ [0] = 58, [1] = 125, [2] = 110, [3] = 188 })[R[29]], ({ [0] = 78, [1] = 86, [2] = 40, [3] = 63 })[R[29]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[33]][R[29]], ({ [0] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[33]][R[29]] }, weapon = "CommandCenter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[33]][R[29]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 } })[R[33]][R[29]] }, weapon = "Tokamak", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [2] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [3] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [6] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [7] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 } })[R[33]][R[29]], ({ [0] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[33]][R[29]] }, weapon = "CommonOreSmelter", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 54, [1] = 121, [2] = 106, [3] = 184 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 62, [1] = 129, [2] = 114, [3] = 192 } })[R[33]][R[29]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 76, [1] = 84, [2] = 38, [3] = 61 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 80, [1] = 88, [2] = 42, [3] = 65 } })[R[33]][R[29]] }, weapon = "StructureFactory", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "ConVec", player = players[4], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [2] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [3] = { [0] = 56, [1] = 123, [2] = 108, [3] = 186 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 }, [6] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [7] = { [0] = 60, [1] = 127, [2] = 112, [3] = 190 } })[R[33]][R[29]], ({ [0] = { [0] = 84, [1] = 92, [2] = 46, [3] = 69 }, [1] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [4] = { [0] = 72, [1] = 80, [2] = 34, [3] = 57 }, [5] = { [0] = 74, [1] = 82, [2] = 36, [3] = 59 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 82, [1] = 90, [2] = 44, [3] = 67 } })[R[33]][R[29]] }, weapon = "Agridome", direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[33]][R[29]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 75, [1] = 83, [2] = 37, [3] = 60 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 81, [1] = 89, [2] = 43, [3] = 66 } })[R[33]][R[29]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [2] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [3] = { [0] = 55, [1] = 122, [2] = 107, [3] = 185 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 }, [6] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [7] = { [0] = 61, [1] = 128, [2] = 113, [3] = 191 } })[R[33]][R[29]], ({ [0] = { [0] = 86, [1] = 94, [2] = 48, [3] = 71 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 70, [1] = 78, [2] = 32, [3] = 55 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[33]][R[29]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("CommonMetal", 1000)
    U[#U + 1] = game.create_unit{ type = "CargoTruck", player = players[4], at = { ({ [0] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 50, [1] = 117, [2] = 102, [3] = 180 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 58, [1] = 125, [2] = 110, [3] = 188 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 66, [1] = 133, [2] = 118, [3] = 196 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[33]][R[29]], ({ [0] = { [0] = 88, [1] = 96, [2] = 50, [3] = 73 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 68, [1] = 76, [2] = 30, [3] = 53 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 78, [1] = 86, [2] = 40, [3] = 63 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[33]][R[29]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U]:set_cargo("Food", 1000)
    U[#U + 1] = game.create_unit{ type = "RoboMiner", player = players[4], at = { ({ [0] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [1] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 51, [1] = 118, [2] = 103, [3] = 181 }, [4] = { [0] = 57, [1] = 124, [2] = 109, [3] = 187 }, [5] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 65, [1] = 132, [2] = 117, [3] = 195 } })[R[33]][R[29]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 }, [2] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [3] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 73, [1] = 81, [2] = 35, [3] = 58 }, [6] = { [0] = 77, [1] = 85, [2] = 39, [3] = 62 }, [7] = { [0] = 83, [1] = 91, [2] = 45, [3] = 68 } })[R[33]][R[29]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    U[#U + 1] = game.create_unit{ type = "Earthworker", player = players[4], at = { ({ [0] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [1] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [2] = { [0] = 49, [1] = 116, [2] = 101, [3] = 179 }, [3] = { [0] = 53, [1] = 120, [2] = 105, [3] = 183 }, [4] = { [0] = 59, [1] = 126, [2] = 111, [3] = 189 }, [5] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 }, [6] = { [0] = 67, [1] = 134, [2] = 119, [3] = 197 }, [7] = { [0] = 63, [1] = 130, [2] = 115, [3] = 193 } })[R[33]][R[29]], ({ [0] = { [0] = 90, [1] = 98, [2] = 52, [3] = 75 }, [1] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 }, [2] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [3] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [4] = { [0] = 66, [1] = 74, [2] = 28, [3] = 51 }, [5] = { [0] = 71, [1] = 79, [2] = 33, [3] = 56 }, [6] = { [0] = 79, [1] = 87, [2] = 41, [3] = 64 }, [7] = { [0] = 85, [1] = 93, [2] = 47, [3] = 70 } })[R[33]][R[29]] }, direction = DIRS[({ [0] = 6, [1] = 7, [2] = 0, [3] = 1, [4] = 2, [5] = 3, [6] = 4, [7] = 5 })[R[33]] + 1], lights = false, exact = true }[1]
    U[#U]:set_lights(true)
    if game.initial_units() == 0 then
    elseif game.initial_units() == 4 or game.initial_units() == 8 or game.initial_units() == 12 then
      for i = 1, game.initial_units() do
        R[34] = game.rand(4)
        if R[33] == 0 then
          if R[29] == 0 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 79 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 79 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 88 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 88 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          elseif R[29] == 1 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 87 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 87 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 96 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 96 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          elseif R[29] == 2 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 41 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 41 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 50 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 50 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          elseif R[29] == 3 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 64 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 64 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 73 }, weapon = "Microwave", direction = "North", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 73 }, weapon = "Laser", direction = "North", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          else
            unseen("R[29]", R[29])
          end
        elseif R[33] == 1 then
          if R[34] == 0 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 77 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 77 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 85 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 85 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 39 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 39 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 62 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 62 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 1 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 81 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 81 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 126, 89 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 126, 89 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 43 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 43 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 189, 66 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 189, 66 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 2 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 80 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 80 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 88 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 88 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 42 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 42 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 65 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 65 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 3 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 86 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 86 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 94 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 94 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 48 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 48 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 71 }, weapon = "Microwave", direction = "NorthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 71 }, weapon = "Laser", direction = "NorthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          else
            unseen("R[34]", R[34])
          end
        elseif R[33] == 2 then
          if R[34] == 0 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 56, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 56, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 123, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 123, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 108, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 108, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 186, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 186, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 1 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 75 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 75 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 83 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 83 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 37 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 37 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 60 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 60 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 2 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 56, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 56, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 123, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 123, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 108, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 108, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 186, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 186, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 3 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 81 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 81 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 89 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 89 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 43 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 43 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 66 }, weapon = "Microwave", direction = "East", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 66 }, weapon = "Laser", direction = "East", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          else
            unseen("R[34]", R[34])
          end
        elseif R[33] == 3 then
          if R[34] == 0 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 79 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 79 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 87 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 87 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 41 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 41 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 64 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 64 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 1 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 75 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 59, 75 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 126, 83 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 126, 83 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 37 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 111, 37 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 189, 60 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 189, 60 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 2 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 76 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 51, 76 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 84 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 118, 84 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 38 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 103, 38 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 61 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 181, 61 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 3 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 70 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 70 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 78 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 78 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 32 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 32 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 55 }, weapon = "Laser", direction = "SouthEast", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 55 }, weapon = "Microwave", direction = "SouthEast", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          else
            unseen("R[34]", R[34])
          end
        elseif R[33] == 4 then
          if R[29] == 0 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 77 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 55, 77 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 68 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 68 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          elseif R[29] == 1 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 85 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 122, 85 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 76 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 76 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          elseif R[29] == 2 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 39 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 107, 39 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 30 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 30 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          elseif R[29] == 3 then
            if R[34] == 0 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 62 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 185, 62 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[34] == 3 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 53 }, weapon = "Laser", direction = "South", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 53 }, weapon = "Microwave", direction = "South", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[34]", R[34])
            end
          else
            unseen("R[29]", R[29])
          end
        elseif R[33] == 5 then
          if R[34] == 0 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 79 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 79 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 87 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 87 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 41 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 41 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 64 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 64 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 1 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 57, 75 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 57, 75 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 124, 83 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 124, 83 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 37 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 37 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 187, 60 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 187, 60 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 2 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 76 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 76 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 84 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 84 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 38 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 38 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 61 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 61 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 3 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 70 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 70 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 78 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 78 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 32 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 32 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 55 }, weapon = "Microwave", direction = "SouthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 55 }, weapon = "Laser", direction = "SouthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          else
            unseen("R[34]", R[34])
          end
        elseif R[33] == 6 then
          if R[34] == 0 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 60, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 60, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 127, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 127, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 112, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 112, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 190, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 190, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 1 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 75 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 75 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 83 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 83 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 37 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 37 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 60 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 60 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 2 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 60, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 60, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 127, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 127, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 112, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 112, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 190, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 190, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 3 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 81 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 81 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 89 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 89 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 43 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 43 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 66 }, weapon = "Microwave", direction = "West", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 66 }, weapon = "Laser", direction = "West", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          else
            unseen("R[34]", R[34])
          end
        elseif R[33] == 7 then
          if R[34] == 0 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 77 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 77 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 85 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 85 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 39 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 39 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 62 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 62 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 1 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 57, 81 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 57, 81 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 124, 89 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 124, 89 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 43 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 109, 43 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 187, 66 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 187, 66 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 2 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 80 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 65, 80 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 88 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 132, 88 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 42 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 117, 42 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 65 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 195, 65 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          elseif R[34] == 3 then
            if R[29] == 0 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 86 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 61, 86 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 1 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 94 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 128, 94 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 2 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 48 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 113, 48 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            elseif R[29] == 3 then
              if (players[4].is_eden and 1 or 0) == 0 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 71 }, weapon = "Microwave", direction = "NorthWest", lights = false, exact = true }[1]
              elseif (players[4].is_eden and 1 or 0) == 1 then
                U[#U + 1] = game.create_unit{ type = "Lynx", player = players[4], at = { 191, 71 }, weapon = "Laser", direction = "NorthWest", lights = false, exact = true }[1]
              else
                unseen("(players[4].is_eden and 1 or 0)", (players[4].is_eden and 1 or 0))
              end
            else
              unseen("R[29]", R[29])
            end
          else
            unseen("R[34]", R[34])
          end
        else
          unseen("R[33]", R[33])
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
    trigger.time{min = 18000, max = 22000, one_shot = false, on = Meteor}  -- after 180 to 220 marks
    trigger.time{min = 12000, max = 18000, one_shot = false, on = Vortex}  -- after 120 to 180 marks
  end
  return true
end
